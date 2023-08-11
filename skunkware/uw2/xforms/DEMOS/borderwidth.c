/* demo showing the effect of different border widths */

#include "forms.h"
#include <stdlib.h>

/* Header file generated with fdesign. */

/**** Callback routines ****/

extern void done_callback(FL_OBJECT *, long);
extern void bw_callback(FL_OBJECT *, long);

/**** Forms and Objects ****/

typedef struct {
	FL_FORM *bwform;
	void *vdata;
	long ldata;
	FL_OBJECT *done;
	FL_OBJECT *bw_choice;
	FL_OBJECT *bwgroup;
	FL_OBJECT *pmobj;
} FD_bwform;

extern FD_bwform * create_form_bwform(void);

/* callbacks for form bwform */
void done_callback(FL_OBJECT *ob, long data)
{
  /* fill-in code for callback */
   exit(0);
}

FD_bwform *fd_bwform;

void bw_callback(FL_OBJECT *ob, long data)
{
  /* fill-in code for callback */
   static int bws[] = { -3,-2,-1,1,2,3,4,5};
   int bw = bws[fl_get_choice(ob)-1];

   fl_set_object_bw(fd_bwform->bwgroup, bw);
   /* since bwgroup includes the backface, it wipes out the done button*/  
   fl_redraw_object(fd_bwform->done);
   fl_redraw_object(fd_bwform->bw_choice);
}


int main(int argc, char *argv[])
{

   /* application default. Can be overriden by the command line options */
   fl_set_border_width(-2); 

   fl_initialize(&argc, argv, "FormDemo", 0, 0);
   fd_bwform = create_form_bwform();

   /* fill-in form initialization code */
   fl_set_pixmapbutton_file(fd_bwform->pmobj, "crab.xpm");

   fl_addto_choice(fd_bwform->bw_choice,"-3 Pixel|-2 Pixel|-1 Pixel");
   fl_addto_choice(fd_bwform->bw_choice," 1 Pixel| 2 Pixel| 3 Pixel");
   fl_addto_choice(fd_bwform->bw_choice," 4 Pixel| 5 Pixel");
   fl_set_choice_text(fd_bwform->bw_choice, "-2 Pixel");

   /* show the first form */
   fl_show_form(fd_bwform->bwform,FL_PLACE_CENTER,FL_NOBORDER,"bwform");
   while (fl_do_forms())
     ;
   return 0;
}

/* Form definition file generated with fdesign. */

FD_bwform *create_form_bwform(void)
{
  FL_OBJECT *obj;
  FD_bwform *fdui = (FD_bwform *) fl_calloc(1, sizeof(FD_bwform));

  fdui->bwform = fl_bgn_form(FL_NO_BOX, 380, 340);

  fdui->bwgroup = fl_bgn_group();
  obj = fl_add_box(FL_UP_BOX,0,0,380,340,"");
  obj = fl_add_frame(FL_EMBOSSED_FRAME,220,60,135,145,"");
  obj = fl_add_frame(FL_ENGRAVED_FRAME,15,60,185,145,"");
  obj = fl_add_slider(FL_HOR_SLIDER,25,75,160,25,"");
  fdui->pmobj = obj = fl_add_pixmapbutton(FL_NORMAL_BUTTON,305,145,40,35,"");
  obj = fl_add_positioner(FL_NORMAL_POSITIONER,30,225,100,80,"");
  obj = fl_add_counter(FL_NORMAL_COUNTER,25,160,160,25,"");
  obj = fl_add_lightbutton(FL_PUSH_BUTTON,230,100,100,30,"LightButton");
  obj = fl_add_roundbutton(FL_PUSH_BUTTON,230,130,80,33,"Button");
  obj = fl_add_round3dbutton(FL_PUSH_BUTTON,230,152,80,33,"Button");
    fl_set_object_color(obj,FL_COL1, FL_BLUE);
  obj = fl_add_checkbutton(FL_PUSH_BUTTON,230,174,80,33,"Button");
  obj = fl_add_input(FL_NORMAL_INPUT,195,240,160,28,"Input");
  obj = fl_add_valslider(FL_HOR_BROWSER_SLIDER,25,120,160,25,"");
  obj = fl_add_button(FL_NORMAL_BUTTON,230,65,100,30,"Button");
  fl_end_group();

  fdui->done = obj = fl_add_button(FL_NORMAL_BUTTON,270,290,75,30,"Done");
    fl_set_object_callback(obj,done_callback,0);
  fdui->bw_choice = obj = fl_add_choice(FL_NORMAL_CHOICE,105,20,80,25,"Border Width");
    fl_set_object_callback(obj,bw_callback,0);
  fl_end_form();
  fdui->bwform->fdui  = fdui;

  return fdui;
}

