#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>
#include <windows.h>

#include "flutter_window.h"
#include "utils.h"

int APIENTRY wWinMain(_In_ HINSTANCE instance, _In_opt_ HINSTANCE prev,
        _In_ wchar_t *command_line, _In_ int show_command) {
// Attach to console when present (e.g., 'flutter run') or create a
// new console when running with a debugger.
if (!::AttachConsole(ATTACH_PARENT_PROCESS) && ::IsDebuggerPresent()) {
CreateAndAttachConsole();
}

// Initialize COM, so that it is available for use in the library and/or
// plugins.
::CoInitializeEx(nullptr, COINIT_APARTMENTTHREADED);

flutter::DartProject project(L"data");

std::vector<std::string> command_line_arguments =
        GetCommandLineArguments();

project.set_dart_entrypoint_arguments(std::move(command_line_arguments));

FlutterWindow window(project);

// Get the screen dimensions
RECT desktop;
const HWND hDesktop = GetDesktopWindow();
GetWindowRect(hDesktop, &desktop);

// Define the window size as a percentage of the screen size
double widthPercentage = 1;  // 100% of screen width
double heightPercentage = 0.90; // 90% of screen height

int screen_width = desktop.right;
int screen_height = desktop.bottom;

int window_width = static_cast<int>(screen_width * widthPercentage);
int window_height = static_cast<int>(screen_height * heightPercentage);

// Calculate the position to center the window
int window_x = (screen_width - window_width);
int window_y = (screen_height - window_height);

Win32Window::Point origin(window_x, window_y);
Win32Window::Size size(window_width, window_height);

if (!window.Create(L"Canteen Management", origin, size)) {
return EXIT_FAILURE;
}
window.SetQuitOnClose(true);

::MSG msg;
while (::GetMessage(&msg, nullptr, 0, 0)) {
::TranslateMessage(&msg);
::DispatchMessage(&msg);
}

::CoUninitialize();
return EXIT_SUCCESS;
}
