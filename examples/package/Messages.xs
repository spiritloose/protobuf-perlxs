#ifdef __cplusplus
extern "C" {
#endif
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#ifdef __cplusplus
}
#endif

// Taken from Glib and Gtk

static void
call_XS ( pTHX_ void (*subaddr) (pTHX_ CV *), CV * cv, SV ** mark )
{
  dSP;
  PUSHMARK (mark);
  (*subaddr) (aTHX_ cv);
  PUTBACK;
}

#define CALL_BOOT(name)	call_XS (aTHX_ name, cv, mark)

// We need these declarations with "C" linkage

#ifdef __cplusplus
extern "C" {
#endif
  XS(boot_Local__Messages__One);
  XS(boot_Local__Messages__Two);
  XS(boot_Local__Messages__Three);
#ifdef __cplusplus
}
#endif

// Bootstrap this module by bootstrapping all of the others.

MODULE = Local::Messages	PACKAGE = Local::Messages

BOOT:
	CALL_BOOT(boot_Local__Messages__One);
	CALL_BOOT(boot_Local__Messages__Two);
	CALL_BOOT(boot_Local__Messages__Three);
