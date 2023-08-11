#include "forms.h"
#include "fd/butttypes_gui.h"
#include <stdlib.h>

/* callbacks for form form0 */
void button_cb(FL_OBJECT *ob, long data)
{
   FD_form0 *ui = ob->form->fdui;
   char buf[128];

   if(ob->type == FL_HIDDEN_BUTTON )
   {
      if(fl_show_question("Want to Quit ?", 1) == 1)
	exit(0);
   }
   else
   {
      sprintf(buf,"%s callback called: %d", ob->label,
	 fl_get_button(ob));
      fl_addto_browser(ui->br, buf);
   }
}


int main(int argc, char *argv[])
{
   FD_form0 *fd_form0;

   fl_initialize(&argc, argv, 0, 0, 0);
   fd_form0 = create_form_form0();

   /* fill-in form initialization code */

   /* show the first form */
   fl_show_form(fd_form0->form0,FL_PLACE_CENTER,FL_FULLBORDER,"form0");
   fl_do_forms();
   return 0;
}

#include "fd/butttypes_gui.c"
