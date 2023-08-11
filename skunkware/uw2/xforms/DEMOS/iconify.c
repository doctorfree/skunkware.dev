#include "forms.h"
#include "crab.xpm"

FL_FORM * create_form_form0(void);

int main(int argc, char *argv[])
{
   FL_FORM *form0;
   Pixmap p, mask;
   unsigned w,h;

   fl_initialize(&argc, argv, "FormDemo", 0, 0);
   form0 = create_form_form0();
   p = fl_read_pixmapfile(fl_root, "crab.xpm", &w, &h, &mask, 0, 0, 0);
   fl_set_form_icon(form0, p, mask);
   fl_show_form(form0,FL_PLACE_CENTER,FL_FULLBORDER, "IconTest");
   fl_do_forms();
   return 0;
}

FL_FORM *
create_form_form0(void)
{
  FL_OBJECT *obj;
  static FL_FORM *form;

  if (form)
     return form;
  form = fl_bgn_form(FL_NO_BOX,151,111);
  obj = fl_add_pixmapbutton(FL_NORMAL_BUTTON,0,0,151,111,
                             "Iconify Me\nvia Window Manager");
  fl_set_object_lalign(obj, FL_ALIGN_BOTTOM|FL_ALIGN_INSIDE);
  fl_set_object_lstyle(obj,FL_BOLD_STYLE);
  fl_set_pixmapbutton_data(obj, crab);
  fl_end_form();
  return form;
}
