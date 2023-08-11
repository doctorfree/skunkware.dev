/* A demo that shows the use of push buttons.  */

#include "forms.h"

FL_FORM *form;
FL_OBJECT  *abox[8];

void
push_cb(FL_OBJECT *ob, long n)
{
   if(fl_get_button(ob))
      fl_show_object(abox[n]);
   else 
      fl_hide_object(abox[n]);
}


void makeform(void)
{
  int i;
  FL_OBJECT *obj;

  form = fl_bgn_form(FL_UP_BOX,400,400);
  for (i=0; i<8; i++)
  {
    obj = fl_add_button(FL_PUSH_BUTTON,40,310-40*i,80,30,"");
      fl_set_object_color(obj,FL_BLACK+i+1,FL_BLACK+i+1);
      fl_set_object_callback(obj,push_cb,i);
    abox[i] = fl_add_box(FL_DOWN_BOX,150+30*i,40,25,320,"");
      fl_set_object_color(abox[i],FL_BLACK+i+1,FL_BLACK+i+1);
      fl_hide_object(abox[i]);
  }
  fl_add_button(FL_NORMAL_BUTTON,40,350,80,30,"Exit");
  fl_end_form();
}

int
main(int argc, char *argv[])
{ 
  fl_initialize(&argc, argv, "FormDemo", 0, 0);
  makeform();
  fl_show_form(form,FL_PLACE_CENTER,FL_NOBORDER,"Push Buttons");
  /* fl_do_forms will return only when Exit is pressed */
  fl_do_forms();
  return 0;
}
