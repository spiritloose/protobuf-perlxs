#ifndef GOOGLE_PROTOBUF_COMPILER_PERLXS_GENERATOR_H__
#define GOOGLE_PROTOBUF_COMPILER_PERLXS_GENERATOR_H__

#include <google/protobuf/compiler/code_generator.h>
#include <google/protobuf/descriptor.h>
#include <google/protobuf/stubs/common.h>

#include <iostream>
#include <map>
#include <set>
#include <string>
#include <vector>

namespace google {
namespace protobuf {

class Descriptor;
class EnumDescriptor;
class EnumValueDescriptor;
class FieldDescriptor;
class ServiceDescriptor;

namespace io {
class Printer;
}

namespace compiler {

// A couple of the C++ code generator headers are not installed, but
// we need to call into that code in a few places.  We duplicate the
// function prototypes here.

namespace cpp {
extern std::string ClassName(const Descriptor* d);
extern std::string ClassName(const EnumDescriptor* d);
extern std::string FieldName(const FieldDescriptor* field);
extern std::string StripProto(const std::string& filename);
}  // namespace cpp

namespace perlxs {

// CodeGenerator implementation for generated Perl/XS protocol buffer
// classes.  If you create your own protocol compiler binary and you
// want it to support Perl/XS output, you can do so by registering an
// instance of this CodeGenerator with the CommandLineInterface in
// your main() function.
class LIBPROTOC_EXPORT PerlXSGenerator : public CodeGenerator {
 public:
  PerlXSGenerator();
  virtual ~PerlXSGenerator();

  // implements CodeGenerator ----------------------------------------
  virtual bool Generate(const FileDescriptor* file,
                        const std::string& parameter,
                        OutputDirectory* output_directory,
                        std::string* error) const;

  const std::string& GetVersionInfo() const;
  bool ProcessOption(const std::string& option);

 private:
  GOOGLE_DISALLOW_EVIL_CONSTRUCTORS(PerlXSGenerator);

 private:
  void GenerateXS(const FileDescriptor* file, OutputDirectory* output_directory,
                  std::string& base) const;

  void GenerateMessageXS(const Descriptor* descriptor,
                         OutputDirectory* outdir) const;

  void GenerateMessageModule(const Descriptor* descriptor,
                             OutputDirectory* outdir) const;

  void GenerateMessagePOD(const Descriptor* descriptor,
                          OutputDirectory* outdir) const;

  void GenerateDescriptorClassNamePOD(const Descriptor* descriptor,
                                      io::Printer& printer) const;

  void GenerateDescriptorMethodPOD(const Descriptor* descriptor,
                                   io::Printer& printer) const;

  void GenerateEnumModule(const EnumDescriptor* enum_descriptor,
                          OutputDirectory* outdir) const;

  void GenerateMessageXSFieldAccessors(const FieldDescriptor* field,
                                       io::Printer& printer,
                                       const std::string& classname) const;

  void GenerateMessageXSCommonMethods(const Descriptor* descriptor,
                                      io::Printer& printer,
                                      const std::string& classname) const;

  void GenerateFileXSTypedefs(const FileDescriptor* file, io::Printer& printer,
                              std::set<const Descriptor*>& seen) const;

  void GenerateMessageXSTypedefs(const Descriptor* descriptor,
                                 io::Printer& printer,
                                 std::set<const Descriptor*>& seen) const;

  void GenerateMessageStatics(const Descriptor* descriptor,
                              io::Printer& printer) const;

  void GenerateMessageXSPackage(const Descriptor* descriptor,
                                io::Printer& printer) const;

  void GenerateTypemapInput(const Descriptor* descriptor, io::Printer& printer,
                            const std::string& svname) const;

  std::string QualifiedClassName(const Descriptor* d) const;

  std::string QualifiedClassName(const EnumDescriptor* d) const;

  std::string MessageModuleName(const Descriptor* descriptor) const;

  std::string MessageClassName(const Descriptor* descriptor) const;

  std::string EnumClassName(const EnumDescriptor* descriptor) const;

  std::string PackageName(const std::string& name,
                          const std::string& package) const;

  void PerlSVGetHelper(io::Printer& printer,
                       const std::map<std::string, std::string>& vars,
                       FieldDescriptor::CppType fieldtype, int depth) const;

  void PODPrintEnumValue(const EnumValueDescriptor* value,
                         io::Printer& printer) const;

  std::string PODFieldTypeString(const FieldDescriptor* field) const;

  void StartFieldToHashref(const FieldDescriptor* field, io::Printer& printer,
                           std::map<std::string, std::string>& vars,
                           int depth) const;

  void FieldToHashrefHelper(io::Printer& printer,
                            std::map<std::string, std::string>& vars,
                            const FieldDescriptor* field) const;

  void EndFieldToHashref(const FieldDescriptor* field, io::Printer& printer,
                         std::map<std::string, std::string>& vars,
                         int depth) const;

  void MessageToHashref(const Descriptor* descriptor, io::Printer& printer,
                        std::map<std::string, std::string>& vars,
                        int depth) const;

  void FieldFromHashrefHelper(io::Printer& printer,
                              std::map<std::string, std::string>& vars,
                              const FieldDescriptor* field) const;

  void MessageFromHashref(const Descriptor* descriptor, io::Printer& printer,
                          std::map<std::string, std::string>& vars,
                          int depth) const;

 private:
  // --perlxs-package option (if given)
  std::string perlxs_package_;
};

}  // namespace perlxs
}  // namespace compiler
}  // namespace protobuf
}  // namespace google
#endif  // GOOGLE_PROTOBUF_COMPILER_PERLXS_GENERATOR_H__
