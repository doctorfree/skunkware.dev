#ifndef FD_buttform_h_
#define FD_buttform_h_
/* Header file generated with fdesign. */

/**** Callback routines ****/

extern void done_cb(FL_OBJECT *, long);
extern void bw_cb(FL_OBJECT *, long);


/**** Forms and Objects ****/

typedef struct {
	FL_FORM *buttform;
	void *vdata;
	long ldata;
	FL_OBJECT *backface;
	FL_OBJECT *done;
	FL_OBJECT *objsgroup;
	FL_OBJECT *bbutt;
	FL_OBJECT *pbutt;
	FL_OBJECT *bw_obj;
} FD_buttform;

extern FD_buttform * create_form_buttform(void);

#endif /* FD_buttform_h_ */
