/* Multiline labels. */

#include "forms.h"

FL_FORM *form;
FL_OBJECT *readyobj;

void create_form_0(void)
{
  FL_OBJECT *obj;

  form = fl_bgn_form(FL_NO_BOX,400,470);
  obj = fl_add_box(FL_UP_BOX,0,0,400,470,"");
    fl_set_object_color(obj,FL_SLATEBLUE,FL_COL1);
  obj = fl_add_text(FL_NORMAL_TEXT,140,40,120,120,"This is\na multi-line\nlabelT");
    fl_set_object_boxtype(obj,FL_BORDER_BOX);
    fl_set_object_lalign(obj,FL_ALIGN_TOP);
  obj = fl_add_text(FL_NORMAL_TEXT,140,160,120,120,"This is\na multi-line\nlabelC");
    fl_set_object_boxtype(obj,FL_BORDER_BOX);
    fl_set_object_color(obj,FL_PALEGREEN,FL_COL1);
    fl_set_object_lsize(obj,FL_LARGE_SIZE);
    fl_set_object_lalign(obj,FL_ALIGN_CENTER);
  readyobj = obj = fl_add_button(FL_NORMAL_BUTTON,280,400,100,50,"I am sure\nthat I am\nReady");
    fl_set_object_lsize(obj,FL_SMALL_SIZE);
  obj = fl_add_text(FL_NORMAL_TEXT,260,160,120,120,"This is\na multi-line\nlabelR");
    fl_set_object_boxtype(obj,FL_BORDER_BOX);
    fl_set_object_lalign(obj,FL_ALIGN_RIGHT);
  obj = fl_add_text(FL_NORMAL_TEXT,140,280,120,120,"This is\na multi-line\nlabelB");
    fl_set_object_boxtype(obj,FL_BORDER_BOX);
    fl_set_object_lalign(obj,FL_ALIGN_BOTTOM);
  obj = fl_add_text(FL_NORMAL_TEXT,20,160,120,120,"This is\na multi-line\nlabel");
    fl_set_object_boxtype(obj,FL_BORDER_BOX);
  fl_end_form();
}

/*---------------------------------------*/

int
main(int argc, char *argv[])
{
  FL_OBJECT *obj;

  fl_initialize(&argc, argv, "FormDemo", 0, 0);
  create_form_0();
  fl_show_form(form,FL_PLACE_CENTER,FL_NOBORDER,"Labels");
  do obj = fl_do_forms(); while (obj != readyobj);
  fl_hide_form(form);
  return 0;
}
