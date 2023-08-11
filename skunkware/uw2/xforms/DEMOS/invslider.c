#include "forms.h"
#include <stdlib.h>

extern void invert_it(FL_OBJECT *, long);
typedef struct {
	FL_FORM *inv;
	FL_OBJECT *sl[3];
	FL_OBJECT *done;
	void *vdata;
	long ldata;
} FD_inv;

extern FD_inv * create_form_inv(void);

FD_inv *ui;
void invert_it(FL_OBJECT *ob, long data)
{
   if(fl_get_button(ob))
   {
      fl_set_slider_bounds(ui->sl[0], 1.0, 0.0);
      fl_set_slider_bounds(ui->sl[1], 1.0, 0.0);
      fl_set_slider_bounds(ui->sl[2], 1.0, 0.0);
   }
   else
   {
      fl_set_slider_bounds(ui->sl[0], 0.0, 1.0);
      fl_set_slider_bounds(ui->sl[1], 0.0, 1.0);
      fl_set_slider_bounds(ui->sl[2], 0.0, 1.0);
   }
}

int main(int argc, char *argv[])
{

   fl_initialize(&argc, argv, "FormDemo", 0, 0);
   ui = create_form_inv();

   /* fill-in form initialization code */

   fl_show_form(ui->inv,FL_PLACE_CENTER,FL_TRANSIENT,"inv");
   while (fl_do_forms() != ui->done)
      ;
   return 0;
}

/* Form definition file generated with fdesign. */

FD_inv *create_form_inv(void)
{
  FL_OBJECT *obj;
  FD_inv *fdui = fl_calloc(1, sizeof(FD_inv));

  fdui->inv = fl_bgn_form(FL_NO_BOX, 245, 280);
  obj = fl_add_box(FL_UP_BOX,0,0,245,280,"");
  fdui->sl[0] = obj = fl_add_valslider(FL_VERT_SLIDER,20,30,35,230,"");
  fdui->sl[1] = obj = fl_add_valslider(FL_VERT_FILL_SLIDER,65,30,35,230,"");
  fdui->sl[2] = obj = fl_add_valslider(FL_VERT_NICE_SLIDER,115,30,35,230,"");
    fl_set_object_boxtype(obj,FL_FLAT_BOX);
    fl_set_object_color(obj,FL_COL1,FL_BLUE);
  fdui->done = obj = fl_add_button(FL_RETURN_BUTTON,160,235,75,30,"Exit");
  obj = fl_add_checkbutton(FL_PUSH_BUTTON,165,30,75,35,"Invert");
    fl_set_object_callback(obj,invert_it,0);
  fl_end_form();

  return fdui;
}
/*---------------------------------------*/

