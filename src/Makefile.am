bin_PROGRAMS = protoxs

protoxs_SOURCES = \
	google/protobuf/compiler/perlxs/perlxs_generator.cc \
	google/protobuf/compiler/perlxs/perlxs_helpers.cc \
	google/protobuf/compiler/perlxs/main.cc

protoxs_LDADD = -lprotoc -lprotobuf -lpthread

noinst_HEADERS = \
	google/protobuf/compiler/perlxs/perlxs_generator.h \
	google/protobuf/compiler/perlxs/perlxs_helpers.h \
	google/protobuf/compiler/perlxs/perlxs_config.h

