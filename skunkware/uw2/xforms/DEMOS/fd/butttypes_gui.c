/* Form definition file generated with fdesign. */

#include "forms.h"
#include <stdlib.h>
#include "butttypes_gui.h"

FD_form0 *create_form_form0(void)
{
  FL_OBJECT *obj;
  FD_form0 *fdui = (FD_form0 *) fl_calloc(1, sizeof(*fdui));

  fdui->form0 = fl_bgn_form(FL_NO_BOX, 360, 300);
  obj = fl_add_box(FL_UP_BOX,0,0,360,300,"");
  obj = fl_add_button(FL_HIDDEN_BUTTON,0,0,360,300,"");
    fl_set_object_callback(obj,button_cb,0);
  obj = fl_add_button(FL_INOUT_BUTTON,20,168,105,30,"InOutButton");
    fl_set_object_lstyle(obj,FL_BOLD_STYLE);
    fl_set_object_callback(obj,button_cb,0);
  obj = fl_add_button(FL_NORMAL_BUTTON,20,15,105,30,"NormalButton");
    fl_set_object_lstyle(obj,FL_BOLD_STYLE);
    fl_set_object_callback(obj,button_cb,0);
  obj = fl_add_button(FL_PUSH_BUTTON,20,53,105,30,"PushButton");
    fl_set_object_lstyle(obj,FL_BOLD_STYLE);
    fl_set_object_callback(obj,button_cb,0);
  obj = fl_add_button(FL_TOUCH_BUTTON,20,130,105,30,"TouchButton");
    fl_set_object_lstyle(obj,FL_BOLD_STYLE);
    fl_set_object_callback(obj,button_cb,0);
  obj = fl_add_button(FL_MENU_BUTTON,20,206,105,30,"MenuButton");
    fl_set_object_lstyle(obj,FL_BOLD_STYLE);
    fl_set_object_callback(obj,button_cb,0);
  obj = fl_add_button(FL_RETURN_BUTTON,20,244,105,30,"ReturnButton");
    fl_set_object_lstyle(obj,FL_BOLD_STYLE);
    fl_set_object_callback(obj,button_cb,0);
  obj = fl_add_button(FL_RADIO_BUTTON,20,91,105,30,"RadioButton");
    fl_set_object_lstyle(obj,FL_BOLD_STYLE);
    fl_set_object_callback(obj,button_cb,0);
  fdui->br = obj = fl_add_browser(FL_NORMAL_BROWSER,135,15,210,260,"");
    fl_set_object_callback(obj,button_cb,0);
  fl_end_form();

  fl_adjust_form_size(fdui->form0);
  fdui->form0->fdui = fdui;

  return fdui;
}
/*---------------------------------------*/

