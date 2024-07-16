# Distributed under the OSI-approved MIT License.  See accompanying
# file LICENSE or https://github.com/Crascit/DownloadProject for details.

cmake_minimum_required(VERSION 3.10)

project(pdfium-download NONE)

include(ExternalProject)

if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.24")
  cmake_policy(SET CMP0135 NEW)
endif()

ExternalProject_Add(pdfium-download
                    URL;https://github.com/bblanchon/pdfium-binaries/releases/download/chromium/4929/pdfium-win-x64.tgz
                    SOURCE_DIR          "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/pdfium-src"
                    BINARY_DIR          "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/pdfium-build"
                    CONFIGURE_COMMAND   ""
                    BUILD_COMMAND       ""
                    INSTALL_COMMAND     ""
                    TEST_COMMAND        ""
)
