/* This is a demo that shows the different types of browsers.  */

#include <stdio.h>
#include <string.h>
#include "forms.h"

FL_FORM *form;
FL_OBJECT *br[4], *exitobj, *readout;
extern void create_form(void), fill_browsers(void);

int
main(int argc, char *argv[])
{
  fl_initialize(&argc, argv, "FormDemo", 0, 0);
  create_form();
  fill_browsers();
  fl_show_form(form,FL_PLACE_CENTER,FL_TRANSIENT,"All Browsers");
  fl_do_forms();
  fl_hide_form(form);
  return 0;
}

static char *bnames[] = 
{
    "NORMAL_BROWSER", "SELECT_BROWSER", "HOLD_BROWSER", "MULTI_BROWSER"
};


void deselect(FL_OBJECT *obj, long arg)
{
  int i;
  for (i=0; i<4; i++) 
     fl_deselect_browser(br[i]);
}

void set_size(FL_OBJECT *obj, long arg)
{
  int i;
  for (i=0; i<4; i++) 
     fl_set_browser_fontsize(br[i],arg);
}

void set_style(FL_OBJECT *obj, long arg)
{
  int i;
  for (i=0; i<4; i++) 
     fl_set_browser_fontstyle(br[i], arg);
}

void br_callback(FL_OBJECT *ob, long arg)
{
    char buf[1024];
    char *mb[] = {"","left","middle","right"};
    int i, b;

    if((b = fl_mouse_button()) < FL_SHORTCUT)
      sprintf(buf,"In %s [%s]", bnames[arg], mb[b]);
    else
      sprintf(buf,"In %s", bnames[arg]);
    i = fl_get_browser(ob);
    strcat(buf,fl_get_browser_line(ob,i >0 ? i:-i)); 
    strcat(buf,i > 0 ?  " was selected":" was deselected.");
    fl_set_object_label(readout,buf);
    fl_replace_browser_line(ob, FL_abs(i),"this\tis a long line\t with tab");
}

void create_form(void)
{
  FL_OBJECT *obj;

  form = fl_bgn_form(FL_UP_BOX,700,570);
  readout = fl_add_text(FL_NORMAL_TEXT,50,30,600,50,"");
  fl_set_object_lsize(readout,FL_LARGE_SIZE);
  fl_set_object_lalign(readout,FL_ALIGN_CENTER);
  fl_set_object_lstyle(readout,FL_BOLD_STYLE);
  fl_set_object_boxtype(readout,FL_UP_BOX);

  fl_set_object_color(readout,FL_MAGENTA,FL_MAGENTA);

  br[0] = obj = fl_add_browser(FL_NORMAL_BROWSER,20,120,150,290,bnames[0]);
    fl_set_object_callback(obj, br_callback, 0);
  br[1] = obj = fl_add_browser(FL_SELECT_BROWSER,190,120,150,290,bnames[1]);
    fl_set_object_callback(obj, br_callback, 1);
  br[2] = obj = fl_add_browser(FL_HOLD_BROWSER,360,120,150,290,bnames[2]);
    fl_set_object_color(obj,FL_COL1,FL_GREEN);
    fl_set_object_callback(obj, br_callback, 2);
  br[3] = obj = fl_add_browser(FL_MULTI_BROWSER,530,120,150,290,bnames[3]);
    fl_set_object_color(br[3],FL_COL1,FL_CYAN);
    fl_set_object_callback(obj, br_callback, 3);

  exitobj = obj = fl_add_button(FL_NORMAL_BUTTON,560,510,120,30,"Exit");
  obj = fl_add_button(FL_NORMAL_BUTTON,560,460,120,30,"Deselect");
    fl_set_object_callback(obj,deselect,0);

  fl_bgn_group();
  obj = fl_add_lightbutton(FL_RADIO_BUTTON,20,500,100,30,"Tiny");
    fl_set_object_lsize(obj,FL_TINY_SIZE);
    fl_set_object_callback(obj,set_size,obj->lsize);
  obj = fl_add_lightbutton(FL_RADIO_BUTTON,130,500,100,30,"Small");
    fl_set_object_lsize(obj,FL_SMALL_SIZE);
    fl_set_object_callback(obj,set_size,obj->lsize);
    fl_set_button(obj,1);
  obj = fl_add_lightbutton(FL_RADIO_BUTTON,240,500,100,30,"Normal");
    fl_set_object_lsize(obj,FL_NORMAL_SIZE);
    fl_set_object_callback(obj,set_size,obj->lsize);
  obj = fl_add_lightbutton(FL_RADIO_BUTTON,350,500,100,30,"Large");
    fl_set_object_lsize(obj,FL_LARGE_SIZE);
    fl_set_object_callback(obj,set_size,obj->lsize);
  fl_end_group();

  fl_bgn_group();
  obj = fl_add_lightbutton(FL_RADIO_BUTTON,20,450,100,30,"Normal");
    fl_set_object_callback(obj,set_style,FL_NORMAL_STYLE);
    fl_set_button(obj,1);
  obj = fl_add_lightbutton(FL_RADIO_BUTTON,120,450,100,30,"Bold");
    fl_set_object_callback(obj,set_style,FL_BOLD_STYLE);
  obj = fl_add_lightbutton(FL_RADIO_BUTTON,220,450,100,30,"Italic");
    fl_set_object_callback(obj,set_style,FL_ITALIC_STYLE);
  obj = fl_add_lightbutton(FL_RADIO_BUTTON,320,450,100,30,"BoldItalic");
    fl_set_object_callback(obj,set_style,FL_BOLDITALIC_STYLE);
  obj = fl_add_lightbutton(FL_RADIO_BUTTON,420,450,100,30,"Fixed");
    fl_set_object_callback(obj,set_style,FL_FIXED_STYLE);
  fl_end_group();
  fl_end_form();
}


void fill_browsers(void)
{
  int i, j;
  char buf[128];

  for (i=0; i<4; i++)
    for (j=1; j<=100; j++)
    {
      if ( j == 5)
        sprintf(buf,"@NLine with qb %3d",j);
      else if ( j == 10)
        strcpy(buf,"@-");
      else if ( j == 40 )
        sprintf(buf,"@mLine with qb %3d",j);
      else
        sprintf(buf,"Line with qb %3d",j);
      fl_add_browser_line(br[i],buf);
    }
}
