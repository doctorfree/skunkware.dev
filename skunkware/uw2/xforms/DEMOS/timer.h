#ifndef FD_timerform_h_
#define FD_timerform_h_
/* Header file generated with fdesign. */

/**** Callback routines ****/

extern void expired(FL_OBJECT *, long);
extern void suspend_resume(FL_OBJECT *, long);
extern void reset(FL_OBJECT *, long);
extern void timer_direction(FL_OBJECT *, long);


/**** Forms and Objects ****/

typedef struct {
	FL_FORM *timerform;
	FL_OBJECT *timer;
	FL_OBJECT *down;
	void *vdata;
	long ldata;
} FD_timerform;

extern FD_timerform * create_form_timerform(void);

#endif /* FD_timerform_h_ */
