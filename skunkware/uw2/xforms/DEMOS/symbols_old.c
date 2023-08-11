/* Demo showing different types of symbols and a user defined symbol */

#include "forms.h"

FL_FORM *form;
FL_OBJECT *readyobj;

void create_form_form(void)
{
  FL_OBJECT *obj;
  form = fl_bgn_form(FL_NO_BOX,470,320);
  readyobj = obj = fl_add_button(FL_HIDDEN_BUTTON,0,0,470,320,"");
  obj = fl_add_box(FL_UP_BOX,0,0,470,320,"");
    fl_set_object_color(obj,FL_SLATEBLUE,FL_COL1);

  obj = fl_add_box(FL_BORDER_BOX,290,120,70,70," @arrow");
    fl_set_object_lalign(obj,FL_ALIGN_BOTTOM);
  obj = fl_add_box(FL_NO_BOX,290,120,70,70,"@arrow");
    fl_set_object_lcol(obj,FL_MAGENTA);

  obj = fl_add_box(FL_BORDER_BOX,20,220,70,70," @line");
    fl_set_object_lalign(obj,FL_ALIGN_BOTTOM);
  obj = fl_add_box(FL_NO_BOX,20,220,70,70,"@line");
    fl_set_object_lcol(obj,FL_BLUE);

  obj = fl_add_box(FL_BORDER_BOX,110,220,70,70," @circle");
    fl_set_object_lalign(obj,FL_ALIGN_BOTTOM);
  obj = fl_add_box(FL_NO_BOX,110,220,70,70,"@circle");
    fl_set_object_lcol(obj,FL_BLUE);

  obj = fl_add_box(FL_BORDER_BOX,200,220,70,70," @AppDefined");
    fl_set_object_lalign(obj,FL_ALIGN_BOTTOM);
  obj = fl_add_box(FL_NO_BOX,200,220,70,70,"@AppDefined");
    fl_set_object_lcol(obj,FL_BLUE);

  obj = fl_add_box(FL_BORDER_BOX,290,220,70,70," @DnLine"); 
    fl_set_object_lalign(obj,FL_ALIGN_BOTTOM);
  obj = fl_add_box(FL_NO_BOX,290,220,70,70,"@DnLine");

  obj = fl_add_box(FL_BORDER_BOX,380,220,70,70," @UpLine"); 
    fl_set_object_lalign(obj,FL_ALIGN_BOTTOM);
  obj = fl_add_box(FL_NO_BOX,380,220,70,70,"@UpLine");

  obj = fl_add_box(FL_BORDER_BOX,290,20,70,70," @<->");
    fl_set_object_lalign(obj,FL_ALIGN_BOTTOM);
  obj = fl_add_box(FL_NO_BOX,290,20,70,70,"@<->");
    fl_set_object_lcol(obj,FL_GREEN);

  obj = fl_add_box(FL_BORDER_BOX,200,20,70,70," @<<");
    fl_set_object_lalign(obj,FL_ALIGN_BOTTOM);
  obj = fl_add_box(FL_NO_BOX,200,20,70,70,"@<<");
    fl_set_object_lcol(obj,FL_GREEN);

  obj = fl_add_box(FL_BORDER_BOX,20,20,70,70," @<-");
    fl_set_object_lalign(obj,FL_ALIGN_BOTTOM);
  obj = fl_add_box(FL_NO_BOX,20,20,70,70,"@<-");
    fl_set_object_lcol(obj,FL_GREEN);

  obj = fl_add_box(FL_BORDER_BOX,20,120,70,70," @->");
    fl_set_object_lalign(obj,FL_ALIGN_BOTTOM);
  obj = fl_add_box(FL_NO_BOX,20,120,70,70,"@->");
    fl_set_object_lcol(obj,FL_MAGENTA);

  obj = fl_add_box(FL_BORDER_BOX,110,120,70,70," @>");
    fl_set_object_lalign(obj,FL_ALIGN_BOTTOM);
  obj = fl_add_box(FL_NO_BOX,110,120,70,70,"@>");
    fl_set_object_lcol(obj,FL_MAGENTA);

  obj = fl_add_box(FL_BORDER_BOX,110,20,70,70," @<");
    fl_set_object_lalign(obj,FL_ALIGN_BOTTOM);
  obj = fl_add_box(FL_NO_BOX,110,20,70,70,"@<");
    fl_set_object_lcol(obj,FL_GREEN);

  obj = fl_add_box(FL_BORDER_BOX,200,120,70,70," @>>");
    fl_set_object_lalign(obj,FL_ALIGN_BOTTOM);
  obj = fl_add_box(FL_NO_BOX,200,120,70,70,"@>>");
    fl_set_object_lcol(obj,FL_MAGENTA);

#if 0
  readyobj = obj = fl_add_button(FL_RETURN_BUTTON,340,270,110,30,"Ready");
    fl_set_object_color(obj,FL_INDIANRED,FL_INDIANRED);
#endif
  obj = fl_add_box(FL_BORDER_BOX,380,20,70,70," @returnarrow");
    fl_set_object_lalign(obj,FL_ALIGN_BOTTOM);
  obj = fl_add_box(FL_NO_BOX,380,20,70,70,"@returnarrow");
    fl_set_object_lcol(obj,FL_GREEN);

  obj = fl_add_box(FL_BORDER_BOX,380,120,70,70," @plus");
    fl_set_object_lalign(obj,FL_ALIGN_BOTTOM);
  obj = fl_add_box(FL_NO_BOX,380,120,70,70,"@plus");
    fl_set_object_lcol(obj,FL_MAGENTA);
  fl_end_form();
}


/* new symbol defination. Need error checking for real programs */
void drawsymbol(FL_Coord x, FL_Coord y, FL_Coord w, FL_Coord h,
               int angle, FL_COLOR col)
{
     int bw = 5;

     /* not rotatable */
     x += bw;
     y += bw;
     w -= 2*bw;
     h -= 2* bw;

     fl_rectf( x, y, w, h, col);
     fl_ovalf( x, y, w, h, FL_RED);
}

/*=================== MAIN PROGRAM ====================*/

int
main(int argc, char *argv[])
{
  FL_OBJECT *obj;

  fl_initialize(&argc, argv, "FormDemo", 0, 0);
  create_form_form();

  /* add the new symbol */
  fl_add_symbol("AppDefined",drawsymbol,0);

  fl_show_form(form,FL_PLACE_CENTER,FL_NOBORDER,NULL);
  do obj = fl_do_forms(); while (obj!=readyobj);
  fl_hide_form(form);
  return 0;
}
