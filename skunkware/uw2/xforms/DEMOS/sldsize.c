/* This demo shows the use of a setting slider sizes */

#include "forms.h"

int
main(int argc, char *argv[])
{
  FL_FORM *form;
  FL_OBJECT *sl1, *sl2, *but, *obj;

  fl_initialize(&argc, argv, "FormDemo", 0, 0);
  form = fl_bgn_form(FL_UP_BOX,150,300);
  sl1 = fl_add_slider(FL_VERT_SLIDER,20,20,40,180,"X");
  sl2 = fl_add_slider(FL_VERT_SLIDER,90,20,40,180,"Y");
  but = fl_add_button(FL_NORMAL_BUTTON,40,250,70,30,"Exit");
  fl_end_form();

  fl_show_form(form,FL_PLACE_CENTER,FL_NOBORDER,"Slider Size");
  do
  {
    fl_set_slider_size(sl2,fl_get_slider_value(sl1));
    fl_set_slider_size(sl1,fl_get_slider_value(sl2));
    obj = fl_do_forms();
  }
  while (obj != but);
  fl_hide_form(form);
  return 0;
}

