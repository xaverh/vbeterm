cmake_minimum_required(VERSION 3.12)
project(vbeterm LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
find_package(PkgConfig REQUIRED)
pkg_check_modules(VTE REQUIRED IMPORTED_TARGET vte-2.91)
pkg_check_modules(GTK REQUIRED IMPORTED_TARGET gtk+-3.0 gdk-3.0)
pkg_check_modules(X11 REQUIRED IMPORTED_TARGET x11)
pkg_check_modules(FONTCONFIG REQUIRED IMPORTED_TARGET fontconfig)
execute_process(
  COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/get-version
  OUTPUT_VARIABLE VBE_VERSION
  OUTPUT_STRIP_TRAILING_WHITESPACE
  ERROR_QUIET
)
if(NOT VBE_VERSION)
  set(VBE_VERSION "unknown")
endif()
add_executable(vbeterm src/term.cxx src/color.cxx)
target_link_libraries(vbeterm PRIVATE
  PkgConfig::VTE
  PkgConfig::GTK
  PkgConfig::X11
  PkgConfig::FONTCONFIG
  m
)
target_compile_definitions(vbeterm PRIVATE
  PACKAGE_NAME="vbeterm"
  PACKAGE_VERSION="${VBE_VERSION}"
  VERSION="${VBE_VERSION}"
)
if(CMAKE_CXX_COMPILER_ID MATCHES "GNU|Clang")
  target_compile_options(vbeterm PRIVATE
    -fdiagnostics-show-option
    -pipe
    -Wall
    -W
    -Wextra
    -Wformat
    -Wformat-security
    -Wfatal-errors
    -Wcast-align
    -Winline
    -fstack-protector
    -Wno-unused-parameter
    -Wno-missing-field-initializers
  )
  target_compile_definitions(vbeterm PRIVATE _FORTIFY_SOURCE=2)
  target_link_options(vbeterm PRIVATE
    -Wl,-z,relro
    -Wl,-z,now
  )
endif()
include(GNUInstallDirs)
install(TARGETS vbeterm DESTINATION ${CMAKE_INSTALL_BINDIR})
