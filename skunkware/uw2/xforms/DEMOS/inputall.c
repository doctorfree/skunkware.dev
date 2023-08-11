#include "forms.h"
#include "inputall_gui.h"
#include <stdlib.h>

/* callbacks for form input */
void done_cb(FL_OBJECT *ob, long data)
{
   exit(0);
}

void input_cb(FL_OBJECT *ob, long data)
{
   int cx, cy, pos;
   char buf[128];

   pos = fl_get_input_cursorpos(ob, &cx,&cy);
   sprintf(buf,"P=%d x=%d y=%d",pos,cx,cy);
   fl_set_object_label(((FD_input *)ob->form->fdui)->report,buf);
}

void hide_show_cb(FL_OBJECT *ob, long data)
{
    FD_input *fd = ob->form->fdui;

    if(fd->multiinput->visible)
       fl_hide_object(fd->multiinput);
    else
       fl_show_object(fd->multiinput);
}



int main(int argc, char *argv[])
{
   FD_input *fd_input;

   fl_initialize(&argc, argv, 0, 0, 0);
   fd_input = create_form_input();

   /* fill-in form initialization code */
   fl_set_object_dblbuffer(fd_input->report,1);
   fl_set_object_return(fd_input->multiinput,FL_RETURN_ALWAYS);
   fl_set_object_return(fd_input->norminput,FL_RETURN_ALWAYS);
#if 0
   fl_set_input_hscrollbar(fd_input->multiinput, FL_OFF);
   fl_set_input_vscrollbar(fd_input->multiinput, FL_OFF);
   fl_set_input_scroll(fd_input->multiinput, 0);
   fl_set_input_scroll(fd_input->norminput, 0);
#endif

   /* show the first form */
   fl_show_form(fd_input->input,FL_PLACE_CENTERFREE,FL_FULLBORDER,"input");
   while (fl_do_forms())
      ;
   return 0;
}

#include "inputall_gui.c"

