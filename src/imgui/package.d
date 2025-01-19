/++
This is a D wrapper around the C cimgui library (Dear ImGui).
It provides D bindings for the Dear ImGui immediate mode GUI library.
The bindings are generated using importC and manually curated.

Features:
- Full ImGui API coverage
- @trusted (unsafe/user-checked) wrapper functions
- Uses importC to directly interface with C code - @system (unsafe) functions by default
- Preserves ImGui's original style and naming conventions
- Handles memory management and context safety
+/

module imgui;
public import imgui.dcimgui;

/++

Index of this file:
// [SECTION] Header mess
// [SECTION] Forward declarations and basic types
// [SECTION] Dear ImGui end-user API functions
// [SECTION] Flags & Enumerations
// [SECTION] Tables API flags and structures (ImGuiTableFlags, ImGuiTableColumnFlags, ImGuiTableRowFlags, ImGuiTableBgTarget, ImGuiTableSortSpecs, ImGuiTableColumnSortSpecs)
// [SECTION] Helpers: Debug log, Memory allocations macros, ImVector<>
// [SECTION] ImGuiStyle
// [SECTION] ImGuiIO
// [SECTION] Misc data structures (ImGuiInputTextCallbackData, ImGuiSizeCallbackData, ImGuiPayload)
// [SECTION] Helpers (ImGuiOnceUponAFrame, ImGuiTextFilter, ImGuiTextBuffer, ImGuiStorage, ImGuiListClipper, Math Operators, ImColor)
// [SECTION] Multi-Select API flags and structures (ImGuiMultiSelectFlags, ImGuiMultiSelectIO, ImGuiSelectionRequest, ImGuiSelectionBasicStorage, ImGuiSelectionExternalStorage)
// [SECTION] Drawing API (ImDrawCallback, ImDrawCmd, ImDrawIdx, ImDrawVert, ImDrawChannel, ImDrawListSplitter, ImDrawFlags, ImDrawListFlags, ImDrawList, ImDrawData)
// [SECTION] Font API (ImFontConfig, ImFontGlyph, ImFontGlyphRangesBuilder, ImFontAtlasFlags, ImFontAtlas, ImFont)
// [SECTION] Viewports (ImGuiViewportFlags, ImGuiViewport)
// [SECTION] ImGuiPlatformIO + other Platform Dependent Interfaces (ImGuiPlatformImeData)
// [SECTION] Obsolete functions and types

+/

/// Context creation and access
/// - Each context create its own ImFontAtlas by default. You may instance one yourself and pass it to CreateContext() to share a font atlas between contexts.
/// - DLL users: heaps and globals are not shared across DLL boundaries! You will need to call SetCurrentContext() + SetAllocatorFunctions()
///   for each static/DLL boundary you are calling from. Read "Context and Memory Allocators" section of imgui.cpp for details.
scope ImGuiContext_t* CreateContext(scope const(ImFontAtlas_t)* shared_font_atlas) @trusted
{
    return igCreateContext(cast(ImFontAtlas_t*) shared_font_atlas);
}

void DestroyContext(scope ImGuiContext_t* ctx) @trusted
{
    igDestroyContext(ctx);
}

scope ImGuiContext_t* GetCurrentContext() @trusted
{
    return igGetCurrentContext();
}

void SetCurrentContext(scope ImGuiContext_t* ctx) @trusted
{
    igSetCurrentContext(ctx);
}

/// Main

/// access the ImGuiIO structure (mouse/keyboard/gamepad inputs, time, various configuration options/flags)
scope ImGuiIO_t* GetIO() @trusted
{
    return igGetIO();
}
/// access the ImGuiPlatformIO structure (mostly hooks/functions to connect to platform/renderer and OS Clipboard, IME etc.)
scope ImGuiPlatformIO_t* GetPlatformIO() @trusted
{
    return igGetPlatformIO();
}
/// access the Style structure (colors, sizes). Always use PushStyleColor(), PushStyleVar() to modify style mid-frame!
scope ImGuiStyle_t* GetStyle() @trusted
{
    return igGetStyle();
}
/// start a new Dear ImGui frame, you can submit any command from this point until Render()/EndFrame().
void NewFrame() @trusted
{
    igNewFrame();
}
/// ends the Dear ImGui frame. automatically called by Render(). If you don't need to render data (skipping rendering) you may call EndFrame() without Render()...
/// but you'll have wasted CPU already! If you don't need to render, better to not create any windows and not call NewFrame() at all!
void EndFrame() @trusted
{
    igEndFrame();
}
/// ends the Dear ImGui frame, finalize the draw data. You can then get call GetDrawData().
void Render() @trusted
{
    igRender();
}
/// valid after Render() and until the next call to NewFrame(). this is what you have to render.
scope ImDrawData_t* GetDrawData() @trusted
{
    return igGetDrawData();
}

/// Demo, Debug, Information

/// create Demo window. demonstrate most ImGui features. call this to learn about the library! try to make it always available in your application!
void ShowDemoWindow(scope bool* p_open) @trusted
{
    igShowDemoWindow(p_open);
}
/// create Metrics/Debugger window. display Dear ImGui internals: windows, draw commands, various internal state, etc.
void ShowMetricsWindow(scope bool* p_open) @trusted
{
    igShowMetricsWindow(p_open);
}
/// create Debug Log window. display a simplified log of important dear imgui events.
void ShowDebugLogWindow(scope bool* p_open) @trusted
{
    igShowDebugLogWindow(p_open);
}
/// Implied p_open = null
void ShowIDStackToolWindow() @trusted
{
    igShowIDStackToolWindow();
}
/// create Stack Tool window. hover items with mouse to query information about the source of their unique ID.
void ShowIDStackToolWindowEx(scope bool* p_open) @trusted
{
    igShowIDStackToolWindowEx(p_open);
}
/// create About window. display Dear ImGui version, credits and build/system information.
void ShowAboutWindow(scope bool* p_open) @trusted
{
    igShowAboutWindow(p_open);
}
/// add style editor block (not a window). you can pass in a reference ImGuiStyle structure to compare to, revert to and save to (else it uses the default style)
void ShowStyleEditor(scope ImGuiStyle_t* reference) @trusted
{
    igShowStyleEditor(reference);
}
/// add style selector block (not a window), essentially a combo listing the default styles.
bool ShowStyleSelector(scope const(char)* label) @trusted
{
    return igShowStyleSelector(label);
}
/// add font selector block (not a window), essentially a combo listing the loaded fonts.
void ShowFontSelector(scope const(char)* label) @trusted
{
    igShowFontSelector(label);
}
/// add basic help/info block (not a window): how to manipulate ImGui as an end-user (mouse/keyboard controls).
void ShowUserGuide() @trusted
{
    igShowUserGuide();
}
/// get the compiled version string e.g. "1.90" (essentially the value for IMGUI_VERSION from the compiled version of imgui.cpp)
scope const(char)* GetVersion() @trusted
{
    return igGetVersion();
}

/// Styles

/// new, recommended style (default)
void StyleColorsDark(scope ImGuiStyle_t* dst) @trusted
{
    igStyleColorsDark(dst);
}
/// best used with borders and a custom, thicker font
void StyleColorsLight(scope ImGuiStyle_t* dst) @trusted
{
    igStyleColorsLight(dst);
}
/// classic imgui style
void StyleColorsClassic(scope ImGuiStyle_t* dst) @trusted
{
    igStyleColorsClassic(dst);
}

/// Windows

/// - Begin() = push window to the stack and start appending to it. End() = pop window from the stack.
/// - Passing 'bool* p_open != NULL' shows a window-closing widget in the upper-right corner of the window,
///   which clicking will set the boolean to false when clicked.
/// - You may append multiple times to the same window during the same frame by calling Begin()/End() pairs multiple times.
///   Some information such as 'flags' or 'p_open' will only be considered by the first call to Begin().
/// - Begin() return false to indicate the window is collapsed or fully clipped, so you may early out and omit submitting
///   anything to the window. Always call a matching End() for each Begin() call, regardless of its return value!
///   [Important: due to legacy reason, Begin/End and BeginChild/EndChild are inconsistent with all other functions
///    such as BeginMenu/EndMenu, BeginPopup/EndPopup, etc. where the EndXXX call should only be called if the corresponding
///    BeginXXX function returned true. Begin and BeginChild are the only odd ones out. Will be fixed in a future update.]
/// - Note that the bottom of window stack always contains a window called "Debug".
bool Begin(scope const(char)* name, scope bool* p_open, int flags) @trusted
{
    return igBegin(name, p_open, flags);
}

void End() @trusted
{
    igEnd();
}

/// Child Windows

/// - Use child windows to begin into a self-contained independent scrolling/clipping regions within a host window. Child windows can embed their own child.
/// - Before 1.90 (November 2023), the "ImGuiChildFlags child_flags = 0" parameter was "bool border = false".
///   This API is backward compatible with old code, as we guarantee that ImGuiChildFlags_Borders == true.
///   Consider updating your old code:
///      BeginChild("Name", size, false)   -> Begin("Name", size, 0); or Begin("Name", size, ImGuiChildFlags_None);
///      BeginChild("Name", size, true)    -> Begin("Name", size, ImGuiChildFlags_Borders);
/// - Manual sizing (each axis can use a different setting e.g. ImVec2(0.0f, 400.0f)):
///     == 0.0f: use remaining parent window size for this axis.
///      > 0.0f: use specified size for this axis.
///      < 0.0f: right/bottom-align to specified distance from available content boundaries.
/// - Specifying ImGuiChildFlags_AutoResizeX or ImGuiChildFlags_AutoResizeY makes the sizing automatic based on child contents.
///   Combining both ImGuiChildFlags_AutoResizeX _and_ ImGuiChildFlags_AutoResizeY defeats purpose of a scrolling region and is NOT recommended.
/// - BeginChild() returns false to indicate the window is collapsed or fully clipped, so you may early out and omit submitting
///   anything to the window. Always call a matching EndChild() for each BeginChild() call, regardless of its return value.
///   [Important: due to legacy reason, Begin/End and BeginChild/EndChild are inconsistent with all other functions
///    such as BeginMenu/EndMenu, BeginPopup/EndPopup, etc. where the EndXXX call should only be called if the corresponding
///    BeginXXX function returned true. Begin and BeginChild are the only odd ones out. Will be fixed in a future update.]
bool BeginChild(scope const(char)* str_id, const ImVec2_t size, int child_flags, int window_flags) @trusted
{
    return igBeginChild(str_id, size, child_flags, window_flags);
}

bool BeginChildID(uint id, const ImVec2_t size, int child_flags, int window_flags) @trusted
{
    return igBeginChildID(id, size, child_flags, window_flags);
}

void EndChild() @trusted
{
    igEndChild();
}

/// Windows Utilities
/// - 'current window' = the window we are appending into while inside a Begin()/End() block. 'next window' = next window we will Begin() into.

bool IsWindowAppearing() @trusted
{
    return igIsWindowAppearing();
}

bool IsWindowCollapsed() @trusted
{
    return igIsWindowCollapsed();
}

bool IsWindowFocused(int flags) @trusted
{
    return igIsWindowFocused(flags);
}

bool IsWindowHovered(int flags) @trusted
{
    return igIsWindowHovered(flags);
}

scope const(ImDrawList_t)* GetWindowDrawList() @trusted
{
    return igGetWindowDrawList();
}

const(ImVec2_t) GetWindowPos() @trusted
{
    return igGetWindowPos();
}

const(ImVec2_t) GetWindowSize() @trusted
{
    return igGetWindowSize();
}

float GetWindowWidth() @trusted
{
    return igGetWindowWidth();
}

float GetWindowHeight() @trusted
{
    return igGetWindowHeight();
}
/// Window manipulation
/// - Prefer using SetNextXXX functions (before Begin) rather that SetXXX functions (after Begin).
void SetNextWindowPos(const(ImVec2_t) pos, int cond) @trusted
{
    igSetNextWindowPos(pos, cond);
}

void SetNextWindowPosEx(const(ImVec2_t) pos, int cond, const ImVec2_t pivot) @trusted
{
    igSetNextWindowPosEx(pos, cond, pivot);
}

void SetNextWindowSize(const(ImVec2_t) size, int cond) @trusted
{
    igSetNextWindowSize(size, cond);
}

extern (C) void SetNextWindowSizeConstraints(const(ImVec2_t) size_min, const ImVec2_t size_max, void function(
        scope ImGuiSizeCallbackData_t* data) custom_callback, scope void* custom_callback_data) @trusted
{
    igSetNextWindowSizeConstraints(size_min, size_max, custom_callback, custom_callback_data);
}

void SetNextWindowContentSize(const(ImVec2_t) size) @trusted
{
    igSetNextWindowContentSize(size);
}

void SetNextWindowCollapsed(bool collapsed, int cond) @trusted
{
    igSetNextWindowCollapsed(collapsed, cond);
}

void SetNextWindowFocus() @trusted
{
    igSetNextWindowFocus();
}

void SetNextWindowScroll(const(ImVec2_t) scroll) @trusted
{
    igSetNextWindowScroll(scroll);
}

void SetNextWindowBgAlpha(float alpha) @trusted
{
    igSetNextWindowBgAlpha(alpha);
}

void SetWindowPos(const(ImVec2_t) pos, int cond) @trusted
{
    igSetWindowPos(pos, cond);
}

void SetWindowSize(const(ImVec2_t) size, int cond) @trusted
{
    igSetWindowSize(size, cond);
}

void SetWindowCollapsed(bool collapsed, int cond) @trusted
{
    igSetWindowCollapsed(collapsed, cond);
}

void SetWindowFocus() @trusted
{
    igSetWindowFocus();
}

void SetWindowFontScale(float scale) @trusted
{
    igSetWindowFontScale(scale);
}

void SetWindowPosStr(scope const(char)* name, const ImVec2_t pos, int cond) @trusted
{
    igSetWindowPosStr(name, pos, cond);
}

void SetWindowSizeStr(scope const(char)* name, const ImVec2_t size, int cond) @trusted
{
    igSetWindowSizeStr(name, size, cond);
}

void SetWindowCollapsedStr(scope const(char)* name, bool collapsed, int cond) @trusted
{
    igSetWindowCollapsedStr(name, collapsed, cond);
}

void SetWindowFocusStr(scope const(char)* name) @trusted
{
    igSetWindowFocusStr(name);
}

float GetScrollX() @trusted
{
    return igGetScrollX();
}

float GetScrollY() @trusted
{
    return igGetScrollY();
}

void SetScrollX(float scroll_x) @trusted
{
    igSetScrollX(scroll_x);
}

void SetScrollY(float scroll_y) @trusted
{
    igSetScrollY(scroll_y);
}

float GetScrollMaxX() @trusted
{
    return igGetScrollMaxX();
}

float GetScrollMaxY() @trusted
{
    return igGetScrollMaxY();
}

void SetScrollHereX(float center_x_ratio) @trusted
{
    igSetScrollHereX(center_x_ratio);
}

void SetScrollHereY(float center_y_ratio) @trusted
{
    igSetScrollHereY(center_y_ratio);
}

void SetScrollFromPosX(float local_x, float center_x_ratio) @trusted
{
    igSetScrollFromPosX(local_x, center_x_ratio);
}

void SetScrollFromPosY(float local_y, float center_y_ratio) @trusted
{
    igSetScrollFromPosY(local_y, center_y_ratio);
}

void PushFont(scope const(ImFont_t)* font) @trusted
{
    igPushFont(cast(ImFont_t*) font);
}

void PopFont() @trusted
{
    igPopFont();
}

void PushStyleColor(int idx, uint col) @trusted
{
    igPushStyleColor(idx, col);
}

void PushStyleColorImVec4(int idx, const ImVec4_t col) @trusted
{
    igPushStyleColorImVec4(idx, col);
}

/// Layout cursor positioning
/// - By "cursor" we mean the current output position.
/// - The typical widget behavior is to output themselves at the current cursor position, then move the cursor one line down.
/// - You can call SameLine() between widgets to undo the last carriage return and output at the right of the preceding widget.
/// - YOU CAN DO 99% OF WHAT YOU NEED WITH ONLY GetCursorScreenPos() and GetContentRegionAvail().
/// - Attention! We currently have inconsistencies between window-local and absolute positions we will aim to fix with future API:
///    - Absolute coordinate:        GetCursorScreenPos(), SetCursorScreenPos(), all ImDrawList:: functions. -> this is the preferred way forward.
///    - Window-local coordinates:   SameLine(offset), GetCursorPos(), SetCursorPos(), GetCursorStartPos(), PushTextWrapPos()
///    - Window-local coordinates:   GetContentRegionMax(), GetWindowContentRegionMin(), GetWindowContentRegionMax() --> all obsoleted. YOU DON'T NEED THEM.
/// - GetCursorScreenPos() = GetCursorPos() + GetWindowPos(). GetWindowPos() is almost only ever useful to convert from window-local to absolute coordinates. Try not to use it.

void PopStyleColor() @trusted
{
    igPopStyleColor();
}

void PopStyleColorEx(int count) @trusted
{
    igPopStyleColorEx(count);
}

void PushStyleVar(int idx, float val) @trusted
{
    igPushStyleVar(idx, val);
}

void PushStyleVarImVec2(int idx, const ImVec2_t val) @trusted
{
    igPushStyleVarImVec2(idx, val);
}

void PushStyleVarX(int idx, float val_x) @trusted
{
    igPushStyleVarX(idx, val_x);
}

void PushStyleVarY(int idx, float val_y) @trusted
{
    igPushStyleVarY(idx, val_y);
}

void PopStyleVar() @trusted
{
    igPopStyleVar();
}

void PopStyleVarEx(int count) @trusted
{
    igPopStyleVarEx(count);
}

void PushItemFlag(int option, bool enabled) @trusted
{
    igPushItemFlag(option, enabled);
}

void PopItemFlag() @trusted
{
    igPopItemFlag();
}

void PushItemWidth(float item_width) @trusted
{
    igPushItemWidth(item_width);
}

void PopItemWidth() @trusted
{
    igPopItemWidth();
}

void SetNextItemWidth(float item_width) @trusted
{
    igSetNextItemWidth(item_width);
}

float CalcItemWidth() @trusted
{
    return igCalcItemWidth();
}

void PushTextWrapPos(float wrap_local_pos_x) @trusted
{
    igPushTextWrapPos(wrap_local_pos_x);
}

void PopTextWrapPos() @trusted
{
    igPopTextWrapPos();
}

const(ImFont_t*) GetFont() @trusted
{
    return igGetFont();
}

float GetFontSize() @trusted
{
    return igGetFontSize();
}

const(ImVec2_t) GetFontTexUvWhitePixel() @trusted
{
    return igGetFontTexUvWhitePixel();
}

uint GetColorU32(int idx) @trusted
{
    return igGetColorU32(idx);
}

uint GetColorU32Ex(int idx, float alpha_mul) @trusted
{
    return igGetColorU32Ex(idx, alpha_mul);
}

uint GetColorU32ImVec4(const ImVec4_t col) @trusted
{
    return igGetColorU32ImVec4(col);
}

uint GetColorU32ImU32(uint col) @trusted
{
    return igGetColorU32ImU32(col);
}

uint GetColorU32ImU32Ex(uint col, float alpha_mul) @trusted
{
    return igGetColorU32ImU32Ex(col, alpha_mul);
}

const(ImVec4_t*) GetStyleColorVec4(int idx) @trusted
{
    return igGetStyleColorVec4(idx);
}

const(ImVec2_t) GetCursorScreenPos() @trusted
{
    return igGetCursorScreenPos();
}

void SetCursorScreenPos(const(ImVec2_t) pos) @trusted
{
    igSetCursorScreenPos(pos);
}

const(ImVec2_t) GetContentRegionAvail() @trusted
{
    return igGetContentRegionAvail();
}

const(ImVec2_t) GetCursorPos() @trusted
{
    return igGetCursorPos();
}

float GetCursorPosX() @trusted
{
    return igGetCursorPosX();
}

float GetCursorPosY() @trusted
{
    return igGetCursorPosY();
}

void SetCursorPos(const(ImVec2_t) local_pos) @trusted
{
    igSetCursorPos(local_pos);
}

void SetCursorPosX(float local_x) @trusted
{
    igSetCursorPosX(local_x);
}

void SetCursorPosY(float local_y) @trusted
{
    igSetCursorPosY(local_y);
}

const(ImVec2_t) GetCursorStartPos() @trusted
{
    return igGetCursorStartPos();
}

void Separator() @trusted
{
    igSeparator();
}

void SameLine() @trusted
{
    igSameLine();
}

void SameLineEx(float offset_from_start_x, float spacing) @trusted
{
    igSameLineEx(offset_from_start_x, spacing);
}

void NewLine() @trusted
{
    igNewLine();
}

void Spacing() @trusted
{
    igSpacing();
}

void Dummy(const(ImVec2_t) size) @trusted
{
    igDummy(size);
}

void Indent() @trusted
{
    igIndent();
}

void IndentEx(float indent_w) @trusted
{
    igIndentEx(indent_w);
}

void Unindent() @trusted
{
    igUnindent();
}

void UnindentEx(float indent_w) @trusted
{
    igUnindentEx(indent_w);
}

void BeginGroup() @trusted
{
    igBeginGroup();
}

void EndGroup() @trusted
{
    igEndGroup();
}

void AlignTextToFramePadding() @trusted
{
    igAlignTextToFramePadding();
}

float GetTextLineHeight() @trusted
{
    return igGetTextLineHeight();
}

float GetTextLineHeightWithSpacing() @trusted
{
    return igGetTextLineHeightWithSpacing();
}

float GetFrameHeight() @trusted
{
    return igGetFrameHeight();
}

float GetFrameHeightWithSpacing() @trusted
{
    return igGetFrameHeightWithSpacing();
}

void PushID(scope const(char)* str_id) @trusted
{
    igPushID(str_id);
}

void PushIDStr(scope const(char)* str_id_begin, scope const(char)* str_id_end) @trusted
{
    igPushIDStr(str_id_begin, str_id_end);
}

void PushIDPtr(const(void)* ptr_id) @trusted
{
    igPushIDPtr(ptr_id);
}

void PushIDInt(int int_id) @trusted
{
    igPushIDInt(int_id);
}

void PopID() @trusted
{
    igPopID();
}

uint GetID(scope const(char)* str_id) @trusted
{
    return igGetID(str_id);
}

uint GetIDStr(scope const(char)* str_id_begin, scope const(char)* str_id_end) @trusted
{
    return igGetIDStr(str_id_begin, str_id_end);
}

uint GetIDPtr(const(void)* ptr_id) @trusted
{
    return igGetIDPtr(ptr_id);
}

uint GetIDInt(int int_id) @trusted
{
    return igGetIDInt(int_id);
}

void TextUnformatted(scope const(char)* text) @trusted
{
    igTextUnformatted(text);
}

void TextUnformattedEx(scope const(char)* text, scope const(char)* text_end) @trusted
{
    igTextUnformattedEx(text, text_end);
}

alias Text = igText;

void TextV(scope const(char)* fmt, __builtin_va_list args) @trusted
{
    igTextV(fmt, args);
}

alias TextColored = igTextColored;

void TextColoredV(const ImVec4_t col, scope const(char)* fmt, __builtin_va_list args) @trusted
{
    igTextColoredV(col, fmt, args);
}

alias TextDisabled = igTextDisabled;

void TextDisabledV(scope const(char)* fmt, __builtin_va_list args) @trusted
{
    igTextDisabledV(fmt, args);
}

alias TextWrapped = igTextWrapped;

void TextWrappedV(scope const(char)* fmt, __builtin_va_list args) @trusted
{
    igTextWrappedV(fmt, args);
}

alias LabelText = igLabelText;

void LabelTextV(scope const(char)* label, scope const(char)* fmt, __builtin_va_list args) @trusted
{
    igLabelTextV(label, fmt, args);
}

alias BulletText = igBulletText;

void BulletTextV(scope const(char)* fmt, __builtin_va_list args) @trusted
{
    igBulletTextV(fmt, args);
}

void SeparatorText(scope const(char)* label) @trusted
{
    igSeparatorText(label);
}

bool Button(scope const(char)* label) @trusted
{
    return igButton(label);
}

bool ButtonEx(scope const(char)* label, const ImVec2_t size) @trusted
{
    return igButtonEx(label, size);
}

bool SmallButton(scope const(char)* label) @trusted
{
    return igSmallButton(label);
}

bool InvisibleButton(scope const(char)* str_id, const ImVec2_t size, int flags) @trusted
{
    return igInvisibleButton(str_id, size, flags);
}

bool ArrowButton(scope const(char)* str_id, int dir) @trusted
{
    return igArrowButton(str_id, dir);
}

bool Checkbox(scope const(char)* label, scope bool* v) @trusted
{
    return igCheckbox(label, v);
}

bool CheckboxFlagsIntPtr(scope const(char)* label, scope int* flags, int flags_value) @trusted
{
    return igCheckboxFlagsIntPtr(label, flags, flags_value);
}

bool CheckboxFlagsUintPtr(scope const(char)* label, scope uint* flags, uint flags_value) @trusted
{
    return igCheckboxFlagsUintPtr(label, flags, flags_value);
}

bool RadioButton(scope const(char)* label, bool active) @trusted
{
    return igRadioButton(label, active);
}

bool RadioButtonIntPtr(scope const(char)* label, scope int* v, int v_button) @trusted
{
    return igRadioButtonIntPtr(label, v, v_button);
}

void ProgressBar(float fraction, const ImVec2_t size_arg, scope const(char)* overlay) @trusted
{
    igProgressBar(fraction, size_arg, overlay);
}

void Bullet() @trusted
{
    igBullet();
}

bool TextLink(scope const(char)* label) @trusted
{
    return igTextLink(label);
}

void TextLinkOpenURL(scope const(char)* label) @trusted
{
    igTextLinkOpenURL(label);
}

void TextLinkOpenURLEx(scope const(char)* label, scope const(char)* url) @trusted
{
    igTextLinkOpenURLEx(label, url);
}

void Image(size_t user_texture_id, const ImVec2_t image_size) @trusted
{
    igImage(user_texture_id, image_size);
}

void ImageEx(size_t user_texture_id, const ImVec2_t image_size, const ImVec2_t uv0, const ImVec2_t uv1, const ImVec4_t tint_col, const ImVec4_t border_col) @trusted
{
    igImageEx(user_texture_id, image_size, uv0, uv1, tint_col, border_col);
}

bool ImageButton(scope const(char)* str_id, size_t user_texture_id, const ImVec2_t image_size) @trusted
{
    return igImageButton(str_id, user_texture_id, image_size);
}

bool ImageButtonEx(scope const(char)* str_id, size_t user_texture_id, const ImVec2_t image_size, const ImVec2_t uv0, const ImVec2_t uv1, const ImVec4_t bg_col, const ImVec4_t tint_col) @trusted
{
    return igImageButtonEx(str_id, user_texture_id, image_size, uv0, uv1, bg_col, tint_col);
}

bool BeginCombo(scope const(char)* label, scope const(char)* preview_value, int flags) @trusted
{
    return igBeginCombo(label, preview_value, flags);
}

void EndCombo() @trusted
{
    igEndCombo();
}

bool ComboChar(scope const(char)* label, scope int* current_item, scope const(char*)[0] items, int items_count) @trusted
{
    return igComboChar(label, current_item, cast(const(char*)*) items, items_count);
}

bool ComboCharEx(scope const(char)* label, scope int* current_item, scope const(char*)[0] items, int items_count, int popup_max_height_in_items) @trusted
{
    return igComboCharEx(label, current_item, cast(const(char*)*) items, items_count, popup_max_height_in_items);
}

bool Combo(scope const(char)* label, scope int* current_item, scope const(char)* items_separated_by_zeros) @trusted
{
    return igCombo(label, current_item, items_separated_by_zeros);
}

bool ComboEx(scope const(char)* label, scope int* current_item, scope const(char)* items_separated_by_zeros, int popup_max_height_in_items) @trusted
{
    return igComboEx(label, current_item, items_separated_by_zeros, popup_max_height_in_items);
}

extern (C) bool ComboCallback(scope const(char)* label, scope int* current_item, scope const(char)* function(
        scope void* user_data, int idx) getter, scope void* user_data, int items_count) @trusted
{
    return igComboCallback(label, current_item, getter, user_data, items_count);
}

extern (C) bool ComboCallbackEx(scope const(char)* label, scope int* current_item, scope const(char)* function(
        scope void* user_data, int idx) getter, scope void* user_data, int items_count, int popup_max_height_in_items) @trusted
{
    return igComboCallbackEx(label, current_item, getter, user_data, items_count, popup_max_height_in_items);
}

bool DragFloat(scope const(char)* label, scope float* v) @trusted
{
    return igDragFloat(label, v);
}

bool DragFloatEx(scope const(char)* label, scope float* v, float v_speed, float v_min, float v_max, scope const(
        char)* format, int flags) @trusted
{
    return igDragFloatEx(label, v, v_speed, v_min, v_max, format, flags);
}

bool DragFloat2(scope const(char)* label, float[2] v) @trusted
{
    return igDragFloat2(label, &v[0]);
}

bool DragFloat2Ex(scope const(char)* label, float[2] v, float v_speed, float v_min, float v_max, scope const(
        char)* format, int flags) @trusted
{
    return igDragFloat2Ex(label, &v[0], v_speed, v_min, v_max, format, flags);
}

bool DragFloat3(scope const(char)* label, float[3] v) @trusted
{
    return igDragFloat3(label, &v[0]);
}

bool DragFloat3Ex(scope const(char)* label, float[3] v, float v_speed, float v_min, float v_max, scope const(
        char)* format, int flags) @trusted
{
    return igDragFloat3Ex(label, &v[0], v_speed, v_min, v_max, format, flags);
}

bool DragFloat4(scope const(char)* label, float[4] v) @trusted
{
    return igDragFloat4(label, &v[0]);
}

bool DragFloat4Ex(scope const(char)* label, float[4] v, float v_speed, float v_min, float v_max, scope const(
        char)* format, int flags) @trusted
{
    return igDragFloat4Ex(label, &v[0], v_speed, v_min, v_max, format, flags);
}

bool DragFloatRange2(scope const(char)* label, scope float* v_current_min, scope float* v_current_max) @trusted
{
    return igDragFloatRange2(label, v_current_min, v_current_max);
}

bool DragFloatRange2Ex(scope const(char)* label, scope float* v_current_min, scope float* v_current_max, float v_speed, float v_min, float v_max, scope const(
        char)* format, scope const(char)* format_max, int flags) @trusted
{
    return igDragFloatRange2Ex(label, v_current_min, v_current_max, v_speed, v_min, v_max, format, format_max, flags);
}

bool DragInt(scope const(char)* label, scope int* v) @trusted
{
    return igDragInt(label, v);
}

bool DragIntEx(scope const(char)* label, scope int* v, float v_speed, int v_min, int v_max, scope const(
        char)* format, int flags) @trusted
{
    return igDragIntEx(label, v, v_speed, v_min, v_max, format, flags);
}

bool DragInt2(scope const(char)* label, int[2] v) @trusted
{
    return igDragInt2(label, &v[0]);
}

bool DragInt2Ex(scope const(char)* label, int[2] v, float v_speed, int v_min, int v_max, scope const(
        char)* format, int flags) @trusted
{
    return igDragInt2Ex(label, &v[0], v_speed, v_min, v_max, format, flags);
}

bool DragInt3(scope const(char)* label, int[3] v) @trusted
{
    return igDragInt3(label, &v[0]);
}

bool DragInt3Ex(scope const(char)* label, int[3] v, float v_speed, int v_min, int v_max, scope const(
        char)* format, int flags) @trusted
{
    return igDragInt3Ex(label, &v[0], v_speed, v_min, v_max, format, flags);
}

bool DragInt4(scope const(char)* label, int[4] v) @trusted
{
    return igDragInt4(label, &v[0]);
}

bool DragInt4Ex(scope const(char)* label, int[4] v, float v_speed, int v_min, int v_max, scope const(
        char)* format, int flags) @trusted
{
    return igDragInt4Ex(label, &v[0], v_speed, v_min, v_max, format, flags);
}

bool DragIntRange2(scope const(char)* label, scope int* v_current_min, scope int* v_current_max) @trusted
{
    return igDragIntRange2(label, v_current_min, v_current_max);
}

bool DragIntRange2Ex(scope const(char)* label, scope int* v_current_min, scope int* v_current_max, float v_speed, int v_min, int v_max, scope const(
        char)* format, scope const(char)* format_max, int flags) @trusted
{
    return igDragIntRange2Ex(label, v_current_min, v_current_max, v_speed, v_min, v_max, format, format_max, flags);
}

bool DragScalar(scope const(char)* label, int data_type, scope void* p_data) @trusted
{
    return igDragScalar(label, data_type, p_data);
}

bool DragScalarEx(scope const(char)* label, int data_type, scope void* p_data, float v_speed, scope const(
        void)* p_min, scope const(
        void)* p_max, scope const(char)* format, int flags) @trusted
{
    return igDragScalarEx(label, data_type, p_data, v_speed, p_min, p_max, format, flags);
}

bool DragScalarN(scope const(char)* label, int data_type, scope void* p_data, int components) @trusted
{
    return igDragScalarN(label, data_type, p_data, components);
}

bool DragScalarNEx(scope const(char)* label, int data_type, scope void* p_data, int components, float v_speed, scope const(
        void)* p_min, scope const(void)* p_max, scope const(char)* format, int flags) @trusted
{
    return igDragScalarNEx(label, data_type, p_data, components, v_speed, p_min, p_max, format, flags);
}

bool SliderFloat(scope const(char)* label, scope float* v, float v_min, float v_max) @trusted
{
    return igSliderFloat(label, v, v_min, v_max);
}

bool SliderFloatEx(scope const(char)* label, scope float* v, float v_min, float v_max, scope const(
        char)* format, int flags) @trusted
{
    return igSliderFloatEx(label, v, v_min, v_max, format, flags);
}

bool SliderFloat2(scope const(char)* label, float[2] v, float v_min, float v_max) @trusted
{
    return igSliderFloat2(label, &v[0], v_min, v_max);
}

bool SliderFloat2Ex(scope const(char)* label, float[2] v, float v_min, float v_max, scope const(
        char)* format, int flags) @trusted
{
    return igSliderFloat2Ex(label, &v[0], v_min, v_max, format, flags);
}

bool SliderFloat3(scope const(char)* label, float[3] v, float v_min, float v_max) @trusted
{
    return igSliderFloat3(label, &v[0], v_min, v_max);
}

bool SliderFloat3Ex(scope const(char)* label, float[3] v, float v_min, float v_max, scope const(
        char)* format, int flags) @trusted
{
    return igSliderFloat3Ex(label, &v[0], v_min, v_max, format, flags);
}

bool SliderFloat4(scope const(char)* label, float[4] v, float v_min, float v_max) @trusted
{
    return igSliderFloat4(label, &v[0], v_min, v_max);
}

bool SliderFloat4Ex(scope const(char)* label, float[4] v, float v_min, float v_max, scope const(
        char)* format, int flags) @trusted
{
    return igSliderFloat4Ex(label, &v[0], v_min, v_max, format, flags);
}

bool SliderAngle(scope const(char)* label, scope float* v_rad) @trusted
{
    return igSliderAngle(label, v_rad);
}

bool SliderAngleEx(scope const(char)* label, scope float* v_rad, float v_degrees_min, float v_degrees_max, scope const(
        char)* format, int flags) @trusted
{
    return igSliderAngleEx(label, v_rad, v_degrees_min, v_degrees_max, format, flags);
}

bool SliderInt(scope const(char)* label, scope int* v, int v_min, int v_max) @trusted
{
    return igSliderInt(label, v, v_min, v_max);
}

bool SliderIntEx(scope const(char)* label, scope int* v, int v_min, int v_max, scope const(char)* format, int flags) @trusted
{
    return igSliderIntEx(label, v, v_min, v_max, format, flags);
}

bool SliderInt2(scope const(char)* label, int[2] v, int v_min, int v_max) @trusted
{
    return igSliderInt2(label, &v[0], v_min, v_max);
}

bool SliderInt2Ex(scope const(char)* label, int[2] v, int v_min, int v_max, scope const(char)* format, int flags) @trusted
{
    return igSliderInt2Ex(label, &v[0], v_min, v_max, format, flags);
}

bool SliderInt3(scope const(char)* label, int[3] v, int v_min, int v_max) @trusted
{
    return igSliderInt3(label, &v[0], v_min, v_max);
}

bool SliderInt3Ex(scope const(char)* label, int[3] v, int v_min, int v_max, scope const(char)* format, int flags) @trusted
{
    return igSliderInt3Ex(label, &v[0], v_min, v_max, format, flags);
}

bool SliderInt4(scope const(char)* label, int[4] v, int v_min, int v_max) @trusted
{
    return igSliderInt4(label, &v[0], v_min, v_max);
}

bool SliderInt4Ex(scope const(char)* label, int[4] v, int v_min, int v_max, scope const(char)* format, int flags) @trusted
{
    return igSliderInt4Ex(label, &v[0], v_min, v_max, format, flags);
}

bool SliderScalar(scope const(char)* label, int data_type, scope void* p_data, scope const(void)* p_min, scope const(
        void)* p_max) @trusted
{
    return igSliderScalar(label, data_type, p_data, p_min, p_max);
}

bool SliderScalarEx(scope const(char)* label, int data_type, scope void* p_data, scope const(void)* p_min, scope const(
        void)* p_max, scope const(char)* format, int flags) @trusted
{
    return igSliderScalarEx(label, data_type, p_data, p_min, p_max, format, flags);
}

bool SliderScalarN(scope const(char)* label, int data_type, scope void* p_data, int components, scope const(
        void)* p_min, scope const(void)* p_max) @trusted
{
    return igSliderScalarN(label, data_type, p_data, components, p_min, p_max);
}

bool SliderScalarNEx(scope const(char)* label, int data_type, scope void* p_data, int components, scope const(
        void)* p_min, scope const(void)* p_max, scope const(char)* format, int flags) @trusted
{
    return igSliderScalarNEx(label, data_type, p_data, components, p_min, p_max, format, flags);
}

bool VSliderFloat(scope const(char)* label, ImVec2_t size, scope float* v, float v_min, float v_max) @trusted
{
    return igVSliderFloat(label, size, v, v_min, v_max);
}

bool VSliderFloatEx(scope const(char)* label, ImVec2_t size, scope float* v, float v_min, float v_max, scope const(
        char)* format, int flags) @trusted
{
    return igVSliderFloatEx(label, size, v, v_min, v_max, format, flags);
}

bool VSliderInt(scope const(char)* label, ImVec2_t size, scope int* v, int v_min, int v_max) @trusted
{
    return igVSliderInt(label, size, v, v_min, v_max);
}

bool VSliderIntEx(scope const(char)* label, ImVec2_t size, scope int* v, int v_min, int v_max, scope const(
        char)* format, int flags) @trusted
{
    return igVSliderIntEx(label, size, v, v_min, v_max, format, flags);
}

bool VSliderScalar(scope const(char)* label, ImVec2_t size, int data_type, scope void* p_data, scope const(
        void)* p_min, scope const(void)* p_max) @trusted
{
    return igVSliderScalar(label, size, data_type, p_data, p_min, p_max);
}

bool VSliderScalarEx(scope const(char)* label, ImVec2_t size, int data_type, scope void* p_data, scope const(
        void)* p_min, scope const(void)* p_max, scope const(char)* format, int flags) @trusted
{
    return igVSliderScalarEx(label, size, data_type, p_data, p_min, p_max, format, flags);
}

bool InputText(scope const(char)* label, scope char* buf, size_t buf_size, int flags) @trusted
{
    return igInputText(label, buf, buf_size, flags);
}

extern (C) bool InputTextEx(scope const(char)* label, scope char* buf, size_t buf_size, int flags, int function(
        const ImGuiInputTextCallbackData_t* data) callback, scope void* user_data) @trusted
{
    return igInputTextEx(label, buf, buf_size, flags, callback, user_data);
}

bool InputTextMultiline(scope const(char)* label, scope char* buf, size_t buf_size) @trusted
{
    return igInputTextMultiline(label, buf, buf_size);
}

extern (C) bool InputTextMultilineEx(scope const(char)* label, scope char* buf, size_t buf_size, ImVec2_t size, int flags, int function(
        const ImGuiInputTextCallbackData_t* data) callback, scope void* user_data) @trusted
{
    return igInputTextMultilineEx(label, buf, buf_size, size, flags, callback, user_data);
}

bool InputTextWithHint(scope const(char)* label, scope const(char)* hint, scope char* buf, size_t buf_size, int flags) @trusted
{
    return igInputTextWithHint(label, hint, buf, buf_size, flags);
}

extern (C) bool InputTextWithHintEx(scope const(char)* label, scope const(char)* hint, scope char* buf, size_t buf_size, int flags, int function(
        const ImGuiInputTextCallbackData_t* data) callback, scope void* user_data) @trusted
{
    return igInputTextWithHintEx(label, hint, buf, buf_size, flags, callback, user_data);
}

bool InputFloat(scope const(char)* label, scope float* v) @trusted
{
    return igInputFloat(label, v);
}

bool InputFloatEx(scope const(char)* label, scope float* v, float step, float step_fast, scope const(
        char)* format, int flags) @trusted
{
    return igInputFloatEx(label, v, step, step_fast, format, flags);
}

bool InputFloat2(scope const(char)* label, float[2] v) @trusted
{
    return igInputFloat2(label, &v[0]);
}

bool InputFloat2Ex(scope const(char)* label, float[2] v, scope const(char)* format, int flags) @trusted
{
    return igInputFloat2Ex(label, &v[0], format, flags);
}

bool InputFloat3(scope const(char)* label, float[3] v) @trusted
{
    return igInputFloat3(label, &v[0]);
}

bool InputFloat3Ex(scope const(char)* label, float[3] v, scope const(char)* format, int flags) @trusted
{
    return igInputFloat3Ex(label, &v[0], format, flags);
}

bool InputFloat4(scope const(char)* label, float[4] v) @trusted
{
    return igInputFloat4(label, &v[0]);
}

bool InputFloat4Ex(scope const(char)* label, float[4] v, scope const(char)* format, int flags) @trusted
{
    return igInputFloat4Ex(label, &v[0], format, flags);
}

bool InputInt(scope const(char)* label, scope int* v) @trusted
{
    return igInputInt(label, v);
}

bool InputIntEx(scope const(char)* label, scope int* v, int step, int step_fast, int flags) @trusted
{
    return igInputIntEx(label, v, step, step_fast, flags);
}

bool InputInt2(scope const(char)* label, int[2] v, int flags) @trusted
{
    return igInputInt2(label, &v[0], flags);
}

bool InputInt3(scope const(char)* label, int[3] v, int flags) @trusted
{
    return igInputInt3(label, &v[0], flags);
}

bool InputInt4(scope const(char)* label, int[4] v, int flags) @trusted
{
    return igInputInt4(label, &v[0], flags);
}

bool InputDouble(scope const(char)* label, scope double* v) @trusted
{
    return igInputDouble(label, v);
}

bool InputDoubleEx(scope const(char)* label, scope double* v, double step, double step_fast, scope const(
        char)* format, int flags) @trusted
{
    return igInputDoubleEx(label, v, step, step_fast, format, flags);
}

bool InputScalar(scope const(char)* label, int data_type, scope void* p_data) @trusted
{
    return igInputScalar(label, data_type, p_data);
}

bool InputScalarEx(scope const(char)* label, int data_type, scope void* p_data, scope const(void)* p_step, scope const(
        void)* p_step_fast, scope const(char)* format, int flags) @trusted
{
    return igInputScalarEx(label, data_type, p_data, p_step, p_step_fast, format, flags);
}

bool InputScalarN(scope const(char)* label, int data_type, scope void* p_data, int components) @trusted
{
    return igInputScalarN(label, data_type, p_data, components);
}

bool InputScalarNEx(scope const(char)* label, int data_type, scope void* p_data, int components, scope const(
        void)* p_step, scope const(void)* p_step_fast, scope const(char)* format, int flags) @trusted
{
    return igInputScalarNEx(label, data_type, p_data, components, p_step, p_step_fast, format, flags);
}

bool ColorEdit3(scope const(char)* label, float[3] col, int flags) @trusted
{
    return igColorEdit3(label, &col[0], flags);
}

bool ColorEdit4(scope const(char)* label, float[4] col, int flags) @trusted
{
    return igColorEdit4(label, &col[0], flags);
}

bool ColorPicker3(scope const(char)* label, float[3] col, int flags) @trusted
{
    return igColorPicker3(label, &col[0], flags);
}

bool ColorPicker4(scope const(char)* label, float[4] col, int flags, scope const(float)* ref_col) @trusted
{
    return igColorPicker4(label, &col[0], flags, ref_col);
}

bool ColorButton(scope const(char)* desc_id, ImVec4_t col, int flags) @trusted
{
    return igColorButton(desc_id, col, flags);
}

bool ColorButtonEx(scope const(char)* desc_id, ImVec4_t col, int flags, ImVec2_t size) @trusted
{
    return igColorButtonEx(desc_id, col, flags, size);
}

void SetColorEditOptions(int flags) @trusted
{
    igSetColorEditOptions(flags);
}

bool TreeNode(scope const(char)* label) @trusted
{
    return igTreeNode(label);
}

alias TreeNodeStr = igTreeNodeStr;
alias TreeNodePtr = igTreeNodePtr;

bool TreeNodeV(scope const(char)* str_id, scope const(char)* fmt, __builtin_va_list args) @trusted
{
    return igTreeNodeV(str_id, fmt, args);
}

bool TreeNodeVPtr(scope const(void)* ptr_id, scope const(char)* fmt, __builtin_va_list args) @trusted
{
    return igTreeNodeVPtr(ptr_id, fmt, args);
}

bool TreeNodeEx(scope const(char)* label, int flags) @trusted
{
    return igTreeNodeEx(label, flags);
}

alias TreeNodeExStr = igTreeNodeExStr;
alias TreeNodeExPtr = igTreeNodeExPtr;

bool TreeNodeExV(scope const(char)* str_id, int flags, scope const(char)* fmt, __builtin_va_list args) @trusted
{
    return igTreeNodeExV(str_id, flags, fmt, args);
}

bool TreeNodeExVPtr(scope const(void)* ptr_id, int flags, scope const(char)* fmt, __builtin_va_list args) @trusted
{
    return igTreeNodeExVPtr(ptr_id, flags, fmt, args);
}

void TreePush(scope const(char)* str_id) @trusted
{
    igTreePush(str_id);
}

void TreePushPtr(scope const(void)* ptr_id) @trusted
{
    igTreePushPtr(ptr_id);
}

void TreePop() @trusted
{
    igTreePop();
}

float GetTreeNodeToLabelSpacing() @trusted
{
    return igGetTreeNodeToLabelSpacing();
}

bool CollapsingHeader(scope const(char)* label, int flags) @trusted
{
    return igCollapsingHeader(label, flags);
}

bool CollapsingHeaderBoolPtr(scope const(char)* label, scope bool* p_visible, int flags) @trusted
{
    return igCollapsingHeaderBoolPtr(label, p_visible, flags);
}

void SetNextItemOpen(bool is_open, int cond) @trusted
{
    igSetNextItemOpen(is_open, cond);
}

void SetNextItemStorageID(uint storage_id) @trusted
{
    igSetNextItemStorageID(storage_id);
}

bool Selectable(scope const(char)* label) @trusted
{
    return igSelectable(label);
}

bool SelectableEx(scope const(char)* label, bool selected, int flags, ImVec2_t size) @trusted
{
    return igSelectableEx(label, selected, flags, size);
}

bool SelectableBoolPtr(scope const(char)* label, scope bool* p_selected, int flags) @trusted
{
    return igSelectableBoolPtr(label, p_selected, flags);
}

bool SelectableBoolPtrEx(scope const(char)* label, scope bool* p_selected, int flags, ImVec2_t size) @trusted
{
    return igSelectableBoolPtrEx(label, p_selected, flags, size);
}

scope ImGuiMultiSelectIO_t* BeginMultiSelect(int flags) @trusted
{
    return igBeginMultiSelect(flags);
}

scope ImGuiMultiSelectIO_t* BeginMultiSelectEx(int flags, int selection_size, int items_count) @trusted
{
    return igBeginMultiSelectEx(flags, selection_size, items_count);
}

scope ImGuiMultiSelectIO_t* EndMultiSelect() @trusted
{
    return igEndMultiSelect();
}

void SetNextItemSelectionUserData(long selection_user_data) @trusted
{
    igSetNextItemSelectionUserData(selection_user_data);
}

bool IsItemToggledSelection() @trusted
{
    return igIsItemToggledSelection();
}

bool BeginListBox(scope const(char)* label, ImVec2_t size) @trusted
{
    return igBeginListBox(label, size);
}

void EndListBox() @trusted
{
    igEndListBox();
}

bool ListBox(scope const(char)* label, scope int* current_item, scope const(char*)[0] items, int items_count, int height_in_items) @trusted
{
    return igListBox(label, current_item, cast(const(char*)*) items, items_count, height_in_items);
}

extern (C) bool ListBoxCallback(scope const(char)* label, scope int* current_item, scope const(char)* function(
        scope void* user_data, int idx) getter, scope void* user_data, int items_count) @trusted
{
    return igListBoxCallback(label, current_item, getter, user_data, items_count);
}

extern (C) bool ListBoxCallbackEx(scope const(char)* label, scope int* current_item, scope const(
        char)* function(
        scope void* user_data, int idx) getter, scope void* user_data, int items_count, int height_in_items) @trusted
{
    return igListBoxCallbackEx(label, current_item, getter, user_data, items_count, height_in_items);
}

void PlotLines(scope const(char)* label, scope const(float)* values, int values_count) @trusted
{
    igPlotLines(label, values, values_count);
}

void PlotLinesEx(scope const(char)* label, scope const(float)* values, int values_count, int values_offset, scope const(
        char)* overlay_text, float scale_min, float scale_max, const ImVec2_t graph_size, int stride) @trusted
{
    igPlotLinesEx(label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size, stride);
}

extern (C) void PlotLinesCallback(scope const(char)* label, float function(scope void* data, int idx) values_getter, scope void* data, int values_count) @trusted
{
    igPlotLinesCallback(label, values_getter, data, values_count);
}

extern (C) void PlotLinesCallbackEx(scope const(char)* label, float function(scope void* data, int idx) values_getter, scope void* data, int values_count, int values_offset, scope const(
        char)* overlay_text, float scale_min, float scale_max, const ImVec2_t graph_size) @trusted
{
    igPlotLinesCallbackEx(label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size);
}

void PlotHistogram(scope const(char)* label, scope const(float)* values, int values_count) @trusted
{
    igPlotHistogram(label, values, values_count);
}

void PlotHistogramEx(scope const(char)* label, scope const(float)* values, int values_count, int values_offset, scope const(
        char)* overlay_text, float scale_min, float scale_max, const ImVec2_t graph_size, int stride) @trusted
{
    igPlotHistogramEx(label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size, stride);
}

extern (C) void PlotHistogramCallback(scope const(char)* label, float function(
        scope void* data, int idx) values_getter, scope void* data, int values_count) @trusted
{
    igPlotHistogramCallback(label, values_getter, data, values_count);
}

extern (C) void PlotHistogramCallbackEx(scope const(char)* label, float function(scope void* data, int idx) values_getter, scope void* data, int values_count, int values_offset, scope const(
        char)* overlay_text, float scale_min, float scale_max, const ImVec2_t graph_size) @trusted
{
    igPlotHistogramCallbackEx(label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size);
}

bool BeginMenuBar() @trusted
{
    return igBeginMenuBar();
}

void EndMenuBar() @trusted
{
    igEndMenuBar();
}

bool BeginMainMenuBar() @trusted
{
    return igBeginMainMenuBar();
}

void EndMainMenuBar() @trusted
{
    igEndMainMenuBar();
}

bool BeginMenu(scope const(char)* label) @trusted
{
    return igBeginMenu(label);
}

bool BeginMenuEx(scope const(char)* label, bool enabled) @trusted
{
    return igBeginMenuEx(label, enabled);
}

void EndMenu() @trusted
{
    igEndMenu();
}

bool MenuItem(scope const(char)* label) @trusted
{
    return igMenuItem(label);
}

bool MenuItemEx(scope const(char)* label, scope const(char)* shortcut, bool selected, bool enabled) @trusted
{
    return igMenuItemEx(label, shortcut, selected, enabled);
}

bool MenuItemBoolPtr(scope const(char)* label, scope const(char)* shortcut, scope bool* p_selected, bool enabled) @trusted
{
    return igMenuItemBoolPtr(label, shortcut, p_selected, enabled);
}

bool BeginTooltip() @trusted
{
    return igBeginTooltip();
}

void EndTooltip() @trusted
{
    igEndTooltip();
}

alias SetTooltip = igSetTooltip;

void SetTooltipV(scope const(char)* fmt, __builtin_va_list args) @trusted
{
    igSetTooltipV(fmt, args);
}

bool BeginItemTooltip() @trusted
{
    return igBeginItemTooltip();
}

alias SetItemTooltip = igSetItemTooltip;

void SetItemTooltipV(scope const(char)* fmt, __builtin_va_list args) @trusted
{
    igSetItemTooltipV(fmt, args);
}

bool BeginPopup(scope const(char)* str_id, int flags) @trusted
{
    return igBeginPopup(str_id, flags);
}

bool BeginPopupModal(scope const(char)* name, scope bool* p_open, int flags) @trusted
{
    return igBeginPopupModal(name, p_open, flags);
}

void EndPopup() @trusted
{
    igEndPopup();
}

void OpenPopup(scope const(char)* str_id, int popup_flags) @trusted
{
    igOpenPopup(str_id, popup_flags);
}

void OpenPopupID(uint id, int popup_flags) @trusted
{
    igOpenPopupID(id, popup_flags);
}

void OpenPopupOnItemClick(scope const(char)* str_id, int popup_flags) @trusted
{
    igOpenPopupOnItemClick(str_id, popup_flags);
}

void CloseCurrentPopup() @trusted
{
    igCloseCurrentPopup();
}

bool BeginPopupContextItem() @trusted
{
    return igBeginPopupContextItem();
}

bool BeginPopupContextItemEx(scope const(char)* str_id, int popup_flags) @trusted
{
    return igBeginPopupContextItemEx(str_id, popup_flags);
}

bool BeginPopupContextWindow() @trusted
{
    return igBeginPopupContextWindow();
}

bool BeginPopupContextWindowEx(scope const(char)* str_id, int popup_flags) @trusted
{
    return igBeginPopupContextWindowEx(str_id, popup_flags);
}

bool BeginPopupContextVoid() @trusted
{
    return igBeginPopupContextVoid();
}

bool BeginPopupContextVoidEx(scope const(char)* str_id, int popup_flags) @trusted
{
    return igBeginPopupContextVoidEx(str_id, popup_flags);
}

bool IsPopupOpen(scope const(char)* str_id, int flags) @trusted
{
    return igIsPopupOpen(str_id, flags);
}

bool BeginTable(scope const(char)* str_id, int columns, int flags) @trusted
{
    return igBeginTable(str_id, columns, flags);
}

bool BeginTableEx(scope const(char)* str_id, int columns, int flags, const ImVec2_t outer_size, float inner_width) @trusted
{
    return igBeginTableEx(str_id, columns, flags, outer_size, inner_width);
}

void EndTable() @trusted
{
    igEndTable();
}

void TableNextRow() @trusted
{
    igTableNextRow();
}

void TableNextRowEx(int row_flags, float min_row_height) @trusted
{
    igTableNextRowEx(row_flags, min_row_height);
}

bool TableNextColumn() @trusted
{
    return igTableNextColumn();
}

bool TableSetColumnIndex(int column_n) @trusted
{
    return igTableSetColumnIndex(column_n);
}

void TableSetupColumn(scope const(char)* label, int flags) @trusted
{
    igTableSetupColumn(label, flags);
}

void TableSetupColumnEx(scope const(char)* label, int flags, float init_width_or_weight, uint user_id) @trusted
{
    igTableSetupColumnEx(label, flags, init_width_or_weight, user_id);
}

void TableSetupScrollFreeze(int cols, int rows) @trusted
{
    igTableSetupScrollFreeze(cols, rows);
}

void TableHeader(scope const(char)* label) @trusted
{
    igTableHeader(label);
}

void TableHeadersRow() @trusted
{
    igTableHeadersRow();
}

void TableAngledHeadersRow() @trusted
{
    igTableAngledHeadersRow();
}

scope ImGuiTableSortSpecs_t* TableGetSortSpecs() @trusted
{
    return igTableGetSortSpecs();
}

int TableGetColumnCount() @trusted
{
    return igTableGetColumnCount();
}

int TableGetColumnIndex() @trusted
{
    return igTableGetColumnIndex();
}

int TableGetRowIndex() @trusted
{
    return igTableGetRowIndex();
}

scope const(char)* TableGetColumnName(int column_n) @trusted
{
    return igTableGetColumnName(column_n);
}

int TableGetColumnFlags(int column_n) @trusted
{
    return igTableGetColumnFlags(column_n);
}

void TableSetColumnEnabled(int column_n, bool v) @trusted
{
    igTableSetColumnEnabled(column_n, v);
}

int TableGetHoveredColumn() @trusted
{
    return igTableGetHoveredColumn();
}

void TableSetBgColor(int target, uint color, int column_n) @trusted
{
    igTableSetBgColor(target, color, column_n);
}

void Columns() @trusted
{
    igColumns();
}

void ColumnsEx(int count, scope const(char)* id, bool borders) @trusted
{
    igColumnsEx(count, id, borders);
}

void NextColumn() @trusted
{
    igNextColumn();
}

int GetColumnIndex() @trusted
{
    return igGetColumnIndex();
}

float GetColumnWidth(int column_index) @trusted
{
    return igGetColumnWidth(column_index);
}

void SetColumnWidth(int column_index, float width) @trusted
{
    igSetColumnWidth(column_index, width);
}

float GetColumnOffset(int column_index) @trusted
{
    return igGetColumnOffset(column_index);
}

void SetColumnOffset(int column_index, float offset_x) @trusted
{
    igSetColumnOffset(column_index, offset_x);
}

int GetColumnsCount() @trusted
{
    return igGetColumnsCount();
}

bool BeginTabBar(scope const(char)* str_id, int flags) @trusted
{
    return igBeginTabBar(str_id, flags);
}

void EndTabBar() @trusted
{
    igEndTabBar();
}

bool BeginTabItem(scope const(char)* label, bool* p_open, int flags) @trusted
{
    return igBeginTabItem(label, p_open, flags);
}

void EndTabItem() @trusted
{
    igEndTabItem();
}

bool TabItemButton(scope const(char)* label, int flags) @trusted
{
    return igTabItemButton(label, flags);
}

void SetTabItemClosed(scope const(char)* tab_or_docked_window_label) @trusted
{
    igSetTabItemClosed(tab_or_docked_window_label);
}

void LogToTTY(int auto_open_depth) @trusted
{
    igLogToTTY(auto_open_depth);
}

void LogToFile(int auto_open_depth, scope const(char)* filename) @trusted
{
    igLogToFile(auto_open_depth, filename);
}

void LogToClipboard(int auto_open_depth) @trusted
{
    igLogToClipboard(auto_open_depth);
}

void LogFinish() @trusted
{
    igLogFinish();
}

void LogButtons() @trusted
{
    igLogButtons();
}

alias LogText = igLogText;

void LogTextV(scope const(char)* fmt, __builtin_va_list args) @trusted
{
    igLogTextV(fmt, args);
}

bool BeginDragDropSource(int flags) @trusted
{
    return igBeginDragDropSource(flags);
}

bool SetDragDropPayload(scope const(char)* type, scope const(void)* data, size_t sz, int cond) @trusted
{
    return igSetDragDropPayload(type, data, sz, cond);
}

void EndDragDropSource() @trusted
{
    igEndDragDropSource();
}

bool BeginDragDropTarget() @trusted
{
    return igBeginDragDropTarget();
}

const(ImGuiPayload_t*) AcceptDragDropPayload(scope const(char)* type, int flags) @trusted
{
    return igAcceptDragDropPayload(type, flags);
}

void EndDragDropTarget() @trusted
{
    igEndDragDropTarget();
}

const(ImGuiPayload_t*) GetDragDropPayload() @trusted
{
    return igGetDragDropPayload();
}

void BeginDisabled(bool disabled) @trusted
{
    igBeginDisabled(disabled);
}

void EndDisabled() @trusted
{
    igEndDisabled();
}

void PushClipRect(const(ImVec2_t) clip_rect_min, const ImVec2_t clip_rect_max, bool intersect_with_current_clip_rect) @trusted
{
    igPushClipRect(clip_rect_min, clip_rect_max, intersect_with_current_clip_rect);
}

void PopClipRect() @trusted
{
    igPopClipRect();
}

void SetItemDefaultFocus() @trusted
{
    igSetItemDefaultFocus();
}

void SetKeyboardFocusHere() @trusted
{
    igSetKeyboardFocusHere();
}

void SetKeyboardFocusHereEx(int offset) @trusted
{
    igSetKeyboardFocusHereEx(offset);
}

void SetNavCursorVisible(bool visible) @trusted
{
    igSetNavCursorVisible(visible);
}

void SetNextItemAllowOverlap() @trusted
{
    igSetNextItemAllowOverlap();
}

bool IsItemHovered(int flags) @trusted
{
    return igIsItemHovered(flags);
}

bool IsItemActive() @trusted
{
    return igIsItemActive();
}

bool IsItemFocused() @trusted
{
    return igIsItemFocused();
}

bool IsItemClicked() @trusted
{
    return igIsItemClicked();
}

bool IsItemClickedEx(int mouse_button) @trusted
{
    return igIsItemClickedEx(mouse_button);
}

bool IsItemVisible() @trusted
{
    return igIsItemVisible();
}

bool IsItemEdited() @trusted
{
    return igIsItemEdited();
}

bool IsItemActivated() @trusted
{
    return igIsItemActivated();
}

bool IsItemDeactivated() @trusted
{
    return igIsItemDeactivated();
}

bool IsItemDeactivatedAfterEdit() @trusted
{
    return igIsItemDeactivatedAfterEdit();
}

bool IsItemToggledOpen() @trusted
{
    return igIsItemToggledOpen();
}

bool IsAnyItemHovered() @trusted
{
    return igIsAnyItemHovered();
}

bool IsAnyItemActive() @trusted
{
    return igIsAnyItemActive();
}

bool IsAnyItemFocused() @trusted
{
    return igIsAnyItemFocused();
}

uint GetItemID() @trusted
{
    return igGetItemID();
}

scope const(ImVec2_t) GetItemRectMin() @trusted
{
    return igGetItemRectMin();
}

scope const(ImVec2_t) GetItemRectMax() @trusted
{
    return igGetItemRectMax();
}

scope const(ImVec2_t) GetItemRectSize() @trusted
{
    return igGetItemRectSize();
}

scope const(ImGuiViewport_t*) GetMainViewport() @trusted
{
    return igGetMainViewport();
}

scope const(ImDrawList_t*) GetBackgroundDrawList() @trusted
{
    return igGetBackgroundDrawList();
}

scope const(ImDrawList_t*) GetForegroundDrawList() @trusted
{
    return igGetForegroundDrawList();
}

bool IsRectVisibleBySize(const(ImVec2_t) size) @trusted
{
    return igIsRectVisibleBySize(size);
}

bool IsRectVisible(const(ImVec2_t) rect_min, const ImVec2_t rect_max) @trusted
{
    return igIsRectVisible(rect_min, rect_max);
}

double GetTime() @trusted
{
    return igGetTime();
}

int GetFrameCount() @trusted
{
    return igGetFrameCount();
}

scope ImDrawListSharedData_t* GetDrawListSharedData() @trusted
{
    return igGetDrawListSharedData();
}

scope const(char)* GetStyleColorName(int idx) @trusted
{
    return igGetStyleColorName(idx);
}

void SetStateStorage(scope const(ImGuiStorage_t)* storage) @trusted
{
    igSetStateStorage(cast(ImGuiStorage_t*) storage);
}

scope const(ImGuiStorage_t)* GetStateStorage() @trusted
{
    return igGetStateStorage();
}

const(ImVec2_t) CalcTextSize(scope const(char)* text) @trusted
{
    return igCalcTextSize(text);
}

const(ImVec2_t) CalcTextSizeEx(scope const(char)* text, scope const(char)* text_end, bool hide_text_after_double_hash, float wrap_width) @trusted
{
    return igCalcTextSizeEx(text, text_end, hide_text_after_double_hash, wrap_width);
}

const(ImVec4_t) ColorConvertU32ToFloat4(uint input) @trusted
{
    return igColorConvertU32ToFloat4(input);
}

uint ColorConvertFloat4ToU32(const(ImVec4_t) input) @trusted
{
    return igColorConvertFloat4ToU32(input);
}

void ColorConvertRGBtoHSV(float r, float g, float b, scope float* out_h, scope float* out_s, scope float* out_v) @trusted
{
    igColorConvertRGBtoHSV(r, g, b, out_h, out_s, out_v);
}

void ColorConvertHSVtoRGB(float h, float s, float v, scope float* out_r, scope float* out_g, scope float* out_b) @trusted
{
    igColorConvertHSVtoRGB(h, s, v, out_r, out_g, out_b);
}

bool IsKeyDown(int key) @trusted
{
    return igIsKeyDown(key);
}

bool IsKeyPressed(int key) @trusted
{
    return igIsKeyPressed(key);
}

bool IsKeyPressedEx(int key, bool repeat) @trusted
{
    return igIsKeyPressedEx(key, repeat);
}

bool IsKeyReleased(int key) @trusted
{
    return igIsKeyReleased(key);
}

bool IsKeyChordPressed(int key_chord) @trusted
{
    return igIsKeyChordPressed(key_chord);
}

int GetKeyPressedAmount(int key, float repeat_delay, float rate) @trusted
{
    return igGetKeyPressedAmount(key, repeat_delay, rate);
}

const(char)* GetKeyName(int key) @trusted
{
    return igGetKeyName(key);
}

void SetNextFrameWantCaptureKeyboard(bool want_capture_keyboard) @trusted
{
    igSetNextFrameWantCaptureKeyboard(want_capture_keyboard);
}

bool Shortcut(int key_chord, int flags) @trusted
{
    return igShortcut(key_chord, flags);
}

void SetNextItemShortcut(int key_chord, int flags) @trusted
{
    igSetNextItemShortcut(key_chord, flags);
}

void SetItemKeyOwner(int key) @trusted
{
    igSetItemKeyOwner(key);
}

bool IsMouseDown(int button) @trusted
{
    return igIsMouseDown(button);
}

bool IsMouseClicked(int button) @trusted
{
    return igIsMouseClicked(button);
}

bool IsMouseClickedEx(int button, bool repeat) @trusted
{
    return igIsMouseClickedEx(button, repeat);
}

bool IsMouseReleased(int button) @trusted
{
    return igIsMouseReleased(button);
}

bool IsMouseDoubleClicked(int button) @trusted
{
    return igIsMouseDoubleClicked(button);
}

int GetMouseClickedCount(int button) @trusted
{
    return igGetMouseClickedCount(button);
}

bool IsMouseHoveringRect(const(ImVec2_t) r_min, const ImVec2_t r_max) @trusted
{
    return igIsMouseHoveringRect(r_min, r_max);
}

bool IsMouseHoveringRectEx(const(ImVec2_t) r_min, const ImVec2_t r_max, bool clip) @trusted
{
    return igIsMouseHoveringRectEx(r_min, r_max, clip);
}

bool IsMousePosValid(scope const(ImVec2_t)* mouse_pos) @trusted
{
    return igIsMousePosValid(cast(ImVec2_t*) mouse_pos);
}

bool IsAnyMouseDown() @trusted
{
    return igIsAnyMouseDown();
}

const(ImVec2_t) GetMousePos() @trusted
{
    return igGetMousePos();
}

const(ImVec2_t) GetMousePosOnOpeningCurrentPopup() @trusted
{
    return igGetMousePosOnOpeningCurrentPopup();
}

bool IsMouseDragging(int button, float lock_threshold) @trusted
{
    return igIsMouseDragging(button, lock_threshold);
}

const(ImVec2_t) GetMouseDragDelta(int button, float lock_threshold) @trusted
{
    return igGetMouseDragDelta(button, lock_threshold);
}

void ResetMouseDragDelta() @trusted
{
    igResetMouseDragDelta();
}

void ResetMouseDragDeltaEx(int button) @trusted
{
    igResetMouseDragDeltaEx(button);
}

int GetMouseCursor() @trusted
{
    return igGetMouseCursor();
}

void SetMouseCursor(int cursor_type) @trusted
{
    igSetMouseCursor(cursor_type);
}

void SetNextFrameWantCaptureMouse(bool want_capture_mouse) @trusted
{
    igSetNextFrameWantCaptureMouse(want_capture_mouse);
}

scope const(char)* GetClipboardText() @trusted
{
    return igGetClipboardText();
}

void SetClipboardText(scope const(char)* text) @trusted
{
    igSetClipboardText(text);
}

void LoadIniSettingsFromDisk(scope const(char)* ini_filename) @trusted
{
    igLoadIniSettingsFromDisk(ini_filename);
}

void LoadIniSettingsFromMemory(scope const(char)* ini_data, size_t ini_size) @trusted
{
    igLoadIniSettingsFromMemory(ini_data, ini_size);
}

void SaveIniSettingsToDisk(scope const(char)* ini_filename) @trusted
{
    igSaveIniSettingsToDisk(ini_filename);
}

scope const(char)* SaveIniSettingsToMemory(scope size_t* out_ini_size) @trusted
{
    return igSaveIniSettingsToMemory(out_ini_size);
}

void DebugTextEncoding(scope const(char)* text) @trusted
{
    igDebugTextEncoding(text);
}

void DebugFlashStyleColor(int idx) @trusted
{
    igDebugFlashStyleColor(idx);
}

void DebugStartItemPicker() @trusted
{
    igDebugStartItemPicker();
}

bool DebugCheckVersionAndDataLayout(scope const(char)* version_str, size_t sz_io, size_t sz_style, size_t sz_vec2, size_t sz_vec4, size_t sz_drawvert, size_t sz_drawidx) @trusted
{
    return igDebugCheckVersionAndDataLayout(version_str, sz_io, sz_style, sz_vec2, sz_vec4, sz_drawvert, sz_drawidx);
}

alias DebugLog = igDebugLog;

void DebugLogV(scope const(char)* fmt, __builtin_va_list args) @trusted
{
    igDebugLogV(fmt, args);
}

extern (C) void SetAllocatorFunctions(scope void* function(size_t sz, void* user_data) alloc_func, void function(
        void* ptr, void* user_data) free_func, scope void* user_data) @trusted
{
    igSetAllocatorFunctions(alloc_func, free_func, user_data);
}

extern (C) void GetAllocatorFunctions(scope void* function(size_t sz, void* user_data)* p_alloc_func, void function(
        void* ptr, void* user_data)* p_free_func, scope void** p_user_data) @trusted
{
    igGetAllocatorFunctions(p_alloc_func, p_free_func, p_user_data);
}

scope void* MemAlloc(size_t size) @trusted
{
    return igMemAlloc(size);
}

void MemFree(scope void* ptr) @trusted
{
    igMemFree(ptr);
}

void VectorConstruct(scope void* vector) @trusted
{
    ImVector_Construct(vector);
}

void VectorDestruct(scope void* vector) @trusted
{
    ImVector_Destruct(vector);
}

void StyleScaleAllSizes(scope ImGuiStyle_t* self, float scale_factor) @trusted
{
    ImGuiStyle_ScaleAllSizes(self, scale_factor);
}

void IOAddKeyEvent(scope ImGuiIO_t* self, int key, bool down) @trusted
{
    ImGuiIO_AddKeyEvent(self, key, down);
}

void IOAddKeyAnalogEvent(scope ImGuiIO_t* self, int key, bool down, float v) @trusted
{
    ImGuiIO_AddKeyAnalogEvent(self, key, down, v);
}

void IOAddMousePosEvent(scope ImGuiIO_t* self, float x, float y) @trusted
{
    ImGuiIO_AddMousePosEvent(self, x, y);
}

void IOAddMouseButtonEvent(scope ImGuiIO_t* self, int button, bool down) @trusted
{
    ImGuiIO_AddMouseButtonEvent(self, button, down);
}

void IOAddMouseWheelEvent(scope ImGuiIO_t* self, float wheel_x, float wheel_y) @trusted
{
    ImGuiIO_AddMouseWheelEvent(self, wheel_x, wheel_y);
}

void IOAddMouseSourceEvent(scope ImGuiIO_t* self, int source) @trusted
{
    ImGuiIO_AddMouseSourceEvent(self, source);
}

void IOAddFocusEvent(scope ImGuiIO_t* self, bool focused) @trusted
{
    ImGuiIO_AddFocusEvent(self, focused);
}

void IOAddInputCharacter(scope ImGuiIO_t* self, uint c) @trusted
{
    ImGuiIO_AddInputCharacter(self, c);
}

void IOAddInputCharacterUTF16(scope ImGuiIO_t* self, ushort c) @trusted
{
    ImGuiIO_AddInputCharacterUTF16(self, c);
}

void IOAddInputCharactersUTF8(scope ImGuiIO_t* self, scope const(char)* str) @trusted
{
    ImGuiIO_AddInputCharactersUTF8(self, str);
}

void IOSetKeyEventNativeData(scope ImGuiIO_t* self, int key, int native_keycode, int native_scancode) @trusted
{
    ImGuiIO_SetKeyEventNativeData(self, key, native_keycode, native_scancode);
}

void IOSetKeyEventNativeDataEx(scope ImGuiIO_t* self, int key, int native_keycode, int native_scancode, int native_legacy_index) @trusted
{
    ImGuiIO_SetKeyEventNativeDataEx(self, key, native_keycode, native_scancode, native_legacy_index);
}

void IOSetAppAcceptingEvents(scope ImGuiIO_t* self, bool accepting_events) @trusted
{
    ImGuiIO_SetAppAcceptingEvents(self, accepting_events);
}

void IOClearEventsQueue(scope ImGuiIO_t* self) @trusted
{
    ImGuiIO_ClearEventsQueue(self);
}

void IOClearInputKeys(scope ImGuiIO_t* self) @trusted
{
    ImGuiIO_ClearInputKeys(self);
}

void IOClearInputMouse(scope ImGuiIO_t* self) @trusted
{
    ImGuiIO_ClearInputMouse(self);
}

void IOClearInputCharacters(scope ImGuiIO_t* self) @trusted
{
    ImGuiIO_ClearInputCharacters(self);
}

void InputTextCallbackDataDeleteChars(
    scope const(ImGuiInputTextCallbackData_t)* self, int pos, int bytes_count) @trusted
{
    ImGuiInputTextCallbackData_DeleteChars(cast(ImGuiInputTextCallbackData_t*) self, pos, bytes_count);
}

void InputTextCallbackDataInsertChars(scope const(ImGuiInputTextCallbackData_t)* self, int pos, scope const(
        char)* text, scope const(
        char)* text_end) @trusted
{
    ImGuiInputTextCallbackData_InsertChars(cast(ImGuiInputTextCallbackData_t*) self, pos, text, text_end);
}

void InputTextCallbackDataSelectAll(scope const(ImGuiInputTextCallbackData_t)* self) @trusted
{
    ImGuiInputTextCallbackData_SelectAll(cast(ImGuiInputTextCallbackData_t*) self);
}

void InputTextCallbackDataClearSelection(scope const(ImGuiInputTextCallbackData_t)* self) @trusted
{
    ImGuiInputTextCallbackData_ClearSelection(cast(ImGuiInputTextCallbackData_t*) self);
}

bool InputTextCallbackDataHasSelection(scope const(ImGuiInputTextCallbackData_t)* self) @trusted
{
    return ImGuiInputTextCallbackData_HasSelection(cast(ImGuiInputTextCallbackData_t*) self);
}

void PayloadClear(scope const(ImGuiPayload_t*) self) @trusted
{
    ImGuiPayload_Clear(cast(ImGuiPayload_t*) self);
}

bool PayloadIsDataType(scope const(ImGuiPayload_t*) self, scope const(char)* type) @trusted
{
    return ImGuiPayload_IsDataType(cast(ImGuiPayload_t*) self, type);
}

bool PayloadIsPreview(scope const(ImGuiPayload_t*) self) @trusted
{
    return ImGuiPayload_IsPreview(cast(ImGuiPayload_t*) self);
}

bool PayloadIsDelivery(scope const(ImGuiPayload_t*) self) @trusted
{
    return ImGuiPayload_IsDelivery(cast(ImGuiPayload_t*) self);
}

bool TextFilterRangeEmpty(const(ImGuiTextFilter_ImGuiTextRange_t)* self) @trusted
{
    return ImGuiTextFilter_ImGuiTextRange_empty(cast(ImGuiTextFilter_ImGuiTextRange_t*) self);
}

void TextFilterRangeSplit(scope const(ImGuiTextFilter_ImGuiTextRange_t)* self, char separator, scope ImVector_ImGuiTextFilter_ImGuiTextRange_t* output) @trusted
{
    ImGuiTextFilter_ImGuiTextRange_split(cast(ImGuiTextFilter_ImGuiTextRange_t*) self, separator, output);
}

bool TextFilterDraw(scope const(ImGuiTextFilter_t)* self, scope const(char)* label, float width) @trusted
{
    return ImGuiTextFilter_Draw(cast(ImGuiTextFilter_t*) self, label, width);
}

bool TextFilterPassFilter(scope const(ImGuiTextFilter_t)* self, scope const(char)* text, scope const(
        char)* text_end) @trusted
{
    return ImGuiTextFilter_PassFilter(cast(ImGuiTextFilter_t*) self, text, text_end);
}

void TextFilterBuild(scope const(ImGuiTextFilter_t)* self) @trusted
{
    ImGuiTextFilter_Build(cast(ImGuiTextFilter_t*) self);
}

void TextFilterClear(scope const(ImGuiTextFilter_t)* self) @trusted
{
    ImGuiTextFilter_Clear(cast(ImGuiTextFilter_t*) self);
}

bool TextFilterIsActive(scope const(ImGuiTextFilter_t)* self) @trusted
{
    return ImGuiTextFilter_IsActive(cast(ImGuiTextFilter_t*) self);
}

const(char)* TextBufferBegin(scope const(ImGuiTextBuffer_t)* self) @trusted
{
    return ImGuiTextBuffer_begin(cast(ImGuiTextBuffer_t*) self);
}

const(char)* TextBufferEnd(scope const(ImGuiTextBuffer_t)* self) @trusted
{
    return ImGuiTextBuffer_end(cast(ImGuiTextBuffer_t*) self);
}

int TextBufferSize(scope const(ImGuiTextBuffer_t)* self) @trusted
{
    return ImGuiTextBuffer_size(cast(ImGuiTextBuffer_t*) self);
}

bool TextBufferEmpty(scope const(ImGuiTextBuffer_t)* self) @trusted
{
    return ImGuiTextBuffer_empty(cast(ImGuiTextBuffer_t*) self);
}

void TextBufferClear(scope const(ImGuiTextBuffer_t)* self) @trusted
{
    ImGuiTextBuffer_clear(cast(ImGuiTextBuffer_t*) self);
}

void TextBufferReserve(scope const(ImGuiTextBuffer_t)* self, int capacity) @trusted
{
    ImGuiTextBuffer_reserve(cast(ImGuiTextBuffer_t*) self, capacity);
}

const(char)* TextBufferCStr(scope const(ImGuiTextBuffer_t)* self) @trusted
{
    return ImGuiTextBuffer_c_str(cast(ImGuiTextBuffer_t*) self);
}

void TextBufferAppend(scope const(ImGuiTextBuffer_t)* self, scope const(char)* str, scope const(
        char)* str_end) @trusted
{
    ImGuiTextBuffer_append(cast(ImGuiTextBuffer_t*) self, str, str_end);
}

void TextBufferAppendF(scope const(ImGuiTextBuffer_t)* self, scope const(char)* fmt, __builtin_va_list args) @trusted
{
    ImGuiTextBuffer_appendf(cast(ImGuiTextBuffer_t*) self, fmt, args);
}

void TextBufferAppendFV(scope const(ImGuiTextBuffer_t)* self, scope const(char)* fmt, __builtin_va_list args) @trusted
{
    ImGuiTextBuffer_appendfv(cast(ImGuiTextBuffer_t*) self, fmt, args);
}

void StorageClear(scope const(ImGuiStorage_t)* self) @trusted
{
    ImGuiStorage_Clear(cast(ImGuiStorage_t*) self);
}

int StorageGetInt(scope const(ImGuiStorage_t)* self, uint key, int default_val) @trusted
{
    return ImGuiStorage_GetInt(cast(ImGuiStorage_t*) self, key, default_val);
}

void StorageSetInt(scope const(ImGuiStorage_t)* self, uint key, int val) @trusted
{
    ImGuiStorage_SetInt(cast(ImGuiStorage_t*) self, key, val);
}

bool StorageGetBool(scope const(ImGuiStorage_t)* self, uint key, bool default_val) @trusted
{
    return ImGuiStorage_GetBool(cast(ImGuiStorage_t*) self, key, default_val);
}

void StorageSetBool(scope const(ImGuiStorage_t)* self, uint key, bool val) @trusted
{
    ImGuiStorage_SetBool(cast(ImGuiStorage_t*) self, key, val);
}

float StorageGetFloat(scope const(ImGuiStorage_t)* self, uint key, float default_val) @trusted
{
    return ImGuiStorage_GetFloat(cast(ImGuiStorage_t*) self, key, default_val);
}

void StorageSetFloat(scope const(ImGuiStorage_t)* self, uint key, float val) @trusted
{
    ImGuiStorage_SetFloat(cast(ImGuiStorage_t*) self, key, val);
}

scope void* StorageGetVoidPtr(scope const(ImGuiStorage_t)* self, uint key) @trusted
{
    return ImGuiStorage_GetVoidPtr(cast(ImGuiStorage_t*) self, key);
}

void StorageSetVoidPtr(scope const(ImGuiStorage_t)* self, uint key, scope void* val) @trusted
{
    ImGuiStorage_SetVoidPtr(cast(ImGuiStorage_t*) self, key, val);
}

scope int* StorageGetIntRef(scope const(ImGuiStorage_t)* self, uint key, int default_val) @trusted
{
    return ImGuiStorage_GetIntRef(cast(ImGuiStorage_t*) self, key, default_val);
}

scope bool* StorageGetBoolRef(scope const(ImGuiStorage_t)* self, uint key, bool default_val) @trusted
{
    return ImGuiStorage_GetBoolRef(cast(ImGuiStorage_t*) self, key, default_val);
}

scope float* StorageGetFloatRef(scope const(ImGuiStorage_t)* self, uint key, float default_val) @trusted
{
    return ImGuiStorage_GetFloatRef(cast(ImGuiStorage_t*) self, key, default_val);
}

scope void** StorageGetVoidPtrRef(scope const(ImGuiStorage_t)* self, uint key, scope void* default_val) @trusted
{
    return ImGuiStorage_GetVoidPtrRef(cast(ImGuiStorage_t*) self, key, default_val);
}

void StorageBuildSortByKey(scope const(ImGuiStorage_t)* self) @trusted
{
    ImGuiStorage_BuildSortByKey(cast(ImGuiStorage_t*) self);
}

void StorageSetAllInt(scope const(ImGuiStorage_t)* self, int val) @trusted
{
    ImGuiStorage_SetAllInt(cast(ImGuiStorage_t*) self, val);
}

void ListClipperBegin(scope ImGuiListClipper_t* self, int items_count, float items_height) @trusted
{
    ImGuiListClipper_Begin(self, items_count, items_height);
}

void ListClipperEnd(scope ImGuiListClipper_t* self) @trusted
{
    ImGuiListClipper_End(self);
}

bool ListClipperStep(scope ImGuiListClipper_t* self) @trusted
{
    return ImGuiListClipper_Step(self);
}

void ListClipperIncludeItemByIndex(scope ImGuiListClipper_t* self, int item_index) @trusted
{
    ImGuiListClipper_IncludeItemByIndex(self, item_index);
}

void ListClipperIncludeItemsByIndex(scope ImGuiListClipper_t* self, int item_begin, int item_end) @trusted
{
    ImGuiListClipper_IncludeItemsByIndex(self, item_begin, item_end);
}

void ListClipperSeekCursorForItem(scope ImGuiListClipper_t* self, int item_index) @trusted
{
    ImGuiListClipper_SeekCursorForItem(self, item_index);
}

void ListClipperIncludeRangeByIndices(scope ImGuiListClipper_t* self, int item_begin, int item_end) @trusted
{
    ImGuiListClipper_IncludeRangeByIndices(self, item_begin, item_end);
}

void ListClipperForceDisplayRangeByIndices(scope ImGuiListClipper_t* self, int item_begin, int item_end) @trusted
{
    ImGuiListClipper_ForceDisplayRangeByIndices(self, item_begin, item_end);
}

void ColorSetHSV(scope ImColor_t* self, float h, float s, float v, float a) @trusted
{
    ImColor_SetHSV(self, h, s, v, a);
}

ImColor_t ColorHSV(float h, float s, float v, float a) @trusted
{
    return ImColor_HSV(h, s, v, a);
}

void SelectionBasicStorageApplyRequests(
    scope const(ImGuiSelectionBasicStorage_t)* self, scope ImGuiMultiSelectIO_t* ms_io) @trusted
{
    ImGuiSelectionBasicStorage_ApplyRequests(cast(ImGuiSelectionBasicStorage_t*) self, ms_io);
}

bool SelectionBasicStorageContains(scope const(ImGuiSelectionBasicStorage_t)* self, uint id) @trusted
{
    return ImGuiSelectionBasicStorage_Contains(cast(ImGuiSelectionBasicStorage_t*) self, id);
}

void SelectionBasicStorageClear(scope const(ImGuiSelectionBasicStorage_t)* self) @trusted
{
    ImGuiSelectionBasicStorage_Clear(cast(ImGuiSelectionBasicStorage_t*) self);
}

void SelectionBasicStorageSwap(scope const(ImGuiSelectionBasicStorage_t)* self, scope const(
        ImGuiSelectionBasicStorage_t)* r) @trusted
{
    ImGuiSelectionBasicStorage_Swap(cast(ImGuiSelectionBasicStorage_t*) self, cast(
            ImGuiSelectionBasicStorage_t*) r);
}

void SelectionBasicStorageSetItemSelected(
    scope const(ImGuiSelectionBasicStorage_t)* self, uint id, bool selected) @trusted
{
    ImGuiSelectionBasicStorage_SetItemSelected(cast(ImGuiSelectionBasicStorage_t*) self, id, selected);
}

bool SelectionBasicStorageGetNextSelectedItem(
    const ImGuiSelectionBasicStorage_t* self, scope void** opaque_it, scope uint* out_id) @trusted
{
    return ImGuiSelectionBasicStorage_GetNextSelectedItem(
        cast(ImGuiSelectionBasicStorage_t*) self, opaque_it, out_id);
}

uint SelectionBasicStorageGetStorageIdFromIndex(
    scope const(ImGuiSelectionBasicStorage_t)* self, int idx) @trusted
{
    return ImGuiSelectionBasicStorage_GetStorageIdFromIndex(
        cast(ImGuiSelectionBasicStorage_t*) self, idx);
}

void applyRequests(
    ImGuiSelectionExternalStorage_t* self, ImGuiMultiSelectIO_t* ms_io) @trusted
{
    ImGuiSelectionExternalStorage_ApplyRequests(self, ms_io);
}

auto getTexID(scope const(ImDrawCmd_t)* self) @trusted
{
    return ImDrawCmd_GetTexID(cast(ImDrawCmd_t*) self);
}

void clear(scope ImDrawListSplitter_t* self) @trusted
{
    ImDrawListSplitter_Clear(self);
}

void clearFreeMemory(scope ImDrawListSplitter_t* self) @trusted
{
    ImDrawListSplitter_ClearFreeMemory(self);
}

void split(scope ImDrawListSplitter_t* self, scope const(ImDrawList_t)* draw_list, int count) @trusted
{
    ImDrawListSplitter_Split(self, cast(ImDrawList_t*) draw_list, count);
}

void merge(scope ImDrawListSplitter_t* self, scope const(ImDrawList_t)* draw_list) @trusted
{
    ImDrawListSplitter_Merge(self, cast(ImDrawList_t*) draw_list);
}

void setCurrentChannel(scope ImDrawListSplitter_t* self, scope const(ImDrawList_t)* draw_list, int channel_idx) @trusted
{
    ImDrawListSplitter_SetCurrentChannel(self, cast(ImDrawList_t*) draw_list, channel_idx);
}

void pushClipRect(scope const(ImDrawList_t)* self, const ImVec2_t clip_rect_min, const ImVec2_t clip_rect_max, bool intersect_with_current_clip_rect) @trusted
{
    ImDrawList_PushClipRect(cast(ImDrawList_t*) self, clip_rect_min, clip_rect_max, intersect_with_current_clip_rect);
}

void pushClipRectFullScreen(scope const(ImDrawList_t)* self) @trusted
{
    ImDrawList_PushClipRectFullScreen(cast(ImDrawList_t*) self);
}

void popClipRect(scope const(ImDrawList_t)* self) @trusted
{
    ImDrawList_PopClipRect(cast(ImDrawList_t*) self);
}

void pushTextureID(scope const(ImDrawList_t)* self, size_t texture_id) @trusted
{
    ImDrawList_PushTextureID(cast(ImDrawList_t*) self, texture_id);
}

void popTextureID(scope const(ImDrawList_t)* self) @trusted
{
    ImDrawList_PopTextureID(cast(ImDrawList_t*) self);
}

const(ImVec2_t) getClipRectMin(scope const(ImDrawList_t)* self) @trusted
{
    return ImDrawList_GetClipRectMin(cast(ImDrawList_t*) self);
}

const(ImVec2_t) getClipRectMax(scope const(ImDrawList_t)* self) @trusted
{
    return ImDrawList_GetClipRectMax(cast(ImDrawList_t*) self);
}

void addLine(scope const(ImDrawList_t)* self, const ImVec2_t p1, const ImVec2_t p2, uint col) @trusted
{
    ImDrawList_AddLine(cast(ImDrawList_t*) self, p1, p2, col);
}

void addLineEx(scope const(ImDrawList_t)* self, const ImVec2_t p1, const ImVec2_t p2, uint col, float thickness) @trusted
{
    ImDrawList_AddLineEx(cast(ImDrawList_t*) self, p1, p2, col, thickness);
}

void addRect(scope const(ImDrawList_t)* self, const ImVec2_t p_min, const ImVec2_t p_max, uint col) @trusted
{
    ImDrawList_AddRect(cast(ImDrawList_t*) self, p_min, p_max, col);
}

void addRectEx(scope const(ImDrawList_t)* self, const ImVec2_t p_min, const ImVec2_t p_max, uint col, float rounding, int flags, float thickness) @trusted
{
    ImDrawList_AddRectEx(cast(ImDrawList_t*) self, p_min, p_max, col, rounding, flags, thickness);
}

void addRectFilled(scope const(ImDrawList_t)* self, const ImVec2_t p_min, const ImVec2_t p_max, uint col) @trusted
{
    ImDrawList_AddRectFilled(cast(ImDrawList_t*) self, p_min, p_max, col);
}

void addRectFilledEx(scope const(ImDrawList_t)* self, const ImVec2_t p_min, const ImVec2_t p_max, uint col, float rounding, int flags) @trusted
{
    ImDrawList_AddRectFilledEx(cast(ImDrawList_t*) self, p_min, p_max, col, rounding, flags);
}

void addRectFilledMultiColor(scope const(ImDrawList_t)* self, const ImVec2_t p_min, const ImVec2_t p_max, uint col_upr_left, uint col_upr_right, uint col_bot_right, uint col_bot_left) @trusted
{
    ImDrawList_AddRectFilledMultiColor(cast(ImDrawList_t*) self, p_min, p_max, col_upr_left, col_upr_right, col_bot_right, col_bot_left);
}

void addQuad(scope const(ImDrawList_t)* self, const ImVec2_t p1, const ImVec2_t p2, const ImVec2_t p3, const ImVec2_t p4, uint col) @trusted
{
    ImDrawList_AddQuad(cast(ImDrawList_t*) self, p1, p2, p3, p4, col);
}

void addQuadEx(scope const(ImDrawList_t)* self, const ImVec2_t p1, const ImVec2_t p2, const ImVec2_t p3, const ImVec2_t p4, uint col, float thickness) @trusted
{
    ImDrawList_AddQuadEx(cast(ImDrawList_t*) self, p1, p2, p3, p4, col, thickness);
}

void addQuadFilled(scope const(ImDrawList_t)* self, const ImVec2_t p1, const ImVec2_t p2, const ImVec2_t p3, const ImVec2_t p4, uint col) @trusted
{
    ImDrawList_AddQuadFilled(cast(ImDrawList_t*) self, p1, p2, p3, p4, col);
}

void addTriangle(scope const(ImDrawList_t)* self, const ImVec2_t p1, const ImVec2_t p2, const ImVec2_t p3, uint col) @trusted
{
    ImDrawList_AddTriangle(cast(ImDrawList_t*) self, p1, p2, p3, col);
}

void addTriangleEx(scope const(ImDrawList_t)* self, const ImVec2_t p1, const ImVec2_t p2, const ImVec2_t p3, uint col, float thickness) @trusted
{
    ImDrawList_AddTriangleEx(cast(ImDrawList_t*) self, p1, p2, p3, col, thickness);
}

void addTriangleFilled(scope const(ImDrawList_t)* self, const ImVec2_t p1, const ImVec2_t p2, const ImVec2_t p3, uint col) @trusted
{
    ImDrawList_AddTriangleFilled(cast(ImDrawList_t*) self, p1, p2, p3, col);
}

void addCircle(scope const(ImDrawList_t)* self, const ImVec2_t center, float radius, uint col) @trusted
{
    ImDrawList_AddCircle(cast(ImDrawList_t*) self, center, radius, col);
}

void addCircleEx(scope const(ImDrawList_t)* self, const ImVec2_t center, float radius, uint col, int num_segments, float thickness) @trusted
{
    ImDrawList_AddCircleEx(cast(ImDrawList_t*) self, center, radius, col, num_segments, thickness);
}

void addCircleFilled(scope const(ImDrawList_t)* self, const ImVec2_t center, float radius, uint col, int num_segments) @trusted
{
    ImDrawList_AddCircleFilled(cast(ImDrawList_t*) self, center, radius, col, num_segments);
}

void addNgon(scope const(ImDrawList_t)* self, const ImVec2_t center, float radius, uint col, int num_segments) @trusted
{
    ImDrawList_AddNgon(cast(ImDrawList_t*) self, center, radius, col, num_segments);
}

void addNgonEx(scope const(ImDrawList_t)* self, const ImVec2_t center, float radius, uint col, int num_segments, float thickness) @trusted
{
    ImDrawList_AddNgonEx(cast(ImDrawList_t*) self, center, radius, col, num_segments, thickness);
}

void addNgonFilled(scope const(ImDrawList_t)* self, const ImVec2_t center, float radius, uint col, int num_segments) @trusted
{
    ImDrawList_AddNgonFilled(cast(ImDrawList_t*) self, center, radius, col, num_segments);
}

void addEllipse(scope const(ImDrawList_t)* self, const ImVec2_t center, const ImVec2_t radius, uint col) @trusted
{
    ImDrawList_AddEllipse(cast(ImDrawList_t*) self, center, radius, col);
}

void addEllipseEx(scope const(ImDrawList_t)* self, const ImVec2_t center, const ImVec2_t radius, uint col, float rot, int num_segments, float thickness) @trusted
{
    ImDrawList_AddEllipseEx(cast(ImDrawList_t*) self, center, radius, col, rot, num_segments, thickness);
}

void addEllipseFilled(scope const(ImDrawList_t)* self, const ImVec2_t center, const ImVec2_t radius, uint col) @trusted
{
    ImDrawList_AddEllipseFilled(cast(ImDrawList_t*) self, center, radius, col);
}

void addEllipseFilledEx(scope const(ImDrawList_t)* self, const ImVec2_t center, const ImVec2_t radius, uint col, float rot, int num_segments) @trusted
{
    ImDrawList_AddEllipseFilledEx(cast(ImDrawList_t*) self, center, radius, col, rot, num_segments);
}

void addText(scope const(ImDrawList_t)* self, const ImVec2_t pos, uint col, scope const(char)* text_begin) @trusted
{
    ImDrawList_AddText(cast(ImDrawList_t*) self, pos, col, text_begin);
}

void addTextEx(scope const(ImDrawList_t)* self, const ImVec2_t pos, uint col, scope const(char)* text_begin, scope const(
        char)* text_end) @trusted
{
    ImDrawList_AddTextEx(cast(ImDrawList_t*) self, pos, col, text_begin, text_end);
}

void addTextImFontPtr(scope const(ImDrawList_t)* self, scope const(ImFont_t)* font, float font_size, const ImVec2_t pos, uint col, scope const(
        char)* text_begin) @trusted
{
    ImDrawList_AddTextImFontPtr(cast(ImDrawList_t*) self, cast(ImFont_t*) font, font_size, pos, col, text_begin);
}

void addTextImFontPtrEx(scope const(ImDrawList_t)* self, scope const(ImFont_t)* font, float font_size, const ImVec2_t pos, uint col, scope const(
        char)* text_begin, scope const(
        char)* text_end, float wrap_width, scope const(ImVec4_t)* cpu_fine_clip_rect) @trusted
{
    ImDrawList_AddTextImFontPtrEx(cast(ImDrawList_t*) self, cast(ImFont_t*) font, font_size, pos, col, text_begin, text_end, wrap_width, cast(
            ImVec4_t*) cpu_fine_clip_rect);
}

void addBezierCubic(scope ImDrawList_t* self, const ImVec2_t p1, const ImVec2_t p2, const ImVec2_t p3, const ImVec2_t p4, uint col, float thickness, int num_segments) @trusted
{
    ImDrawList_AddBezierCubic(self, p1, p2, p3, p4, col, thickness, num_segments);
}

void addBezierQuadratic(scope ImDrawList_t* self, const ImVec2_t p1, const ImVec2_t p2, const ImVec2_t p3, uint col, float thickness, int num_segments) @trusted
{
    ImDrawList_AddBezierQuadratic(self, p1, p2, p3, col, thickness, num_segments);
}

void addPolyline(scope ImDrawList_t* self, scope const(ImVec2_t)* points, int num_points, uint col, int flags, float thickness) @trusted
{
    ImDrawList_AddPolyline(self, cast(ImVec2_t*) points, num_points, col, flags, thickness);
}

void addConvexPolyFilled(scope ImDrawList_t* self, scope const(ImVec2_t)* points, int num_points, uint col) @trusted
{
    ImDrawList_AddConvexPolyFilled(self, cast(ImVec2_t*) points, num_points, col);
}

void addConcavePolyFilled(scope ImDrawList_t* self, scope const(ImVec2_t)* points, int num_points, uint col) @trusted
{
    ImDrawList_AddConcavePolyFilled(self, cast(ImVec2_t*) points, num_points, col);
}

void addImage(scope ImDrawList_t* self, size_t user_texture_id, const ImVec2_t p_min, const ImVec2_t p_max) @trusted
{
    ImDrawList_AddImage(self, user_texture_id, p_min, p_max);
}

void addImageEx(scope ImDrawList_t* self, size_t user_texture_id, const ImVec2_t p_min, const ImVec2_t p_max, const ImVec2_t uv_min, const ImVec2_t uv_max, uint col) @trusted
{
    ImDrawList_AddImageEx(self, user_texture_id, p_min, p_max, uv_min, uv_max, col);
}

void addImageQuad(scope ImDrawList_t* self, size_t user_texture_id, const ImVec2_t p1, const ImVec2_t p2, const ImVec2_t p3, const ImVec2_t p4) @trusted
{
    ImDrawList_AddImageQuad(self, user_texture_id, p1, p2, p3, p4);
}

void addImageQuadEx(scope ImDrawList_t* self, size_t user_texture_id, const ImVec2_t p1, const ImVec2_t p2, const ImVec2_t p3, const ImVec2_t p4, const ImVec2_t uv1, const ImVec2_t uv2, const ImVec2_t uv3, const ImVec2_t uv4, uint col) @trusted
{
    ImDrawList_AddImageQuadEx(self, user_texture_id, p1, p2, p3, p4, uv1, uv2, uv3, uv4, col);
}

void addImageRounded(scope ImDrawList_t* self, size_t user_texture_id, const ImVec2_t p_min, const ImVec2_t p_max, const ImVec2_t uv_min, const ImVec2_t uv_max, uint col, float rounding, int flags) @trusted
{
    ImDrawList_AddImageRounded(self, user_texture_id, p_min, p_max, uv_min, uv_max, col, rounding, flags);
}

void pathClear(scope ImDrawList_t* self) @trusted
{
    ImDrawList_PathClear(self);
}

void pathLineTo(scope ImDrawList_t* self, const ImVec2_t pos) @trusted
{
    ImDrawList_PathLineTo(self, pos);
}

void pathLineToMergeDuplicate(scope ImDrawList_t* self, const ImVec2_t pos) @trusted
{
    ImDrawList_PathLineToMergeDuplicate(self, pos);
}

void pathFillConvex(scope ImDrawList_t* self, uint col) @trusted
{
    ImDrawList_PathFillConvex(self, col);
}

void pathFillConcave(scope ImDrawList_t* self, uint col) @trusted
{
    ImDrawList_PathFillConcave(self, col);
}

void pathStroke(scope ImDrawList_t* self, uint col, int flags, float thickness) @trusted
{
    ImDrawList_PathStroke(self, col, flags, thickness);
}

void pathArcTo(scope ImDrawList_t* self, const ImVec2_t center, float radius, float a_min, float a_max, int num_segments) @trusted
{
    ImDrawList_PathArcTo(self, center, radius, a_min, a_max, num_segments);
}

void pathArcToFast(scope ImDrawList_t* self, const ImVec2_t center, float radius, int a_min_of_12, int a_max_of_12) @trusted
{
    ImDrawList_PathArcToFast(self, center, radius, a_min_of_12, a_max_of_12);
}

void pathEllipticalArcTo(scope ImDrawList_t* self, const ImVec2_t center, const ImVec2_t radius, float rot, float a_min, float a_max) @trusted
{
    ImDrawList_PathEllipticalArcTo(self, center, radius, rot, a_min, a_max);
}

void pathEllipticalArcToEx(scope ImDrawList_t* self, const ImVec2_t center, const ImVec2_t radius, float rot, float a_min, float a_max, int num_segments) @trusted
{
    ImDrawList_PathEllipticalArcToEx(self, center, radius, rot, a_min, a_max, num_segments);
}

void pathBezierCubicCurveTo(scope ImDrawList_t* self, const ImVec2_t p2, const ImVec2_t p3, const ImVec2_t p4, int num_segments) @trusted
{
    ImDrawList_PathBezierCubicCurveTo(self, p2, p3, p4, num_segments);
}

void pathBezierQuadraticCurveTo(scope ImDrawList_t* self, const ImVec2_t p2, const ImVec2_t p3, int num_segments) @trusted
{
    ImDrawList_PathBezierQuadraticCurveTo(self, p2, p3, num_segments);
}

void pathRect(scope ImDrawList_t* self, const ImVec2_t rect_min, const ImVec2_t rect_max, float rounding, int flags) @trusted
{
    ImDrawList_PathRect(self, rect_min, rect_max, rounding, flags);
}

extern (C) void addCallback(scope ImDrawList_t* self, void function(scope const(
        ImDrawList_t)* parent_list, scope const(ImDrawCmd_t)* cmd) callback, scope void* userdata) @trusted
{
    ImDrawList_AddCallback(self, callback, userdata);
}

extern (C) void addCallbackEx(scope ImDrawList_t* self, void function(scope const(
        ImDrawList_t)* parent_list, scope const(ImDrawCmd_t)* cmd) callback, scope void* userdata, size_t userdata_size) @trusted
{
    ImDrawList_AddCallbackEx(self, callback, userdata, userdata_size);
}

void addDrawCmd(scope ImDrawList_t* self) @trusted
{
    ImDrawList_AddDrawCmd(self);
}

scope ImDrawList_t* cloneOutput(scope ImDrawList_t* self) @trusted
{
    return cast(ImDrawList_t*) ImDrawList_CloneOutput(self);
}

void channelsSplit(scope ImDrawList_t* self, int count) @trusted
{
    ImDrawList_ChannelsSplit(self, count);
}

void channelsMerge(scope ImDrawList_t* self) @trusted
{
    ImDrawList_ChannelsMerge(self);
}

void channelsSetCurrent(scope ImDrawList_t* self, int n) @trusted
{
    ImDrawList_ChannelsSetCurrent(self, n);
}

void primReserve(scope ImDrawList_t* self, int idx_count, int vtx_count) @trusted
{
    ImDrawList_PrimReserve(self, idx_count, vtx_count);
}

void primUnreserve(scope ImDrawList_t* self, int idx_count, int vtx_count) @trusted
{
    ImDrawList_PrimUnreserve(self, idx_count, vtx_count);
}

void primRect(scope ImDrawList_t* self, ImVec2_t a, ImVec2_t b, uint col) @trusted
{
    ImDrawList_PrimRect(self, a, b, col);
}

void primRectUV(scope ImDrawList_t* self, ImVec2_t a, ImVec2_t b, ImVec2_t uv_a, ImVec2_t uv_b, uint col) @trusted
{
    ImDrawList_PrimRectUV(self, a, b, uv_a, uv_b, col);
}

void primQuadUV(scope ImDrawList_t* self, ImVec2_t a, ImVec2_t b, ImVec2_t c, ImVec2_t d, ImVec2_t uv_a, ImVec2_t uv_b, ImVec2_t uv_c, ImVec2_t uv_d, uint col) @trusted
{
    ImDrawList_PrimQuadUV(self, a, b, c, d, uv_a, uv_b, uv_c, uv_d, col);
}

void primWriteVtx(scope ImDrawList_t* self, ImVec2_t pos, ImVec2_t uv, uint col) @trusted
{
    ImDrawList_PrimWriteVtx(self, pos, uv, col);
}

void primWriteIdx(scope ImDrawList_t* self, ushort idx) @trusted
{
    ImDrawList_PrimWriteIdx(self, idx);
}

void primVtx(scope ImDrawList_t* self, ImVec2_t pos, ImVec2_t uv, uint col) @trusted
{
    ImDrawList_PrimVtx(self, pos, uv, col);
}

void resetForNewFrame(scope ImDrawList_t* self) @trusted
{
    ImDrawList__ResetForNewFrame(self);
}

void clearFreeMemory(scope ImDrawList_t* self) @trusted
{
    ImDrawList__ClearFreeMemory(self);
}

void popUnusedDrawCmd(scope ImDrawList_t* self) @trusted
{
    ImDrawList__PopUnusedDrawCmd(self);
}

void tryMergeDrawCmds(scope ImDrawList_t* self) @trusted
{
    ImDrawList__TryMergeDrawCmds(self);
}

void onChangedClipRect(scope ImDrawList_t* self) @trusted
{
    ImDrawList__OnChangedClipRect(self);
}

void onChangedTextureID(scope ImDrawList_t* self) @trusted
{
    ImDrawList__OnChangedTextureID(self);
}

void onChangedVtxOffset(scope ImDrawList_t* self) @trusted
{
    ImDrawList__OnChangedVtxOffset(self);
}

void setTextureID(scope ImDrawList_t* self, size_t texture_id) @trusted
{
    ImDrawList__SetTextureID(self, texture_id);
}

int calcCircleAutoSegmentCount(scope ImDrawList_t* self, float radius) @trusted
{
    return ImDrawList__CalcCircleAutoSegmentCount(self, radius);
}

void pathArcToFastEx(scope ImDrawList_t* self, ImVec2_t center, float radius, int a_min_sample, int a_max_sample, int a_step) @trusted
{
    ImDrawList__PathArcToFastEx(self, center, radius, a_min_sample, a_max_sample, a_step);
}

void pathArcToN(scope ImDrawList_t* self, ImVec2_t center, float radius, float a_min, float a_max, int num_segments) @trusted
{
    ImDrawList__PathArcToN(self, center, radius, a_min, a_max, num_segments);
}

void clearDrawData(scope ImDrawData_t* self) @trusted
{
    ImDrawData_Clear(self);
}

void addDrawList(scope ImDrawData_t* self, scope const(ImDrawList_t)* draw_list) @trusted
{
    ImDrawData_AddDrawList(self, cast(ImDrawList_t*) draw_list);
}

void deIndexAllBuffers(scope ImDrawData_t* self) @trusted
{
    ImDrawData_DeIndexAllBuffers(self);
}

void scaleClipRects(scope ImDrawData_t* self, const ImVec2_t fb_scale) @trusted
{
    ImDrawData_ScaleClipRects(self, fb_scale);
}

void clearGlyphRangesBuilder(scope const(ImFontGlyphRangesBuilder_t)* self) @trusted
{
    ImFontGlyphRangesBuilder_Clear(cast(ImFontGlyphRangesBuilder_t*) self);
}

bool getBit(scope const(ImFontGlyphRangesBuilder_t)* self, size_t n) @trusted
{
    return ImFontGlyphRangesBuilder_GetBit(cast(ImFontGlyphRangesBuilder_t*) self, n);
}

void setBit(scope const(ImFontGlyphRangesBuilder_t)* self, size_t n) @trusted
{
    ImFontGlyphRangesBuilder_SetBit(cast(ImFontGlyphRangesBuilder_t*) self, n);
}

void addChar(scope const(ImFontGlyphRangesBuilder_t)* self, ushort c) @trusted
{
    ImFontGlyphRangesBuilder_AddChar(cast(ImFontGlyphRangesBuilder_t*) self, c);
}

void addText(scope const(ImFontGlyphRangesBuilder_t)* self, scope const(char)* text, scope const(
        char)* text_end) @trusted
{
    ImFontGlyphRangesBuilder_AddText(cast(ImFontGlyphRangesBuilder_t*) self, text, text_end);
}

void addRanges(scope const(ImFontGlyphRangesBuilder_t)* self, scope const(ushort)* ranges) @trusted
{
    ImFontGlyphRangesBuilder_AddRanges(cast(ImFontGlyphRangesBuilder_t*) self, ranges);
}

void buildRanges(scope const(ImFontGlyphRangesBuilder_t)* self, ImVector_ImWchar_t* out_ranges) @trusted
{
    ImFontGlyphRangesBuilder_BuildRanges(cast(ImFontGlyphRangesBuilder_t*) self, out_ranges);
}

bool isPacked(scope const(ImFontAtlasCustomRect_t)* self) @trusted
{
    return ImFontAtlasCustomRect_IsPacked(cast(ImFontAtlasCustomRect_t*) self);
}

scope const(ImFont_t)* addFont(scope const(ImFontAtlas_t)* self, scope const(ImFontConfig_t)* font_cfg) @trusted
{
    return ImFontAtlas_AddFont(cast(ImFontAtlas_t*) self, cast(ImFontConfig_t*) font_cfg);
}

scope const(ImFont_t)* addFontDefault(scope const(ImFontAtlas_t)* self, scope const(ImFontConfig_t)* font_cfg) @trusted
{
    return ImFontAtlas_AddFontDefault(cast(ImFontAtlas_t*) self, cast(ImFontConfig_t*) font_cfg);
}

scope const(ImFont_t)* addFontFromFileTTF(scope const(ImFontAtlas_t)* self, scope const(char)* filename, float size_pixels, scope const(
        ImFontConfig_t)* font_cfg, scope const(
        ushort)* glyph_ranges) @trusted
{
    return ImFontAtlas_AddFontFromFileTTF(cast(ImFontAtlas_t*) self, filename, size_pixels, cast(
            ImFontConfig_t*) font_cfg, glyph_ranges);
}

scope const(ImFont_t)* addFontFromMemoryTTF(scope const(ImFontAtlas_t)* self, scope void* font_data, int font_data_size, float size_pixels, scope const(
        ImFontConfig_t)* font_cfg, scope const(
        ushort)* glyph_ranges) @trusted
{
    return ImFontAtlas_AddFontFromMemoryTTF(cast(ImFontAtlas_t*) self, font_data, font_data_size, size_pixels, cast(
            ImFontConfig_t*) font_cfg, glyph_ranges);
}

scope const(ImFont_t)* addFontFromMemoryCompressedTTF(
    scope const(ImFontAtlas_t)* self, scope const(void)* compressed_font_data, int compressed_font_data_size, float size_pixels, scope const(
        ImFontConfig_t)* font_cfg, scope const(
        ushort)* glyph_ranges) @trusted
{
    return ImFontAtlas_AddFontFromMemoryCompressedTTF(cast(ImFontAtlas_t*) self, compressed_font_data, compressed_font_data_size, size_pixels, cast(
            ImFontConfig_t*) font_cfg, glyph_ranges);
}

scope const(ImFont_t)* addFontFromMemoryCompressedBase85TTF(
    scope const(ImFontAtlas_t)* self, scope const(char)* compressed_font_data_base85, float size_pixels, scope const(
        ImFontConfig_t)* font_cfg, scope const(
        ushort)* glyph_ranges) @trusted
{
    return ImFontAtlas_AddFontFromMemoryCompressedBase85TTF(cast(ImFontAtlas_t*) self, compressed_font_data_base85, size_pixels, cast(
            ImFontConfig_t*) font_cfg, glyph_ranges);
}

void clearInputData(scope const(ImFontAtlas_t)* self) @trusted
{
    ImFontAtlas_ClearInputData(cast(ImFontAtlas_t*) self);
}

void clearTexData(scope const(ImFontAtlas_t)* self) @trusted
{
    ImFontAtlas_ClearTexData(cast(ImFontAtlas_t*) self);
}

void clearFonts(scope const(ImFontAtlas_t)* self) @trusted
{
    ImFontAtlas_ClearFonts(cast(ImFontAtlas_t*) self);
}

void clearFontAtlas(scope const(ImFontAtlas_t)* self) @trusted
{
    ImFontAtlas_Clear(cast(ImFontAtlas_t*) self);
}

bool buildFontAtlas(scope const(ImFontAtlas_t)* self) @trusted
{
    return ImFontAtlas_Build(cast(ImFontAtlas_t*) self);
}

void getTexDataAsAlpha8(scope const(ImFontAtlas_t)* self, scope ubyte** out_pixels, scope int* out_width, scope int* out_height, scope int* out_bytes_per_pixel) @trusted
{
    ImFontAtlas_GetTexDataAsAlpha8(cast(ImFontAtlas_t*) self, out_pixels, out_width, out_height, out_bytes_per_pixel);
}

void getTexDataAsRGBA32(scope const(ImFontAtlas_t)* self, scope ubyte** out_pixels, scope int* out_width, scope int* out_height, scope int* out_bytes_per_pixel) @trusted
{
    ImFontAtlas_GetTexDataAsRGBA32(cast(ImFontAtlas_t*) self, out_pixels, out_width, out_height, out_bytes_per_pixel);
}

bool isFontAtlasBuilt(scope const(ImFontAtlas_t)* self) @trusted
{
    return ImFontAtlas_IsBuilt(cast(ImFontAtlas_t*) self);
}

void setTexID(scope const(ImFontAtlas_t)* self, size_t id) @trusted
{
    ImFontAtlas_SetTexID(cast(ImFontAtlas_t*) self, id);
}

scope const(ushort)* getGlyphRangesDefault(scope const(ImFontAtlas_t)* self) @trusted
{
    return ImFontAtlas_GetGlyphRangesDefault(cast(ImFontAtlas_t*) self);
}

scope const(ushort)* getGlyphRangesGreek(scope const(ImFontAtlas_t)* self) @trusted
{
    return ImFontAtlas_GetGlyphRangesGreek(cast(ImFontAtlas_t*) self);
}

scope const(ushort)* getGlyphRangesKorean(scope const(ImFontAtlas_t)* self) @trusted
{
    return ImFontAtlas_GetGlyphRangesKorean(cast(ImFontAtlas_t*) self);
}

scope const(ushort)* getGlyphRangesJapanese(scope const(ImFontAtlas_t)* self) @trusted
{
    return ImFontAtlas_GetGlyphRangesJapanese(cast(ImFontAtlas_t*) self);
}

scope const(ushort)* getGlyphRangesChineseFull(scope const(ImFontAtlas_t)* self) @trusted
{
    return ImFontAtlas_GetGlyphRangesChineseFull(cast(ImFontAtlas_t*) self);
}

scope const(ushort)* getGlyphRangesChineseSimplifiedCommon(scope const(ImFontAtlas_t)* self) @trusted
{
    return ImFontAtlas_GetGlyphRangesChineseSimplifiedCommon(cast(ImFontAtlas_t*) self);
}

scope const(ushort)* getGlyphRangesCyrillic(scope const(ImFontAtlas_t)* self) @trusted
{
    return ImFontAtlas_GetGlyphRangesCyrillic(cast(ImFontAtlas_t*) self);
}

scope const(ushort)* getGlyphRangesThai(scope const(ImFontAtlas_t)* self) @trusted
{
    return ImFontAtlas_GetGlyphRangesThai(cast(ImFontAtlas_t*) self);
}

scope const(ushort)* getGlyphRangesVietnamese(scope const(ImFontAtlas_t)* self) @trusted
{
    return ImFontAtlas_GetGlyphRangesVietnamese(cast(ImFontAtlas_t*) self);
}

int addCustomRectRegular(scope const(ImFontAtlas_t)* self, int width, int height) @trusted
{
    return ImFontAtlas_AddCustomRectRegular(cast(ImFontAtlas_t*) self, width, height);
}

int addCustomRectFontGlyph(scope const(ImFontAtlas_t)* self, scope const(ImFont_t)* font, ushort id, int width, int height, float advance_x, const ImVec2_t offset) @trusted
{
    return ImFontAtlas_AddCustomRectFontGlyph(cast(ImFontAtlas_t*) self, cast(ImFont_t*) font, id, width, height, advance_x, offset);
}

scope const(ImFontAtlasCustomRect_t)* getCustomRectByIndex(
    scope const(ImFontAtlas_t)* self, int index) @trusted
{
    return ImFontAtlas_GetCustomRectByIndex(cast(ImFontAtlas_t*) self, index);
}

void calcCustomRectUV(scope const(ImFontAtlas_t)* self, scope const(ImFontAtlasCustomRect_t)* rect, scope const(
        ImVec2_t)* out_uv_min, scope const(ImVec2_t)* out_uv_max) @trusted
{
    ImFontAtlas_CalcCustomRectUV(cast(ImFontAtlas_t*) self, cast(ImFontAtlasCustomRect_t*) rect, cast(
            ImVec2_t*) out_uv_min, cast(
            ImVec2_t*) out_uv_max);
}

bool getMouseCursorTexData(scope const(ImFontAtlas_t)* self, int cursor, scope const(ImVec2_t)* out_offset, scope const(
        ImVec2_t)* out_size, const(ImVec2_t)[2] out_uv_border, const(ImVec2_t)[2] out_uv_fill) @trusted
{
    return ImFontAtlas_GetMouseCursorTexData(cast(ImFontAtlas_t*) self, cursor, cast(ImVec2_t*) out_offset, cast(
            ImVec2_t*) out_size, cast(ImVec2_t*)&out_uv_border[0], cast(ImVec2_t*)&out_uv_fill[0]);
}

scope const(ImFontGlyph_t)* findGlyph(scope const(ImFont_t)* self, ushort c) @trusted
{
    return ImFont_FindGlyph(cast(ImFont_t*) self, c);
}

scope const(ImFontGlyph_t)* findGlyphNoFallback(scope const(ImFont_t)* self, ushort c) @trusted
{
    return ImFont_FindGlyphNoFallback(cast(ImFont_t*) self, c);
}

float getCharAdvance(scope const(ImFont_t)* self, ushort c) @trusted
{
    return ImFont_GetCharAdvance(cast(ImFont_t*) self, c);
}

bool isLoaded(scope const(ImFont_t)* self) @trusted
{
    return ImFont_IsLoaded(cast(ImFont_t*) self);
}

const(char)* getDebugName(scope const(ImFont_t)* self) @trusted
{
    return ImFont_GetDebugName(cast(ImFont_t*) self);
}

ImVec2_t calcTextSizeA(scope const(ImFont_t)* self, float size, float max_width, float wrap_width, const(
        char)* text_begin) @trusted
{
    return ImFont_CalcTextSizeA(cast(ImFont_t*) self, size, max_width, wrap_width, text_begin);
}

ImVec2_t calcTextSizeAEx(scope const(ImFont_t)* self, float size, float max_width, float wrap_width,
    scope const(char)* text_begin, scope const(char)* text_end, scope const(char)** remaining) @trusted
{
    return ImFont_CalcTextSizeAEx(cast(ImFont_t*) self, size, max_width, wrap_width, text_begin, text_end, remaining);
}

const(char)* calcWordWrapPositionA(scope const(ImFont_t)* self, float scale, scope const(char)* text,
    const(char)* text_end, float wrap_width) @trusted
{
    return ImFont_CalcWordWrapPositionA(cast(ImFont_t*) self, scale, text, text_end, wrap_width);
}

void renderChar(scope const(ImFont_t)* self, scope const(ImDrawList_t)* draw_list, float size,
    const ImVec2_t pos, uint col, ushort c) @trusted
{
    ImFont_RenderChar(cast(ImFont_t*) self, cast(ImDrawList_t*) draw_list, size, pos, col, c);
}

void renderText(scope const(ImFont_t)* self, scope const(ImDrawList_t)* draw_list, float size, const ImVec2_t pos,
    uint col, const ImVec4_t clip_rect, scope const(char)* text_begin, scope const(char)* text_end,
    float wrap_width, bool cpu_fine_clip) @trusted
{
    ImFont_RenderText(cast(ImFont_t*) self, cast(ImDrawList_t*) draw_list, size, pos, col, clip_rect, text_begin, text_end, wrap_width, cpu_fine_clip);
}

void buildLookupTable(scope const(ImFont_t)* self) @trusted
{
    ImFont_BuildLookupTable(cast(ImFont_t*) self);
}

void clearOutputData(scope const(ImFont_t)* self) @trusted
{
    ImFont_ClearOutputData(cast(ImFont_t*) self);
}

void growIndex(scope const(ImFont_t)* self, int new_size) @trusted
{
    ImFont_GrowIndex(cast(ImFont_t*) self, new_size);
}

void addGlyph(scope const(ImFont_t)* self, const(ImFontConfig_t)* src_cfg, ushort c,
    float x0, float y0, float x1, float y1, float u0, float v0, float u1, float v1, float advance_x) @trusted
{
    ImFont_AddGlyph(cast(ImFont_t*) self, cast(ImFontConfig_t*) src_cfg, c, x0, y0, x1, y1, u0, v0, u1, v1, advance_x);
}

void addRemapChar(scope const(ImFont_t)* self, ushort dst, ushort src, bool overwrite_dst) @trusted
{
    ImFont_AddRemapChar(cast(ImFont_t*) self, dst, src, overwrite_dst);
}

void setGlyphVisible(scope const(ImFont_t)* self, ushort c, bool visible) @trusted
{
    ImFont_SetGlyphVisible(cast(ImFont_t*) self, c, visible);
}

bool isGlyphRangeUnused(scope const(ImFont_t)* self, uint c_begin, uint c_last) @trusted
{
    return ImFont_IsGlyphRangeUnused(cast(ImFont_t*) self, c_begin, c_last);
}

ImVec2_t getViewportCenter(scope const(ImGuiViewport_t)* self) @trusted
{
    return ImGuiViewport_GetCenter(cast(ImGuiViewport_t*) self);
}

ImVec2_t getViewportWorkCenter(scope const(ImGuiViewport_t)* self) @trusted
{
    return ImGuiViewport_GetWorkCenter(cast(ImGuiViewport_t*) self);
}

void pushButtonRepeat(bool repeat) @trusted
{
    igPushButtonRepeat(repeat);
}

void popButtonRepeat() @trusted
{
    igPopButtonRepeat();
}

void pushTabStop(bool tab_stop) @trusted
{
    igPushTabStop(tab_stop);
}

void popTabStop() @trusted
{
    igPopTabStop();
}

ImVec2_t getContentRegionMax() @trusted
{
    return igGetContentRegionMax();
}

ImVec2_t getWindowContentRegionMin() @trusted
{
    return igGetWindowContentRegionMin();
}

ImVec2_t getWindowContentRegionMax() @trusted
{
    return igGetWindowContentRegionMax();
}

bool beginChildFrame(uint id, const ImVec2_t size) @trusted
{
    return igBeginChildFrame(id, size);
}

bool beginChildFrameEx(uint id, const ImVec2_t size, int window_flags) @trusted
{
    return igBeginChildFrameEx(id, size, window_flags);
}

void endChildFrame() @trusted
{
    igEndChildFrame();
}

void showStackToolWindow(scope bool* p_open) @trusted
{
    igShowStackToolWindow(p_open);
}

extern (C) bool comboObsolete(scope const(char)* label, scope int* current_item,
    bool function(void* user_data, int idx, scope const(char)** out_text) old_callback,
    void* user_data, int items_count) @trusted
{
    return igComboObsolete(label, current_item, old_callback, user_data, items_count);
}

extern (C) bool comboObsoleteEx(scope const(char)* label, scope int* current_item,
    bool function(void* user_data, int idx, scope const(char)** out_text) old_callback,
    void* user_data, int items_count, int popup_max_height_in_items) @trusted
{
    return igComboObsoleteEx(label, current_item, old_callback, user_data, items_count, popup_max_height_in_items);
}

extern (C) bool listBoxObsolete(scope const(char)* label, scope int* current_item,
    bool function(void* user_data, int idx, scope const(char)** out_text) old_callback,
    void* user_data, int items_count) @trusted
{
    return igListBoxObsolete(label, current_item, old_callback, user_data, items_count);
}

extern (C) bool listBoxObsoleteEx(scope const(char)* label, scope int* current_item,
    bool function(void* user_data, int idx, scope const(char)** out_text) old_callback,
    void* user_data, int items_count, int height_in_items) @trusted
{
    return igListBoxObsoleteEx(label, current_item, old_callback, user_data, items_count, height_in_items);
}

void setItemAllowOverlap() @trusted
{
    igSetItemAllowOverlap();
}

void pushAllowKeyboardFocus(bool tab_stop) @trusted
{
    igPushAllowKeyboardFocus(tab_stop);
}

void popAllowKeyboardFocus() @trusted
{
    igPopAllowKeyboardFocus();
}
