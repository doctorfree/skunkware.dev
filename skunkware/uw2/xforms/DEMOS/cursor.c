/* Cursor routines demo. */

#include <stdlib.h>
#include "forms.h"
#include "bm1.xbm"
#include "bm2.xbm"

typedef struct {
	FL_FORM *cursor;
	void *vdata;
	long ldata;
} FD_cursor;

extern FD_cursor * create_form_cursor(void);

/* callbacks for form cursor */
void setcursor_cb(FL_OBJECT *ob, long data)
{
   fl_set_cursor(FL_ObjWin(ob), data);
}

void setbitmapcursor_cb(FL_OBJECT *ob, long data)
{
  static int bitmapcur;

  if(!bitmapcur)
     bitmapcur = fl_create_bitmap_cursor((char *)bm1_bits, (char *)bm2_bits, 
                                         bm1_width, bm1_height,
                                         bm1_width/2, bm1_height/2);
  fl_set_cursor(FL_ObjWin(ob), bitmapcur);

}

void done_cb(FL_OBJECT *ob, long data)
{
    exit(0);
}



int main(int argc, char *argv[])
{
   FD_cursor *fd_cursor;

   fl_set_border_width(-2);
   fl_initialize(&argc, argv, "FormDemo", 0, 0);
   fd_cursor = create_form_cursor();

   /* fill-in form initialization code */

   fl_show_form(fd_cursor->cursor,FL_PLACE_CENTER,FL_FULLBORDER,"cursor");
   fl_do_forms();
   return 0;
}


FD_cursor *create_form_cursor(void)
{
  FL_OBJECT *obj;
  FD_cursor *fdui = (FD_cursor *) fl_calloc(1, sizeof(*fdui));

  fdui->cursor = fl_bgn_form(FL_NO_BOX, 325, 175);
  obj = fl_add_box(FL_UP_BOX,0,0,325,175,"");
  obj = fl_add_frame(FL_EMBOSSED_FRAME,10,10,305,120,"");
  obj = fl_add_button(FL_NORMAL_BUTTON,20,20,65,30,"Hand");
    fl_set_object_callback(obj,setcursor_cb,XC_hand2);
  obj = fl_add_button(FL_NORMAL_BUTTON,250,140,60,25,"Done");
    fl_set_object_callback(obj,done_cb,0);
  obj = fl_add_button(FL_NORMAL_BUTTON,95,20,65,30,"Watch");
    fl_set_object_callback(obj,setcursor_cb,XC_watch);
  obj = fl_add_button(FL_NORMAL_BUTTON,170,20,65,30,"Invisible");
    fl_set_object_callback(obj,setcursor_cb,FL_INVISIBLE_CURSOR);
  obj = fl_add_button(FL_NORMAL_BUTTON,90,70,140,50,"DefaultCursor");
    fl_set_button_shortcut(obj,"Dd#d",1);
    fl_set_object_callback(obj,setcursor_cb,FL_DEFAULT_CURSOR);
  obj = fl_add_button(FL_NORMAL_BUTTON,245,20,65,30,"BitmapCur");
    fl_set_object_callback(obj,setbitmapcursor_cb,0);
  fl_end_form();

  return fdui;
}
/*---------------------------------------*/

