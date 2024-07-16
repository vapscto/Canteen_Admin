# Install script for directory: D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/windows

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "$<TARGET_FILE_DIR:canteen_management>")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/flutter/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/bitsdojo_window_windows/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/connectivity_plus/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/desktop_window/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/flutter_acrylic/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/platform_device_id_windows/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/printing/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/screen_retriever/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/smart_auth/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/syncfusion_pdfviewer_windows/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/url_launcher_windows/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/window_manager/cmake_install.cmake")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Debug/canteen_management.exe")
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    file(INSTALL DESTINATION "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Debug" TYPE EXECUTABLE FILES "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Debug/canteen_management.exe")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Pp][Rr][Oo][Ff][Ii][Ll][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Profile/canteen_management.exe")
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    file(INSTALL DESTINATION "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Profile" TYPE EXECUTABLE FILES "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Profile/canteen_management.exe")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Release/canteen_management.exe")
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    file(INSTALL DESTINATION "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Release" TYPE EXECUTABLE FILES "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Release/canteen_management.exe")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Debug/data/icudtl.dat")
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    file(INSTALL DESTINATION "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Debug/data" TYPE FILE FILES "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/windows/flutter/ephemeral/icudtl.dat")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Pp][Rr][Oo][Ff][Ii][Ll][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Profile/data/icudtl.dat")
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    file(INSTALL DESTINATION "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Profile/data" TYPE FILE FILES "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/windows/flutter/ephemeral/icudtl.dat")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Release/data/icudtl.dat")
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    file(INSTALL DESTINATION "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Release/data" TYPE FILE FILES "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/windows/flutter/ephemeral/icudtl.dat")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Debug/flutter_windows.dll")
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    file(INSTALL DESTINATION "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Debug" TYPE FILE FILES "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/windows/flutter/ephemeral/flutter_windows.dll")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Pp][Rr][Oo][Ff][Ii][Ll][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Profile/flutter_windows.dll")
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    file(INSTALL DESTINATION "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Profile" TYPE FILE FILES "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/windows/flutter/ephemeral/flutter_windows.dll")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Release/flutter_windows.dll")
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    file(INSTALL DESTINATION "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Release" TYPE FILE FILES "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/windows/flutter/ephemeral/flutter_windows.dll")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Debug/bitsdojo_window_windows_plugin.lib;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Debug/connectivity_plus_plugin.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Debug/desktop_window_plugin.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Debug/flutter_acrylic_plugin.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Debug/platform_device_id_windows_plugin.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Debug/printing_plugin.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Debug/pdfium.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Debug/screen_retriever_plugin.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Debug/smart_auth_plugin.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Debug/syncfusion_pdfviewer_windows_plugin.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Debug/pdfium.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Debug/url_launcher_windows_plugin.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Debug/window_manager_plugin.dll")
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    file(INSTALL DESTINATION "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Debug" TYPE FILE FILES
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/bitsdojo_window_windows/Debug/bitsdojo_window_windows_plugin.lib"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/connectivity_plus/Debug/connectivity_plus_plugin.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/desktop_window/Debug/desktop_window_plugin.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/flutter_acrylic/Debug/flutter_acrylic_plugin.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/platform_device_id_windows/Debug/platform_device_id_windows_plugin.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/printing/Debug/printing_plugin.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/pdfium-src/bin/pdfium.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/screen_retriever/Debug/screen_retriever_plugin.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/smart_auth/Debug/smart_auth_plugin.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/syncfusion_pdfviewer_windows/Debug/syncfusion_pdfviewer_windows_plugin.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/pdfium-src/bin/pdfium.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/url_launcher_windows/Debug/url_launcher_windows_plugin.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/window_manager/Debug/window_manager_plugin.dll"
      )
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Pp][Rr][Oo][Ff][Ii][Ll][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Profile/bitsdojo_window_windows_plugin.lib;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Profile/connectivity_plus_plugin.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Profile/desktop_window_plugin.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Profile/flutter_acrylic_plugin.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Profile/platform_device_id_windows_plugin.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Profile/printing_plugin.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Profile/pdfium.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Profile/screen_retriever_plugin.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Profile/smart_auth_plugin.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Profile/syncfusion_pdfviewer_windows_plugin.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Profile/pdfium.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Profile/url_launcher_windows_plugin.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Profile/window_manager_plugin.dll")
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    file(INSTALL DESTINATION "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Profile" TYPE FILE FILES
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/bitsdojo_window_windows/Profile/bitsdojo_window_windows_plugin.lib"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/connectivity_plus/Profile/connectivity_plus_plugin.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/desktop_window/Profile/desktop_window_plugin.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/flutter_acrylic/Profile/flutter_acrylic_plugin.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/platform_device_id_windows/Profile/platform_device_id_windows_plugin.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/printing/Profile/printing_plugin.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/pdfium-src/bin/pdfium.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/screen_retriever/Profile/screen_retriever_plugin.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/smart_auth/Profile/smart_auth_plugin.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/syncfusion_pdfviewer_windows/Profile/syncfusion_pdfviewer_windows_plugin.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/pdfium-src/bin/pdfium.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/url_launcher_windows/Profile/url_launcher_windows_plugin.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/window_manager/Profile/window_manager_plugin.dll"
      )
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Release/bitsdojo_window_windows_plugin.lib;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Release/connectivity_plus_plugin.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Release/desktop_window_plugin.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Release/flutter_acrylic_plugin.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Release/platform_device_id_windows_plugin.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Release/printing_plugin.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Release/pdfium.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Release/screen_retriever_plugin.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Release/smart_auth_plugin.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Release/syncfusion_pdfviewer_windows_plugin.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Release/pdfium.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Release/url_launcher_windows_plugin.dll;D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Release/window_manager_plugin.dll")
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    file(INSTALL DESTINATION "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Release" TYPE FILE FILES
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/bitsdojo_window_windows/Release/bitsdojo_window_windows_plugin.lib"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/connectivity_plus/Release/connectivity_plus_plugin.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/desktop_window/Release/desktop_window_plugin.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/flutter_acrylic/Release/flutter_acrylic_plugin.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/platform_device_id_windows/Release/platform_device_id_windows_plugin.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/printing/Release/printing_plugin.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/pdfium-src/bin/pdfium.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/screen_retriever/Release/screen_retriever_plugin.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/smart_auth/Release/smart_auth_plugin.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/syncfusion_pdfviewer_windows/Release/syncfusion_pdfviewer_windows_plugin.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/pdfium-src/bin/pdfium.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/url_launcher_windows/Release/url_launcher_windows_plugin.dll"
      "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/plugins/window_manager/Release/window_manager_plugin.dll"
      )
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    
  file(REMOVE_RECURSE "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Debug/data/flutter_assets")
  
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Pp][Rr][Oo][Ff][Ii][Ll][Ee])$")
    
  file(REMOVE_RECURSE "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Profile/data/flutter_assets")
  
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    
  file(REMOVE_RECURSE "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Release/data/flutter_assets")
  
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Debug/data/flutter_assets")
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    file(INSTALL DESTINATION "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Debug/data" TYPE DIRECTORY FILES "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build//flutter_assets")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Pp][Rr][Oo][Ff][Ii][Ll][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Profile/data/flutter_assets")
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    file(INSTALL DESTINATION "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Profile/data" TYPE DIRECTORY FILES "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build//flutter_assets")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Release/data/flutter_assets")
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    file(INSTALL DESTINATION "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Release/data" TYPE DIRECTORY FILES "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build//flutter_assets")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Runtime" OR NOT CMAKE_INSTALL_COMPONENT)
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Pp][Rr][Oo][Ff][Ii][Ll][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Profile/data/app.so")
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    file(INSTALL DESTINATION "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Profile/data" TYPE FILE FILES "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/app.so")
  elseif(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
     "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Release/data/app.so")
    if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
      message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
    endif()
    file(INSTALL DESTINATION "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/runner/Release/data" TYPE FILE FILES "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/app.so")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "D:/Flutter_application/flutter_windows_application/canteen_admin/Canteen_Admin/build/windows/x64/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
