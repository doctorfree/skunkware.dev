/* Testing bitmaps Class. */

#include "forms.h"
#include "srs.xbm"

int
main(int argc, char *argv[])
{
  FL_FORM *form;
  FL_OBJECT *obj;

  fl_initialize(&argc, argv, "FormDemo", 0, 0);
  form = fl_bgn_form(FL_UP_BOX,200,200);
    obj = fl_add_bitmap(FL_NORMAL_BITMAP,50,50,100,100,"A bitmap");
      fl_set_object_lcol(obj,FL_BLUE);
    fl_add_button(FL_HIDDEN_BUTTON,50,50,100,100,"");
  fl_end_form();

  fl_set_bitmap_data(obj,sorceress_width,sorceress_height,sorceress_bits);

  fl_show_form(form,FL_PLACE_MOUSE,FL_NOBORDER,"X Bitmap");
  fl_do_forms() ;
  fl_hide_form(form);
  return 0;
}
