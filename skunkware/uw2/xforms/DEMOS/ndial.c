/* This is an example of the use of dials.  */

#include <stdio.h>
#include "forms.h"

FL_FORM *form;
FL_OBJECT *button, *red, *green, *blue, *redtext, *greentext, *bluetext,
       *result;

void makeform(void)
{
  form = fl_bgn_form(FL_UP_BOX,300,330);
    button = fl_add_button(FL_NORMAL_BUTTON,45,15,210,45,"A Color Editor");
    fl_set_object_lsize(button,FL_LARGE_SIZE);

    red = fl_add_dial(FL_NORMAL_DIAL,30,240,60,60,"Red");
    fl_set_dial_bounds(red,0.0,255.0);
    fl_set_dial_value(red,128.0);
    fl_set_object_color(red,FL_RED,FL_DIAL_COL2);
    redtext = fl_add_box(FL_DOWN_BOX,105,255,50,25,"");

    green = fl_add_dial(FL_NORMAL_DIAL,30,155,60,60,"Green");
    fl_set_dial_bounds(green,0.0,255.0);
    fl_set_dial_value(green,128.0);
    fl_set_object_color(green,FL_GREEN,FL_DIAL_COL2);
    greentext = fl_add_box(FL_DOWN_BOX,105,170,50,25,"");

    blue = fl_add_dial(FL_NORMAL_DIAL,30,70,60,60,"Blue");
    fl_set_dial_bounds(blue,0.0,255.0);
    fl_set_dial_value(blue,128);
    fl_set_object_color(blue,FL_BLUE,FL_DIAL_COL2);
    bluetext = fl_add_box(FL_DOWN_BOX,105,90,50,25,"");

    result = fl_add_box(FL_DOWN_BOX,180,70,90,245,"");
    fl_set_object_color(result,FL_FREE_COL1,FL_FREE_COL1);
    fl_set_object_dblbuffer(result, 1); /* to avoid flicker */
  fl_end_form();
}

int
main(int argc, char *argv[])
{
  FL_OBJECT *ret;
  int r,g,b;
  char str[100];

  fl_initialize(&argc, argv, "FormDemo", 0, 0);
  makeform();
  fl_show_form(form,FL_PLACE_MOUSE,FL_TRANSIENT,"A Form");
  do
  {
    r = (int) fl_get_dial_value(red);
    g = (int) fl_get_dial_value(green);
    b = (int) fl_get_dial_value(blue);
    fl_mapcolor(FL_FREE_COL1,r,g,b);
    fl_redraw_object(result);
    sprintf(str,"%d",r); fl_set_object_label(redtext,str);
    sprintf(str,"%d",g); fl_set_object_label(greentext,str);
    sprintf(str,"%d",b); fl_set_object_label(bluetext,str);
    ret = fl_do_forms();
  } while (ret != button);
  fl_hide_form(form);
  return 0;
}
