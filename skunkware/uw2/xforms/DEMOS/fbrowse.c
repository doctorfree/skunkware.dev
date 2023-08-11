/* This demo shows the use of a browser and a file selector.
*/

#include <stdio.h>
#include <stdlib.h>
#include "forms.h"

FL_FORM *form;
FL_OBJECT *br;

void load_file(FL_OBJECT *ob, long arg)
{
  const char *fname;

  fname = fl_show_file_selector("File To Load","","*","");
  if (fname == NULL) return;
  if (! fl_load_browser(br,fname)) 
     fl_add_browser_line(br,"NO SUCH FILE!");
}
 
void set_size(FL_OBJECT *ob, long arg)
{
   fl_set_browser_fontsize(br,(int)arg);
}

void exit_program(FL_OBJECT *ob, long data)
{
   exit(0);
}

void create_form(void)
{
  FL_OBJECT *obj;
  FL_Coord x = 20, dx = 85;

  form = fl_bgn_form(FL_NO_BOX,590,610);
  obj = fl_add_box(FL_UP_BOX,0,0,590,610,"");
  br = obj = fl_add_browser(FL_NORMAL_BROWSER,20,20,550,530,"");

  obj = fl_add_button(FL_NORMAL_BUTTON,x,560,dx,30,"Load");
    fl_set_object_callback(obj,load_file,0);
    x += dx + 10;
  obj = fl_add_lightbutton(FL_RADIO_BUTTON,x,560,dx,30,"Tiny");
    fl_set_object_callback(obj,set_size,FL_TINY_SIZE);
    x += dx;
  obj = fl_add_lightbutton(FL_RADIO_BUTTON,x ,560,dx,30,"Small");
    fl_set_object_callback(obj,set_size,FL_SMALL_SIZE);
    fl_set_button(obj, FL_SMALL_SIZE == FL_BROWSER_FONTSIZE);
    x += dx;
  obj = fl_add_lightbutton(FL_RADIO_BUTTON,x ,560,dx,30,"Normal");
    fl_set_object_callback(obj,set_size,FL_NORMAL_SIZE);
    fl_set_button(obj, FL_NORMAL_SIZE == FL_BROWSER_FONTSIZE);
    x += dx;
  obj = fl_add_lightbutton(FL_RADIO_BUTTON,x ,560,dx,30,"Large");
    fl_set_object_callback(obj,set_size,FL_LARGE_SIZE);

  obj = fl_add_button(FL_NORMAL_BUTTON,470,560,100,30,"Exit");
    fl_set_object_callback(obj, exit_program, 0);
  fl_end_form();
}

int
main(int argc, char *argv[])
{
  fl_initialize(&argc, argv, "FormDemo", 0, 0);
  create_form();

  fl_clear_browser(br);
  fl_add_browser_line(br,"LOAD A FILE.");
  fl_set_browser_fontstyle(br,FL_FIXED_STYLE);

  fl_show_form(form,FL_PLACE_FREE,FL_FULLBORDER,"Browser");
  fl_do_forms();
  fl_hide_form(form);
  fl_free_form(form);
  return 0;
}
