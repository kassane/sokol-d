// Generated on 2025-06-28
/++
D wrapper for cimgui (Dear ImGui).
Provides bindings for Dear ImGui immediate mode GUI library.

Features:
- Full ImGui API coverage
- @trusted wrapper functions
- Preserves ImGui naming conventions
- Handles memory management
+/
module imgui.cimgui;
public import imgui.c.dcimgui;

pure @nogc nothrow:

// Callback function types
extern(C) alias ImGuiGetterCallback = const(char)* function(void*, int);
extern(C) alias ImGuiOld_callbackCallback = bool function(void*, int, const(char)**);
extern(C) alias ImGuiValues_getterCallback = float function(void*, int);

// D-friendly wrappers
/++
Context creation and access
- Each context create its own ImFontAtlas by default. You may instance one yourself and pass it to CreateContext() to share a font atlas between contexts.
- DLL users: heaps and globals are not shared across DLL boundaries! You will need to call SetCurrentContext() + SetAllocatorFunctions()
for each static/DLL boundary you are calling from. Read "Context and Memory Allocators" section of imgui.cpp for details.
+/
ImGuiContext* CreateContext(scope ImFontAtlas* shared_font_atlas) @trusted
{
    return igCreateContext(shared_font_atlas);
}

void DestroyContext(scope ImGuiContext* ctx) @trusted
{
    igDestroyContext(ctx);
}

ImGuiContext* GetCurrentContext() @trusted
{
    return igGetCurrentContext();
}

void SetCurrentContext(scope ImGuiContext* ctx) @trusted
{
    igSetCurrentContext(ctx);
}

/++
Main
+/
ImGuiIO* GetIO() @trusted
{
    return igGetIO();
}

ImGuiPlatformIO* GetPlatformIO() @trusted
{
    return igGetPlatformIO();
}

ImGuiStyle* GetStyle() @trusted
{
    return igGetStyle();
}

void NewFrame() @trusted
{
    igNewFrame();
}

void EndFrame() @trusted
{
    igEndFrame();
}

void Render() @trusted
{
    igRender();
}

ImDrawData* GetDrawData() @trusted
{
    return igGetDrawData();
}

/++
Demo, Debug, Information
+/
void ShowDemoWindow(scope bool* p_open) @trusted
{
    igShowDemoWindow(p_open);
}

void ShowMetricsWindow(scope bool* p_open) @trusted
{
    igShowMetricsWindow(p_open);
}

void ShowDebugLogWindow(scope bool* p_open) @trusted
{
    igShowDebugLogWindow(p_open);
}

void ShowIDStackToolWindow() @trusted
{
    igShowIDStackToolWindow();
}

void ShowIDStackToolWindowEx(scope bool* p_open) @trusted
{
    igShowIDStackToolWindowEx(p_open);
}

void ShowAboutWindow(scope bool* p_open) @trusted
{
    igShowAboutWindow(p_open);
}

void ShowStyleEditor(scope ImGuiStyle* ref_) @trusted
{
    igShowStyleEditor(ref_);
}

bool ShowStyleSelector(scope const(char)* label) @trusted
{
    return igShowStyleSelector(label);
}

void ShowFontSelector(scope const(char)* label) @trusted
{
    igShowFontSelector(label);
}

void ShowUserGuide() @trusted
{
    igShowUserGuide();
}

const(char)* GetVersion() @trusted
{
    return igGetVersion();
}

/++
Styles
+/
void StyleColorsDark(scope ImGuiStyle* dst) @trusted
{
    igStyleColorsDark(dst);
}

void StyleColorsLight(scope ImGuiStyle* dst) @trusted
{
    igStyleColorsLight(dst);
}

void StyleColorsClassic(scope ImGuiStyle* dst) @trusted
{
    igStyleColorsClassic(dst);
}

/++
Windows
- Begin() = push window to the stack and start appending to it. End() = pop window from the stack.
- Passing 'bool* p_open != NULL' shows a window-closing widget in the upper-right corner of the window,
which clicking will set the boolean to false when clicked.
- You may append multiple times to the same window during the same frame by calling Begin()/End() pairs multiple times.
Some information such as 'flags' or 'p_open' will only be considered by the first call to Begin().
- Begin() return false to indicate the window is collapsed or fully clipped, so you may early out and omit submitting
anything to the window. Always call a matching End() for each Begin() call, regardless of its return value!
[Important: due to legacy reason, Begin/End and BeginChild/EndChild are inconsistent with all other functions
such as BeginMenu/EndMenu, BeginPopup/EndPopup, etc. where the EndXXX call should only be called if the corresponding
BeginXXX function returned true. Begin and BeginChild are the only odd ones out. Will be fixed in a future update.]
- Note that the bottom of window stack always contains a window called "Debug".
+/
bool Begin(scope const(char)* name, scope bool* p_open, ImGuiWindowFlags flags) @trusted
{
    return igBegin(name, p_open, flags);
}

void End() @trusted
{
    igEnd();
}

/++
Child Windows
- Use child windows to begin into a self-contained independent scrolling/clipping regions within a host window. Child windows can embed their own child.
- Before 1.90 (November 2023), the "ImGuiChildFlags child_flags = 0" parameter was "bool border = false".
This API is backward compatible with old code, as we guarantee that ImGuiChildFlags_Borders == true.
Consider updating your old code:
BeginChild("Name", size, false)   -> Begin("Name", size, 0); or Begin("Name", size, ImGuiChildFlags_None);
BeginChild("Name", size, true)    -> Begin("Name", size, ImGuiChildFlags_Borders);
- Manual sizing (each axis can use a different setting e.g. ImVec2(0.0f, 400.0f)):
== 0.0f: use remaining parent window size for this axis.
> 0.0f: use specified size for this axis.

<
0.0f: right/bottom-align to specified distance from available content boundaries.
- Specifying ImGuiChildFlags_AutoResizeX or ImGuiChildFlags_AutoResizeY makes the sizing automatic based on child contents.
Combining both ImGuiChildFlags_AutoResizeX _and_ ImGuiChildFlags_AutoResizeY defeats purpose of a scrolling region and is NOT recommended.
- BeginChild() returns false to indicate the window is collapsed or fully clipped, so you may early out and omit submitting
anything to the window. Always call a matching EndChild() for each BeginChild() call, regardless of its return value.
[Important: due to legacy reason, Begin/End and BeginChild/EndChild are inconsistent with all other functions
such as BeginMenu/EndMenu, BeginPopup/EndPopup, etc. where the EndXXX call should only be called if the corresponding
BeginXXX function returned true. Begin and BeginChild are the only odd ones out. Will be fixed in a future update.]
+/
bool BeginChild(scope const(char)* str_id, ImVec2 size, ImGuiChildFlags child_flags, ImGuiWindowFlags window_flags) @trusted
{
    return igBeginChild(str_id, size, child_flags, window_flags);
}

bool BeginChildID(ImGuiID id, ImVec2 size, ImGuiChildFlags child_flags, ImGuiWindowFlags window_flags) @trusted
{
    return igBeginChildID(id, size, child_flags, window_flags);
}

void EndChild() @trusted
{
    igEndChild();
}

/++
Windows Utilities
- 'current window' = the window we are appending into while inside a Begin()/End() block. 'next window' = next window we will Begin() into.
+/
bool IsWindowAppearing() @trusted
{
    return igIsWindowAppearing();
}

bool IsWindowCollapsed() @trusted
{
    return igIsWindowCollapsed();
}

bool IsWindowFocused(ImGuiFocusedFlags flags) @trusted
{
    return igIsWindowFocused(flags);
}

bool IsWindowHovered(ImGuiHoveredFlags flags) @trusted
{
    return igIsWindowHovered(flags);
}

ImDrawList* GetWindowDrawList() @trusted
{
    return igGetWindowDrawList();
}

ImVec2 GetWindowPos() @trusted
{
    return igGetWindowPos();
}

ImVec2 GetWindowSize() @trusted
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

/++
Window manipulation
- Prefer using SetNextXXX functions (before Begin) rather that SetXXX functions (after Begin).
+/
void SetNextWindowPos(ImVec2 pos, ImGuiCond cond) @trusted
{
    igSetNextWindowPos(pos, cond);
}

void SetNextWindowPosEx(ImVec2 pos, ImGuiCond cond, ImVec2 pivot) @trusted
{
    igSetNextWindowPosEx(pos, cond, pivot);
}

void SetNextWindowSize(ImVec2 size, ImGuiCond cond) @trusted
{
    igSetNextWindowSize(size, cond);
}

void SetNextWindowSizeConstraints(ImVec2 size_min, ImVec2 size_max, ImGuiSizeCallback custom_callback, scope void* custom_callback_data) @trusted
{
    igSetNextWindowSizeConstraints(size_min, size_max, custom_callback, custom_callback_data);
}

void SetNextWindowContentSize(ImVec2 size) @trusted
{
    igSetNextWindowContentSize(size);
}

void SetNextWindowCollapsed(bool collapsed, ImGuiCond cond) @trusted
{
    igSetNextWindowCollapsed(collapsed, cond);
}

void SetNextWindowFocus() @trusted
{
    igSetNextWindowFocus();
}

void SetNextWindowScroll(ImVec2 scroll) @trusted
{
    igSetNextWindowScroll(scroll);
}

void SetNextWindowBgAlpha(float alpha) @trusted
{
    igSetNextWindowBgAlpha(alpha);
}

void SetWindowPos(ImVec2 pos, ImGuiCond cond) @trusted
{
    igSetWindowPos(pos, cond);
}

void SetWindowSize(ImVec2 size, ImGuiCond cond) @trusted
{
    igSetWindowSize(size, cond);
}

void SetWindowCollapsed(bool collapsed, ImGuiCond cond) @trusted
{
    igSetWindowCollapsed(collapsed, cond);
}

void SetWindowFocus() @trusted
{
    igSetWindowFocus();
}

void SetWindowPosStr(scope const(char)* name, ImVec2 pos, ImGuiCond cond) @trusted
{
    igSetWindowPosStr(name, pos, cond);
}

void SetWindowSizeStr(scope const(char)* name, ImVec2 size, ImGuiCond cond) @trusted
{
    igSetWindowSizeStr(name, size, cond);
}

void SetWindowCollapsedStr(scope const(char)* name, bool collapsed, ImGuiCond cond) @trusted
{
    igSetWindowCollapsedStr(name, collapsed, cond);
}

void SetWindowFocusStr(scope const(char)* name) @trusted
{
    igSetWindowFocusStr(name);
}

/++
Windows Scrolling
- Any change of Scroll will be applied at the beginning of next frame in the first call to Begin().
- You may instead use SetNextWindowScroll() prior to calling Begin() to avoid this delay, as an alternative to using SetScrollX()/SetScrollY().
+/
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

/++
Parameters stacks (font)
- PushFont(font, 0.0f)                       // Change font and keep current size
- PushFont(NULL, 20.0f)                      // Keep font and change current size
- PushFont(font, 20.0f)                      // Change font and set size to 20.0f
- PushFont(font, style.FontSizeBase * 2.0f)  // Change font and set size to be twice bigger than current size.
- PushFont(font, font->LegacySize)           // Change font and set size to size passed to AddFontXXX() function. Same as pre-1.92 behavior.
*IMPORTANT* before 1.92, fonts had a single size. They can now be dynamically be adjusted.
- In 1.92 we have REMOVED the single parameter version of PushFont() because it seems like the easiest way to provide an error-proof transition.
- PushFont(font) before 1.92 = PushFont(font, font->LegacySize) after 1.92          // Use default font size as passed to AddFontXXX() function.
*IMPORTANT* global scale factors are applied over the provided size.
- Global scale factors are: 'style.FontScaleMain', 'style.FontScaleDpi' and maybe more.
-  If you want to apply a factor to the _current_ font size:
- CORRECT:   PushFont(NULL, style.FontSizeBase)         // use current unscaled size    == does nothing
- CORRECT:   PushFont(NULL, style.FontSizeBase * 2.0f)  // use current unscaled size x2 == make text twice bigger
- INCORRECT: PushFont(NULL, GetFontSize())              // INCORRECT! using size after global factors already applied == GLOBAL SCALING FACTORS WILL APPLY TWICE!
- INCORRECT: PushFont(NULL, GetFontSize() * 2.0f)       // INCORRECT! using size after global factors already applied == GLOBAL SCALING FACTORS WILL APPLY TWICE!
+/
void PushFontFloat(scope ImFont* font, float font_size_base_unscaled) @trusted
{
    igPushFontFloat(font, font_size_base_unscaled);
}

void PopFont() @trusted
{
    igPopFont();
}

ImFont* GetFont() @trusted
{
    return igGetFont();
}

float GetFontSize() @trusted
{
    return igGetFontSize();
}

ImFontBaked* GetFontBaked() @trusted
{
    return igGetFontBaked();
}

/++
Parameters stacks (shared)
+/
void PushStyleColor(ImGuiCol idx, ImU32 col) @trusted
{
    igPushStyleColor(idx, col);
}

void PushStyleColorImVec4(ImGuiCol idx, ImVec4 col) @trusted
{
    igPushStyleColorImVec4(idx, col);
}

void PopStyleColor() @trusted
{
    igPopStyleColor();
}

void PopStyleColorEx(int count) @trusted
{
    igPopStyleColorEx(count);
}

void PushStyleVar(ImGuiStyleVar idx, float val) @trusted
{
    igPushStyleVar(idx, val);
}

void PushStyleVarImVec2(ImGuiStyleVar idx, ImVec2 val) @trusted
{
    igPushStyleVarImVec2(idx, val);
}

void PushStyleVarX(ImGuiStyleVar idx, float val_x) @trusted
{
    igPushStyleVarX(idx, val_x);
}

void PushStyleVarY(ImGuiStyleVar idx, float val_y) @trusted
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

void PushItemFlag(ImGuiItemFlags option, bool enabled) @trusted
{
    igPushItemFlag(option, enabled);
}

void PopItemFlag() @trusted
{
    igPopItemFlag();
}

/++
Parameters stacks (current window)
+/
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

/++
Style read access
- Use the ShowStyleEditor() function to interactively see/edit the colors.
+/
ImVec2 GetFontTexUvWhitePixel() @trusted
{
    return igGetFontTexUvWhitePixel();
}

ImU32 GetColorU32(ImGuiCol idx) @trusted
{
    return igGetColorU32(idx);
}

ImU32 GetColorU32Ex(ImGuiCol idx, float alpha_mul) @trusted
{
    return igGetColorU32Ex(idx, alpha_mul);
}

ImU32 GetColorU32ImVec4(ImVec4 col) @trusted
{
    return igGetColorU32ImVec4(col);
}

ImU32 GetColorU32ImU32(ImU32 col) @trusted
{
    return igGetColorU32ImU32(col);
}

ImU32 GetColorU32ImU32Ex(ImU32 col, float alpha_mul) @trusted
{
    return igGetColorU32ImU32Ex(col, alpha_mul);
}

scope const(ImVec4)* GetStyleColorVec4(ImGuiCol idx) @trusted
{
    return igGetStyleColorVec4(idx);
}

/++
Layout cursor positioning
- By "cursor" we mean the current output position.
- The typical widget behavior is to output themselves at the current cursor position, then move the cursor one line down.
- You can call SameLine() between widgets to undo the last carriage return and output at the right of the preceding widget.
- YOU CAN DO 99% OF WHAT YOU NEED WITH ONLY GetCursorScreenPos() and GetContentRegionAvail().
- Attention! We currently have inconsistencies between window-local and absolute positions we will aim to fix with future API:
- Absolute coordinate:        GetCursorScreenPos(), SetCursorScreenPos(), all ImDrawList:: functions. -> this is the preferred way forward.
- Window-local coordinates:   SameLine(offset), GetCursorPos(), SetCursorPos(), GetCursorStartPos(), PushTextWrapPos()
- Window-local coordinates:   GetContentRegionMax(), GetWindowContentRegionMin(), GetWindowContentRegionMax() --> all obsoleted. YOU DON'T NEED THEM.
- GetCursorScreenPos() = GetCursorPos() + GetWindowPos(). GetWindowPos() is almost only ever useful to convert from window-local to absolute coordinates. Try not to use it.
+/
ImVec2 GetCursorScreenPos() @trusted
{
    return igGetCursorScreenPos();
}

void SetCursorScreenPos(ImVec2 pos) @trusted
{
    igSetCursorScreenPos(pos);
}

ImVec2 GetContentRegionAvail() @trusted
{
    return igGetContentRegionAvail();
}

ImVec2 GetCursorPos() @trusted
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

void SetCursorPos(ImVec2 local_pos) @trusted
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

ImVec2 GetCursorStartPos() @trusted
{
    return igGetCursorStartPos();
}

/++
Other layout functions
+/
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

void Dummy(ImVec2 size) @trusted
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

/++
ID stack/scopes
Read the FAQ (docs/FAQ.md or http://dearimgui.com/faq) for more details about how ID are handled in dear imgui.
- Those questions are answered and impacted by understanding of the ID stack system:
- "Q: Why is my widget not reacting when I click on it?"
- "Q: How can I have widgets with an empty label?"
- "Q: How can I have multiple widgets with the same label?"
- Short version: ID are hashes of the entire ID stack. If you are creating widgets in a loop you most likely
want to push a unique identifier (e.g. object pointer, loop index) to uniquely differentiate them.
- You can also use the "Label##foobar" syntax within widget label to distinguish them from each others.
- In this header file we use the "label"/"name" terminology to denote a string that will be displayed + used as an ID,
whereas "str_id" denote a string that is only used as an ID and not normally displayed.
+/
void PushID(scope const(char)* str_id) @trusted
{
    igPushID(str_id);
}

void PushIDStr(scope const(char)* str_id_begin, scope const(char)* str_id_end) @trusted
{
    igPushIDStr(str_id_begin, str_id_end);
}

void PushIDPtr(scope const void* ptr_id) @trusted
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

ImGuiID GetID(scope const(char)* str_id) @trusted
{
    return igGetID(str_id);
}

ImGuiID GetIDStr(scope const(char)* str_id_begin, scope const(char)* str_id_end) @trusted
{
    return igGetIDStr(str_id_begin, str_id_end);
}

ImGuiID GetIDPtr(scope const void* ptr_id) @trusted
{
    return igGetIDPtr(ptr_id);
}

ImGuiID GetIDInt(int int_id) @trusted
{
    return igGetIDInt(int_id);
}

/++
Widgets: Text
+/
void TextUnformatted(scope const(char)* text) @trusted
{
    igTextUnformatted(text);
}

void TextUnformattedEx(scope const(char)* text, scope const(char)* text_end) @trusted
{
    igTextUnformattedEx(text, text_end);
}

alias Text = igText;

alias TextV = igTextV;

alias TextColored = igTextColored;

alias TextColoredV = igTextColoredV;

alias TextDisabled = igTextDisabled;

alias TextDisabledV = igTextDisabledV;

alias TextWrapped = igTextWrapped;

alias TextWrappedV = igTextWrappedV;

void LabelText(scope const(char)* label, scope const(char)* fmt) @trusted
{
    igLabelText(label, fmt);
}

alias LabelTextV = igLabelTextV;

void BulletText(scope const(char)* fmt) @trusted
{
    igBulletText(fmt);
}

alias BulletTextV = igBulletTextV;

void SeparatorText(scope const(char)* label) @trusted
{
    igSeparatorText(label);
}

/++
Widgets: Main
- Most widgets return true when the value has been changed or when pressed/selected
- You may also use one of the many IsItemXXX functions (e.g. IsItemActive, IsItemHovered, etc.) to query widget state.
+/
bool Button(scope const(char)* label) @trusted
{
    return igButton(label);
}

bool ButtonEx(scope const(char)* label, ImVec2 size) @trusted
{
    return igButtonEx(label, size);
}

bool SmallButton(scope const(char)* label) @trusted
{
    return igSmallButton(label);
}

bool InvisibleButton(scope const(char)* str_id, ImVec2 size, ImGuiButtonFlags flags) @trusted
{
    return igInvisibleButton(str_id, size, flags);
}

bool ArrowButton(scope const(char)* str_id, ImGuiDir dir) @trusted
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

void ProgressBar(float fraction, ImVec2 size_arg, scope const(char)* overlay) @trusted
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

bool TextLinkOpenURL(scope const(char)* label) @trusted
{
    return igTextLinkOpenURL(label);
}

bool TextLinkOpenURLEx(scope const(char)* label, scope const(char)* url) @trusted
{
    return igTextLinkOpenURLEx(label, url);
}

/++
Widgets: Images
- Read about ImTextureID/ImTextureRef  here: https://github.com/ocornut/imgui/wiki/Image-Loading-and-Displaying-Examples
- 'uv0' and 'uv1' are texture coordinates. Read about them from the same link above.
- Image() pads adds style.ImageBorderSize on each side, ImageButton() adds style.FramePadding on each side.
- ImageButton() draws a background based on regular Button() color + optionally an inner background if specified.
- An obsolete version of Image(), before 1.91.9 (March 2025), had a 'tint_col' parameter which is now supported by the ImageWithBg() function.
+/
void Image(ImTextureRef tex_ref, ImVec2 image_size) @trusted
{
    igImage(tex_ref, image_size);
}

void ImageEx(ImTextureRef tex_ref, ImVec2 image_size, ImVec2 uv0, ImVec2 uv1) @trusted
{
    igImageEx(tex_ref, image_size, uv0, uv1);
}

void ImageWithBg(ImTextureRef tex_ref, ImVec2 image_size) @trusted
{
    igImageWithBg(tex_ref, image_size);
}

void ImageWithBgEx(ImTextureRef tex_ref, ImVec2 image_size, ImVec2 uv0, ImVec2 uv1, ImVec4 bg_col, ImVec4 tint_col) @trusted
{
    igImageWithBgEx(tex_ref, image_size, uv0, uv1, bg_col, tint_col);
}

bool ImageButton(scope const(char)* str_id, ImTextureRef tex_ref, ImVec2 image_size) @trusted
{
    return igImageButton(str_id, tex_ref, image_size);
}

bool ImageButtonEx(scope const(char)* str_id, ImTextureRef tex_ref, ImVec2 image_size, ImVec2 uv0, ImVec2 uv1, ImVec4 bg_col, ImVec4 tint_col) @trusted
{
    return igImageButtonEx(str_id, tex_ref, image_size, uv0, uv1, bg_col, tint_col);
}

/++
Widgets: Combo Box (Dropdown)
- The BeginCombo()/EndCombo() api allows you to manage your contents and selection state however you want it, by creating e.g. Selectable() items.
- The old Combo() api are helpers over BeginCombo()/EndCombo() which are kept available for convenience purpose. This is analogous to how ListBox are created.
+/
bool BeginCombo(scope const(char)* label, scope const(char)* preview_value, ImGuiComboFlags flags) @trusted
{
    return igBeginCombo(label, preview_value, flags);
}

void EndCombo() @trusted
{
    igEndCombo();
}

bool ComboChar(scope const(char)* label, scope int* current_item, scope const(char)** items, int items_count) @trusted
{
    return igComboChar(label, current_item, items, items_count);
}

bool ComboCharEx(scope const(char)* label, scope int* current_item, scope const(char)** items, int items_count, int popup_max_height_in_items) @trusted
{
    return igComboCharEx(label, current_item, items, items_count, popup_max_height_in_items);
}

bool Combo(scope const(char)* label, scope int* current_item, scope const(char)* items_separated_by_zeros) @trusted
{
    return igCombo(label, current_item, items_separated_by_zeros);
}

bool ComboEx(scope const(char)* label, scope int* current_item, scope const(char)* items_separated_by_zeros, int popup_max_height_in_items) @trusted
{
    return igComboEx(label, current_item, items_separated_by_zeros, popup_max_height_in_items);
}

bool ComboCallback(scope const(char)* label, scope int* current_item, ImGuiGetterCallback getter, scope void* user_data, int items_count) @trusted
{
    return igComboCallback(label, current_item, getter, user_data, items_count);
}

bool ComboCallbackEx(scope const(char)* label, scope int* current_item, ImGuiGetterCallback getter, scope void* user_data, int items_count, int popup_max_height_in_items) @trusted
{
    return igComboCallbackEx(label, current_item, getter, user_data, items_count, popup_max_height_in_items);
}

/++
Widgets: Drag Sliders
- CTRL+Click on any drag box to turn them into an input box. Manually input values aren't clamped by default and can go off-bounds. Use ImGuiSliderFlags_AlwaysClamp to always clamp.
- For all the Float2/Float3/Float4/Int2/Int3/Int4 versions of every function, note that a 'float v[X]' function argument is the same as 'float* v',
the array syntax is just a way to document the number of elements that are expected to be accessible. You can pass address of your first element out of a contiguous set, e.g.
&myvector
.x
- Adjust format string to decorate the value with a prefix, a suffix, or adapt the editing and display precision e.g. "%.3f" -> 1.234; "%5.2f secs" -> 01.23 secs; "Biscuit: %.0f" -> Biscuit: 1; etc.
- Format string may also be set to NULL or use the default format ("%f" or "%d").
- Speed are per-pixel of mouse movement (v_speed=0.2f: mouse needs to move by 5 pixels to increase value by 1). For keyboard/gamepad navigation, minimum speed is Max(v_speed, minimum_step_at_given_precision).
- Use v_min
<
v_max to clamp edits to given limits. Note that CTRL+Click manual input can override those limits if ImGuiSliderFlags_AlwaysClamp is not used.
- Use v_max = FLT_MAX / INT_MAX etc to avoid clamping to a maximum, same with v_min = -FLT_MAX / INT_MIN to avoid clamping to a minimum.
- We use the same sets of flags for DragXXX() and SliderXXX() functions as the features are the same and it makes it easier to swap them.
- Legacy: Pre-1.78 there are DragXXX() function signatures that take a final `float power=1.0f' argument instead of the `ImGuiSliderFlags flags=0' argument.
If you get a warning converting a float to ImGuiSliderFlags, read https://github.com/ocornut/imgui/issues/3361
+/
bool DragFloat(scope const(char)* label, scope float* v) @trusted
{
    return igDragFloat(label, v);
}

bool DragFloatEx(scope const(char)* label, scope float* v, float v_speed, float v_min, float v_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igDragFloatEx(label, v, v_speed, v_min, v_max, format, flags);
}

bool DragFloat2(scope const(char)* label, scope float* v) @trusted
{
    return igDragFloat2(label, v);
}

bool DragFloat2Ex(scope const(char)* label, scope float* v, float v_speed, float v_min, float v_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igDragFloat2Ex(label, v, v_speed, v_min, v_max, format, flags);
}

bool DragFloat3(scope const(char)* label, scope float* v) @trusted
{
    return igDragFloat3(label, v);
}

bool DragFloat3Ex(scope const(char)* label, scope float* v, float v_speed, float v_min, float v_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igDragFloat3Ex(label, v, v_speed, v_min, v_max, format, flags);
}

bool DragFloat4(scope const(char)* label, scope float* v) @trusted
{
    return igDragFloat4(label, v);
}

bool DragFloat4Ex(scope const(char)* label, scope float* v, float v_speed, float v_min, float v_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igDragFloat4Ex(label, v, v_speed, v_min, v_max, format, flags);
}

bool DragFloatRange2(scope const(char)* label, scope float* v_current_min, scope float* v_current_max) @trusted
{
    return igDragFloatRange2(label, v_current_min, v_current_max);
}

bool DragFloatRange2Ex(scope const(char)* label, scope float* v_current_min, scope float* v_current_max, float v_speed, float v_min, float v_max, scope const(char)* format, scope const(char)* format_max, ImGuiSliderFlags flags) @trusted
{
    return igDragFloatRange2Ex(label, v_current_min, v_current_max, v_speed, v_min, v_max, format, format_max, flags);
}

bool DragInt(scope const(char)* label, scope int* v) @trusted
{
    return igDragInt(label, v);
}

bool DragIntEx(scope const(char)* label, scope int* v, float v_speed, int v_min, int v_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igDragIntEx(label, v, v_speed, v_min, v_max, format, flags);
}

bool DragInt2(scope const(char)* label, scope int* v) @trusted
{
    return igDragInt2(label, v);
}

bool DragInt2Ex(scope const(char)* label, scope int* v, float v_speed, int v_min, int v_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igDragInt2Ex(label, v, v_speed, v_min, v_max, format, flags);
}

bool DragInt3(scope const(char)* label, scope int* v) @trusted
{
    return igDragInt3(label, v);
}

bool DragInt3Ex(scope const(char)* label, scope int* v, float v_speed, int v_min, int v_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igDragInt3Ex(label, v, v_speed, v_min, v_max, format, flags);
}

bool DragInt4(scope const(char)* label, scope int* v) @trusted
{
    return igDragInt4(label, v);
}

bool DragInt4Ex(scope const(char)* label, scope int* v, float v_speed, int v_min, int v_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igDragInt4Ex(label, v, v_speed, v_min, v_max, format, flags);
}

bool DragIntRange2(scope const(char)* label, scope int* v_current_min, scope int* v_current_max) @trusted
{
    return igDragIntRange2(label, v_current_min, v_current_max);
}

bool DragIntRange2Ex(scope const(char)* label, scope int* v_current_min, scope int* v_current_max, float v_speed, int v_min, int v_max, scope const(char)* format, scope const(char)* format_max, ImGuiSliderFlags flags) @trusted
{
    return igDragIntRange2Ex(label, v_current_min, v_current_max, v_speed, v_min, v_max, format, format_max, flags);
}

bool DragScalar(scope const(char)* label, ImGuiDataType data_type, scope void* p_data) @trusted
{
    return igDragScalar(label, data_type, p_data);
}

bool DragScalarEx(scope const(char)* label, ImGuiDataType data_type, scope void* p_data, float v_speed, scope const void* p_min, scope const void* p_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igDragScalarEx(label, data_type, p_data, v_speed, p_min, p_max, format, flags);
}

bool DragScalarN(scope const(char)* label, ImGuiDataType data_type, scope void* p_data, int components) @trusted
{
    return igDragScalarN(label, data_type, p_data, components);
}

bool DragScalarNEx(scope const(char)* label, ImGuiDataType data_type, scope void* p_data, int components, float v_speed, scope const void* p_min, scope const void* p_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igDragScalarNEx(label, data_type, p_data, components, v_speed, p_min, p_max, format, flags);
}

/++
Widgets: Regular Sliders
- CTRL+Click on any slider to turn them into an input box. Manually input values aren't clamped by default and can go off-bounds. Use ImGuiSliderFlags_AlwaysClamp to always clamp.
- Adjust format string to decorate the value with a prefix, a suffix, or adapt the editing and display precision e.g. "%.3f" -> 1.234; "%5.2f secs" -> 01.23 secs; "Biscuit: %.0f" -> Biscuit: 1; etc.
- Format string may also be set to NULL or use the default format ("%f" or "%d").
- Legacy: Pre-1.78 there are SliderXXX() function signatures that take a final `float power=1.0f' argument instead of the `ImGuiSliderFlags flags=0' argument.
If you get a warning converting a float to ImGuiSliderFlags, read https://github.com/ocornut/imgui/issues/3361
+/
bool SliderFloat(scope const(char)* label, scope float* v, float v_min, float v_max) @trusted
{
    return igSliderFloat(label, v, v_min, v_max);
}

bool SliderFloatEx(scope const(char)* label, scope float* v, float v_min, float v_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igSliderFloatEx(label, v, v_min, v_max, format, flags);
}

bool SliderFloat2(scope const(char)* label, scope float* v, float v_min, float v_max) @trusted
{
    return igSliderFloat2(label, v, v_min, v_max);
}

bool SliderFloat2Ex(scope const(char)* label, scope float* v, float v_min, float v_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igSliderFloat2Ex(label, v, v_min, v_max, format, flags);
}

bool SliderFloat3(scope const(char)* label, scope float* v, float v_min, float v_max) @trusted
{
    return igSliderFloat3(label, v, v_min, v_max);
}

bool SliderFloat3Ex(scope const(char)* label, scope float* v, float v_min, float v_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igSliderFloat3Ex(label, v, v_min, v_max, format, flags);
}

bool SliderFloat4(scope const(char)* label, scope float* v, float v_min, float v_max) @trusted
{
    return igSliderFloat4(label, v, v_min, v_max);
}

bool SliderFloat4Ex(scope const(char)* label, scope float* v, float v_min, float v_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igSliderFloat4Ex(label, v, v_min, v_max, format, flags);
}

bool SliderAngle(scope const(char)* label, scope float* v_rad) @trusted
{
    return igSliderAngle(label, v_rad);
}

bool SliderAngleEx(scope const(char)* label, scope float* v_rad, float v_degrees_min, float v_degrees_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igSliderAngleEx(label, v_rad, v_degrees_min, v_degrees_max, format, flags);
}

bool SliderInt(scope const(char)* label, scope int* v, int v_min, int v_max) @trusted
{
    return igSliderInt(label, v, v_min, v_max);
}

bool SliderIntEx(scope const(char)* label, scope int* v, int v_min, int v_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igSliderIntEx(label, v, v_min, v_max, format, flags);
}

bool SliderInt2(scope const(char)* label, scope int* v, int v_min, int v_max) @trusted
{
    return igSliderInt2(label, v, v_min, v_max);
}

bool SliderInt2Ex(scope const(char)* label, scope int* v, int v_min, int v_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igSliderInt2Ex(label, v, v_min, v_max, format, flags);
}

bool SliderInt3(scope const(char)* label, scope int* v, int v_min, int v_max) @trusted
{
    return igSliderInt3(label, v, v_min, v_max);
}

bool SliderInt3Ex(scope const(char)* label, scope int* v, int v_min, int v_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igSliderInt3Ex(label, v, v_min, v_max, format, flags);
}

bool SliderInt4(scope const(char)* label, scope int* v, int v_min, int v_max) @trusted
{
    return igSliderInt4(label, v, v_min, v_max);
}

bool SliderInt4Ex(scope const(char)* label, scope int* v, int v_min, int v_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igSliderInt4Ex(label, v, v_min, v_max, format, flags);
}

bool SliderScalar(scope const(char)* label, ImGuiDataType data_type, scope void* p_data, scope const void* p_min, scope const void* p_max) @trusted
{
    return igSliderScalar(label, data_type, p_data, p_min, p_max);
}

bool SliderScalarEx(scope const(char)* label, ImGuiDataType data_type, scope void* p_data, scope const void* p_min, scope const void* p_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igSliderScalarEx(label, data_type, p_data, p_min, p_max, format, flags);
}

bool SliderScalarN(scope const(char)* label, ImGuiDataType data_type, scope void* p_data, int components, scope const void* p_min, scope const void* p_max) @trusted
{
    return igSliderScalarN(label, data_type, p_data, components, p_min, p_max);
}

bool SliderScalarNEx(scope const(char)* label, ImGuiDataType data_type, scope void* p_data, int components, scope const void* p_min, scope const void* p_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igSliderScalarNEx(label, data_type, p_data, components, p_min, p_max, format, flags);
}

bool VSliderFloat(scope const(char)* label, ImVec2 size, scope float* v, float v_min, float v_max) @trusted
{
    return igVSliderFloat(label, size, v, v_min, v_max);
}

bool VSliderFloatEx(scope const(char)* label, ImVec2 size, scope float* v, float v_min, float v_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igVSliderFloatEx(label, size, v, v_min, v_max, format, flags);
}

bool VSliderInt(scope const(char)* label, ImVec2 size, scope int* v, int v_min, int v_max) @trusted
{
    return igVSliderInt(label, size, v, v_min, v_max);
}

bool VSliderIntEx(scope const(char)* label, ImVec2 size, scope int* v, int v_min, int v_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igVSliderIntEx(label, size, v, v_min, v_max, format, flags);
}

bool VSliderScalar(scope const(char)* label, ImVec2 size, ImGuiDataType data_type, scope void* p_data, scope const void* p_min, scope const void* p_max) @trusted
{
    return igVSliderScalar(label, size, data_type, p_data, p_min, p_max);
}

bool VSliderScalarEx(scope const(char)* label, ImVec2 size, ImGuiDataType data_type, scope void* p_data, scope const void* p_min, scope const void* p_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igVSliderScalarEx(label, size, data_type, p_data, p_min, p_max, format, flags);
}

/++
Widgets: Input with Keyboard
- If you want to use InputText() with std::string or any custom dynamic string type, see misc/cpp/imgui_stdlib.h and comments in imgui_demo.cpp.
- Most of the ImGuiInputTextFlags flags are only useful for InputText() and not for InputFloatX, InputIntX, InputDouble etc.
+/
bool InputText(scope const(char)* label, scope char* buf, size_t buf_size, ImGuiInputTextFlags flags) @trusted
{
    return igInputText(label, buf, buf_size, flags);
}

bool InputTextEx(scope const(char)* label, scope char* buf, size_t buf_size, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, scope void* user_data) @trusted
{
    return igInputTextEx(label, buf, buf_size, flags, callback, user_data);
}

bool InputTextMultiline(scope const(char)* label, scope char* buf, size_t buf_size) @trusted
{
    return igInputTextMultiline(label, buf, buf_size);
}

bool InputTextMultilineEx(scope const(char)* label, scope char* buf, size_t buf_size, ImVec2 size, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, scope void* user_data) @trusted
{
    return igInputTextMultilineEx(label, buf, buf_size, size, flags, callback, user_data);
}

bool InputTextWithHint(scope const(char)* label, scope const(char)* hint, scope char* buf, size_t buf_size, ImGuiInputTextFlags flags) @trusted
{
    return igInputTextWithHint(label, hint, buf, buf_size, flags);
}

bool InputTextWithHintEx(scope const(char)* label, scope const(char)* hint, scope char* buf, size_t buf_size, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, scope void* user_data) @trusted
{
    return igInputTextWithHintEx(label, hint, buf, buf_size, flags, callback, user_data);
}

bool InputFloat(scope const(char)* label, scope float* v) @trusted
{
    return igInputFloat(label, v);
}

bool InputFloatEx(scope const(char)* label, scope float* v, float step, float step_fast, scope const(char)* format, ImGuiInputTextFlags flags) @trusted
{
    return igInputFloatEx(label, v, step, step_fast, format, flags);
}

bool InputFloat2(scope const(char)* label, scope float* v) @trusted
{
    return igInputFloat2(label, v);
}

bool InputFloat2Ex(scope const(char)* label, scope float* v, scope const(char)* format, ImGuiInputTextFlags flags) @trusted
{
    return igInputFloat2Ex(label, v, format, flags);
}

bool InputFloat3(scope const(char)* label, scope float* v) @trusted
{
    return igInputFloat3(label, v);
}

bool InputFloat3Ex(scope const(char)* label, scope float* v, scope const(char)* format, ImGuiInputTextFlags flags) @trusted
{
    return igInputFloat3Ex(label, v, format, flags);
}

bool InputFloat4(scope const(char)* label, scope float* v) @trusted
{
    return igInputFloat4(label, v);
}

bool InputFloat4Ex(scope const(char)* label, scope float* v, scope const(char)* format, ImGuiInputTextFlags flags) @trusted
{
    return igInputFloat4Ex(label, v, format, flags);
}

bool InputInt(scope const(char)* label, scope int* v) @trusted
{
    return igInputInt(label, v);
}

bool InputIntEx(scope const(char)* label, scope int* v, int step, int step_fast, ImGuiInputTextFlags flags) @trusted
{
    return igInputIntEx(label, v, step, step_fast, flags);
}

bool InputInt2(scope const(char)* label, scope int* v, ImGuiInputTextFlags flags) @trusted
{
    return igInputInt2(label, v, flags);
}

bool InputInt3(scope const(char)* label, scope int* v, ImGuiInputTextFlags flags) @trusted
{
    return igInputInt3(label, v, flags);
}

bool InputInt4(scope const(char)* label, scope int* v, ImGuiInputTextFlags flags) @trusted
{
    return igInputInt4(label, v, flags);
}

bool InputDouble(scope const(char)* label, scope double* v) @trusted
{
    return igInputDouble(label, v);
}

bool InputDoubleEx(scope const(char)* label, scope double* v, double step, double step_fast, scope const(char)* format, ImGuiInputTextFlags flags) @trusted
{
    return igInputDoubleEx(label, v, step, step_fast, format, flags);
}

bool InputScalar(scope const(char)* label, ImGuiDataType data_type, scope void* p_data) @trusted
{
    return igInputScalar(label, data_type, p_data);
}

bool InputScalarEx(scope const(char)* label, ImGuiDataType data_type, scope void* p_data, scope const void* p_step, scope const void* p_step_fast, scope const(char)* format, ImGuiInputTextFlags flags) @trusted
{
    return igInputScalarEx(label, data_type, p_data, p_step, p_step_fast, format, flags);
}

bool InputScalarN(scope const(char)* label, ImGuiDataType data_type, scope void* p_data, int components) @trusted
{
    return igInputScalarN(label, data_type, p_data, components);
}

bool InputScalarNEx(scope const(char)* label, ImGuiDataType data_type, scope void* p_data, int components, scope const void* p_step, scope const void* p_step_fast, scope const(char)* format, ImGuiInputTextFlags flags) @trusted
{
    return igInputScalarNEx(label, data_type, p_data, components, p_step, p_step_fast, format, flags);
}

/++
Widgets: Color Editor/Picker (tip: the ColorEdit* functions have a little color square that can be left-clicked to open a picker, and right-clicked to open an option menu.)
- Note that in C++ a 'float v[X]' function argument is the _same_ as 'float* v', the array syntax is just a way to document the number of elements that are expected to be accessible.
- You can pass the address of a first float element out of a contiguous structure, e.g.
&myvector
.x
+/
bool ColorEdit3(scope const(char)* label, scope float* col, ImGuiColorEditFlags flags) @trusted
{
    return igColorEdit3(label, col, flags);
}

bool ColorEdit4(scope const(char)* label, scope float* col, ImGuiColorEditFlags flags) @trusted
{
    return igColorEdit4(label, col, flags);
}

bool ColorPicker3(scope const(char)* label, scope float* col, ImGuiColorEditFlags flags) @trusted
{
    return igColorPicker3(label, col, flags);
}

bool ColorPicker4(scope const(char)* label, scope float* col, ImGuiColorEditFlags flags, scope const float* ref_col) @trusted
{
    return igColorPicker4(label, col, flags, ref_col);
}

bool ColorButton(scope const(char)* desc_id, ImVec4 col, ImGuiColorEditFlags flags) @trusted
{
    return igColorButton(desc_id, col, flags);
}

bool ColorButtonEx(scope const(char)* desc_id, ImVec4 col, ImGuiColorEditFlags flags, ImVec2 size) @trusted
{
    return igColorButtonEx(desc_id, col, flags, size);
}

void SetColorEditOptions(ImGuiColorEditFlags flags) @trusted
{
    igSetColorEditOptions(flags);
}

/++
Widgets: Trees
- TreeNode functions return true when the node is open, in which case you need to also call TreePop() when you are finished displaying the tree node contents.
+/
bool TreeNode(scope const(char)* label) @trusted
{
    return igTreeNode(label);
}

bool TreeNodeStr(scope const(char)* str_id, scope const(char)* fmt) @trusted
{
    return igTreeNodeStr(str_id, fmt);
}

bool TreeNodePtr(scope const void* ptr_id, scope const(char)* fmt) @trusted
{
    return igTreeNodePtr(ptr_id, fmt);
}

alias TreeNodeV = igTreeNodeV;

alias TreeNodeVPtr = igTreeNodeVPtr;

bool TreeNodeEx(scope const(char)* label, ImGuiTreeNodeFlags flags) @trusted
{
    return igTreeNodeEx(label, flags);
}

bool TreeNodeExStr(scope const(char)* str_id, ImGuiTreeNodeFlags flags, scope const(char)* fmt) @trusted
{
    return igTreeNodeExStr(str_id, flags, fmt);
}

bool TreeNodeExPtr(scope const void* ptr_id, ImGuiTreeNodeFlags flags, scope const(char)* fmt) @trusted
{
    return igTreeNodeExPtr(ptr_id, flags, fmt);
}

alias TreeNodeExV = igTreeNodeExV;

alias TreeNodeExVPtr = igTreeNodeExVPtr;

void TreePush(scope const(char)* str_id) @trusted
{
    igTreePush(str_id);
}

void TreePushPtr(scope const void* ptr_id) @trusted
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

bool CollapsingHeader(scope const(char)* label, ImGuiTreeNodeFlags flags) @trusted
{
    return igCollapsingHeader(label, flags);
}

bool CollapsingHeaderBoolPtr(scope const(char)* label, scope bool* p_visible, ImGuiTreeNodeFlags flags) @trusted
{
    return igCollapsingHeaderBoolPtr(label, p_visible, flags);
}

void SetNextItemOpen(bool is_open, ImGuiCond cond) @trusted
{
    igSetNextItemOpen(is_open, cond);
}

void SetNextItemStorageID(ImGuiID storage_id) @trusted
{
    igSetNextItemStorageID(storage_id);
}

/++
Widgets: Selectables
- A selectable highlights when hovered, and can display another color when selected.
- Neighbors selectable extend their highlight bounds in order to leave no gap between them. This is so a series of selected Selectable appear contiguous.
+/
bool Selectable(scope const(char)* label) @trusted
{
    return igSelectable(label);
}

bool SelectableEx(scope const(char)* label, bool selected, ImGuiSelectableFlags flags, ImVec2 size) @trusted
{
    return igSelectableEx(label, selected, flags, size);
}

bool SelectableBoolPtr(scope const(char)* label, scope bool* p_selected, ImGuiSelectableFlags flags) @trusted
{
    return igSelectableBoolPtr(label, p_selected, flags);
}

bool SelectableBoolPtrEx(scope const(char)* label, scope bool* p_selected, ImGuiSelectableFlags flags, ImVec2 size) @trusted
{
    return igSelectableBoolPtrEx(label, p_selected, flags, size);
}

/++
Multi-selection system for Selectable(), Checkbox(), TreeNode() functions [BETA]
- This enables standard multi-selection/range-selection idioms (CTRL+Mouse/Keyboard, SHIFT+Mouse/Keyboard, etc.) in a way that also allow a clipper to be used.
- ImGuiSelectionUserData is often used to store your item index within the current view (but may store something else).
- Read comments near ImGuiMultiSelectIO for instructions/details and see 'Demo->Widgets->Selection State
&
Multi-Select' for demo.
- TreeNode() is technically supported but... using this correctly is more complicated. You need some sort of linear/random access to your tree,
which is suited to advanced trees setups already implementing filters and clipper. We will work simplifying the current demo.
- 'selection_size' and 'items_count' parameters are optional and used by a few features. If they are costly for you to compute, you may avoid them.
+/
ImGuiMultiSelectIO* BeginMultiSelect(ImGuiMultiSelectFlags flags) @trusted
{
    return igBeginMultiSelect(flags);
}

ImGuiMultiSelectIO* BeginMultiSelectEx(ImGuiMultiSelectFlags flags, int selection_size, int items_count) @trusted
{
    return igBeginMultiSelectEx(flags, selection_size, items_count);
}

ImGuiMultiSelectIO* EndMultiSelect() @trusted
{
    return igEndMultiSelect();
}

void SetNextItemSelectionUserData(ImGuiSelectionUserData selection_user_data) @trusted
{
    igSetNextItemSelectionUserData(selection_user_data);
}

bool IsItemToggledSelection() @trusted
{
    return igIsItemToggledSelection();
}

/++
Widgets: List Boxes
- This is essentially a thin wrapper to using BeginChild/EndChild with the ImGuiChildFlags_FrameStyle flag for stylistic changes + displaying a label.
- If you don't need a label you can probably simply use BeginChild() with the ImGuiChildFlags_FrameStyle flag for the same result.
- You can submit contents and manage your selection state however you want it, by creating e.g. Selectable() or any other items.
- The simplified/old ListBox() api are helpers over BeginListBox()/EndListBox() which are kept available for convenience purpose. This is analogous to how Combos are created.
- Choose frame width:   size.x > 0.0f: custom  /  size.x
<
0.0f or -FLT_MIN: right-align   /  size.x = 0.0f (default): use current ItemWidth
- Choose frame height:  size.y > 0.0f: custom  /  size.y
<
0.0f or -FLT_MIN: bottom-align  /  size.y = 0.0f (default): arbitrary default height which can fit ~7 items
+/
bool BeginListBox(scope const(char)* label, ImVec2 size) @trusted
{
    return igBeginListBox(label, size);
}

void EndListBox() @trusted
{
    igEndListBox();
}

bool ListBox(scope const(char)* label, scope int* current_item, scope const(char)** items, int items_count, int height_in_items) @trusted
{
    return igListBox(label, current_item, items, items_count, height_in_items);
}

bool ListBoxCallback(scope const(char)* label, scope int* current_item, ImGuiGetterCallback getter, scope void* user_data, int items_count) @trusted
{
    return igListBoxCallback(label, current_item, getter, user_data, items_count);
}

bool ListBoxCallbackEx(scope const(char)* label, scope int* current_item, ImGuiGetterCallback getter, scope void* user_data, int items_count, int height_in_items) @trusted
{
    return igListBoxCallbackEx(label, current_item, getter, user_data, items_count, height_in_items);
}

/++
Widgets: Data Plotting
- Consider using ImPlot (https://github.com/epezent/implot) which is much better!
+/
void PlotLines(scope const(char)* label, scope const float* values, int values_count) @trusted
{
    igPlotLines(label, values, values_count);
}

void PlotLinesEx(scope const(char)* label, scope const float* values, int values_count, int values_offset, scope const(char)* overlay_text, float scale_min, float scale_max, ImVec2 graph_size, int stride) @trusted
{
    igPlotLinesEx(label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size, stride);
}

void PlotLinesCallback(scope const(char)* label, ImGuiValues_getterCallback values_getter, scope void* data, int values_count) @trusted
{
    igPlotLinesCallback(label, values_getter, data, values_count);
}

void PlotLinesCallbackEx(scope const(char)* label, ImGuiValues_getterCallback values_getter, scope void* data, int values_count, int values_offset, scope const(char)* overlay_text, float scale_min, float scale_max, ImVec2 graph_size) @trusted
{
    igPlotLinesCallbackEx(label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size);
}

void PlotHistogram(scope const(char)* label, scope const float* values, int values_count) @trusted
{
    igPlotHistogram(label, values, values_count);
}

void PlotHistogramEx(scope const(char)* label, scope const float* values, int values_count, int values_offset, scope const(char)* overlay_text, float scale_min, float scale_max, ImVec2 graph_size, int stride) @trusted
{
    igPlotHistogramEx(label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size, stride);
}

void PlotHistogramCallback(scope const(char)* label, ImGuiValues_getterCallback values_getter, scope void* data, int values_count) @trusted
{
    igPlotHistogramCallback(label, values_getter, data, values_count);
}

void PlotHistogramCallbackEx(scope const(char)* label, ImGuiValues_getterCallback values_getter, scope void* data, int values_count, int values_offset, scope const(char)* overlay_text, float scale_min, float scale_max, ImVec2 graph_size) @trusted
{
    igPlotHistogramCallbackEx(label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size);
}

/++
Widgets: Menus
- Use BeginMenuBar() on a window ImGuiWindowFlags_MenuBar to append to its menu bar.
- Use BeginMainMenuBar() to create a menu bar at the top of the screen and append to it.
- Use BeginMenu() to create a menu. You can call BeginMenu() multiple time with the same identifier to append more items to it.
- Not that MenuItem() keyboardshortcuts are displayed as a convenience but _not processed_ by Dear ImGui at the moment.
+/
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

/++
Tooltips
- Tooltips are windows following the mouse. They do not take focus away.
- A tooltip window can contain items of any types.
- SetTooltip() is more or less a shortcut for the 'if (BeginTooltip()) { Text(...); EndTooltip(); }' idiom (with a subtlety that it discard any previously submitted tooltip)
+/
bool BeginTooltip() @trusted
{
    return igBeginTooltip();
}

void EndTooltip() @trusted
{
    igEndTooltip();
}

void SetTooltip(scope const(char)* fmt) @trusted
{
    igSetTooltip(fmt);
}

alias SetTooltipV = igSetTooltipV;

/++
Tooltips: helpers for showing a tooltip when hovering an item
- BeginItemTooltip() is a shortcut for the 'if (IsItemHovered(ImGuiHoveredFlags_ForTooltip)
&
&
BeginTooltip())' idiom.
- SetItemTooltip() is a shortcut for the 'if (IsItemHovered(ImGuiHoveredFlags_ForTooltip)) { SetTooltip(...); }' idiom.
- Where 'ImGuiHoveredFlags_ForTooltip' itself is a shortcut to use 'style.HoverFlagsForTooltipMouse' or 'style.HoverFlagsForTooltipNav' depending on active input type. For mouse it defaults to 'ImGuiHoveredFlags_Stationary | ImGuiHoveredFlags_DelayShort'.
+/
bool BeginItemTooltip() @trusted
{
    return igBeginItemTooltip();
}

void SetItemTooltip(scope const(char)* fmt) @trusted
{
    igSetItemTooltip(fmt);
}

alias SetItemTooltipV = igSetItemTooltipV;

/++
Popups, Modals
- They block normal mouse hovering detection (and therefore most mouse interactions) behind them.
- If not modal: they can be closed by clicking anywhere outside them, or by pressing ESCAPE.
- Their visibility state (~bool) is held internally instead of being held by the programmer as we are used to with regular Begin*() calls.
- The 3 properties above are related: we need to retain popup visibility state in the library because popups may be closed as any time.
- You can bypass the hovering restriction by using ImGuiHoveredFlags_AllowWhenBlockedByPopup when calling IsItemHovered() or IsWindowHovered().
- IMPORTANT: Popup identifiers are relative to the current ID stack, so OpenPopup and BeginPopup generally needs to be at the same level of the stack.
This is sometimes leading to confusing mistakes. May rework this in the future.
- BeginPopup(): query popup state, if open start appending into the window. Call EndPopup() afterwards if returned true. ImGuiWindowFlags are forwarded to the window.
- BeginPopupModal(): block every interaction behind the window, cannot be closed by user, add a dimming background, has a title bar.
+/
bool BeginPopup(scope const(char)* str_id, ImGuiWindowFlags flags) @trusted
{
    return igBeginPopup(str_id, flags);
}

bool BeginPopupModal(scope const(char)* name, scope bool* p_open, ImGuiWindowFlags flags) @trusted
{
    return igBeginPopupModal(name, p_open, flags);
}

void EndPopup() @trusted
{
    igEndPopup();
}

/++
Popups: open/close functions
- OpenPopup(): set popup state to open. ImGuiPopupFlags are available for opening options.
- If not modal: they can be closed by clicking anywhere outside them, or by pressing ESCAPE.
- CloseCurrentPopup(): use inside the BeginPopup()/EndPopup() scope to close manually.
- CloseCurrentPopup() is called by default by Selectable()/MenuItem() when activated (FIXME: need some options).
- Use ImGuiPopupFlags_NoOpenOverExistingPopup to avoid opening a popup if there's already one at the same level. This is equivalent to e.g. testing for !IsAnyPopupOpen() prior to OpenPopup().
- Use IsWindowAppearing() after BeginPopup() to tell if a window just opened.
- IMPORTANT: Notice that for OpenPopupOnItemClick() we exceptionally default flags to 1 (== ImGuiPopupFlags_MouseButtonRight) for backward compatibility with older API taking 'int mouse_button = 1' parameter
+/
void OpenPopup(scope const(char)* str_id, ImGuiPopupFlags popup_flags) @trusted
{
    igOpenPopup(str_id, popup_flags);
}

void OpenPopupID(ImGuiID id, ImGuiPopupFlags popup_flags) @trusted
{
    igOpenPopupID(id, popup_flags);
}

void OpenPopupOnItemClick(scope const(char)* str_id, ImGuiPopupFlags popup_flags) @trusted
{
    igOpenPopupOnItemClick(str_id, popup_flags);
}

void CloseCurrentPopup() @trusted
{
    igCloseCurrentPopup();
}

/++
Popups: open+begin combined functions helpers
- Helpers to do OpenPopup+BeginPopup where the Open action is triggered by e.g. hovering an item and right-clicking.
- They are convenient to easily create context menus, hence the name.
- IMPORTANT: Notice that BeginPopupContextXXX takes ImGuiPopupFlags just like OpenPopup() and unlike BeginPopup(). For full consistency, we may add ImGuiWindowFlags to the BeginPopupContextXXX functions in the future.
- IMPORTANT: Notice that we exceptionally default their flags to 1 (== ImGuiPopupFlags_MouseButtonRight) for backward compatibility with older API taking 'int mouse_button = 1' parameter, so if you add other flags remember to re-add the ImGuiPopupFlags_MouseButtonRight.
+/
bool BeginPopupContextItem() @trusted
{
    return igBeginPopupContextItem();
}

bool BeginPopupContextItemEx(scope const(char)* str_id, ImGuiPopupFlags popup_flags) @trusted
{
    return igBeginPopupContextItemEx(str_id, popup_flags);
}

bool BeginPopupContextWindow() @trusted
{
    return igBeginPopupContextWindow();
}

bool BeginPopupContextWindowEx(scope const(char)* str_id, ImGuiPopupFlags popup_flags) @trusted
{
    return igBeginPopupContextWindowEx(str_id, popup_flags);
}

bool BeginPopupContextVoid() @trusted
{
    return igBeginPopupContextVoid();
}

bool BeginPopupContextVoidEx(scope const(char)* str_id, ImGuiPopupFlags popup_flags) @trusted
{
    return igBeginPopupContextVoidEx(str_id, popup_flags);
}

/++
Popups: query functions
- IsPopupOpen(): return true if the popup is open at the current BeginPopup() level of the popup stack.
- IsPopupOpen() with ImGuiPopupFlags_AnyPopupId: return true if any popup is open at the current BeginPopup() level of the popup stack.
- IsPopupOpen() with ImGuiPopupFlags_AnyPopupId + ImGuiPopupFlags_AnyPopupLevel: return true if any popup is open.
+/
bool IsPopupOpen(scope const(char)* str_id, ImGuiPopupFlags flags) @trusted
{
    return igIsPopupOpen(str_id, flags);
}

/++
Tables
- Full-featured replacement for old Columns API.
- See Demo->Tables for demo code. See top of imgui_tables.cpp for general commentary.
- See ImGuiTableFlags_ and ImGuiTableColumnFlags_ enums for a description of available flags.
The typical call flow is:
- 1. Call BeginTable(), early out if returning false.
- 2. Optionally call TableSetupColumn() to submit column name/flags/defaults.
- 3. Optionally call TableSetupScrollFreeze() to request scroll freezing of columns/rows.
- 4. Optionally call TableHeadersRow() to submit a header row. Names are pulled from TableSetupColumn() data.
- 5. Populate contents:
- In most situations you can use TableNextRow() + TableSetColumnIndex(N) to start appending into a column.
- If you are using tables as a sort of grid, where every column is holding the same type of contents,
you may prefer using TableNextColumn() instead of TableNextRow() + TableSetColumnIndex().
TableNextColumn() will automatically wrap-around into the next row if needed.
- IMPORTANT: Comparatively to the old Columns() API, we need to call TableNextColumn() for the first column!
- Summary of possible call flow:
- TableNextRow() -> TableSetColumnIndex(0) -> Text("Hello 0") -> TableSetColumnIndex(1) -> Text("Hello 1")  // OK
- TableNextRow() -> TableNextColumn()      -> Text("Hello 0") -> TableNextColumn()      -> Text("Hello 1")  // OK
-                   TableNextColumn()      -> Text("Hello 0") -> TableNextColumn()      -> Text("Hello 1")  // OK: TableNextColumn() automatically gets to next row!
- TableNextRow()                           -> Text("Hello 0")                                               // Not OK! Missing TableSetColumnIndex() or TableNextColumn()! Text will not appear!
- 5. Call EndTable()
+/
bool BeginTable(scope const(char)* str_id, int columns, ImGuiTableFlags flags) @trusted
{
    return igBeginTable(str_id, columns, flags);
}

bool BeginTableEx(scope const(char)* str_id, int columns, ImGuiTableFlags flags, ImVec2 outer_size, float inner_width) @trusted
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

void TableNextRowEx(ImGuiTableRowFlags row_flags, float min_row_height) @trusted
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

/++
Tables: Headers
&
Columns declaration
- Use TableSetupColumn() to specify label, resizing policy, default width/weight, id, various other flags etc.
- Use TableHeadersRow() to create a header row and automatically submit a TableHeader() for each column.
Headers are required to perform: reordering, sorting, and opening the context menu.
The context menu can also be made available in columns body using ImGuiTableFlags_ContextMenuInBody.
- You may manually submit headers using TableNextRow() + TableHeader() calls, but this is only useful in
some advanced use cases (e.g. adding custom widgets in header row).
- Use TableSetupScrollFreeze() to lock columns/rows so they stay visible when scrolled.
+/
void TableSetupColumn(scope const(char)* label, ImGuiTableColumnFlags flags) @trusted
{
    igTableSetupColumn(label, flags);
}

void TableSetupColumnEx(scope const(char)* label, ImGuiTableColumnFlags flags, float init_width_or_weight, ImGuiID user_id) @trusted
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

/++
Tables: Sorting
&
Miscellaneous functions
- Sorting: call TableGetSortSpecs() to retrieve latest sort specs for the table. NULL when not sorting.
When 'sort_specs->SpecsDirty == true' you should sort your data. It will be true when sorting specs have
changed since last call, or the first time. Make sure to set 'SpecsDirty = false' after sorting,
else you may wastefully sort your data every frame!
- Functions args 'int column_n' treat the default value of -1 as the same as passing the current column index.
+/
ImGuiTableSortSpecs* TableGetSortSpecs() @trusted
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

const(char)* TableGetColumnName(int column_n) @trusted
{
    return igTableGetColumnName(column_n);
}

ImGuiTableColumnFlags TableGetColumnFlags(int column_n) @trusted
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

void TableSetBgColor(ImGuiTableBgTarget target, ImU32 color, int column_n) @trusted
{
    igTableSetBgColor(target, color, column_n);
}

/++
Legacy Columns API (prefer using Tables!)
- You can also use SameLine(pos_x) to mimic simplified columns.
+/
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

/++
Tab Bars, Tabs
- Note: Tabs are automatically created by the docking system (when in 'docking' branch). Use this to create tab bars/tabs yourself.
+/
bool BeginTabBar(scope const(char)* str_id, ImGuiTabBarFlags flags) @trusted
{
    return igBeginTabBar(str_id, flags);
}

void EndTabBar() @trusted
{
    igEndTabBar();
}

bool BeginTabItem(scope const(char)* label, scope bool* p_open, ImGuiTabItemFlags flags) @trusted
{
    return igBeginTabItem(label, p_open, flags);
}

void EndTabItem() @trusted
{
    igEndTabItem();
}

bool TabItemButton(scope const(char)* label, ImGuiTabItemFlags flags) @trusted
{
    return igTabItemButton(label, flags);
}

void SetTabItemClosed(scope const(char)* tab_or_docked_window_label) @trusted
{
    igSetTabItemClosed(tab_or_docked_window_label);
}

/++
Logging/Capture
- All text output from the interface can be captured into tty/file/clipboard. By default, tree nodes are automatically opened during logging.
+/
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

void LogText(scope const(char)* fmt) @trusted
{
    igLogText(fmt);
}

alias LogTextV = igLogTextV;

/++
Drag and Drop
- On source items, call BeginDragDropSource(), if it returns true also call SetDragDropPayload() + EndDragDropSource().
- On target candidates, call BeginDragDropTarget(), if it returns true also call AcceptDragDropPayload() + EndDragDropTarget().
- If you stop calling BeginDragDropSource() the payload is preserved however it won't have a preview tooltip (we currently display a fallback "..." tooltip, see #1725)
- An item can be both drag source and drop target.
+/
bool BeginDragDropSource(ImGuiDragDropFlags flags) @trusted
{
    return igBeginDragDropSource(flags);
}

bool SetDragDropPayload(scope const(char)* type, scope const void* data, size_t sz, ImGuiCond cond) @trusted
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

scope const(ImGuiPayload)* AcceptDragDropPayload(const(char)* type, ImGuiDragDropFlags flags) @trusted
{
    return igAcceptDragDropPayload(type, flags);
}

void EndDragDropTarget() @trusted
{
    igEndDragDropTarget();
}

scope const(ImGuiPayload)* GetDragDropPayload() @trusted
{
    return igGetDragDropPayload();
}

/++
Disabling [BETA API]
- Disable all user interactions and dim items visuals (applying style.DisabledAlpha over current colors)
- Those can be nested but it cannot be used to enable an already disabled section (a single BeginDisabled(true) in the stack is enough to keep everything disabled)
- Tooltips windows by exception are opted out of disabling.
- BeginDisabled(false)/EndDisabled() essentially does nothing but is provided to facilitate use of boolean expressions (as a micro-optimization: if you have tens of thousands of BeginDisabled(false)/EndDisabled() pairs, you might want to reformulate your code to avoid making those calls)
+/
void BeginDisabled(bool disabled) @trusted
{
    igBeginDisabled(disabled);
}

void EndDisabled() @trusted
{
    igEndDisabled();
}

/++
Clipping
- Mouse hovering is affected by ImGui::PushClipRect() calls, unlike direct calls to ImDrawList::PushClipRect() which are render only.
+/
void PushClipRect(ImVec2 clip_rect_min, ImVec2 clip_rect_max, bool intersect_with_current_clip_rect) @trusted
{
    igPushClipRect(clip_rect_min, clip_rect_max, intersect_with_current_clip_rect);
}

void PopClipRect() @trusted
{
    igPopClipRect();
}

/++
Focus, Activation
+/
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

/++
Keyboard/Gamepad Navigation
+/
void SetNavCursorVisible(bool visible) @trusted
{
    igSetNavCursorVisible(visible);
}

/++
Overlapping mode
+/
void SetNextItemAllowOverlap() @trusted
{
    igSetNextItemAllowOverlap();
}

/++
Item/Widgets Utilities and Query Functions
- Most of the functions are referring to the previous Item that has been submitted.
- See Demo Window under "Widgets->Querying Status" for an interactive visualization of most of those functions.
+/
bool IsItemHovered(ImGuiHoveredFlags flags) @trusted
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

bool IsItemClickedEx(ImGuiMouseButton mouse_button) @trusted
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

ImGuiID GetItemID() @trusted
{
    return igGetItemID();
}

ImVec2 GetItemRectMin() @trusted
{
    return igGetItemRectMin();
}

ImVec2 GetItemRectMax() @trusted
{
    return igGetItemRectMax();
}

ImVec2 GetItemRectSize() @trusted
{
    return igGetItemRectSize();
}

/++
Viewports
- Currently represents the Platform Window created by the application which is hosting our Dear ImGui windows.
- In 'docking' branch with multi-viewport enabled, we extend this concept to have multiple active viewports.
- In the future we will extend this concept further to also represent Platform Monitor and support a "no main platform window" operation mode.
+/
ImGuiViewport* GetMainViewport() @trusted
{
    return igGetMainViewport();
}

/++
Background/Foreground Draw Lists
+/
ImDrawList* GetBackgroundDrawList() @trusted
{
    return igGetBackgroundDrawList();
}

ImDrawList* GetForegroundDrawList() @trusted
{
    return igGetForegroundDrawList();
}

/++
Miscellaneous Utilities
+/
bool IsRectVisibleBySize(ImVec2 size) @trusted
{
    return igIsRectVisibleBySize(size);
}

bool IsRectVisible(ImVec2 rect_min, ImVec2 rect_max) @trusted
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

ImDrawListSharedData* GetDrawListSharedData() @trusted
{
    return igGetDrawListSharedData();
}

const(char)* GetStyleColorName(ImGuiCol idx) @trusted
{
    return igGetStyleColorName(idx);
}

void SetStateStorage(scope ImGuiStorage* storage) @trusted
{
    igSetStateStorage(storage);
}

ImGuiStorage* GetStateStorage() @trusted
{
    return igGetStateStorage();
}

/++
Text Utilities
+/
ImVec2 CalcTextSize(scope const(char)* text) @trusted
{
    return igCalcTextSize(text);
}

ImVec2 CalcTextSizeEx(scope const(char)* text, scope const(char)* text_end, bool hide_text_after_double_hash, float wrap_width) @trusted
{
    return igCalcTextSizeEx(text, text_end, hide_text_after_double_hash, wrap_width);
}

/++
Color Utilities
+/
ImVec4 ColorConvertU32ToFloat4(ImU32 in_) @trusted
{
    return igColorConvertU32ToFloat4(in_);
}

ImU32 ColorConvertFloat4ToU32(ImVec4 in_) @trusted
{
    return igColorConvertFloat4ToU32(in_);
}

alias ColorConvertRGBtoHSV = igColorConvertRGBtoHSV;

void ColorConvertHSVtoRGB(float h, float s, float v, scope float* out_r, scope float* out_g, scope float* out_b) @trusted
{
    igColorConvertHSVtoRGB(h, s, v, out_r, out_g, out_b);
}

/++
Inputs Utilities: Keyboard/Mouse/Gamepad
- the ImGuiKey enum contains all possible keyboard, mouse and gamepad inputs (e.g. ImGuiKey_A, ImGuiKey_MouseLeft, ImGuiKey_GamepadDpadUp...).
- (legacy: before v1.87, we used ImGuiKey to carry native/user indices as defined by each backends. This was obsoleted in 1.87 (2022-02) and completely removed in 1.91.5 (2024-11). See https://github.com/ocornut/imgui/issues/4921)
- (legacy: any use of ImGuiKey will assert when key
<
512 to detect passing legacy native/user indices)
+/
bool IsKeyDown(ImGuiKey key) @trusted
{
    return igIsKeyDown(key);
}

bool IsKeyPressed(ImGuiKey key) @trusted
{
    return igIsKeyPressed(key);
}

bool IsKeyPressedEx(ImGuiKey key, bool repeat) @trusted
{
    return igIsKeyPressedEx(key, repeat);
}

bool IsKeyReleased(ImGuiKey key) @trusted
{
    return igIsKeyReleased(key);
}

bool IsKeyChordPressed(ImGuiKeyChord key_chord) @trusted
{
    return igIsKeyChordPressed(key_chord);
}

int GetKeyPressedAmount(ImGuiKey key, float repeat_delay, float rate) @trusted
{
    return igGetKeyPressedAmount(key, repeat_delay, rate);
}

const(char)* GetKeyName(ImGuiKey key) @trusted
{
    return igGetKeyName(key);
}

void SetNextFrameWantCaptureKeyboard(bool want_capture_keyboard) @trusted
{
    igSetNextFrameWantCaptureKeyboard(want_capture_keyboard);
}

/++
Inputs Utilities: Shortcut Testing
&
Routing [BETA]
- ImGuiKeyChord = a ImGuiKey + optional ImGuiMod_Alt/ImGuiMod_Ctrl/ImGuiMod_Shift/ImGuiMod_Super.
ImGuiKey_C                          // Accepted by functions taking ImGuiKey or ImGuiKeyChord arguments)
ImGuiMod_Ctrl | ImGuiKey_C          // Accepted by functions taking ImGuiKeyChord arguments)
only ImGuiMod_XXX values are legal to combine with an ImGuiKey. You CANNOT combine two ImGuiKey values.
- The general idea is that several callers may register interest in a shortcut, and only one owner gets it.
Parent   -> call Shortcut(Ctrl+S)    // When Parent is focused, Parent gets the shortcut.
Child1 -> call Shortcut(Ctrl+S)    // When Child1 is focused, Child1 gets the shortcut (Child1 overrides Parent shortcuts)
Child2 -> no call                  // When Child2 is focused, Parent gets the shortcut.
The whole system is order independent, so if Child1 makes its calls before Parent, results will be identical.
This is an important property as it facilitate working with foreign code or larger codebase.
- To understand the difference:
- IsKeyChordPressed() compares mods and call IsKeyPressed() -> function has no side-effect.
- Shortcut() submits a route, routes are resolved, if it currently can be routed it calls IsKeyChordPressed() -> function has (desirable) side-effects as it can prevents another call from getting the route.
- Visualize registered routes in 'Metrics/Debugger->Inputs'.
+/
bool Shortcut(ImGuiKeyChord key_chord, ImGuiInputFlags flags) @trusted
{
    return igShortcut(key_chord, flags);
}

void SetNextItemShortcut(ImGuiKeyChord key_chord, ImGuiInputFlags flags) @trusted
{
    igSetNextItemShortcut(key_chord, flags);
}

/++
Inputs Utilities: Key/Input Ownership [BETA]
- One common use case would be to allow your items to disable standard inputs behaviors such
as Tab or Alt key handling, Mouse Wheel scrolling, etc.
e.g. Button(...); SetItemKeyOwner(ImGuiKey_MouseWheelY); to make hovering/activating a button disable wheel for scrolling.
- Reminder ImGuiKey enum include access to mouse buttons and gamepad, so key ownership can apply to them.
- Many related features are still in imgui_internal.h. For instance, most IsKeyXXX()/IsMouseXXX() functions have an owner-id-aware version.
+/
void SetItemKeyOwner(ImGuiKey key) @trusted
{
    igSetItemKeyOwner(key);
}

/++
Inputs Utilities: Mouse
- To refer to a mouse button, you may use named enums in your code e.g. ImGuiMouseButton_Left, ImGuiMouseButton_Right.
- You can also use regular integer: it is forever guaranteed that 0=Left, 1=Right, 2=Middle.
- Dragging operations are only reported after mouse has moved a certain distance away from the initial clicking position (see 'lock_threshold' and 'io.MouseDraggingThreshold')
+/
bool IsMouseDown(ImGuiMouseButton button) @trusted
{
    return igIsMouseDown(button);
}

bool IsMouseClicked(ImGuiMouseButton button) @trusted
{
    return igIsMouseClicked(button);
}

bool IsMouseClickedEx(ImGuiMouseButton button, bool repeat) @trusted
{
    return igIsMouseClickedEx(button, repeat);
}

bool IsMouseReleased(ImGuiMouseButton button) @trusted
{
    return igIsMouseReleased(button);
}

bool IsMouseDoubleClicked(ImGuiMouseButton button) @trusted
{
    return igIsMouseDoubleClicked(button);
}

bool IsMouseReleasedWithDelay(ImGuiMouseButton button, float delay) @trusted
{
    return igIsMouseReleasedWithDelay(button, delay);
}

int GetMouseClickedCount(ImGuiMouseButton button) @trusted
{
    return igGetMouseClickedCount(button);
}

bool IsMouseHoveringRect(ImVec2 r_min, ImVec2 r_max) @trusted
{
    return igIsMouseHoveringRect(r_min, r_max);
}

bool IsMouseHoveringRectEx(ImVec2 r_min, ImVec2 r_max, bool clip) @trusted
{
    return igIsMouseHoveringRectEx(r_min, r_max, clip);
}

bool IsMousePosValid(scope ImVec2* mouse_pos) @trusted
{
    return igIsMousePosValid(mouse_pos);
}

bool IsAnyMouseDown() @trusted
{
    return igIsAnyMouseDown();
}

ImVec2 GetMousePos() @trusted
{
    return igGetMousePos();
}

ImVec2 GetMousePosOnOpeningCurrentPopup() @trusted
{
    return igGetMousePosOnOpeningCurrentPopup();
}

bool IsMouseDragging(ImGuiMouseButton button, float lock_threshold) @trusted
{
    return igIsMouseDragging(button, lock_threshold);
}

ImVec2 GetMouseDragDelta(ImGuiMouseButton button, float lock_threshold) @trusted
{
    return igGetMouseDragDelta(button, lock_threshold);
}

void ResetMouseDragDelta() @trusted
{
    igResetMouseDragDelta();
}

void ResetMouseDragDeltaEx(ImGuiMouseButton button) @trusted
{
    igResetMouseDragDeltaEx(button);
}

ImGuiMouseCursor GetMouseCursor() @trusted
{
    return igGetMouseCursor();
}

void SetMouseCursor(ImGuiMouseCursor cursor_type) @trusted
{
    igSetMouseCursor(cursor_type);
}

void SetNextFrameWantCaptureMouse(bool want_capture_mouse) @trusted
{
    igSetNextFrameWantCaptureMouse(want_capture_mouse);
}

/++
Clipboard Utilities
- Also see the LogToClipboard() function to capture GUI into clipboard, or easily output text data to the clipboard.
+/
const(char)* GetClipboardText() @trusted
{
    return igGetClipboardText();
}

void SetClipboardText(scope const(char)* text) @trusted
{
    igSetClipboardText(text);
}

/++
Settings/.Ini Utilities
- The disk functions are automatically called if io.IniFilename != NULL (default is "imgui.ini").
- Set io.IniFilename to NULL to load/save manually. Read io.WantSaveIniSettings description about handling .ini saving manually.
- Important: default value "imgui.ini" is relative to current working dir! Most apps will want to lock this to an absolute path (e.g. same path as executables).
+/
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

const(char)* SaveIniSettingsToMemory(size_t* out_ini_size) @trusted
{
    return igSaveIniSettingsToMemory(out_ini_size);
}

/++
Debug Utilities
- Your main debugging friend is the ShowMetricsWindow() function, which is also accessible from Demo->Tools->Metrics Debugger
+/
void DebugTextEncoding(scope const(char)* text) @trusted
{
    igDebugTextEncoding(text);
}

void DebugFlashStyleColor(ImGuiCol idx) @trusted
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

void DebugLog(scope const(char)* fmt) @trusted
{
    igDebugLog(fmt);
}

alias DebugLogV = igDebugLogV;

/++
Memory Allocators
- Those functions are not reliant on the current context.
- DLL users: heaps and globals are not shared across DLL boundaries! You will need to call SetCurrentContext() + SetAllocatorFunctions()
for each static/DLL boundary you are calling from. Read "Context and Memory Allocators" section of imgui.cpp for more details.
+/
void SetAllocatorFunctions(ImGuiMemAllocFunc alloc_func, ImGuiMemFreeFunc free_func, scope void* user_data) @trusted
{
    igSetAllocatorFunctions(alloc_func, free_func, user_data);
}

void GetAllocatorFunctions(scope ImGuiMemAllocFunc* p_alloc_func, scope ImGuiMemFreeFunc* p_free_func, scope void** p_user_data) @trusted
{
    igGetAllocatorFunctions(p_alloc_func, p_free_func, p_user_data);
}

void* MemAlloc(size_t size) @trusted
{
    return igMemAlloc(size);
}

void MemFree(scope void* ptr) @trusted
{
    igMemFree(ptr);
}

/++
OBSOLETED in 1.92.0 (from June 2025)
+/
void PushFont(scope ImFont* font) @trusted
{
    igPushFont(font);
}

void SetWindowFontScale(float scale) @trusted
{
    igSetWindowFontScale(scale);
}

/++
OBSOLETED in 1.91.9 (from February 2025)
+/
void ImageImVec4(ImTextureRef tex_ref, ImVec2 image_size, ImVec2 uv0, ImVec2 uv1, ImVec4 tint_col, ImVec4 border_col) @trusted
{
    igImageImVec4(tex_ref, image_size, uv0, uv1, tint_col, border_col);
}

/++
OBSOLETED in 1.91.0 (from July 2024)
+/
void PushButtonRepeat(bool repeat) @trusted
{
    igPushButtonRepeat(repeat);
}

void PopButtonRepeat() @trusted
{
    igPopButtonRepeat();
}

void PushTabStop(bool tab_stop) @trusted
{
    igPushTabStop(tab_stop);
}

void PopTabStop() @trusted
{
    igPopTabStop();
}

ImVec2 GetContentRegionMax() @trusted
{
    return igGetContentRegionMax();
}

ImVec2 GetWindowContentRegionMin() @trusted
{
    return igGetWindowContentRegionMin();
}

ImVec2 GetWindowContentRegionMax() @trusted
{
    return igGetWindowContentRegionMax();
}

/++
OBSOLETED in 1.90.0 (from September 2023)
+/
bool BeginChildFrame(ImGuiID id, ImVec2 size) @trusted
{
    return igBeginChildFrame(id, size);
}

bool BeginChildFrameEx(ImGuiID id, ImVec2 size, ImGuiWindowFlags window_flags) @trusted
{
    return igBeginChildFrameEx(id, size, window_flags);
}

void EndChildFrame() @trusted
{
    igEndChildFrame();
}

/++
static inline bool BeginChild(const char* str_id, const ImVec2
&
size_arg, bool borders, ImGuiWindowFlags window_flags){ return BeginChild(str_id, size_arg, borders ? ImGuiChildFlags_Borders : ImGuiChildFlags_None, window_flags); } // Unnecessary as true == ImGuiChildFlags_Borders
static inline bool BeginChild(ImGuiID id, const ImVec2
&
size_arg, bool borders, ImGuiWindowFlags window_flags)        { return BeginChild(id, size_arg, borders ? ImGuiChildFlags_Borders : ImGuiChildFlags_None, window_flags);     } // Unnecessary as true == ImGuiChildFlags_Borders
+/
void ShowStackToolWindow(scope bool* p_open) @trusted
{
    igShowStackToolWindow(p_open);
}

bool ComboObsolete(scope const(char)* label, scope int* current_item, ImGuiOld_callbackCallback old_callback, scope void* user_data, int items_count) @trusted
{
    return igComboObsolete(label, current_item, old_callback, user_data, items_count);
}

bool ComboObsoleteEx(scope const(char)* label, scope int* current_item, ImGuiOld_callbackCallback old_callback, scope void* user_data, int items_count, int popup_max_height_in_items) @trusted
{
    return igComboObsoleteEx(label, current_item, old_callback, user_data, items_count, popup_max_height_in_items);
}

bool ListBoxObsolete(scope const(char)* label, scope int* current_item, ImGuiOld_callbackCallback old_callback, scope void* user_data, int items_count) @trusted
{
    return igListBoxObsolete(label, current_item, old_callback, user_data, items_count);
}

bool ListBoxObsoleteEx(scope const(char)* label, scope int* current_item, ImGuiOld_callbackCallback old_callback, scope void* user_data, int items_count, int height_in_items) @trusted
{
    return igListBoxObsoleteEx(label, current_item, old_callback, user_data, items_count, height_in_items);
}

/++
OBSOLETED in 1.89.7 (from June 2023)
+/
void SetItemAllowOverlap() @trusted
{
    igSetItemAllowOverlap();
}
