/* This is an example of the use of counters.
*/

#include <stdio.h>
#include "forms.h"


FL_FORM *form;
FL_OBJECT *result, *co[3];

void
color_change(FL_OBJECT *ob, long data)
{
    int r =  fl_get_counter_value(co[0]);
    int g =  fl_get_counter_value(co[1]);
    int b =  fl_get_counter_value(co[2]);

    fl_mapcolor(FL_FREE_COL1,r,g,b);
    fl_redraw_object(result);

}

void create_form_form(void)
{
  FL_OBJECT *obj;

  form = fl_bgn_form(FL_NO_BOX,480,200);
  obj = fl_add_box(FL_UP_BOX,0,0,480,200,"");
  result = obj = fl_add_box(FL_DOWN_BOX,310,20,150,160,"");
    fl_set_object_dblbuffer(result, 1);
  co[0] = obj = fl_add_counter(FL_NORMAL_COUNTER,20,20,270,30,"");
    fl_set_object_color(obj,FL_INDIANRED,FL_RED);
    fl_set_object_callback(obj,color_change,0);
  co[1] = obj = fl_add_counter(FL_NORMAL_COUNTER,20,60,270,30,"");
    fl_set_object_color(obj,FL_PALEGREEN,FL_GREEN);
    fl_set_object_callback(obj,color_change,0);
  co[2] = obj = fl_add_counter(FL_NORMAL_COUNTER,20,100,270,30,"");
    fl_set_object_color(obj,FL_SLATEBLUE,FL_BLUE);
    fl_set_object_callback(obj,color_change,0);
  obj = fl_add_button(FL_NORMAL_BUTTON,100,150,110,30,"Exit");
  fl_end_form();
}


int
main(int argc, char *argv[])
{
  int i;

  fl_initialize(&argc, argv, "FormDemo", 0, 0);
  create_form_form();
  fl_set_object_color(result,FL_FREE_COL1,FL_FREE_COL1);

  for (i=0; i<3; i++)
  {
    fl_set_counter_bounds(co[i],0.0,255.0);
    fl_set_counter_step(co[i],1.0,10.0);
    fl_set_counter_precision(co[i],0);
    fl_set_counter_return(co[i],1);
  }

  fl_call_object_callback(co[0]);

  fl_show_form(form,FL_PLACE_CENTER,FL_NOBORDER,"Counter");
  fl_do_forms();

  return 0;
}

