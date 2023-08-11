/* Demo showing the use of xyplot overlay. */

#include "forms.h"
#include <stdlib.h>

/**** Forms and Objects ****/

typedef struct {
	FL_FORM *fff;
	FL_OBJECT *xyplot;
	void *vdata;
	long ldata;
} FD_fff;

extern FD_fff * create_form_fff(void);


#include <math.h>


int main(int argc, char *argv[])
{
   int i;
   float xx[70], yy[70];
   FD_fff *fd_fff;

   fl_initialize(&argc, argv, "FormDemo", 0, 0);

   /* fill-in form initialization code */
   for (i = 0; i < 70; i++)
   {
        xx[i] = 3.1415 * i / 8.0;
        yy[i] = sin(2 * xx[i]) + cos(xx[i]);
   }

   fd_fff = create_form_fff();

   fl_set_xyplot_data(fd_fff->xyplot, xx, yy, 35, "", "","");
   fl_add_xyplot_overlay(fd_fff->xyplot, 1, xx, yy, 70, FL_BLUE);
   fl_set_xyplot_overlay_type(fd_fff->xyplot, 1, FL_NORMAL_XYPLOT);
   fl_set_xyplot_xbounds(fd_fff->xyplot, 0, 3.142 * 69/8.0);
   fl_set_xyplot_interpolate(fd_fff->xyplot, 1, 2, 0.1);
   /* add inset text */
   fl_add_xyplot_text(fd_fff->xyplot, 2.2, 1.2, "Original: Impulse",
                      FL_ALIGN_LEFT , FL_BLACK);
   fl_add_xyplot_text(fd_fff->xyplot, 2.2, 1.0, "Overlay: Solid", 
                      FL_ALIGN_LEFT, FL_BLUE);


   /* show the first form */
   fl_show_form(fd_fff->fff,FL_PLACE_MOUSE,FL_TRANSIENT,"XYPlot Overlay");
   fl_do_forms();
   return 0;
}

FD_fff *create_form_fff(void)
{
  FL_OBJECT *obj;
  FD_fff *fdui = (FD_fff *) fl_calloc(1, sizeof(*fdui));

  fdui->fff = fl_bgn_form(FL_NO_BOX, 370, 310);
  obj = fl_add_box(FL_UP_BOX,0,0,370,310,"");
  fdui->xyplot = obj = fl_add_xyplot(FL_IMPULSE_XYPLOT,10,20,350,260,"");
    fl_set_object_lalign(obj,FL_ALIGN_BOTTOM|FL_ALIGN_INSIDE);
  obj = fl_add_button(FL_HIDDEN_BUTTON,10,10,350,290,"");
  fl_end_form();

  return fdui;
}
/*---------------------------------------*/

