/* This demo shows the use of a touch buttons.
*/

#include <stdio.h>
#include "forms.h"

static void show_val(FL_OBJECT *, long);
FL_OBJECT *valobj;

int
main(int argc, char *argv[])
{
  FL_FORM *form;
  FL_OBJECT *obj;

  fl_initialize(&argc, argv, "FormDemo", 0, 0);
  form = fl_bgn_form(FL_UP_BOX,360,140);
    obj = fl_add_button(FL_TOUCH_BUTTON,50,30,40,30,"@<<");
     fl_set_object_boxtype(obj,FL_FRAME_BOX);
     fl_set_object_color(obj, FL_COL1, FL_INDIANRED); 
     fl_set_object_callback(obj, show_val,-5);
     fl_set_button_shortcut(obj,"1", 0);
    obj = fl_add_button(FL_TOUCH_BUTTON,90,30,40,30,"@<");
     fl_set_object_boxtype(obj,FL_FRAME_BOX);
     fl_set_object_color(obj, FL_COL1, FL_INDIANRED); 
     fl_set_object_callback(obj, show_val,-1);
     fl_set_button_shortcut(obj,"2", 0);
    valobj = obj = fl_add_box(FL_BORDER_BOX,130,30,100,30,"");
     fl_set_object_color(obj,FL_LEFT_BCOL,FL_LEFT_BCOL);
    obj = fl_add_button(FL_TOUCH_BUTTON,230,30,40,30,"@>");
     fl_set_object_boxtype(obj,FL_FRAME_BOX);
     fl_set_object_color(obj, FL_COL1, FL_INDIANRED); 
     fl_set_object_callback(obj, show_val,1);
     fl_set_button_shortcut(obj,"3", 0);
    obj = fl_add_button(FL_TOUCH_BUTTON,270,30,40,30,"@>>");
     fl_set_object_boxtype(obj,FL_FRAME_BOX);
     fl_set_object_callback(obj, show_val,5);
     fl_set_object_color(obj, FL_COL1, FL_INDIANRED); 
     fl_set_button_shortcut(obj,"4", 0);
    obj = fl_add_button(FL_NORMAL_BUTTON,220,90,100,30,"Exit");
  fl_end_form();

  fl_show_form(form,FL_PLACE_CENTER,FL_NOBORDER,"Touch Buttons");
  fl_do_forms();

  return 0;
}

static void
show_val(FL_OBJECT *ob, long delta)
{
   static int val = 0;
   char str[32];

   val += delta;
   sprintf(str,"%d", val);
   fl_set_object_label(valobj, str);
}
