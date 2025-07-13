// Use importC to import the C header files.
#pragma attribute(push, nogc, nothrow, pure) // dmdfrontend-2.111.x feature
#define IMGUI_DISABLE_SSE
#include <cimgui_all.h>
#pragma attribute(pop)
