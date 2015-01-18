#ifndef GOOGLE_PROTOBUF_COMPILER_PERLXS_HELPERS_H__
#define GOOGLE_PROTOBUF_COMPILER_PERLXS_HELPERS_H__

#include <map>
#include <string>

namespace google {
namespace protobuf {

extern std::string StringReplace(const std::string& s,
				 const std::string& oldsub,
				 const std::string& newsub,
				 bool replace_all);

namespace compiler {
namespace perlxs {

void SetupDepthVars(std::map<std::string, std::string>& vars, int depth);

}  // namespace perlxs
}  // namespace compiler
}  // namespace protobuf
}  // namespace google

#endif  // GOOGLE_PROTOBUF_COMPILER_PERLXS_HELPERS_H__
