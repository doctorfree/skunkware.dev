/* This demo is meant to demonstrate the use of a free
   object in a form.
*/

#include "forms.h"
#include <stdlib.h>

int on = 1, dcol = 1;
FL_COLOR cole;

/* The call back routine */
int handle_it(FL_OBJECT *obj, int event, FL_Coord mx, FL_Coord my, 
          int key, void *ev)
{
  static int dcol = 1;

  switch (event)
  {
    case FL_DRAW:
        fl_rectf(obj->x,obj->y,obj->w,obj->h, obj->u_ldata);
        break;
    case FL_RELEASE:
	on = !on;
	break;
    case FL_STEP:
 	if (on)
	{ 
	  if (obj->u_ldata == cole) 
	      dcol = -1;
	  if (obj->u_ldata == FL_FREE_COL1) 
	      dcol = 1;
          obj->u_ldata += dcol;
          fl_redraw_object(obj);
	}
	break;
  }
  return 0;
}

void done(FL_OBJECT *ob, long data) { exit(0);}

int
main(int argc, char *argv[])
{
  FL_FORM *form;
  FL_OBJECT *obj;
  int i, j, depth, col;

  fl_initialize(&argc, argv, "FormDemo", 0, 0);

  form = fl_bgn_form(FL_UP_BOX,400.0,400.0);
  obj = fl_add_button(FL_NORMAL_BUTTON,320.0,20.0,40.0,30.0,"Exit");
  fl_set_object_callback(obj, done, 0);
  obj = fl_add_free(FL_CONTINUOUS_FREE,40.0,80.0,320.0,280.0,"",handle_it);
  fl_end_form();

  depth  = fl_get_visual_depth();
  /* can't do it if less than 4 bit deep */
  if(depth < 4)
  {
    fprintf(stderr,"This Demo requires a depth of at least 4 bits\n");
    exit(1);
  }

  cole = ((1 << depth)-1);
  if(cole > 64)
     cole = 64;

  obj->u_ldata = col = FL_FREE_COL1;
  cole += col;

  for ( i = col; i <= cole; i++)
  {
     j = 255 * (i - col) /(float)(cole  - col);
     fl_mapcolor(i, j, j, j);
  }

  fl_show_form(form,FL_PLACE_CENTER,FL_NOBORDER,"Free Object");
  fl_do_forms();
  return 0;
}
