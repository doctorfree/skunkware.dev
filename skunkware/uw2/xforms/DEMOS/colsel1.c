/************

show the use of setting object colors and call-back routines.


************/

#include <stdio.h>
#include "forms.h"

FL_FORM *form;
FL_OBJECT *topbox;

void change_color(FL_OBJECT *obj, long col)
{ 
  fl_set_object_color(topbox, col,  col); 
}

void makeform(void)
{
  FL_OBJECT *obj;
  int i,j;
  char str[32];

  form = fl_bgn_form(FL_UP_BOX,100.0,100.0);
    for (i=0; i<8; i++) for (j=0; j<8; j++)
      {
        sprintf(str,"%d",8*j+i);
        obj = fl_add_button(FL_RADIO_BUTTON,11+10*i,15+10*j,8,6,str);
        fl_set_object_color(obj,8*j+i,8*j+i);
        fl_set_object_lalign(obj,FL_ALIGN_BOTTOM);
        fl_set_object_callback(obj,change_color, (long) (8*j+i));
      }
    topbox = fl_add_button(FL_NORMAL_BUTTON,30,5,40,8,"The Color Map");
    fl_set_object_lsize(topbox,FL_LARGE_SIZE);
    fl_set_object_lstyle(topbox,FL_BOLD_STYLE);
  fl_end_form();
}

int
main(int argc, char *argv[])
{
  FL_OBJECT *ret;

  fl_initialize(&argc, argv, "FormDemo", 0, 0);
  makeform();
  fl_scale_form(form, 4.0,4.0);
  fl_show_form(form,FL_PLACE_FREE,FL_NOBORDER,NULL);
  do ret = fl_do_forms(); while (ret != topbox);
  fl_hide_form(form);
  return 0;
}
