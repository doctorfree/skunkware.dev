#include "forms.h"

void 
input_cb(FL_OBJECT *ob, long data)
{
    int x, y;

    fl_get_input_cursorpos(ob, &x , &y);
    fprintf(stderr,"x=%d y=%d\n",x,y);
}

int
main(int argc, char *argv[])
{
  FL_FORM *form;
  FL_OBJECT *but, *obj;

  fl_initialize(&argc, argv, "FormDemo", 0, 0);
  form = fl_bgn_form(FL_UP_BOX,400,450);
    obj = fl_add_input(FL_MULTILINE_INPUT,30,270,340,150,"");
    obj =  fl_add_input(FL_MULTILINE_INPUT,30,90,340,150,"");
    fl_set_object_lsize(obj, FL_NORMAL_SIZE);
  but = fl_add_button(FL_NORMAL_BUTTON,160,30,80,30,"Exit");
  fl_end_form();
  fl_show_form(form,FL_PLACE_CENTERFREE,FL_FULLBORDER,"MultiLineInput");
  do  obj = fl_do_forms(); while (obj != but);
  return 0;
}
