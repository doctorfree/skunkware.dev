#ifndef FD_input_h_
#define FD_input_h_
/* Header file generated with fdesign. */

/**** Callback routines ****/

extern void input_cb(FL_OBJECT *, long);
extern void done_cb(FL_OBJECT *, long);
extern void hide_show_cb(FL_OBJECT *, long);


/**** Forms and Objects ****/

typedef struct {
	FL_FORM *input;
	void *vdata;
	long ldata;
	FL_OBJECT *norminput;
	FL_OBJECT *multiinput;
	FL_OBJECT *report;
} FD_input;

extern FD_input * create_form_input(void);

#endif /* FD_input_h_ */
