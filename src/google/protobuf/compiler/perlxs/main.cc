#include <iostream>
#include <string>
#include <google/protobuf/compiler/command_line_interface.h>
#include <google/protobuf/compiler/cpp/cpp_generator.h>
#include <google/protobuf/compiler/perlxs/perlxs_generator.h>

using namespace std;

int main(int argc, char* argv[]) {
  google::protobuf::compiler::CommandLineInterface cli;

  // Proto2 C++ (for convenience, so the user doesn't need to call
  // protoc separately)

  google::protobuf::compiler::cpp::CppGenerator cpp_generator;
  cli.RegisterGenerator("--cpp_out",
			&cpp_generator,
                        "Generate C++ header and source.");

  // Proto2 Perl/XS
  google::protobuf::compiler::perlxs::PerlXSGenerator perlxs_generator;
  cli.RegisterGenerator("--out",
			&perlxs_generator,
                        "Generate Perl/XS source files.");

  cli.SetVersionInfo(perlxs_generator.GetVersionInfo());

  // process Perl/XS command line options first, and filter them out
  // of the argument list.  we really need to be able to register
  // options with the CLI instead of doing this stupid hack here.

  int j = 1;
  for (int i = 1; i < argc; i++) {
    if (perlxs_generator.ProcessOption(argv[i]) == false) {
      argv[j++] = argv[i];
    }
  }

  return cli.Run(j, argv);
}
