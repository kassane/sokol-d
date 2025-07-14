// Use importC to import the C header files.
#pragma attribute(push, nogc, nothrow, pure) // dmdfrontend-2.111.x feature

#if (defined __x86_64__ || defined _M_X64 ||                                   \
     (defined(_M_IX86_FP) && (_M_IX86_FP >= 1)))
#define IMGUI_DISABLE_SSE
#endif

#if defined(__linux__) && defined(__aarch64__)
#define IMGUI_DISABLE_DEFAULT_MATH_FUNCTIONS

extern float acosf(float x);
extern float atan2f(float x, float y);
extern double atof(const char *str);
extern float ceilf(float x);
extern float cosf(float x);
extern float fabsf(float x);
extern float fmodf(float x, float y);
extern float powf(float x, float y);
extern float sinf(float x);
extern float sqrtf(float x);

#define ImFabs(X) fabsf(X)
#define ImSqrt(X) sqrtf(X)
#define ImFmod(X, Y) fmodf((X), (Y))
#define ImCos(X) cosf(X)
#define ImSin(X) sinf(X)
#define ImAcos(X) acosf(X)
#define ImAtan2(Y, X) atan2f((Y), (X))
#define ImAtof(STR) atof(STR)
#define ImCeil(X) ceilf(X)
#endif
#include <cimgui_all.h>
#pragma attribute(pop)
