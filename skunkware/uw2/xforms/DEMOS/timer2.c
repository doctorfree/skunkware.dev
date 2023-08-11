/* A demo showing the use of timer objects.
 * note there is only one fl_do_form().
 */

#include <stdlib.h>
#include "forms.h"

FL_FORM *form1, *form2;
FL_OBJECT *tim, *tim2;

#define TIME 5

void
timer1_expired(FL_OBJECT *ob, long q)
{
   fl_deactivate_form(form1);
   fl_set_timer(tim2,10);
   fl_show_form(form2,FL_PLACE_MOUSE,0,"Q");
}

void nothing(FL_OBJECT *ob, long q)
{
}

void
continue_cb(FL_OBJECT *ob, long q)
{
   fl_hide_form(form2);
   fl_activate_form(form1);
   fl_set_timer(tim,TIME);
   fl_set_object_callback(tim,nothing,0);
}

void
done_cb(FL_OBJECT *ob, long a)
{
   exit(0);
}


void makeforms(void)
{
  FL_OBJECT *obj;

  form1 = fl_bgn_form(FL_UP_BOX,400,400);
    obj = fl_add_button(FL_NORMAL_BUTTON,140,160,120,80,"Push Me");
      fl_set_object_callback(obj, done_cb, 0);
    tim = fl_add_timer(FL_VALUE_TIMER,200,40,90,50,"Time Left");
      fl_set_object_callback(tim, timer1_expired,0);
    fl_set_object_lcol(tim, FL_BLACK);
  fl_end_form();

  form2 = fl_bgn_form(FL_UP_BOX,320,120);
    fl_add_box(FL_NO_BOX,160,40,0,0,"You were too late");
    obj = fl_add_button(FL_NORMAL_BUTTON,100,70,120,30,"Try Again");
    fl_set_object_callback(obj, continue_cb, 0);
    tim2 = fl_add_timer(FL_HIDDEN_TIMER,0,0,1,2,"");
    fl_set_object_callback(tim2, continue_cb, 0);
  fl_end_form();
}

int
main(int argc, char *argv[])
{
  fl_initialize(&argc, argv, "FormDemo", 0, 0);
  makeforms();
  fl_show_form(form1,FL_PLACE_CENTER,FL_NOBORDER,"Timer");
  fl_set_timer(tim,TIME);
  fl_do_forms();
  return 0;
}

