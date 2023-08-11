/* demo showing the choices when to return object. Note this program,
 * strictly speaking, is illegal in the usage of user data parameter
 * in the callback function.
 */

#include "forms.h"
#include <stdlib.h>

/**** Forms and Objects ****/
typedef struct
{
    FL_FORM *form0;
    FL_OBJECT *obj[4];
    FL_OBJECT *br;
    FL_OBJECT *when;
    void *vdata;
    long ldata;
} FD_form0;

extern FD_form0 *create_form_form0(void);
static FD_form0 *fd_form0;

/* callbacks for form form0 */
void 
return_cb(FL_OBJECT * ob, long data)
{
    fl_addto_browser(fd_form0->br, (char *) data);
}

void 
set_when(int n)
{
    fl_set_object_return(fd_form0->obj[0], n);
    fl_set_object_return(fd_form0->obj[1], n);
    fl_set_object_return(fd_form0->obj[2], n);
    fl_set_object_return(fd_form0->obj[3], n);
}

void 
when_cb(FL_OBJECT * ob, long data)
{
    int n = fl_get_choice(ob) - 1;
    if (n >= 0)
	set_when(n);
}

void 
resetlog_cb(FL_OBJECT * ob, long data)
{
    fl_clear_browser(fd_form0->br);
}

int 
main(int argc, char *argv[])
{

    fl_initialize(&argc, argv, "FormDemo", 0, 0);
    fd_form0 = create_form_form0();

    /* fill-in form initialization code */
    set_when(0);
    fl_set_object_dblbuffer(fd_form0->br, 1);
    fl_addto_choice(fd_form0->when,
	      "RETURN_END_CHANGED|RETURN_CHANGED|RETURN_END|RETURN_ALWAYS");

    /* show the first form */
    fl_show_form(fd_form0->form0, FL_PLACE_CENTER, FL_FULLBORDER, "form0");
    fl_do_forms();
    return 0;
}

FD_form0 *create_form_form0(void)
{
  FL_OBJECT *obj;
  FD_form0 *fdui = (FD_form0 *) fl_calloc(1, sizeof(*fdui));
  int old_bw = fl_get_border_width();

  fl_set_border_width(-2);
  fdui->form0 = fl_bgn_form(FL_NO_BOX, 321, 276);
  obj = fl_add_box(FL_UP_BOX,0,0,321,276,"");
  fdui->obj[0] = obj = fl_add_valslider(FL_HOR_SLIDER,12,55,138,22,"");
    fl_set_object_lalign(obj,FL_ALIGN_BOTTOM|FL_ALIGN_INSIDE);
    fl_set_object_callback(obj,return_cb,(long)"slider returned");
     fl_set_slider_return(obj, FL_RETURN_CHANGED);
  fdui->obj[1] = obj = fl_add_counter(FL_NORMAL_COUNTER,12,85,138,22,"");
    fl_set_object_lalign(obj,FL_ALIGN_BOTTOM|FL_ALIGN_INSIDE);
    fl_set_object_callback(obj,return_cb,(long)"counter returned");
  fdui->obj[3] = obj = fl_add_input(FL_NORMAL_INPUT,12,187,138,25,"");
    fl_set_object_lalign(obj,FL_ALIGN_LEFT|FL_ALIGN_INSIDE);
    fl_set_object_callback(obj,return_cb,(long)"input2 returned");
  fdui->obj[2] = obj = fl_add_input(FL_NORMAL_INPUT,12,150,138,25,"");
    fl_set_object_callback(obj,return_cb,(long)"input1 returnd");
  fdui->br = obj = fl_add_browser(FL_NORMAL_BROWSER,170,55,140,160,"");
  fdui->when = obj = fl_add_choice(FL_NORMAL_CHOICE,80,12,168,27,"");
    fl_set_object_callback(obj,when_cb,0);
  obj = fl_add_button(FL_NORMAL_BUTTON,170,239,80,25,"Done");
  obj = fl_add_button(FL_NORMAL_BUTTON,70,239,80,25,"ResetLog");
    fl_set_object_callback(obj,resetlog_cb,0);
  fl_end_form();
  fl_set_border_width(old_bw);

  return fdui;
}
/*---------------------------------------*/

