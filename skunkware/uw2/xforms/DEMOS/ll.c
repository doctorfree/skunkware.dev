#include "forms.h"
#include <stdlib.h>
#include <math.h>

/**** Forms and Objects ****/

typedef struct {
	FL_FORM *axypform;
	FL_OBJECT *xyplot;
	FL_OBJECT *status;
	void *vdata;
	long ldata;
} FD_axypform;

extern FD_axypform * create_form_axypform(void);
#define LOG

FD_axypform *xypui;

/* callbacks for form axypform */
void xyplot_cb(FL_OBJECT *ob, long data)
{
    float x, y;
    int i;
    char buf[64];
    fl_get_xyplot(ob, &x, &y, &i);
    if(i < 0)
       return ;
    sprintf(buf,"X=%g  Y=%g",x,y);
    fl_set_object_label(xypui->status, buf);
}

void alwaysreturn_cb(FL_OBJECT *ob, long data)
{
   fl_set_xyplot_return(xypui->xyplot, fl_get_button(ob));
}

void interpolate_cb(FL_OBJECT *ob, long data)
{
#ifdef LOG
   fl_set_xyplot_interpolate(xypui->xyplot, 0, fl_get_button(ob) ? 2:0, 20000);
#else
   fl_set_xyplot_interpolate(xypui->xyplot, 0, fl_get_button(ob) ? 2:0, 0.2);
#endif
}

void inspect_cb(FL_OBJECT *ob, long data)
{
   fl_set_xyplot_inspect(xypui->xyplot, fl_get_button(ob));
}

void notic_cb(FL_OBJECT *ob, long data)
{
   int notic = fl_get_button(ob);

   if(notic)
   {
      fl_set_xyplot_xtics(xypui->xyplot, -1, -1);
      fl_set_xyplot_ytics(xypui->xyplot, -1, -1);
   }
   else
   {
      fl_set_xyplot_xtics(xypui->xyplot, 0, 0);
      fl_set_xyplot_ytics(xypui->xyplot, 0, 0);
   }
}



int main(int argc, char *argv[])
{
   float x[25], y[25];
   int i;

   fl_initialize(&argc, argv, "FormDemo", 0, 0);
   xypui = create_form_axypform();

   /* fill-in form initialization code */
   fl_set_object_dblbuffer(xypui->status, 1);
   for (i  = 0; i <= 10; i++)
#ifdef LOG
      x[i] = y[i] =  pow(10,i-12);
#else
      x[i] = y[i] =  i;
#endif
   fl_set_xyplot_data(xypui->xyplot, x, y, 11, "","","");

#ifdef LOG
   fl_set_xyplot_xscale(xypui->xyplot, FL_LOG, 5);
   fl_set_xyplot_yscale(xypui->xyplot, FL_LOG, 5);
   fl_set_xyplot_xgrid(xypui->xyplot, 2);
   fl_set_xyplot_ytics(xypui->xyplot, 3,5);
#endif
   /* show the first form */
   fl_show_form(xypui->axypform,FL_PLACE_MOUSE,FL_TRANSIENT,"axypform");
   fl_do_forms();
   return 0;
}

FD_axypform *create_form_axypform(void)
{
  FL_OBJECT *obj;
  FD_axypform *fdui = (FD_axypform *) fl_calloc(1, sizeof(*fdui));

  fdui->axypform = fl_bgn_form(FL_NO_BOX, 431, 301);
  obj = fl_add_box(FL_UP_BOX,0,0,431,301,"");
  fdui->xyplot = obj = fl_add_xyplot(FL_ACTIVE_XYPLOT,20,50,285,235,"");
    fl_set_object_boxtype(obj,FL_DOWN_BOX);
    fl_set_object_color(obj, FL_BLACK, FL_GREEN);
    fl_set_object_lalign(obj,FL_ALIGN_BOTTOM|FL_ALIGN_INSIDE);
    fl_set_object_callback(obj,xyplot_cb,0);
  obj = fl_add_checkbutton(FL_PUSH_BUTTON,315,40,80,25,"AlwaysReturn");
    fl_set_object_color(obj,FL_COL1,FL_BLUE);
    fl_set_object_callback(obj,alwaysreturn_cb,0);
  obj = fl_add_checkbutton(FL_PUSH_BUTTON,315,65,80,25,"Interpolate");
    fl_set_object_color(obj,FL_COL1,FL_BLUE);
    fl_set_object_callback(obj,interpolate_cb,0);
  obj = fl_add_checkbutton(FL_PUSH_BUTTON,315,90,85,25,"InspectOnly");
    fl_set_object_color(obj,FL_COL1,FL_BLUE);
    fl_set_object_callback(obj,inspect_cb,0);
  fdui->status = obj = fl_add_text(FL_NORMAL_TEXT,45,15,170,25,"");
    fl_set_object_boxtype(obj, FL_DOWN_BOX);
  obj = fl_add_button(FL_NORMAL_BUTTON,325,250,90,30,"Done");
  obj = fl_add_checkbutton(FL_PUSH_BUTTON,315,120,85,25,"NoTics");
    fl_set_object_color(obj,FL_COL1,FL_BLUE);
    fl_set_object_callback(obj,notic_cb,0);
  fl_end_form();

  return fdui;
}
/*---------------------------------------*/

