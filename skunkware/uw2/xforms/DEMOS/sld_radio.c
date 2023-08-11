/* This demo shows the use of a slider as radio object */

#include "forms.h"

int
main(int argc, char *argv[])
{
  FL_FORM *form;
  FL_OBJECT *sl, *but1, *but2, *but3, *but, *obj;

  fl_initialize(&argc, argv, "FormDemo", 0, 0);
  form = fl_bgn_form(FL_UP_BOX,300.0,300.0);
  sl = fl_add_slider(FL_VERT_SLIDER,40.0,40.0,60.0,220.0,"X");
  sl->radio = 1;
  but1 = fl_add_lightbutton(FL_RADIO_BUTTON,140.0,220.0,120.0,40.0,"0.0");
  but2 = fl_add_lightbutton(FL_RADIO_BUTTON,140.0,160.0,120.0,40.0,"0.5");
  but3 = fl_add_lightbutton(FL_RADIO_BUTTON,140.0,100.0,120.0,40.0,"1.0");
  but = fl_add_button(FL_NORMAL_BUTTON,140.0,40.0,120.0,40.0,"Exit");
  fl_end_form();

  fl_show_form(form,FL_PLACE_CENTER,FL_NOBORDER,NULL);
  do
  {
    obj = fl_do_forms();
    if (obj == but1) fl_set_slider_value(sl,0.0);
    if (obj == but2) fl_set_slider_value(sl,0.5);
    if (obj == but3) fl_set_slider_value(sl,1.0);
  }
  while (obj != but);
  fl_hide_form(form);
  return 0;
}

