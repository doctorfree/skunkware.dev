/* This is a crazy demo showing the "use" of changing
   fields in objects.
*/

#include "forms.h"

void
move_cb(FL_OBJECT *ob, long data)
{
   static FL_Coord dx=11, dy=7;
   FL_OBJECT *but = (FL_OBJECT *)data;
   FL_Coord x,y,w,h; 

   fl_get_object_geometry(but,&x,&y, &w, &h);

   if( (x + dx) < 0 || (x+w+dx) >= but->form->w)
       dx = -dx;
   if( (y + dy) < 0 || (y+h+dy) >= but->form->h)
       dy = -dy;
    x += dx;
    y += dy;

    fl_set_object_position(but,x,y);
}

int
main(int argc, char *argv[])
{
  FL_FORM *form;
  FL_OBJECT *but, *obj;

  fl_initialize(&argc, argv, "FormDemo", 0, 0);

  form = fl_bgn_form(FL_DOWN_BOX,400,200);
    but = fl_add_button(FL_NORMAL_BUTTON,140,160,70,35,"Exit");
    obj = fl_add_button(FL_TOUCH_BUTTON,330,150,50,30,"Move");
     fl_set_object_callback(obj,move_cb,(long)but);
  fl_end_form();

  fl_show_form(form,FL_PLACE_MOUSE,FL_NOBORDER,"ObjPos");

  fl_do_forms();

  return 0;
}
