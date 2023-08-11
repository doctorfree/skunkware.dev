#include "forms.h"
#include "buttons_gui.h"   /* from fd/ directory */
#include <stdlib.h>

/* callbacks for form buttform */

void done_cb(FL_OBJECT *ob, long data)
{
   exit(0);
}

void bw_cb(FL_OBJECT *ob, long data)
{
    int bws[] = {-4,-3,-2,-1,1,2,3,4};
    int n = fl_get_choice(ob)-1;
    FD_buttform *fdui = ob->form->fdui;

    fl_freeze_form(ob->form);
    fl_set_object_bw(fdui->backface, bws[n]);
    fl_set_object_bw(fdui->objsgroup, bws[n]);
    /* redrawing the backface wipes out the done button. Redraw it*/
    fl_redraw_object(fdui->done);
    fl_unfreeze_form(ob->form);
}

int main(int argc, char *argv[])
{
   FD_buttform *fd_buttform;

   fl_initialize(&argc, argv, 0, 0, 0);
   fd_buttform = create_form_buttform();

   /* fill-in form initialization code */
   fl_set_pixmapbutton_file(fd_buttform->pbutt,"crab45.xpm");
   fl_set_bitmapbutton_file(fd_buttform->bbutt,"bm1.xbm");
   fl_addto_choice(fd_buttform->bw_obj," -4 | -3 | -2 | -1 |  1|  2|  3|  4");
   fl_set_choice(fd_buttform->bw_obj,7);

   /* show the first form */
   fl_show_form(fd_buttform->buttform,FL_PLACE_CENTER,FL_FULLBORDER,"buttform");
   while (fl_do_forms())
     ;
   return 0;
}

#include "buttons_gui.c"
