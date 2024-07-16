# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/pdfium-src"
  "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/pdfium-build"
  "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/pdfium-download/pdfium-download-prefix"
  "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/pdfium-download/pdfium-download-prefix/tmp"
  "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/pdfium-download/pdfium-download-prefix/src/pdfium-download-stamp"
  "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/pdfium-download/pdfium-download-prefix/src"
  "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/pdfium-download/pdfium-download-prefix/src/pdfium-download-stamp"
)

set(configSubDirs Debug;Release;MinSizeRel;RelWithDebInfo)
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/pdfium-download/pdfium-download-prefix/src/pdfium-download-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/pdfium-download/pdfium-download-prefix/src/pdfium-download-stamp${cfgdir}") # cfgdir has leading slash
endif()
