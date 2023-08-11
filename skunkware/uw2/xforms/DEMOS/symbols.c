#include "forms.h"
#include <stdlib.h>

char *symbols[] =
{
    "@>", 
    "@<-", 
    "@9->", 
    "@DnLine",
    "@8>", 
    "@circle",
    "@->|",
    "@>>", 
    "@square",
    "@4->|",
/*    "@8->|", */
    "@<->",
    "@UpArrow",
    "@9+",
    "@->", 
    "@<", 
    "@DnArrow",
    "@+",
    "@-->", 
    "@line", 
    "@3->", 
    "@UpLine",
    "@>|", 
    "@2-->", 
    "@4>|", 
    "@8>|", 
    "@=", 
    "@menu", 
    "@8=",
    "@|>",
    "@2|>",
    "@-32|>",
    "@+32|>",
    "@-2circle",
    0
};

#define N  (sizeof(symbols)/sizeof(*symbols) - 1)

FL_FORM *form;

static void
done_cb(FL_OBJECT *ob, long data)
{
   exit(0);
}

void
make_symbols(void)
{
    char **p, buf[32];
    int x0 = 10, y0 = 10, dx = 35, dy = 35, ty = 17 , n = 7;
    int xsep = 15, ysep = 5;
    int x,y, i, w, h;
    FL_OBJECT *obj;

    form = fl_bgn_form(FL_FLAT_BOX,
                       w = 2 * x0 + n * dx + (n-1)* xsep,
                       h = 2 * y0 + (1 + (N/n) - !(N%n)) * (dy+ty + ysep));
    obj = fl_add_button(FL_HIDDEN_BUTTON, 0, 0, w, h,"");
    fl_set_object_callback(obj,done_cb,0);

    for ( x = x0, y=y0, i = 1, p = symbols; *p; p++, i++) 
    {
        obj = fl_add_box(FL_UP_BOX,x,y,dx,dy,*p);
        fl_set_object_lcol(obj, FL_BOTTOM_BCOL);
        strcat(strcpy(buf," "),*p);
        fl_add_box(FL_FLAT_BOX,x, y+dy, dx, ty,buf);
        if((i%n)==0)
        {
           static int j = 1;
            x = x0;
            y = y0 +  j * ( dy + ty + ysep + 1); 
            j++;
         }
         else
           x += dx +  xsep;
     }

     fl_end_form();

     fl_adjust_form_size(form);
}

int
main(int argc, char *argv[])
{
     fl_initialize(&argc, argv , 0, 0, 0);
     make_symbols();
     fl_show_form(form, FL_PLACE_FREE, FL_FULLBORDER, "test");

     while (fl_do_forms())
        ;
     return 0;
}
