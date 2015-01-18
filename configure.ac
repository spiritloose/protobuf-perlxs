AC_INIT([protobuf-perlxs], [1.1], [dave@daveb.net])
AM_INIT_AUTOMAKE([-Wall])
AC_LANG([C++])
AC_PROG_CXX
AC_PROG_CC
AC_PROG_INSTALL

dnl Look for protobuf headers and libs

AC_ARG_WITH(protobuf,
[  --with-protobuf[=DIR]     where to find Google's Protocol Buffers],,
  with_protobuf=yes)

if test "$with_protobuf" != no; then
  if test -d "$with_protobuf"; then
    CPPFLAGS="$CPPFLAGS -I$with_protobuf/include"
    LDFLAGS="$LDFLAGS -L$with_protobuf/lib"
  else
    AC_CHECK_HEADER([google/protobuf/stubs/common.h],,
    [AC_MSG_ERROR([protobuf headers are required.  Try using the --with-protobuf option.])])
  fi
fi

AC_CONFIG_FILES([
Makefile
src/Makefile
src/google/protobuf/compiler/perlxs/perlxs_config.h
examples/big/Makefile.PL
examples/embedded/Makefile.PL
examples/error/Makefile.PL
examples/package/Makefile.PL
examples/simple/Makefile.PL
examples/string_bytes/Makefile.PL
examples/types/Makefile.PL
])
AC_OUTPUT

