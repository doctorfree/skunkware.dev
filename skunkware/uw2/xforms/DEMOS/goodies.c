/* This demo program uses the routines in the
   goodies section, that help you create easy
   forms in an even easier way.
*/

#include <stdlib.h>
#include <string.h>
#include "forms.h"

int
main(int argc, char *argv[])
{
  int choice;
  char str1[100],str2[100];
  const char *s;

  fl_initialize(&argc, argv, "FormDemo", 0, 0);

#if 0
  fl_set_resource(FLOKLabel,"Go");
#endif

  if( fl_show_question("Do you want bold font ?",1))
     fl_set_goodies_font(FL_BOLD_STYLE,FL_NORMAL_SIZE);

  fl_show_messages("This is a test program for the goodies of the"
		"forms library");

  fl_show_alert("Alert", "Alert form can be used to inform", 
               "recoverable errors", 0);

  if (fl_show_question("Do you want to quit?", 0))
      exit(0);

  strcpy(str1,(s=fl_show_input("Give a string:","")) ? s:"");
  fl_show_message("You typed:","",str1);
  choice = fl_show_choices("Pick a choice",3,"One","Two","Three",2);
  switch(choice)
  {
    case 1: fl_show_message("You typed: One","",""); break;
    case 2: fl_show_message("You typed: Two","",""); break;
    case 3: fl_show_message("You typed: Three","",""); break;
    default: fl_show_message("An error occured!","",""); break;
  }

  strcpy(str2,(s=fl_show_input("Give another string:",str1)) ? s:"<Cancel>");
  fl_show_message("You typed:","",str2);
  fl_show_messages("Good Bye");
  return 0;
}
