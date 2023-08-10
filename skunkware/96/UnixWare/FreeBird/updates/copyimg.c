static char ident[] = "@(#)copyimg, Andy Levinson, 95-Nov-21\n";
/*
** view this file with tabstops=4
**
** copy disk image file to floppy, akin to a hard-coded substitute for:
**		dd if=image_file of=floppy_drive bs=9216 count=160
** the floppy must contain a 1.44mb previously-formatted diskette
** the image_file must have filesize=1474560
**
** usage: copyimg [-v] a|b image_file
**		-v = optional verify-after-write flag
**		a|b = write to drive a or drive b
**		image_file = image file to copy to floppy
**
** fairly complete and generic but has several magic numbers
** uses bios interrupt 0x13, functions 03, 04, and 08
** requires about 11k stack (I tested with 0x3000)
**
** no copyright or responsibility claimed. just give me credit
** if it works and blame someone else if it does not
*/

#include <sys\types.h>
#include <sys\stat.h>
#include <dos.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define SIZE_SECTOR			((unsigned)512)
#define SECTORS_HALF_CYL	((unsigned)18)
#define SIZE_HALF_CYL		(unsigned)(SIZE_SECTOR * SECTORS_HALF_CYL)
#define HEADS_PER_CYL		((unsigned)2)
#define CYL_PER_DISK		((unsigned)80)
#define FULL_DISK_SIZE	\
		((long)((long)SIZE_HALF_CYL * HEADS_PER_CYL * CYL_PER_DISK))

static char *chatty_error(unsigned error_code, char *buffer)
{
	switch (error_code) {
	  case 0x02: return "address not found";
	  case 0x03: return "write protected disk";
	  case 0x04: return "sector not found";
	  case 0x08: return "DMA overrun";
	  case 0x20: return "controller error";
	  case 0x40: return "track not found";
	  case 0x80: return "drive timeout";
	  case 0xaa: return "drive not ready";
	  default:
		sprintf(buffer, "bios error code 0x%02x", error_code);
		return buffer;
	}
}

static void usage(char *prog)
{
	fprintf(stderr, "usage: %s [-v] a|b image_file\n", prog);
	exit(1);
}

main(int argc, char **argv)
{
	unsigned segment_addr, offset_addr;
	unsigned char cylinder, head, drive_id, do_verify = 0;
	struct stat statbuf;
	char *ptr, *prog, buffer[SIZE_HALF_CYL];
	union REGS regs;
	struct SREGS sregs;
	FILE *fp;

	if (*argv && **argv && (ptr = strrchr(*argv, '\\')) && ptr[1])
		prog = ptr + 1;
	else
		prog = "copyimg";

	do_verify = 0;
	if (argc > 1 && (*argv[1] == '-' || *argv[1] == '/'))
		switch (argv[1][1]) {
		  case 'V':
			fputs(ident+4, stderr);
			return 0;
		  case 'v':
			do_verify = 1;
			++argv; --argc;
			break;
		  default:
			usage(prog);
		}

	if (argc != 3 || !*argv[1] || !*argv[2])
		usage(prog);

	switch (*argv[1]) {
	  case 'a': case 'A':
		drive_id = 0;	break;
	  case 'b': case 'B':
		drive_id = 1;	break;
	  default:
	  	fprintf(stderr, "invalid drive ID `%c'\n", *argv[1]);
		usage(prog);
	}

	regs.h.ah = 0x08;				/* get drive parameters */
	regs.h.dl = drive_id;
	int86(0x13, &regs, &regs);
	if (regs.x.cflag) {
		fprintf(stderr, "Error getting drive %c parameters\n%s\n",
				drive_id+'A', chatty_error(regs.h.ah, buffer));
		return 1;
	}
	if (regs.h.bl != 0x04) {
		fprintf(stderr,
				"drive %c does not contain a 1.44mb formatted floppy\n",
				drive_id+'A');
		return 1;
	}

	if (!(fp = fopen(argv[2], "rb"))) {
		fprintf(stderr, "can't open file `%s'\n", argv[2]);
		perror("fopen");
		return 1;
	}
	if (fstat(fileno(fp), &statbuf)) {
		fprintf(stderr, "can't stat file `%s'\n", argv[2]);
		perror("fstat");
		return 1;
	}
	if (statbuf.st_size != FULL_DISK_SIZE) {
		fprintf(stderr, "%s filesize not %ld\n", argv[2], FULL_DISK_SIZE);
		return 1;
	}

	offset_addr = (unsigned)((void far *)buffer);
	segment_addr = (unsigned)((((unsigned long)((void far *)buffer)) >> 16));

	fputs("Writing to Cylinder 00 ", stderr);
	for (cylinder = 0; cylinder < (unsigned char)CYL_PER_DISK; ++cylinder) {
		fprintf(stderr, "\b\b\b%02d ", (int)cylinder);
		for (head = 0; head < (unsigned char)HEADS_PER_CYL; ++head) {
			if (fread(buffer, 1, SIZE_HALF_CYL, fp) != SIZE_HALF_CYL) {
				fprintf(stderr, "\nError reading file `%s'\n", argv[2]);
				perror("fread");
				return 1;
			}
			regs.h.ah = 0x03;				/* write to floppy */
			regs.h.al = (unsigned char)SECTORS_HALF_CYL;
			regs.x.bx = offset_addr;
			regs.h.ch = cylinder;
			regs.h.cl = 1;					/* starting sector */
			regs.h.dh = head;
			regs.h.dl = drive_id;
			sregs.es = segment_addr;
			int86x(0x13, &regs, &regs, &sregs);
			if (regs.x.cflag) {
				fprintf(stderr, "\nError writing cylinder %d, head %d\n%s\n",
						(int)cylinder, (int)head,
						chatty_error(regs.h.ah, buffer));
				return 1;
			}
			if (do_verify) {
				regs.h.ah = 0x04;			/* verify floppy */
				regs.h.al = (unsigned char)SECTORS_HALF_CYL;
				regs.x.bx = offset_addr;
				regs.h.ch = cylinder;
				regs.h.cl = 1;				/* starting sector */
				regs.h.dh = head;
				regs.h.dl = drive_id;
				sregs.es = segment_addr;
				int86x(0x13, &regs, &regs, &sregs);
				if (regs.x.cflag) {
					fprintf(stderr,
							"\nError verifying cylinder %d, head %d\n%s\n",
							(int)cylinder, (int)head,
							chatty_error(regs.h.ah, buffer));
					return 1;
				}
			}
		}
	}

	fputs("- Done\n", stderr);
	return 0;
}
