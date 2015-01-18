#include <vector>
#include <sstream>
#include <google/protobuf/compiler/perlxs/perlxs_helpers.h>
#include <google/protobuf/io/printer.h>
#include <google/protobuf/descriptor.pb.h>

namespace google {
namespace protobuf {

extern string StringReplace(const string& s, const string& oldsub,
			    const string& newsub, bool replace_all);

namespace compiler {
namespace perlxs {

void
SetupDepthVars(map<string, string>& vars, int depth)
{
  ostringstream ost_pdepth;
  ostringstream ost_depth;
  ostringstream ost_ndepth;

  ost_pdepth << depth;
  ost_depth  << depth + 1;
  ost_ndepth << depth + 2;

  vars["pdepth"] = ost_pdepth.str();
  vars["depth"]  = ost_depth.str();
  vars["ndepth"] = ost_ndepth.str();
}

}  // namespace perlxs
}  // namespace compiler
}  // namespace protobuf
}  // namespace google
