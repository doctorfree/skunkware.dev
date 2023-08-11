/*
 * Demo showing the use of user defined object class: CROSSBUTTON
 *
 * Form definition file generated with fdesign. 
 * changed stub button to crossbutton
 */

#include "forms.h"
#include "crossbut.h"
#include <stdlib.h>

#ifndef FD_newbut_h_
#define FD_newbut_h

/**** Forms and Objects ****/
typedef struct {
	FL_FORM *newbut;
	FL_OBJECT *bexit;
	void *vdata;
	long ldata;
} FD_newbut;

extern FD_newbut *create_form_newbut(void);
#endif /* FD_newbut_h_ */

int main(int argc, char *argv[])
{
      FD_newbut *cbform ;

      fl_initialize(&argc, argv, "FormDemo", 0, 0);
      cbform = create_form_newbut();
      fl_show_form(cbform->newbut, FL_PLACE_CENTER, 0, 0);
      while(fl_do_forms() != cbform->bexit)
          ;
      return 0;
}


FD_newbut *create_form_newbut(void)
{
  FL_OBJECT *obj;
  FD_newbut *fdui = fl_calloc(1, sizeof(FD_newbut));
  int oldbw = fl_get_border_width();

  fl_set_border_width(-2);
  fdui->newbut = fl_bgn_form(FL_NO_BOX, 310, 190);
  obj = fl_add_box(FL_UP_BOX,0,0,310,190,"");
  obj = fl_add_labelframe(FL_ENGRAVED_FRAME,40,45,100,120,"CrossB");
    fl_set_object_boxtype(obj,FL_FLAT_BOX);
    fl_set_object_lstyle(obj,FL_BOLD_STYLE);
  obj = fl_add_crossbutton(FL_RADIO_BUTTON,50,115,80,30,"cross1");
    fl_set_object_color(obj,FL_COL1,FL_RED);
  obj = fl_add_crossbutton(FL_RADIO_BUTTON,50,85,80,30,"Button");
    fl_set_object_color(obj,FL_COL1,FL_GREEN);
  obj = fl_add_crossbutton(FL_RADIO_BUTTON,50,55,80,30,"Button");
    fl_set_object_color(obj,FL_COL1,FL_BLUE);
  obj = fl_add_labelframe(FL_ENGRAVED_FRAME,180,45,100,120,"CrossB");
    fl_set_object_boxtype(obj,FL_FLAT_BOX);
    fl_set_object_lstyle(obj,FL_BOLD_STYLE);
  obj = fl_add_crossbutton(FL_PUSH_BUTTON,190,115,80,30,"Button");
    fl_set_object_color(obj,FL_COL1,FL_RED);
  obj = fl_add_crossbutton(FL_PUSH_BUTTON,190,85,90,30,"Button");
    fl_set_object_color(obj,FL_COL1,FL_GREEN);
  obj = fl_add_crossbutton(FL_PUSH_BUTTON,190,55,80,30,"Button");
    fl_set_object_color(obj,FL_COL1,FL_BLUE);
  fdui->bexit = obj = fl_add_button(FL_NORMAL_BUTTON,125,10,65,25,"Exit");
  fl_end_form();
  fl_set_border_width(oldbw);

  return fdui;
}
