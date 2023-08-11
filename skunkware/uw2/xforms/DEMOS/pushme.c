#include "forms.h"

int main(int argc, char *argv[])
{
  FL_FORM *simpleform;

  fl_initialize(&argc, argv, "FormDemo", 0, 0);
  simpleform = fl_bgn_form(FL_UP_BOX,230,160);
   fl_add_button(FL_NORMAL_BUTTON,40,50,150,60,"Push Me");
  fl_end_form();
  fl_show_form(simpleform, FL_PLACE_MOUSE, FL_NOBORDER, "PushMe");
  fl_do_forms();
  fl_hide_form(simpleform);
  return 0;
}
