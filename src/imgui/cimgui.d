// Generated on 2025-09-13
/++
+ D wrapper for cimgui (Dear ImGui).
+ Provides bindings for Dear ImGui immediate mode GUI library.
+
+ Features:
+   Full ImGui API coverage
+   @trusted wrapper functions
+   Preserves ImGui naming conventions
+   Handles memory management
+/
module imgui.cimgui;
public import imgui.c.dcimgui;

pure @nogc nothrow:

// Callback function types
extern(C) alias ImGuiGet_item_name_funcCallback = const(char)* function(void*, int);
extern(C) alias ImGuiGetterCallback = const(char)* function(void*, int);
extern(C) alias ImGuiOld_callbackCallback = bool function(void*, int, const(char)**);
extern(C) alias ImGuiValues_getterCallback = float function(void*, int);
extern(C) alias ImGui__funcCallback = void function(int, void*);

// D-friendly wrappers
/++
+ Context creation and access
+  Each context create its own ImFontAtlas by default. You may instance one yourself and pass it to CreateContext() to share a font atlas between contexts.
+  DLL users: heaps and globals are not shared across DLL boundaries! You will need to call SetCurrentContext() + SetAllocatorFunctions()
+ for each static/DLL boundary you are calling from. Read "Context and Memory Allocators" section of imgui.cpp for details.
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
+ Main
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
+ Demo, Debug, Information
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

bool ShowStyleSelector(const(char)* label) @trusted
{
    return igShowStyleSelector(label);
}

void ShowFontSelector(const(char)* label) @trusted
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
+ Styles
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
+ Windows
+  Begin() = push window to the stack and start appending to it. End() = pop window from the stack.
+  Passing 'bool* p_open != NULL' shows a windowclosing widget in the upperright corner of the window,
+ which clicking will set the boolean to false when clicked.
+  You may append multiple times to the same window during the same frame by calling Begin()/End() pairs multiple times.
+ Some information such as 'flags' or 'p_open' will only be considered by the first call to Begin().
+  Begin() return false to indicate the window is collapsed or fully clipped, so you may early out and omit submitting
+ anything to the window. Always call a matching End() for each Begin() call, regardless of its return value!
+ [Important: due to legacy reason, Begin/End and BeginChild/EndChild are inconsistent with all other functions
+ such as BeginMenu/EndMenu, BeginPopup/EndPopup, etc. where the EndXXX call should only be called if the corresponding
+ BeginXXX function returned true. Begin and BeginChild are the only odd ones out. Will be fixed in a future update.]
+  Note that the bottom of window stack always contains a window called "Debug".
+/
bool Begin(const(char)* name, scope bool* p_open, ImGuiWindowFlags flags) @trusted
{
    return igBegin(name, p_open, flags);
}

void End() @trusted
{
    igEnd();
}

/++
+ Child Windows
+  Use child windows to begin into a selfcontained independent scrolling/clipping regions within a host window. Child windows can embed their own child.
+  Before 1.90 (November 2023), the "ImGuiChildFlags child_flags = 0" parameter was "bool border = false".
+ This API is backward compatible with old code, as we guarantee that ImGuiChildFlags_Borders == true.
+ Consider updating your old code:
+ BeginChild("Name", size, false)   > Begin("Name", size, 0); or Begin("Name", size, ImGuiChildFlags_None);
+ BeginChild("Name", size, true)    > Begin("Name", size, ImGuiChildFlags_Borders);
+  Manual sizing (each axis can use a different setting e.g. ImVec2(0.0f, 400.0f)):
+ == 0.0f: use remaining parent window size for this axis.
+ > 0.0f: use specified size for this axis.
+
+ <
+ 0.0f: right/bottomalign to specified distance from available content boundaries.
+  Specifying ImGuiChildFlags_AutoResizeX or ImGuiChildFlags_AutoResizeY makes the sizing automatic based on child contents.
+ Combining both ImGuiChildFlags_AutoResizeX _and_ ImGuiChildFlags_AutoResizeY defeats purpose of a scrolling region and is NOT recommended.
+  BeginChild() returns false to indicate the window is collapsed or fully clipped, so you may early out and omit submitting
+ anything to the window. Always call a matching EndChild() for each BeginChild() call, regardless of its return value.
+ [Important: due to legacy reason, Begin/End and BeginChild/EndChild are inconsistent with all other functions
+ such as BeginMenu/EndMenu, BeginPopup/EndPopup, etc. where the EndXXX call should only be called if the corresponding
+ BeginXXX function returned true. Begin and BeginChild are the only odd ones out. Will be fixed in a future update.]
+/
bool BeginChild(const(char)* str_id, ImVec2 size, ImGuiChildFlags child_flags, ImGuiWindowFlags window_flags) @trusted
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
+ Windows Utilities
+  'current window' = the window we are appending into while inside a Begin()/End() block. 'next window' = next window we will Begin() into.
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
+ Window manipulation
+  Prefer using SetNextXXX functions (before Begin) rather that SetXXX functions (after Begin).
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

void SetWindowPosStr(const(char)* name, ImVec2 pos, ImGuiCond cond) @trusted
{
    igSetWindowPosStr(name, pos, cond);
}

void SetWindowSizeStr(const(char)* name, ImVec2 size, ImGuiCond cond) @trusted
{
    igSetWindowSizeStr(name, size, cond);
}

void SetWindowCollapsedStr(const(char)* name, bool collapsed, ImGuiCond cond) @trusted
{
    igSetWindowCollapsedStr(name, collapsed, cond);
}

void SetWindowFocusStr(const(char)* name) @trusted
{
    igSetWindowFocusStr(name);
}

/++
+ Windows Scrolling
+  Any change of Scroll will be applied at the beginning of next frame in the first call to Begin().
+  You may instead use SetNextWindowScroll() prior to calling Begin() to avoid this delay, as an alternative to using SetScrollX()/SetScrollY().
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
+ Parameters stacks (font)
+  PushFont(font, 0.0f)                       // Change font and keep current size
+  PushFont(NULL, 20.0f)                      // Keep font and change current size
+  PushFont(font, 20.0f)                      // Change font and set size to 20.0f
+  PushFont(font, style.FontSizeBase * 2.0f)  // Change font and set size to be twice bigger than current size.
+  PushFont(font, font>LegacySize)           // Change font and set size to size passed to AddFontXXX() function. Same as pre1.92 behavior.
+ *IMPORTANT* before 1.92, fonts had a single size. They can now be dynamically be adjusted.
+  In 1.92 we have REMOVED the single parameter version of PushFont() because it seems like the easiest way to provide an errorproof transition.
+  PushFont(font) before 1.92 = PushFont(font, font>LegacySize) after 1.92          // Use default font size as passed to AddFontXXX() function.
+ *IMPORTANT* global scale factors are applied over the provided size.
+  Global scale factors are: 'style.FontScaleMain', 'style.FontScaleDpi' and maybe more.
+   If you want to apply a factor to the _current_ font size:
+  CORRECT:   PushFont(NULL, style.FontSizeBase)         // use current unscaled size    == does nothing
+  CORRECT:   PushFont(NULL, style.FontSizeBase * 2.0f)  // use current unscaled size x2 == make text twice bigger
+  INCORRECT: PushFont(NULL, GetFontSize())              // INCORRECT! using size after global factors already applied == GLOBAL SCALING FACTORS WILL APPLY TWICE!
+  INCORRECT: PushFont(NULL, GetFontSize() * 2.0f)       // INCORRECT! using size after global factors already applied == GLOBAL SCALING FACTORS WILL APPLY TWICE!
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
+ Parameters stacks (shared)
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
+ Parameters stacks (current window)
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
+ Style read access
+  Use the ShowStyleEditor() function to interactively see/edit the colors.
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

const(ImVec4)* GetStyleColorVec4(ImGuiCol idx) @trusted
{
    return igGetStyleColorVec4(idx);
}

/++
+ Layout cursor positioning
+  By "cursor" we mean the current output position.
+  The typical widget behavior is to output themselves at the current cursor position, then move the cursor one line down.
+  You can call SameLine() between widgets to undo the last carriage return and output at the right of the preceding widget.
+  YOU CAN DO 99% OF WHAT YOU NEED WITH ONLY GetCursorScreenPos() and GetContentRegionAvail().
+  Attention! We currently have inconsistencies between windowlocal and absolute positions we will aim to fix with future API:
+  Absolute coordinate:        GetCursorScreenPos(), SetCursorScreenPos(), all ImDrawList:: functions. > this is the preferred way forward.
+  Windowlocal coordinates:   SameLine(offset), GetCursorPos(), SetCursorPos(), GetCursorStartPos(), PushTextWrapPos()
+  Windowlocal coordinates:   GetContentRegionMax(), GetWindowContentRegionMin(), GetWindowContentRegionMax() > all obsoleted. YOU DON'T NEED THEM.
+  GetCursorScreenPos() = GetCursorPos() + GetWindowPos(). GetWindowPos() is almost only ever useful to convert from windowlocal to absolute coordinates. Try not to use it.
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
+ Other layout functions
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
+ ID stack/scopes
+ Read the FAQ (docs/FAQ.md or http://dearimgui.com/faq) for more details about how ID are handled in dear imgui.
+  Those questions are answered and impacted by understanding of the ID stack system:
+  "Q: Why is my widget not reacting when I click on it?"
+  "Q: How can I have widgets with an empty label?"
+  "Q: How can I have multiple widgets with the same label?"
+  Short version: ID are hashes of the entire ID stack. If you are creating widgets in a loop you most likely
+ want to push a unique identifier (e.g. object pointer, loop index) to uniquely differentiate them.
+  You can also use the "Label##foobar" syntax within widget label to distinguish them from each others.
+  In this header file we use the "label"/"name" terminology to denote a string that will be displayed + used as an ID,
+ whereas "str_id" denote a string that is only used as an ID and not normally displayed.
+/
void PushID(const(char)* str_id) @trusted
{
    igPushID(str_id);
}

void PushIDStr(const(char)* str_id_begin, const(char)* str_id_end) @trusted
{
    igPushIDStr(str_id_begin, str_id_end);
}

void PushIDPtr(scope const(void)* ptr_id) @trusted
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

ImGuiID GetID(const(char)* str_id) @trusted
{
    return igGetID(str_id);
}

ImGuiID GetIDStr(const(char)* str_id_begin, const(char)* str_id_end) @trusted
{
    return igGetIDStr(str_id_begin, str_id_end);
}

ImGuiID GetIDPtr(scope const(void)* ptr_id) @trusted
{
    return igGetIDPtr(ptr_id);
}

ImGuiID GetIDInt(int int_id) @trusted
{
    return igGetIDInt(int_id);
}

/++
+ Widgets: Text
+/
void TextUnformatted(const(char)* text) @trusted
{
    igTextUnformatted(text);
}

void TextUnformattedEx(const(char)* text, const(char)* text_end) @trusted
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

void LabelText(const(char)* label, const(char)* fmt) @trusted
{
    igLabelText(label, fmt);
}

alias LabelTextV = igLabelTextV;

void BulletText(const(char)* fmt) @trusted
{
    igBulletText(fmt);
}

alias BulletTextV = igBulletTextV;

void SeparatorText(const(char)* label) @trusted
{
    igSeparatorText(label);
}

/++
+ Widgets: Main
+  Most widgets return true when the value has been changed or when pressed/selected
+  You may also use one of the many IsItemXXX functions (e.g. IsItemActive, IsItemHovered, etc.) to query widget state.
+/
bool Button(const(char)* label) @trusted
{
    return igButton(label);
}

bool ButtonEx(const(char)* label, ImVec2 size) @trusted
{
    return igButtonEx(label, size);
}

bool SmallButton(const(char)* label) @trusted
{
    return igSmallButton(label);
}

bool InvisibleButton(const(char)* str_id, ImVec2 size, ImGuiButtonFlags flags) @trusted
{
    return igInvisibleButton(str_id, size, flags);
}

bool ArrowButton(const(char)* str_id, ImGuiDir dir) @trusted
{
    return igArrowButton(str_id, dir);
}

bool Checkbox(const(char)* label, scope bool* v) @trusted
{
    return igCheckbox(label, v);
}

bool CheckboxFlagsIntPtr(const(char)* label, scope int* flags, int flags_value) @trusted
{
    return igCheckboxFlagsIntPtr(label, flags, flags_value);
}

bool CheckboxFlagsUintPtr(const(char)* label, scope uint* flags, uint flags_value) @trusted
{
    return igCheckboxFlagsUintPtr(label, flags, flags_value);
}

bool RadioButton(const(char)* label, bool active) @trusted
{
    return igRadioButton(label, active);
}

bool RadioButtonIntPtr(const(char)* label, scope int* v, int v_button) @trusted
{
    return igRadioButtonIntPtr(label, v, v_button);
}

void ProgressBar(float fraction, ImVec2 size_arg, const(char)* overlay) @trusted
{
    igProgressBar(fraction, size_arg, overlay);
}

void Bullet() @trusted
{
    igBullet();
}

bool TextLink(const(char)* label) @trusted
{
    return igTextLink(label);
}

bool TextLinkOpenURL(const(char)* label) @trusted
{
    return igTextLinkOpenURL(label);
}

bool TextLinkOpenURLEx(const(char)* label, const(char)* url) @trusted
{
    return igTextLinkOpenURLEx(label, url);
}

/++
+ Widgets: Images
+  Read about ImTextureID/ImTextureRef  here: https://github.com/ocornut/imgui/wiki/ImageLoadingandDisplayingExamples
+  'uv0' and 'uv1' are texture coordinates. Read about them from the same link above.
+  Image() pads adds style.ImageBorderSize on each side, ImageButton() adds style.FramePadding on each side.
+  ImageButton() draws a background based on regular Button() color + optionally an inner background if specified.
+  An obsolete version of Image(), before 1.91.9 (March 2025), had a 'tint_col' parameter which is now supported by the ImageWithBg() function.
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

bool ImageButton(const(char)* str_id, ImTextureRef tex_ref, ImVec2 image_size) @trusted
{
    return igImageButton(str_id, tex_ref, image_size);
}

bool ImageButtonEx(const(char)* str_id, ImTextureRef tex_ref, ImVec2 image_size, ImVec2 uv0, ImVec2 uv1, ImVec4 bg_col, ImVec4 tint_col) @trusted
{
    return igImageButtonEx(str_id, tex_ref, image_size, uv0, uv1, bg_col, tint_col);
}

/++
+ Widgets: Combo Box (Dropdown)
+  The BeginCombo()/EndCombo() api allows you to manage your contents and selection state however you want it, by creating e.g. Selectable() items.
+  The old Combo() api are helpers over BeginCombo()/EndCombo() which are kept available for convenience purpose. This is analogous to how ListBox are created.
+/
bool BeginCombo(const(char)* label, const(char)* preview_value, ImGuiComboFlags flags) @trusted
{
    return igBeginCombo(label, preview_value, flags);
}

void EndCombo() @trusted
{
    igEndCombo();
}

bool ComboChar(const(char)* label, scope int* current_item, const(char)** items, int items_count) @trusted
{
    return igComboChar(label, current_item, items, items_count);
}

bool ComboCharEx(const(char)* label, scope int* current_item, const(char)** items, int items_count, int popup_max_height_in_items) @trusted
{
    return igComboCharEx(label, current_item, items, items_count, popup_max_height_in_items);
}

bool Combo(const(char)* label, scope int* current_item, const(char)* items_separated_by_zeros) @trusted
{
    return igCombo(label, current_item, items_separated_by_zeros);
}

bool ComboEx(const(char)* label, scope int* current_item, const(char)* items_separated_by_zeros, int popup_max_height_in_items) @trusted
{
    return igComboEx(label, current_item, items_separated_by_zeros, popup_max_height_in_items);
}

bool ComboCallback(const(char)* label, scope int* current_item, ImGuiGetterCallback getter, scope void* user_data, int items_count) @trusted
{
    return igComboCallback(label, current_item, getter, user_data, items_count);
}

bool ComboCallbackEx(const(char)* label, scope int* current_item, ImGuiGetterCallback getter, scope void* user_data, int items_count, int popup_max_height_in_items) @trusted
{
    return igComboCallbackEx(label, current_item, getter, user_data, items_count, popup_max_height_in_items);
}

/++
+ Widgets: Drag Sliders
+  CTRL+Click on any drag box to turn them into an input box. Manually input values aren't clamped by default and can go offbounds. Use ImGuiSliderFlags_AlwaysClamp to always clamp.
+  For all the Float2/Float3/Float4/Int2/Int3/Int4 versions of every function, note that a 'float v[X]' function argument is the same as 'float* v',
+ the array syntax is just a way to document the number of elements that are expected to be accessible. You can pass address of your first element out of a contiguous set, e.g.
+ &myvector
+ .x
+  Adjust format string to decorate the value with a prefix, a suffix, or adapt the editing and display precision e.g. "%.3f" > 1.234; "%5.2f secs" > 01.23 secs; "Biscuit: %.0f" > Biscuit: 1; etc.
+  Format string may also be set to NULL or use the default format ("%f" or "%d").
+  Speed are perpixel of mouse movement (v_speed=0.2f: mouse needs to move by 5 pixels to increase value by 1). For keyboard/gamepad navigation, minimum speed is Max(v_speed, minimum_step_at_given_precision).
+  Use v_min
+ <
+ v_max to clamp edits to given limits. Note that CTRL+Click manual input can override those limits if ImGuiSliderFlags_AlwaysClamp is not used.
+  Use v_max = FLT_MAX / INT_MAX etc to avoid clamping to a maximum, same with v_min = FLT_MAX / INT_MIN to avoid clamping to a minimum.
+  We use the same sets of flags for DragXXX() and SliderXXX() functions as the features are the same and it makes it easier to swap them.
+  Legacy: Pre1.78 there are DragXXX() function signatures that take a final `float power=1.0f' argument instead of the `ImGuiSliderFlags flags=0' argument.
+ If you get a warning converting a float to ImGuiSliderFlags, read https://github.com/ocornut/imgui/issues/3361
+/
bool DragFloat(const(char)* label, scope float* v) @trusted
{
    return igDragFloat(label, v);
}

bool DragFloatEx(const(char)* label, scope float* v, float v_speed, float v_min, float v_max, const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igDragFloatEx(label, v, v_speed, v_min, v_max, format, flags);
}

bool DragFloat2(const(char)* label, scope float* v) @trusted
{
    return igDragFloat2(label, v);
}

bool DragFloat2Ex(const(char)* label, scope float* v, float v_speed, float v_min, float v_max, const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igDragFloat2Ex(label, v, v_speed, v_min, v_max, format, flags);
}

bool DragFloat3(const(char)* label, scope float* v) @trusted
{
    return igDragFloat3(label, v);
}

bool DragFloat3Ex(const(char)* label, scope float* v, float v_speed, float v_min, float v_max, const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igDragFloat3Ex(label, v, v_speed, v_min, v_max, format, flags);
}

bool DragFloat4(const(char)* label, scope float* v) @trusted
{
    return igDragFloat4(label, v);
}

bool DragFloat4Ex(const(char)* label, scope float* v, float v_speed, float v_min, float v_max, const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igDragFloat4Ex(label, v, v_speed, v_min, v_max, format, flags);
}

bool DragFloatRange2(const(char)* label, scope float* v_current_min, scope float* v_current_max) @trusted
{
    return igDragFloatRange2(label, v_current_min, v_current_max);
}

bool DragFloatRange2Ex(const(char)* label, scope float* v_current_min, scope float* v_current_max, float v_speed, float v_min, float v_max, const(char)* format, const(char)* format_max, ImGuiSliderFlags flags) @trusted
{
    return igDragFloatRange2Ex(label, v_current_min, v_current_max, v_speed, v_min, v_max, format, format_max, flags);
}

bool DragInt(const(char)* label, scope int* v) @trusted
{
    return igDragInt(label, v);
}

bool DragIntEx(const(char)* label, scope int* v, float v_speed, int v_min, int v_max, const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igDragIntEx(label, v, v_speed, v_min, v_max, format, flags);
}

bool DragInt2(const(char)* label, scope int* v) @trusted
{
    return igDragInt2(label, v);
}

bool DragInt2Ex(const(char)* label, scope int* v, float v_speed, int v_min, int v_max, const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igDragInt2Ex(label, v, v_speed, v_min, v_max, format, flags);
}

bool DragInt3(const(char)* label, scope int* v) @trusted
{
    return igDragInt3(label, v);
}

bool DragInt3Ex(const(char)* label, scope int* v, float v_speed, int v_min, int v_max, const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igDragInt3Ex(label, v, v_speed, v_min, v_max, format, flags);
}

bool DragInt4(const(char)* label, scope int* v) @trusted
{
    return igDragInt4(label, v);
}

bool DragInt4Ex(const(char)* label, scope int* v, float v_speed, int v_min, int v_max, const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igDragInt4Ex(label, v, v_speed, v_min, v_max, format, flags);
}

bool DragIntRange2(const(char)* label, scope int* v_current_min, scope int* v_current_max) @trusted
{
    return igDragIntRange2(label, v_current_min, v_current_max);
}

bool DragIntRange2Ex(const(char)* label, scope int* v_current_min, scope int* v_current_max, float v_speed, int v_min, int v_max, const(char)* format, const(char)* format_max, ImGuiSliderFlags flags) @trusted
{
    return igDragIntRange2Ex(label, v_current_min, v_current_max, v_speed, v_min, v_max, format, format_max, flags);
}

bool DragScalar(const(char)* label, ImGuiDataType data_type, scope void* p_data) @trusted
{
    return igDragScalar(label, data_type, p_data);
}

bool DragScalarEx(const(char)* label, ImGuiDataType data_type, scope void* p_data, float v_speed, scope const(void)* p_min, scope const(void)* p_max, const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igDragScalarEx(label, data_type, p_data, v_speed, p_min, p_max, format, flags);
}

bool DragScalarN(const(char)* label, ImGuiDataType data_type, scope void* p_data, int components) @trusted
{
    return igDragScalarN(label, data_type, p_data, components);
}

bool DragScalarNEx(const(char)* label, ImGuiDataType data_type, scope void* p_data, int components, float v_speed, scope const(void)* p_min, scope const(void)* p_max, const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igDragScalarNEx(label, data_type, p_data, components, v_speed, p_min, p_max, format, flags);
}

/++
+ Widgets: Regular Sliders
+  CTRL+Click on any slider to turn them into an input box. Manually input values aren't clamped by default and can go offbounds. Use ImGuiSliderFlags_AlwaysClamp to always clamp.
+  Adjust format string to decorate the value with a prefix, a suffix, or adapt the editing and display precision e.g. "%.3f" > 1.234; "%5.2f secs" > 01.23 secs; "Biscuit: %.0f" > Biscuit: 1; etc.
+  Format string may also be set to NULL or use the default format ("%f" or "%d").
+  Legacy: Pre1.78 there are SliderXXX() function signatures that take a final `float power=1.0f' argument instead of the `ImGuiSliderFlags flags=0' argument.
+ If you get a warning converting a float to ImGuiSliderFlags, read https://github.com/ocornut/imgui/issues/3361
+/
bool SliderFloat(const(char)* label, scope float* v, float v_min, float v_max) @trusted
{
    return igSliderFloat(label, v, v_min, v_max);
}

bool SliderFloatEx(const(char)* label, scope float* v, float v_min, float v_max, const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igSliderFloatEx(label, v, v_min, v_max, format, flags);
}

bool SliderFloat2(const(char)* label, scope float* v, float v_min, float v_max) @trusted
{
    return igSliderFloat2(label, v, v_min, v_max);
}

bool SliderFloat2Ex(const(char)* label, scope float* v, float v_min, float v_max, const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igSliderFloat2Ex(label, v, v_min, v_max, format, flags);
}

bool SliderFloat3(const(char)* label, scope float* v, float v_min, float v_max) @trusted
{
    return igSliderFloat3(label, v, v_min, v_max);
}

bool SliderFloat3Ex(const(char)* label, scope float* v, float v_min, float v_max, const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igSliderFloat3Ex(label, v, v_min, v_max, format, flags);
}

bool SliderFloat4(const(char)* label, scope float* v, float v_min, float v_max) @trusted
{
    return igSliderFloat4(label, v, v_min, v_max);
}

bool SliderFloat4Ex(const(char)* label, scope float* v, float v_min, float v_max, const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igSliderFloat4Ex(label, v, v_min, v_max, format, flags);
}

bool SliderAngle(const(char)* label, scope float* v_rad) @trusted
{
    return igSliderAngle(label, v_rad);
}

bool SliderAngleEx(const(char)* label, scope float* v_rad, float v_degrees_min, float v_degrees_max, const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igSliderAngleEx(label, v_rad, v_degrees_min, v_degrees_max, format, flags);
}

bool SliderInt(const(char)* label, scope int* v, int v_min, int v_max) @trusted
{
    return igSliderInt(label, v, v_min, v_max);
}

bool SliderIntEx(const(char)* label, scope int* v, int v_min, int v_max, const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igSliderIntEx(label, v, v_min, v_max, format, flags);
}

bool SliderInt2(const(char)* label, scope int* v, int v_min, int v_max) @trusted
{
    return igSliderInt2(label, v, v_min, v_max);
}

bool SliderInt2Ex(const(char)* label, scope int* v, int v_min, int v_max, const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igSliderInt2Ex(label, v, v_min, v_max, format, flags);
}

bool SliderInt3(const(char)* label, scope int* v, int v_min, int v_max) @trusted
{
    return igSliderInt3(label, v, v_min, v_max);
}

bool SliderInt3Ex(const(char)* label, scope int* v, int v_min, int v_max, const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igSliderInt3Ex(label, v, v_min, v_max, format, flags);
}

bool SliderInt4(const(char)* label, scope int* v, int v_min, int v_max) @trusted
{
    return igSliderInt4(label, v, v_min, v_max);
}

bool SliderInt4Ex(const(char)* label, scope int* v, int v_min, int v_max, const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igSliderInt4Ex(label, v, v_min, v_max, format, flags);
}

bool SliderScalar(const(char)* label, ImGuiDataType data_type, scope void* p_data, scope const(void)* p_min, scope const(void)* p_max) @trusted
{
    return igSliderScalar(label, data_type, p_data, p_min, p_max);
}

bool SliderScalarEx(const(char)* label, ImGuiDataType data_type, scope void* p_data, scope const(void)* p_min, scope const(void)* p_max, const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igSliderScalarEx(label, data_type, p_data, p_min, p_max, format, flags);
}

bool SliderScalarN(const(char)* label, ImGuiDataType data_type, scope void* p_data, int components, scope const(void)* p_min, scope const(void)* p_max) @trusted
{
    return igSliderScalarN(label, data_type, p_data, components, p_min, p_max);
}

bool SliderScalarNEx(const(char)* label, ImGuiDataType data_type, scope void* p_data, int components, scope const(void)* p_min, scope const(void)* p_max, const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igSliderScalarNEx(label, data_type, p_data, components, p_min, p_max, format, flags);
}

bool VSliderFloat(const(char)* label, ImVec2 size, scope float* v, float v_min, float v_max) @trusted
{
    return igVSliderFloat(label, size, v, v_min, v_max);
}

bool VSliderFloatEx(const(char)* label, ImVec2 size, scope float* v, float v_min, float v_max, const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igVSliderFloatEx(label, size, v, v_min, v_max, format, flags);
}

bool VSliderInt(const(char)* label, ImVec2 size, scope int* v, int v_min, int v_max) @trusted
{
    return igVSliderInt(label, size, v, v_min, v_max);
}

bool VSliderIntEx(const(char)* label, ImVec2 size, scope int* v, int v_min, int v_max, const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igVSliderIntEx(label, size, v, v_min, v_max, format, flags);
}

bool VSliderScalar(const(char)* label, ImVec2 size, ImGuiDataType data_type, scope void* p_data, scope const(void)* p_min, scope const(void)* p_max) @trusted
{
    return igVSliderScalar(label, size, data_type, p_data, p_min, p_max);
}

bool VSliderScalarEx(const(char)* label, ImVec2 size, ImGuiDataType data_type, scope void* p_data, scope const(void)* p_min, scope const(void)* p_max, const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igVSliderScalarEx(label, size, data_type, p_data, p_min, p_max, format, flags);
}

/++
+ Widgets: Input with Keyboard
+  If you want to use InputText() with std::string or any custom dynamic string type, see misc/cpp/imgui_stdlib.h and comments in imgui_demo.cpp.
+  Most of the ImGuiInputTextFlags flags are only useful for InputText() and not for InputFloatX, InputIntX, InputDouble etc.
+/
bool InputText(const(char)* label, scope char* buf, size_t buf_size, ImGuiInputTextFlags flags) @trusted
{
    return igInputText(label, buf, buf_size, flags);
}

bool InputTextEx(const(char)* label, scope char* buf, size_t buf_size, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, scope void* user_data) @trusted
{
    return igInputTextEx(label, buf, buf_size, flags, callback, user_data);
}

bool InputTextMultiline(const(char)* label, scope char* buf, size_t buf_size) @trusted
{
    return igInputTextMultiline(label, buf, buf_size);
}

bool InputTextMultilineEx(const(char)* label, scope char* buf, size_t buf_size, ImVec2 size, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, scope void* user_data) @trusted
{
    return igInputTextMultilineEx(label, buf, buf_size, size, flags, callback, user_data);
}

bool InputTextWithHint(const(char)* label, const(char)* hint, scope char* buf, size_t buf_size, ImGuiInputTextFlags flags) @trusted
{
    return igInputTextWithHint(label, hint, buf, buf_size, flags);
}

bool InputTextWithHintEx(const(char)* label, const(char)* hint, scope char* buf, size_t buf_size, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, scope void* user_data) @trusted
{
    return igInputTextWithHintEx(label, hint, buf, buf_size, flags, callback, user_data);
}

bool InputFloat(const(char)* label, scope float* v) @trusted
{
    return igInputFloat(label, v);
}

bool InputFloatEx(const(char)* label, scope float* v, float step, float step_fast, const(char)* format, ImGuiInputTextFlags flags) @trusted
{
    return igInputFloatEx(label, v, step, step_fast, format, flags);
}

bool InputFloat2(const(char)* label, scope float* v) @trusted
{
    return igInputFloat2(label, v);
}

bool InputFloat2Ex(const(char)* label, scope float* v, const(char)* format, ImGuiInputTextFlags flags) @trusted
{
    return igInputFloat2Ex(label, v, format, flags);
}

bool InputFloat3(const(char)* label, scope float* v) @trusted
{
    return igInputFloat3(label, v);
}

bool InputFloat3Ex(const(char)* label, scope float* v, const(char)* format, ImGuiInputTextFlags flags) @trusted
{
    return igInputFloat3Ex(label, v, format, flags);
}

bool InputFloat4(const(char)* label, scope float* v) @trusted
{
    return igInputFloat4(label, v);
}

bool InputFloat4Ex(const(char)* label, scope float* v, const(char)* format, ImGuiInputTextFlags flags) @trusted
{
    return igInputFloat4Ex(label, v, format, flags);
}

bool InputInt(const(char)* label, scope int* v) @trusted
{
    return igInputInt(label, v);
}

bool InputIntEx(const(char)* label, scope int* v, int step, int step_fast, ImGuiInputTextFlags flags) @trusted
{
    return igInputIntEx(label, v, step, step_fast, flags);
}

bool InputInt2(const(char)* label, scope int* v, ImGuiInputTextFlags flags) @trusted
{
    return igInputInt2(label, v, flags);
}

bool InputInt3(const(char)* label, scope int* v, ImGuiInputTextFlags flags) @trusted
{
    return igInputInt3(label, v, flags);
}

bool InputInt4(const(char)* label, scope int* v, ImGuiInputTextFlags flags) @trusted
{
    return igInputInt4(label, v, flags);
}

bool InputDouble(const(char)* label, scope double* v) @trusted
{
    return igInputDouble(label, v);
}

bool InputDoubleEx(const(char)* label, scope double* v, double step, double step_fast, const(char)* format, ImGuiInputTextFlags flags) @trusted
{
    return igInputDoubleEx(label, v, step, step_fast, format, flags);
}

bool InputScalar(const(char)* label, ImGuiDataType data_type, scope void* p_data) @trusted
{
    return igInputScalar(label, data_type, p_data);
}

bool InputScalarEx(const(char)* label, ImGuiDataType data_type, scope void* p_data, scope const(void)* p_step, scope const(void)* p_step_fast, const(char)* format, ImGuiInputTextFlags flags) @trusted
{
    return igInputScalarEx(label, data_type, p_data, p_step, p_step_fast, format, flags);
}

bool InputScalarN(const(char)* label, ImGuiDataType data_type, scope void* p_data, int components) @trusted
{
    return igInputScalarN(label, data_type, p_data, components);
}

bool InputScalarNEx(const(char)* label, ImGuiDataType data_type, scope void* p_data, int components, scope const(void)* p_step, scope const(void)* p_step_fast, const(char)* format, ImGuiInputTextFlags flags) @trusted
{
    return igInputScalarNEx(label, data_type, p_data, components, p_step, p_step_fast, format, flags);
}

/++
+ Widgets: Color Editor/Picker (tip: the ColorEdit* functions have a little color square that can be leftclicked to open a picker, and rightclicked to open an option menu.)
+  Note that in C++ a 'float v[X]' function argument is the _same_ as 'float* v', the array syntax is just a way to document the number of elements that are expected to be accessible.
+  You can pass the address of a first float element out of a contiguous structure, e.g.
+ &myvector
+ .x
+/
bool ColorEdit3(const(char)* label, scope float* col, ImGuiColorEditFlags flags) @trusted
{
    return igColorEdit3(label, col, flags);
}

bool ColorEdit4(const(char)* label, scope float* col, ImGuiColorEditFlags flags) @trusted
{
    return igColorEdit4(label, col, flags);
}

bool ColorPicker3(const(char)* label, scope float* col, ImGuiColorEditFlags flags) @trusted
{
    return igColorPicker3(label, col, flags);
}

bool ColorPicker4(const(char)* label, scope float* col, ImGuiColorEditFlags flags, scope const(float)* ref_col) @trusted
{
    return igColorPicker4(label, col, flags, ref_col);
}

bool ColorButton(const(char)* desc_id, ImVec4 col, ImGuiColorEditFlags flags) @trusted
{
    return igColorButton(desc_id, col, flags);
}

bool ColorButtonEx(const(char)* desc_id, ImVec4 col, ImGuiColorEditFlags flags, ImVec2 size) @trusted
{
    return igColorButtonEx(desc_id, col, flags, size);
}

void SetColorEditOptions(ImGuiColorEditFlags flags) @trusted
{
    igSetColorEditOptions(flags);
}

/++
+ Widgets: Trees
+  TreeNode functions return true when the node is open, in which case you need to also call TreePop() when you are finished displaying the tree node contents.
+/
bool TreeNode(const(char)* label) @trusted
{
    return igTreeNode(label);
}

bool TreeNodeStr(const(char)* str_id, const(char)* fmt) @trusted
{
    return igTreeNodeStr(str_id, fmt);
}

bool TreeNodePtr(scope const(void)* ptr_id, const(char)* fmt) @trusted
{
    return igTreeNodePtr(ptr_id, fmt);
}

alias TreeNodeV = igTreeNodeV;

alias TreeNodeVPtr = igTreeNodeVPtr;

bool TreeNodeEx(const(char)* label, ImGuiTreeNodeFlags flags) @trusted
{
    return igTreeNodeEx(label, flags);
}

bool TreeNodeExStr(const(char)* str_id, ImGuiTreeNodeFlags flags, const(char)* fmt) @trusted
{
    return igTreeNodeExStr(str_id, flags, fmt);
}

bool TreeNodeExPtr(scope const(void)* ptr_id, ImGuiTreeNodeFlags flags, const(char)* fmt) @trusted
{
    return igTreeNodeExPtr(ptr_id, flags, fmt);
}

alias TreeNodeExV = igTreeNodeExV;

alias TreeNodeExVPtr = igTreeNodeExVPtr;

void TreePush(const(char)* str_id) @trusted
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

bool CollapsingHeader(const(char)* label, ImGuiTreeNodeFlags flags) @trusted
{
    return igCollapsingHeader(label, flags);
}

bool CollapsingHeaderBoolPtr(const(char)* label, scope bool* p_visible, ImGuiTreeNodeFlags flags) @trusted
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
+ Widgets: Selectables
+  A selectable highlights when hovered, and can display another color when selected.
+  Neighbors selectable extend their highlight bounds in order to leave no gap between them. This is so a series of selected Selectable appear contiguous.
+/
bool Selectable(const(char)* label) @trusted
{
    return igSelectable(label);
}

bool SelectableEx(const(char)* label, bool selected, ImGuiSelectableFlags flags, ImVec2 size) @trusted
{
    return igSelectableEx(label, selected, flags, size);
}

bool SelectableBoolPtr(const(char)* label, scope bool* p_selected, ImGuiSelectableFlags flags) @trusted
{
    return igSelectableBoolPtr(label, p_selected, flags);
}

bool SelectableBoolPtrEx(const(char)* label, scope bool* p_selected, ImGuiSelectableFlags flags, ImVec2 size) @trusted
{
    return igSelectableBoolPtrEx(label, p_selected, flags, size);
}

/++
+ Multiselection system for Selectable(), Checkbox(), TreeNode() functions [BETA]
+  This enables standard multiselection/rangeselection idioms (CTRL+Mouse/Keyboard, SHIFT+Mouse/Keyboard, etc.) in a way that also allow a clipper to be used.
+  ImGuiSelectionUserData is often used to store your item index within the current view (but may store something else).
+  Read comments near ImGuiMultiSelectIO for instructions/details and see 'Demo>Widgets>Selection State
+ &
+ MultiSelect' for demo.
+  TreeNode() is technically supported but... using this correctly is more complicated. You need some sort of linear/random access to your tree,
+ which is suited to advanced trees setups already implementing filters and clipper. We will work simplifying the current demo.
+  'selection_size' and 'items_count' parameters are optional and used by a few features. If they are costly for you to compute, you may avoid them.
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
+ Widgets: List Boxes
+  This is essentially a thin wrapper to using BeginChild/EndChild with the ImGuiChildFlags_FrameStyle flag for stylistic changes + displaying a label.
+  If you don't need a label you can probably simply use BeginChild() with the ImGuiChildFlags_FrameStyle flag for the same result.
+  You can submit contents and manage your selection state however you want it, by creating e.g. Selectable() or any other items.
+  The simplified/old ListBox() api are helpers over BeginListBox()/EndListBox() which are kept available for convenience purpose. This is analogous to how Combos are created.
+  Choose frame width:   size.x > 0.0f: custom  /  size.x
+ <
+ 0.0f or FLT_MIN: rightalign   /  size.x = 0.0f (default): use current ItemWidth
+  Choose frame height:  size.y > 0.0f: custom  /  size.y
+ <
+ 0.0f or FLT_MIN: bottomalign  /  size.y = 0.0f (default): arbitrary default height which can fit ~7 items
+/
bool BeginListBox(const(char)* label, ImVec2 size) @trusted
{
    return igBeginListBox(label, size);
}

void EndListBox() @trusted
{
    igEndListBox();
}

bool ListBox(const(char)* label, scope int* current_item, const(char)** items, int items_count, int height_in_items) @trusted
{
    return igListBox(label, current_item, items, items_count, height_in_items);
}

bool ListBoxCallback(const(char)* label, scope int* current_item, ImGuiGetterCallback getter, scope void* user_data, int items_count) @trusted
{
    return igListBoxCallback(label, current_item, getter, user_data, items_count);
}

bool ListBoxCallbackEx(const(char)* label, scope int* current_item, ImGuiGetterCallback getter, scope void* user_data, int items_count, int height_in_items) @trusted
{
    return igListBoxCallbackEx(label, current_item, getter, user_data, items_count, height_in_items);
}

/++
+ Widgets: Data Plotting
+  Consider using ImPlot (https://github.com/epezent/implot) which is much better!
+/
void PlotLines(const(char)* label, scope const(float)* values, int values_count) @trusted
{
    igPlotLines(label, values, values_count);
}

void PlotLinesEx(const(char)* label, scope const(float)* values, int values_count, int values_offset, const(char)* overlay_text, float scale_min, float scale_max, ImVec2 graph_size, int stride) @trusted
{
    igPlotLinesEx(label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size, stride);
}

void PlotLinesCallback(const(char)* label, ImGuiValues_getterCallback values_getter, scope void* data, int values_count) @trusted
{
    igPlotLinesCallback(label, values_getter, data, values_count);
}

void PlotLinesCallbackEx(const(char)* label, ImGuiValues_getterCallback values_getter, scope void* data, int values_count, int values_offset, const(char)* overlay_text, float scale_min, float scale_max, ImVec2 graph_size) @trusted
{
    igPlotLinesCallbackEx(label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size);
}

void PlotHistogram(const(char)* label, scope const(float)* values, int values_count) @trusted
{
    igPlotHistogram(label, values, values_count);
}

void PlotHistogramEx(const(char)* label, scope const(float)* values, int values_count, int values_offset, const(char)* overlay_text, float scale_min, float scale_max, ImVec2 graph_size, int stride) @trusted
{
    igPlotHistogramEx(label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size, stride);
}

void PlotHistogramCallback(const(char)* label, ImGuiValues_getterCallback values_getter, scope void* data, int values_count) @trusted
{
    igPlotHistogramCallback(label, values_getter, data, values_count);
}

void PlotHistogramCallbackEx(const(char)* label, ImGuiValues_getterCallback values_getter, scope void* data, int values_count, int values_offset, const(char)* overlay_text, float scale_min, float scale_max, ImVec2 graph_size) @trusted
{
    igPlotHistogramCallbackEx(label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size);
}

/++
+ Widgets: Menus
+  Use BeginMenuBar() on a window ImGuiWindowFlags_MenuBar to append to its menu bar.
+  Use BeginMainMenuBar() to create a menu bar at the top of the screen and append to it.
+  Use BeginMenu() to create a menu. You can call BeginMenu() multiple time with the same identifier to append more items to it.
+  Not that MenuItem() keyboardshortcuts are displayed as a convenience but _not processed_ by Dear ImGui at the moment.
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

bool BeginMenu(const(char)* label) @trusted
{
    return igBeginMenu(label);
}

bool BeginMenuEx(const(char)* label, bool enabled) @trusted
{
    return igBeginMenuEx(label, enabled);
}

void EndMenu() @trusted
{
    igEndMenu();
}

bool MenuItem(const(char)* label) @trusted
{
    return igMenuItem(label);
}

bool MenuItemEx(const(char)* label, const(char)* shortcut, bool selected, bool enabled) @trusted
{
    return igMenuItemEx(label, shortcut, selected, enabled);
}

bool MenuItemBoolPtr(const(char)* label, const(char)* shortcut, scope bool* p_selected, bool enabled) @trusted
{
    return igMenuItemBoolPtr(label, shortcut, p_selected, enabled);
}

/++
+ Tooltips
+  Tooltips are windows following the mouse. They do not take focus away.
+  A tooltip window can contain items of any types.
+  SetTooltip() is more or less a shortcut for the 'if (BeginTooltip()) { Text(...); EndTooltip(); }' idiom (with a subtlety that it discard any previously submitted tooltip)
+/
bool BeginTooltip() @trusted
{
    return igBeginTooltip();
}

void EndTooltip() @trusted
{
    igEndTooltip();
}

void SetTooltip(const(char)* fmt) @trusted
{
    igSetTooltip(fmt);
}

alias SetTooltipV = igSetTooltipV;

/++
+ Tooltips: helpers for showing a tooltip when hovering an item
+  BeginItemTooltip() is a shortcut for the 'if (IsItemHovered(ImGuiHoveredFlags_ForTooltip)
+ &
+ &
+ BeginTooltip())' idiom.
+  SetItemTooltip() is a shortcut for the 'if (IsItemHovered(ImGuiHoveredFlags_ForTooltip)) { SetTooltip(...); }' idiom.
+  Where 'ImGuiHoveredFlags_ForTooltip' itself is a shortcut to use 'style.HoverFlagsForTooltipMouse' or 'style.HoverFlagsForTooltipNav' depending on active input type. For mouse it defaults to 'ImGuiHoveredFlags_Stationary | ImGuiHoveredFlags_DelayShort'.
+/
bool BeginItemTooltip() @trusted
{
    return igBeginItemTooltip();
}

void SetItemTooltip(const(char)* fmt) @trusted
{
    igSetItemTooltip(fmt);
}

alias SetItemTooltipV = igSetItemTooltipV;

/++
+ Popups, Modals
+  They block normal mouse hovering detection (and therefore most mouse interactions) behind them.
+  If not modal: they can be closed by clicking anywhere outside them, or by pressing ESCAPE.
+  Their visibility state (~bool) is held internally instead of being held by the programmer as we are used to with regular Begin*() calls.
+  The 3 properties above are related: we need to retain popup visibility state in the library because popups may be closed as any time.
+  You can bypass the hovering restriction by using ImGuiHoveredFlags_AllowWhenBlockedByPopup when calling IsItemHovered() or IsWindowHovered().
+  IMPORTANT: Popup identifiers are relative to the current ID stack, so OpenPopup and BeginPopup generally needs to be at the same level of the stack.
+ This is sometimes leading to confusing mistakes. May rework this in the future.
+  BeginPopup(): query popup state, if open start appending into the window. Call EndPopup() afterwards if returned true. ImGuiWindowFlags are forwarded to the window.
+  BeginPopupModal(): block every interaction behind the window, cannot be closed by user, add a dimming background, has a title bar.
+/
bool BeginPopup(const(char)* str_id, ImGuiWindowFlags flags) @trusted
{
    return igBeginPopup(str_id, flags);
}

bool BeginPopupModal(const(char)* name, scope bool* p_open, ImGuiWindowFlags flags) @trusted
{
    return igBeginPopupModal(name, p_open, flags);
}

void EndPopup() @trusted
{
    igEndPopup();
}

/++
+ Popups: open/close functions
+  OpenPopup(): set popup state to open. ImGuiPopupFlags are available for opening options.
+  If not modal: they can be closed by clicking anywhere outside them, or by pressing ESCAPE.
+  CloseCurrentPopup(): use inside the BeginPopup()/EndPopup() scope to close manually.
+  CloseCurrentPopup() is called by default by Selectable()/MenuItem() when activated (FIXME: need some options).
+  Use ImGuiPopupFlags_NoOpenOverExistingPopup to avoid opening a popup if there's already one at the same level. This is equivalent to e.g. testing for !IsAnyPopupOpen() prior to OpenPopup().
+  Use IsWindowAppearing() after BeginPopup() to tell if a window just opened.
+  IMPORTANT: Notice that for OpenPopupOnItemClick() we exceptionally default flags to 1 (== ImGuiPopupFlags_MouseButtonRight) for backward compatibility with older API taking 'int mouse_button = 1' parameter
+/
void OpenPopup(const(char)* str_id, ImGuiPopupFlags popup_flags) @trusted
{
    igOpenPopup(str_id, popup_flags);
}

void OpenPopupID(ImGuiID id, ImGuiPopupFlags popup_flags) @trusted
{
    igOpenPopupID(id, popup_flags);
}

void OpenPopupOnItemClick(const(char)* str_id, ImGuiPopupFlags popup_flags) @trusted
{
    igOpenPopupOnItemClick(str_id, popup_flags);
}

void CloseCurrentPopup() @trusted
{
    igCloseCurrentPopup();
}

/++
+ Popups: open+begin combined functions helpers
+  Helpers to do OpenPopup+BeginPopup where the Open action is triggered by e.g. hovering an item and rightclicking.
+  They are convenient to easily create context menus, hence the name.
+  IMPORTANT: Notice that BeginPopupContextXXX takes ImGuiPopupFlags just like OpenPopup() and unlike BeginPopup(). For full consistency, we may add ImGuiWindowFlags to the BeginPopupContextXXX functions in the future.
+  IMPORTANT: Notice that we exceptionally default their flags to 1 (== ImGuiPopupFlags_MouseButtonRight) for backward compatibility with older API taking 'int mouse_button = 1' parameter, so if you add other flags remember to readd the ImGuiPopupFlags_MouseButtonRight.
+/
bool BeginPopupContextItem() @trusted
{
    return igBeginPopupContextItem();
}

bool BeginPopupContextItemEx(const(char)* str_id, ImGuiPopupFlags popup_flags) @trusted
{
    return igBeginPopupContextItemEx(str_id, popup_flags);
}

bool BeginPopupContextWindow() @trusted
{
    return igBeginPopupContextWindow();
}

bool BeginPopupContextWindowEx(const(char)* str_id, ImGuiPopupFlags popup_flags) @trusted
{
    return igBeginPopupContextWindowEx(str_id, popup_flags);
}

bool BeginPopupContextVoid() @trusted
{
    return igBeginPopupContextVoid();
}

bool BeginPopupContextVoidEx(const(char)* str_id, ImGuiPopupFlags popup_flags) @trusted
{
    return igBeginPopupContextVoidEx(str_id, popup_flags);
}

/++
+ Popups: query functions
+  IsPopupOpen(): return true if the popup is open at the current BeginPopup() level of the popup stack.
+  IsPopupOpen() with ImGuiPopupFlags_AnyPopupId: return true if any popup is open at the current BeginPopup() level of the popup stack.
+  IsPopupOpen() with ImGuiPopupFlags_AnyPopupId + ImGuiPopupFlags_AnyPopupLevel: return true if any popup is open.
+/
bool IsPopupOpen(const(char)* str_id, ImGuiPopupFlags flags) @trusted
{
    return igIsPopupOpen(str_id, flags);
}

/++
+ Tables
+  Fullfeatured replacement for old Columns API.
+  See Demo>Tables for demo code. See top of imgui_tables.cpp for general commentary.
+  See ImGuiTableFlags_ and ImGuiTableColumnFlags_ enums for a description of available flags.
+ The typical call flow is:
+  1. Call BeginTable(), early out if returning false.
+  2. Optionally call TableSetupColumn() to submit column name/flags/defaults.
+  3. Optionally call TableSetupScrollFreeze() to request scroll freezing of columns/rows.
+  4. Optionally call TableHeadersRow() to submit a header row. Names are pulled from TableSetupColumn() data.
+  5. Populate contents:
+  In most situations you can use TableNextRow() + TableSetColumnIndex(N) to start appending into a column.
+  If you are using tables as a sort of grid, where every column is holding the same type of contents,
+ you may prefer using TableNextColumn() instead of TableNextRow() + TableSetColumnIndex().
+ TableNextColumn() will automatically wraparound into the next row if needed.
+  IMPORTANT: Comparatively to the old Columns() API, we need to call TableNextColumn() for the first column!
+  Summary of possible call flow:
+  TableNextRow() > TableSetColumnIndex(0) > Text("Hello 0") > TableSetColumnIndex(1) > Text("Hello 1")  // OK
+  TableNextRow() > TableNextColumn()      > Text("Hello 0") > TableNextColumn()      > Text("Hello 1")  // OK
+                    TableNextColumn()      > Text("Hello 0") > TableNextColumn()      > Text("Hello 1")  // OK: TableNextColumn() automatically gets to next row!
+  TableNextRow()                           > Text("Hello 0")                                               // Not OK! Missing TableSetColumnIndex() or TableNextColumn()! Text will not appear!
+  5. Call EndTable()
+/
bool BeginTable(const(char)* str_id, int columns, ImGuiTableFlags flags) @trusted
{
    return igBeginTable(str_id, columns, flags);
}

bool BeginTableEx(const(char)* str_id, int columns, ImGuiTableFlags flags, ImVec2 outer_size, float inner_width) @trusted
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
+ Tables: Headers
+ &
+ Columns declaration
+  Use TableSetupColumn() to specify label, resizing policy, default width/weight, id, various other flags etc.
+  Use TableHeadersRow() to create a header row and automatically submit a TableHeader() for each column.
+ Headers are required to perform: reordering, sorting, and opening the context menu.
+ The context menu can also be made available in columns body using ImGuiTableFlags_ContextMenuInBody.
+  You may manually submit headers using TableNextRow() + TableHeader() calls, but this is only useful in
+ some advanced use cases (e.g. adding custom widgets in header row).
+  Use TableSetupScrollFreeze() to lock columns/rows so they stay visible when scrolled.
+/
void TableSetupColumn(const(char)* label, ImGuiTableColumnFlags flags) @trusted
{
    igTableSetupColumn(label, flags);
}

void TableSetupColumnEx(const(char)* label, ImGuiTableColumnFlags flags, float init_width_or_weight, ImGuiID user_id) @trusted
{
    igTableSetupColumnEx(label, flags, init_width_or_weight, user_id);
}

void TableSetupScrollFreeze(int cols, int rows) @trusted
{
    igTableSetupScrollFreeze(cols, rows);
}

void TableHeader(const(char)* label) @trusted
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
+ Tables: Sorting
+ &
+ Miscellaneous functions
+  Sorting: call TableGetSortSpecs() to retrieve latest sort specs for the table. NULL when not sorting.
+ When 'sort_specs>SpecsDirty == true' you should sort your data. It will be true when sorting specs have
+ changed since last call, or the first time. Make sure to set 'SpecsDirty = false' after sorting,
+ else you may wastefully sort your data every frame!
+  Functions args 'int column_n' treat the default value of 1 as the same as passing the current column index.
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
+ Legacy Columns API (prefer using Tables!)
+  You can also use SameLine(pos_x) to mimic simplified columns.
+/
void Columns() @trusted
{
    igColumns();
}

void ColumnsEx(int count, const(char)* id, bool borders) @trusted
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
+ Tab Bars, Tabs
+  Note: Tabs are automatically created by the docking system (when in 'docking' branch). Use this to create tab bars/tabs yourself.
+/
bool BeginTabBar(const(char)* str_id, ImGuiTabBarFlags flags) @trusted
{
    return igBeginTabBar(str_id, flags);
}

void EndTabBar() @trusted
{
    igEndTabBar();
}

bool BeginTabItem(const(char)* label, scope bool* p_open, ImGuiTabItemFlags flags) @trusted
{
    return igBeginTabItem(label, p_open, flags);
}

void EndTabItem() @trusted
{
    igEndTabItem();
}

bool TabItemButton(const(char)* label, ImGuiTabItemFlags flags) @trusted
{
    return igTabItemButton(label, flags);
}

void SetTabItemClosed(const(char)* tab_or_docked_window_label) @trusted
{
    igSetTabItemClosed(tab_or_docked_window_label);
}

/++
+ Logging/Capture
+  All text output from the interface can be captured into tty/file/clipboard. By default, tree nodes are automatically opened during logging.
+/
void LogToTTY(int auto_open_depth) @trusted
{
    igLogToTTY(auto_open_depth);
}

void LogToFile(int auto_open_depth, const(char)* filename) @trusted
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

void LogText(const(char)* fmt) @trusted
{
    igLogText(fmt);
}

alias LogTextV = igLogTextV;

/++
+ Drag and Drop
+  On source items, call BeginDragDropSource(), if it returns true also call SetDragDropPayload() + EndDragDropSource().
+  On target candidates, call BeginDragDropTarget(), if it returns true also call AcceptDragDropPayload() + EndDragDropTarget().
+  If you stop calling BeginDragDropSource() the payload is preserved however it won't have a preview tooltip (we currently display a fallback "..." tooltip, see #1725)
+  An item can be both drag source and drop target.
+/
bool BeginDragDropSource(ImGuiDragDropFlags flags) @trusted
{
    return igBeginDragDropSource(flags);
}

bool SetDragDropPayload(const(char)* type, scope const(void)* data, size_t sz, ImGuiCond cond) @trusted
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

const(ImGuiPayload)* AcceptDragDropPayload(const(char)* type, ImGuiDragDropFlags flags) @trusted
{
    return igAcceptDragDropPayload(type, flags);
}

void EndDragDropTarget() @trusted
{
    igEndDragDropTarget();
}

const(ImGuiPayload)* GetDragDropPayload() @trusted
{
    return igGetDragDropPayload();
}

/++
+ Disabling [BETA API]
+  Disable all user interactions and dim items visuals (applying style.DisabledAlpha over current colors)
+  Those can be nested but it cannot be used to enable an already disabled section (a single BeginDisabled(true) in the stack is enough to keep everything disabled)
+  Tooltips windows by exception are opted out of disabling.
+  BeginDisabled(false)/EndDisabled() essentially does nothing but is provided to facilitate use of boolean expressions (as a microoptimization: if you have tens of thousands of BeginDisabled(false)/EndDisabled() pairs, you might want to reformulate your code to avoid making those calls)
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
+ Clipping
+  Mouse hovering is affected by ImGui::PushClipRect() calls, unlike direct calls to ImDrawList::PushClipRect() which are render only.
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
+ Focus, Activation
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
+ Keyboard/Gamepad Navigation
+/
void SetNavCursorVisible(bool visible) @trusted
{
    igSetNavCursorVisible(visible);
}

/++
+ Overlapping mode
+/
void SetNextItemAllowOverlap() @trusted
{
    igSetNextItemAllowOverlap();
}

/++
+ Item/Widgets Utilities and Query Functions
+  Most of the functions are referring to the previous Item that has been submitted.
+  See Demo Window under "Widgets>Querying Status" for an interactive visualization of most of those functions.
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
+ Viewports
+  Currently represents the Platform Window created by the application which is hosting our Dear ImGui windows.
+  In 'docking' branch with multiviewport enabled, we extend this concept to have multiple active viewports.
+  In the future we will extend this concept further to also represent Platform Monitor and support a "no main platform window" operation mode.
+/
ImGuiViewport* GetMainViewport() @trusted
{
    return igGetMainViewport();
}

/++
+ Background/Foreground Draw Lists
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
+ Miscellaneous Utilities
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
+ Text Utilities
+/
ImVec2 CalcTextSize(const(char)* text) @trusted
{
    return igCalcTextSize(text);
}

ImVec2 CalcTextSizeEx(const(char)* text, const(char)* text_end, bool hide_text_after_double_hash, float wrap_width) @trusted
{
    return igCalcTextSizeEx(text, text_end, hide_text_after_double_hash, wrap_width);
}

/++
+ Color Utilities
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
+ Inputs Utilities: Keyboard/Mouse/Gamepad
+  the ImGuiKey enum contains all possible keyboard, mouse and gamepad inputs (e.g. ImGuiKey_A, ImGuiKey_MouseLeft, ImGuiKey_GamepadDpadUp...).
+  (legacy: before v1.87, we used ImGuiKey to carry native/user indices as defined by each backends. This was obsoleted in 1.87 (202202) and completely removed in 1.91.5 (202411). See https://github.com/ocornut/imgui/issues/4921)
+  (legacy: any use of ImGuiKey will assert when key
+ <
+ 512 to detect passing legacy native/user indices)
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
+ Inputs Utilities: Shortcut Testing
+ &
+ Routing [BETA]
+  ImGuiKeyChord = a ImGuiKey + optional ImGuiMod_Alt/ImGuiMod_Ctrl/ImGuiMod_Shift/ImGuiMod_Super.
+ ImGuiKey_C                          // Accepted by functions taking ImGuiKey or ImGuiKeyChord arguments)
+ ImGuiMod_Ctrl | ImGuiKey_C          // Accepted by functions taking ImGuiKeyChord arguments)
+ only ImGuiMod_XXX values are legal to combine with an ImGuiKey. You CANNOT combine two ImGuiKey values.
+  The general idea is that several callers may register interest in a shortcut, and only one owner gets it.
+ Parent   > call Shortcut(Ctrl+S)    // When Parent is focused, Parent gets the shortcut.
+ Child1 > call Shortcut(Ctrl+S)    // When Child1 is focused, Child1 gets the shortcut (Child1 overrides Parent shortcuts)
+ Child2 > no call                  // When Child2 is focused, Parent gets the shortcut.
+ The whole system is order independent, so if Child1 makes its calls before Parent, results will be identical.
+ This is an important property as it facilitate working with foreign code or larger codebase.
+  To understand the difference:
+  IsKeyChordPressed() compares mods and call IsKeyPressed() > function has no sideeffect.
+  Shortcut() submits a route, routes are resolved, if it currently can be routed it calls IsKeyChordPressed() > function has (desirable) sideeffects as it can prevents another call from getting the route.
+  Visualize registered routes in 'Metrics/Debugger>Inputs'.
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
+ Inputs Utilities: Key/Input Ownership [BETA]
+  One common use case would be to allow your items to disable standard inputs behaviors such
+ as Tab or Alt key handling, Mouse Wheel scrolling, etc.
+ e.g. Button(...); SetItemKeyOwner(ImGuiKey_MouseWheelY); to make hovering/activating a button disable wheel for scrolling.
+  Reminder ImGuiKey enum include access to mouse buttons and gamepad, so key ownership can apply to them.
+  Many related features are still in imgui_internal.h. For instance, most IsKeyXXX()/IsMouseXXX() functions have an owneridaware version.
+/
void SetItemKeyOwner(ImGuiKey key) @trusted
{
    igSetItemKeyOwner(key);
}

/++
+ Inputs Utilities: Mouse
+  To refer to a mouse button, you may use named enums in your code e.g. ImGuiMouseButton_Left, ImGuiMouseButton_Right.
+  You can also use regular integer: it is forever guaranteed that 0=Left, 1=Right, 2=Middle.
+  Dragging operations are only reported after mouse has moved a certain distance away from the initial clicking position (see 'lock_threshold' and 'io.MouseDraggingThreshold')
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

bool IsMousePosValid(ImVec2* mouse_pos) @trusted
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
+ Clipboard Utilities
+  Also see the LogToClipboard() function to capture GUI into clipboard, or easily output text data to the clipboard.
+/
const(char)* GetClipboardText() @trusted
{
    return igGetClipboardText();
}

void SetClipboardText(const(char)* text) @trusted
{
    igSetClipboardText(text);
}

/++
+ Settings/.Ini Utilities
+  The disk functions are automatically called if io.IniFilename != NULL (default is "imgui.ini").
+  Set io.IniFilename to NULL to load/save manually. Read io.WantSaveIniSettings description about handling .ini saving manually.
+  Important: default value "imgui.ini" is relative to current working dir! Most apps will want to lock this to an absolute path (e.g. same path as executables).
+/
void LoadIniSettingsFromDisk(const(char)* ini_filename) @trusted
{
    igLoadIniSettingsFromDisk(ini_filename);
}

void LoadIniSettingsFromMemory(const(char)* ini_data, size_t ini_size) @trusted
{
    igLoadIniSettingsFromMemory(ini_data, ini_size);
}

void SaveIniSettingsToDisk(const(char)* ini_filename) @trusted
{
    igSaveIniSettingsToDisk(ini_filename);
}

const(char)* SaveIniSettingsToMemory(size_t* out_ini_size) @trusted
{
    return igSaveIniSettingsToMemory(out_ini_size);
}

/++
+ Debug Utilities
+  Your main debugging friend is the ShowMetricsWindow() function, which is also accessible from Demo>Tools>Metrics Debugger
+/
void DebugTextEncoding(const(char)* text) @trusted
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

bool DebugCheckVersionAndDataLayout(const(char)* version_str, size_t sz_io, size_t sz_style, size_t sz_vec2, size_t sz_vec4, size_t sz_drawvert, size_t sz_drawidx) @trusted
{
    return igDebugCheckVersionAndDataLayout(version_str, sz_io, sz_style, sz_vec2, sz_vec4, sz_drawvert, sz_drawidx);
}

void DebugLog(const(char)* fmt) @trusted
{
    igDebugLog(fmt);
}

alias DebugLogV = igDebugLogV;

/++
+ Memory Allocators
+  Those functions are not reliant on the current context.
+  DLL users: heaps and globals are not shared across DLL boundaries! You will need to call SetCurrentContext() + SetAllocatorFunctions()
+ for each static/DLL boundary you are calling from. Read "Context and Memory Allocators" section of imgui.cpp for more details.
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
+ OBSOLETED in 1.92.0 (from June 2025)
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
+ OBSOLETED in 1.91.9 (from February 2025)
+/
void ImageImVec4(ImTextureRef tex_ref, ImVec2 image_size, ImVec2 uv0, ImVec2 uv1, ImVec4 tint_col, ImVec4 border_col) @trusted
{
    igImageImVec4(tex_ref, image_size, uv0, uv1, tint_col, border_col);
}

/++
+ OBSOLETED in 1.91.0 (from July 2024)
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
+ OBSOLETED in 1.90.0 (from September 2023)
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
+ inline bool       BeginChild(const char* str_id, const ImVec2
+ &
+ size_arg, bool borders, ImGuiWindowFlags window_flags){ return BeginChild(str_id, size_arg, borders ? ImGuiChildFlags_Borders : ImGuiChildFlags_None, window_flags); } // Unnecessary as true == ImGuiChildFlags_Borders
+ inline bool       BeginChild(ImGuiID id, const ImVec2
+ &
+ size_arg, bool borders, ImGuiWindowFlags window_flags)        { return BeginChild(id, size_arg, borders ? ImGuiChildFlags_Borders : ImGuiChildFlags_None, window_flags);     } // Unnecessary as true == ImGuiChildFlags_Borders
+/
void ShowStackToolWindow(scope bool* p_open) @trusted
{
    igShowStackToolWindow(p_open);
}

bool ComboObsolete(const(char)* label, scope int* current_item, ImGuiOld_callbackCallback old_callback, scope void* user_data, int items_count) @trusted
{
    return igComboObsolete(label, current_item, old_callback, user_data, items_count);
}

bool ComboObsoleteEx(const(char)* label, scope int* current_item, ImGuiOld_callbackCallback old_callback, scope void* user_data, int items_count, int popup_max_height_in_items) @trusted
{
    return igComboObsoleteEx(label, current_item, old_callback, user_data, items_count, popup_max_height_in_items);
}

bool ListBoxObsolete(const(char)* label, scope int* current_item, ImGuiOld_callbackCallback old_callback, scope void* user_data, int items_count) @trusted
{
    return igListBoxObsolete(label, current_item, old_callback, user_data, items_count);
}

bool ListBoxObsoleteEx(const(char)* label, scope int* current_item, ImGuiOld_callbackCallback old_callback, scope void* user_data, int items_count, int height_in_items) @trusted
{
    return igListBoxObsoleteEx(label, current_item, old_callback, user_data, items_count, height_in_items);
}

/++
+ OBSOLETED in 1.89.7 (from June 2023)
+/
void SetItemAllowOverlap() @trusted
{
    igSetItemAllowOverlap();
}

/++
+ Windows
+ We should always have a CurrentWindow in the stack (there is an implicit "Debug" window)
+ If this ever crashes because g.CurrentWindow is NULL, it means that either:
+  ImGui::NewFrame() has never been called, which is illegal.
+  You are calling ImGui functions after ImGui::EndFrame()/ImGui::Render() and before the next ImGui::NewFrame(), which is also illegal.
+/
ImGuiIO* GetIOImGuiContextPtr(scope ImGuiContext* ctx) @trusted
{
    return igGetIOImGuiContextPtr(ctx);
}

ImGuiPlatformIO* GetPlatformIOImGuiContextPtr(scope ImGuiContext* ctx) @trusted
{
    return igGetPlatformIOImGuiContextPtr(ctx);
}

ImGuiWindow* GetCurrentWindowRead() @trusted
{
    return igGetCurrentWindowRead();
}

ImGuiWindow* GetCurrentWindow() @trusted
{
    return igGetCurrentWindow();
}

ImGuiWindow* FindWindowByID(ImGuiID id) @trusted
{
    return igFindWindowByID(id);
}

ImGuiWindow* FindWindowByName(const(char)* name) @trusted
{
    return igFindWindowByName(name);
}

void UpdateWindowParentAndRootLinks(scope ImGuiWindow* window, ImGuiWindowFlags flags, scope ImGuiWindow* parent_window) @trusted
{
    igUpdateWindowParentAndRootLinks(window, flags, parent_window);
}

void UpdateWindowSkipRefresh(scope ImGuiWindow* window) @trusted
{
    igUpdateWindowSkipRefresh(window);
}

ImVec2 CalcWindowNextAutoFitSize(scope ImGuiWindow* window) @trusted
{
    return igCalcWindowNextAutoFitSize(window);
}

bool IsWindowChildOf(scope ImGuiWindow* window, scope ImGuiWindow* potential_parent, bool popup_hierarchy) @trusted
{
    return igIsWindowChildOf(window, potential_parent, popup_hierarchy);
}

bool IsWindowWithinBeginStackOf(scope ImGuiWindow* window, scope ImGuiWindow* potential_parent) @trusted
{
    return igIsWindowWithinBeginStackOf(window, potential_parent);
}

bool IsWindowAbove(scope ImGuiWindow* potential_above, scope ImGuiWindow* potential_below) @trusted
{
    return igIsWindowAbove(potential_above, potential_below);
}

bool IsWindowNavFocusable(scope ImGuiWindow* window) @trusted
{
    return igIsWindowNavFocusable(window);
}

void SetWindowPosImGuiWindowPtr(scope ImGuiWindow* window, ImVec2 pos, ImGuiCond cond) @trusted
{
    igSetWindowPosImGuiWindowPtr(window, pos, cond);
}

void SetWindowSizeImGuiWindowPtr(scope ImGuiWindow* window, ImVec2 size, ImGuiCond cond) @trusted
{
    igSetWindowSizeImGuiWindowPtr(window, size, cond);
}

void SetWindowCollapsedImGuiWindowPtr(scope ImGuiWindow* window, bool collapsed, ImGuiCond cond) @trusted
{
    igSetWindowCollapsedImGuiWindowPtr(window, collapsed, cond);
}

void SetWindowHitTestHole(scope ImGuiWindow* window, ImVec2 pos, ImVec2 size) @trusted
{
    igSetWindowHitTestHole(window, pos, size);
}

void SetWindowHiddenAndSkipItemsForCurrentFrame(scope ImGuiWindow* window) @trusted
{
    igSetWindowHiddenAndSkipItemsForCurrentFrame(window);
}

void SetWindowParentWindowForFocusRoute(scope ImGuiWindow* window, scope ImGuiWindow* parent_window) @trusted
{
    igSetWindowParentWindowForFocusRoute(window, parent_window);
}

ImRect WindowRectAbsToRel(scope ImGuiWindow* window, ImRect r) @trusted
{
    return igWindowRectAbsToRel(window, r);
}

ImRect WindowRectRelToAbs(scope ImGuiWindow* window, ImRect r) @trusted
{
    return igWindowRectRelToAbs(window, r);
}

ImVec2 WindowPosAbsToRel(scope ImGuiWindow* window, ImVec2 p) @trusted
{
    return igWindowPosAbsToRel(window, p);
}

ImVec2 WindowPosRelToAbs(scope ImGuiWindow* window, ImVec2 p) @trusted
{
    return igWindowPosRelToAbs(window, p);
}

/++
+ Windows: Display Order and Focus Order
+/
void FocusWindow(scope ImGuiWindow* window, ImGuiFocusRequestFlags flags) @trusted
{
    igFocusWindow(window, flags);
}

void FocusTopMostWindowUnderOne(scope ImGuiWindow* under_this_window, scope ImGuiWindow* ignore_window, scope ImGuiViewport* filter_viewport, ImGuiFocusRequestFlags flags) @trusted
{
    igFocusTopMostWindowUnderOne(under_this_window, ignore_window, filter_viewport, flags);
}

void BringWindowToFocusFront(scope ImGuiWindow* window) @trusted
{
    igBringWindowToFocusFront(window);
}

void BringWindowToDisplayFront(scope ImGuiWindow* window) @trusted
{
    igBringWindowToDisplayFront(window);
}

void BringWindowToDisplayBack(scope ImGuiWindow* window) @trusted
{
    igBringWindowToDisplayBack(window);
}

void BringWindowToDisplayBehind(scope ImGuiWindow* window, scope ImGuiWindow* above_window) @trusted
{
    igBringWindowToDisplayBehind(window, above_window);
}

int FindWindowDisplayIndex(scope ImGuiWindow* window) @trusted
{
    return igFindWindowDisplayIndex(window);
}

ImGuiWindow* FindBottomMostVisibleWindowWithinBeginStack(scope ImGuiWindow* window) @trusted
{
    return igFindBottomMostVisibleWindowWithinBeginStack(window);
}

/++
+ Windows: Idle, Refresh Policies [EXPERIMENTAL]
+/
void SetNextWindowRefreshPolicy(ImGuiWindowRefreshFlags flags) @trusted
{
    igSetNextWindowRefreshPolicy(flags);
}

/++
+ Fonts, drawing
+/
void RegisterUserTexture(scope ImTextureData* tex) @trusted
{
    igRegisterUserTexture(tex);
}

void UnregisterUserTexture(scope ImTextureData* tex) @trusted
{
    igUnregisterUserTexture(tex);
}

void RegisterFontAtlas(scope ImFontAtlas* atlas) @trusted
{
    igRegisterFontAtlas(atlas);
}

void UnregisterFontAtlas(scope ImFontAtlas* atlas) @trusted
{
    igUnregisterFontAtlas(atlas);
}

void SetCurrentFont(scope ImFont* font, float font_size_before_scaling, float font_size_after_scaling) @trusted
{
    igSetCurrentFont(font, font_size_before_scaling, font_size_after_scaling);
}

void UpdateCurrentFontSize(float restore_font_size_after_scaling) @trusted
{
    igUpdateCurrentFontSize(restore_font_size_after_scaling);
}

void SetFontRasterizerDensity(float rasterizer_density) @trusted
{
    igSetFontRasterizerDensity(rasterizer_density);
}

float GetFontRasterizerDensity() @trusted
{
    return igGetFontRasterizerDensity();
}

float GetRoundedFontSize(float size) @trusted
{
    return igGetRoundedFontSize(size);
}

ImFont* GetDefaultFont() @trusted
{
    return igGetDefaultFont();
}

void PushPasswordFont() @trusted
{
    igPushPasswordFont();
}

void PopPasswordFont() @trusted
{
    igPopPasswordFont();
}

ImDrawList* GetForegroundDrawListImGuiWindowPtr(scope ImGuiWindow* window) @trusted
{
    return igGetForegroundDrawListImGuiWindowPtr(window);
}

ImDrawList* GetBackgroundDrawListImGuiViewportPtr(scope ImGuiViewport* viewport) @trusted
{
    return igGetBackgroundDrawListImGuiViewportPtr(viewport);
}

ImDrawList* GetForegroundDrawListImGuiViewportPtr(scope ImGuiViewport* viewport) @trusted
{
    return igGetForegroundDrawListImGuiViewportPtr(viewport);
}

void AddDrawListToDrawDataEx(scope ImDrawData* draw_data, scope ImVector_ImDrawListPtr* out_list, scope ImDrawList* draw_list) @trusted
{
    igAddDrawListToDrawDataEx(draw_data, out_list, draw_list);
}

/++
+ Init
+/
void Initialize() @trusted
{
    igInitialize();
}

void Shutdown() @trusted
{
    igShutdown();
}

/++
+ NewFrame
+/
void UpdateInputEvents(bool trickle_fast_inputs) @trusted
{
    igUpdateInputEvents(trickle_fast_inputs);
}

void UpdateHoveredWindowAndCaptureFlags(ImVec2 mouse_pos) @trusted
{
    igUpdateHoveredWindowAndCaptureFlags(mouse_pos);
}

void FindHoveredWindowEx(ImVec2 pos, bool find_first_and_in_any_viewport, scope ImGuiWindow** out_hovered_window, scope ImGuiWindow** out_hovered_window_under_moving_window) @trusted
{
    igFindHoveredWindowEx(pos, find_first_and_in_any_viewport, out_hovered_window, out_hovered_window_under_moving_window);
}

void StartMouseMovingWindow(scope ImGuiWindow* window) @trusted
{
    igStartMouseMovingWindow(window);
}

void StopMouseMovingWindow() @trusted
{
    igStopMouseMovingWindow();
}

void UpdateMouseMovingWindowNewFrame() @trusted
{
    igUpdateMouseMovingWindowNewFrame();
}

void UpdateMouseMovingWindowEndFrame() @trusted
{
    igUpdateMouseMovingWindowEndFrame();
}

/++
+ Generic context hooks
+/
ImGuiID AddContextHook(ImGuiContext* context, ImGuiContextHook* hook) @trusted
{
    return igAddContextHook(context, hook);
}

void RemoveContextHook(scope ImGuiContext* context, ImGuiID hook_to_remove) @trusted
{
    igRemoveContextHook(context, hook_to_remove);
}

void CallContextHooks(scope ImGuiContext* context, ImGuiContextHookType type) @trusted
{
    igCallContextHooks(context, type);
}

/++
+ Viewports
+/
void ScaleWindowsInViewport(scope ImGuiViewportP* viewport, float scale) @trusted
{
    igScaleWindowsInViewport(viewport, scale);
}

void SetWindowViewport(scope ImGuiWindow* window, scope ImGuiViewportP* viewport) @trusted
{
    igSetWindowViewport(window, viewport);
}

/++
+ Settings
+/
void MarkIniSettingsDirty() @trusted
{
    igMarkIniSettingsDirty();
}

void MarkIniSettingsDirtyImGuiWindowPtr(scope ImGuiWindow* window) @trusted
{
    igMarkIniSettingsDirtyImGuiWindowPtr(window);
}

void ClearIniSettings() @trusted
{
    igClearIniSettings();
}

void AddSettingsHandler(ImGuiSettingsHandler* handler) @trusted
{
    igAddSettingsHandler(handler);
}

void RemoveSettingsHandler(const(char)* type_name) @trusted
{
    igRemoveSettingsHandler(type_name);
}

ImGuiSettingsHandler* FindSettingsHandler(const(char)* type_name) @trusted
{
    return igFindSettingsHandler(type_name);
}

/++
+ Settings  Windows
+/
ImGuiWindowSettings* CreateNewWindowSettings(const(char)* name) @trusted
{
    return igCreateNewWindowSettings(name);
}

ImGuiWindowSettings* FindWindowSettingsByID(ImGuiID id) @trusted
{
    return igFindWindowSettingsByID(id);
}

ImGuiWindowSettings* FindWindowSettingsByWindow(scope ImGuiWindow* window) @trusted
{
    return igFindWindowSettingsByWindow(window);
}

void ClearWindowSettings(const(char)* name) @trusted
{
    igClearWindowSettings(name);
}

/++
+ Localization
+/
void LocalizeRegisterEntries(ImGuiLocEntry* entries, int count) @trusted
{
    igLocalizeRegisterEntries(entries, count);
}

const(char)* LocalizeGetMsg(ImGuiLocKey key) @trusted
{
    return igLocalizeGetMsg(key);
}

/++
+ Scrolling
+/
void SetScrollXImGuiWindowPtr(scope ImGuiWindow* window, float scroll_x) @trusted
{
    igSetScrollXImGuiWindowPtr(window, scroll_x);
}

void SetScrollYImGuiWindowPtr(scope ImGuiWindow* window, float scroll_y) @trusted
{
    igSetScrollYImGuiWindowPtr(window, scroll_y);
}

void SetScrollFromPosXImGuiWindowPtr(scope ImGuiWindow* window, float local_x, float center_x_ratio) @trusted
{
    igSetScrollFromPosXImGuiWindowPtr(window, local_x, center_x_ratio);
}

void SetScrollFromPosYImGuiWindowPtr(scope ImGuiWindow* window, float local_y, float center_y_ratio) @trusted
{
    igSetScrollFromPosYImGuiWindowPtr(window, local_y, center_y_ratio);
}

/++
+ Early workinprogress API (ScrollToItem() will become public)
+/
void ScrollToItem(ImGuiScrollFlags flags) @trusted
{
    igScrollToItem(flags);
}

void ScrollToRect(scope ImGuiWindow* window, ImRect rect, ImGuiScrollFlags flags) @trusted
{
    igScrollToRect(window, rect, flags);
}

ImVec2 ScrollToRectEx(scope ImGuiWindow* window, ImRect rect, ImGuiScrollFlags flags) @trusted
{
    return igScrollToRectEx(window, rect, flags);
}

/++
+ #ifndef IMGUI_DISABLE_OBSOLETE_FUNCTIONS
+/
void ScrollToBringRectIntoView(scope ImGuiWindow* window, ImRect rect) @trusted
{
    igScrollToBringRectIntoView(window, rect);
}

/++
+ Basic Accessors
+/
ImGuiItemStatusFlags GetItemStatusFlags() @trusted
{
    return igGetItemStatusFlags();
}

ImGuiItemFlags GetItemFlags() @trusted
{
    return igGetItemFlags();
}

ImGuiID GetActiveID() @trusted
{
    return igGetActiveID();
}

ImGuiID GetFocusID() @trusted
{
    return igGetFocusID();
}

void SetActiveID(ImGuiID id, scope ImGuiWindow* window) @trusted
{
    igSetActiveID(id, window);
}

void SetFocusID(ImGuiID id, scope ImGuiWindow* window) @trusted
{
    igSetFocusID(id, window);
}

void ClearActiveID() @trusted
{
    igClearActiveID();
}

ImGuiID GetHoveredID() @trusted
{
    return igGetHoveredID();
}

void SetHoveredID(ImGuiID id) @trusted
{
    igSetHoveredID(id);
}

void KeepAliveID(ImGuiID id) @trusted
{
    igKeepAliveID(id);
}

void MarkItemEdited(ImGuiID id) @trusted
{
    igMarkItemEdited(id);
}

void PushOverrideID(ImGuiID id) @trusted
{
    igPushOverrideID(id);
}

ImGuiID GetIDWithSeedStr(const(char)* str_id_begin, const(char)* str_id_end, ImGuiID seed) @trusted
{
    return igGetIDWithSeedStr(str_id_begin, str_id_end, seed);
}

ImGuiID GetIDWithSeed(int n, ImGuiID seed) @trusted
{
    return igGetIDWithSeed(n, seed);
}

/++
+ Basic Helpers for widget code
+/
void ItemSize(ImVec2 size) @trusted
{
    igItemSize(size);
}

void ItemSizeEx(ImVec2 size, float text_baseline_y) @trusted
{
    igItemSizeEx(size, text_baseline_y);
}

void ItemSizeImRect(ImRect bb) @trusted
{
    igItemSizeImRect(bb);
}

void ItemSizeImRectEx(ImRect bb, float text_baseline_y) @trusted
{
    igItemSizeImRectEx(bb, text_baseline_y);
}

bool ItemAdd(ImRect bb, ImGuiID id) @trusted
{
    return igItemAdd(bb, id);
}

bool ItemAddEx(ImRect bb, ImGuiID id, ImRect* nav_bb, ImGuiItemFlags extra_flags) @trusted
{
    return igItemAddEx(bb, id, nav_bb, extra_flags);
}

bool ItemHoverable(ImRect bb, ImGuiID id, ImGuiItemFlags item_flags) @trusted
{
    return igItemHoverable(bb, id, item_flags);
}

bool IsWindowContentHoverable(scope ImGuiWindow* window, ImGuiHoveredFlags flags) @trusted
{
    return igIsWindowContentHoverable(window, flags);
}

bool IsClippedEx(ImRect bb, ImGuiID id) @trusted
{
    return igIsClippedEx(bb, id);
}

void SetLastItemData(ImGuiID item_id, ImGuiItemFlags item_flags, ImGuiItemStatusFlags status_flags, ImRect item_rect) @trusted
{
    igSetLastItemData(item_id, item_flags, status_flags, item_rect);
}

ImVec2 CalcItemSize(ImVec2 size, float default_w, float default_h) @trusted
{
    return igCalcItemSize(size, default_w, default_h);
}

float CalcWrapWidthForPos(ImVec2 pos, float wrap_pos_x) @trusted
{
    return igCalcWrapWidthForPos(pos, wrap_pos_x);
}

void PushMultiItemsWidths(int components, float width_full) @trusted
{
    igPushMultiItemsWidths(components, width_full);
}

void ShrinkWidths(scope ImGuiShrinkWidthItem* items, int count, float width_excess, float width_min) @trusted
{
    igShrinkWidths(items, count, width_excess, width_min);
}

/++
+ Parameter stacks (shared)
+/
const(ImGuiStyleVarInfo)* GetStyleVarInfo(ImGuiStyleVar idx) @trusted
{
    return igGetStyleVarInfo(idx);
}

void BeginDisabledOverrideReenable() @trusted
{
    igBeginDisabledOverrideReenable();
}

void EndDisabledOverrideReenable() @trusted
{
    igEndDisabledOverrideReenable();
}

/++
+ Logging/Capture
+/
void LogBegin(ImGuiLogFlags flags, int auto_open_depth) @trusted
{
    igLogBegin(flags, auto_open_depth);
}

void LogToBuffer() @trusted
{
    igLogToBuffer();
}

void LogToBufferEx(int auto_open_depth) @trusted
{
    igLogToBufferEx(auto_open_depth);
}

void LogRenderedText(ImVec2* ref_pos, const(char)* text) @trusted
{
    igLogRenderedText(ref_pos, text);
}

void LogRenderedTextEx(ImVec2* ref_pos, const(char)* text, const(char)* text_end) @trusted
{
    igLogRenderedTextEx(ref_pos, text, text_end);
}

void LogSetNextTextDecoration(const(char)* prefix, const(char)* suffix) @trusted
{
    igLogSetNextTextDecoration(prefix, suffix);
}

/++
+ Childs
+/
bool BeginChildEx(const(char)* name, ImGuiID id, ImVec2 size_arg, ImGuiChildFlags child_flags, ImGuiWindowFlags window_flags) @trusted
{
    return igBeginChildEx(name, id, size_arg, child_flags, window_flags);
}

/++
+ Popups, Modals
+/
bool BeginPopupEx(ImGuiID id, ImGuiWindowFlags extra_window_flags) @trusted
{
    return igBeginPopupEx(id, extra_window_flags);
}

bool BeginPopupMenuEx(ImGuiID id, const(char)* label, ImGuiWindowFlags extra_window_flags) @trusted
{
    return igBeginPopupMenuEx(id, label, extra_window_flags);
}

void OpenPopupEx(ImGuiID id) @trusted
{
    igOpenPopupEx(id);
}

void OpenPopupExEx(ImGuiID id, ImGuiPopupFlags popup_flags) @trusted
{
    igOpenPopupExEx(id, popup_flags);
}

void ClosePopupToLevel(int remaining, bool restore_focus_to_window_under_popup) @trusted
{
    igClosePopupToLevel(remaining, restore_focus_to_window_under_popup);
}

void ClosePopupsOverWindow(scope ImGuiWindow* ref_window, bool restore_focus_to_window_under_popup) @trusted
{
    igClosePopupsOverWindow(ref_window, restore_focus_to_window_under_popup);
}

void ClosePopupsExceptModals() @trusted
{
    igClosePopupsExceptModals();
}

bool IsPopupOpenID(ImGuiID id, ImGuiPopupFlags popup_flags) @trusted
{
    return igIsPopupOpenID(id, popup_flags);
}

ImRect GetPopupAllowedExtentRect(scope ImGuiWindow* window) @trusted
{
    return igGetPopupAllowedExtentRect(window);
}

ImGuiWindow* GetTopMostPopupModal() @trusted
{
    return igGetTopMostPopupModal();
}

ImGuiWindow* GetTopMostAndVisiblePopupModal() @trusted
{
    return igGetTopMostAndVisiblePopupModal();
}

ImGuiWindow* FindBlockingModal(scope ImGuiWindow* window) @trusted
{
    return igFindBlockingModal(window);
}

ImVec2 FindBestWindowPosForPopup(scope ImGuiWindow* window) @trusted
{
    return igFindBestWindowPosForPopup(window);
}

ImVec2 FindBestWindowPosForPopupEx(ImVec2 ref_pos, ImVec2 size, scope ImGuiDir* last_dir, ImRect r_outer, ImRect r_avoid, ImGuiPopupPositionPolicy policy) @trusted
{
    return igFindBestWindowPosForPopupEx(ref_pos, size, last_dir, r_outer, r_avoid, policy);
}

/++
+ Tooltips
+/
bool BeginTooltipEx(ImGuiTooltipFlags tooltip_flags, ImGuiWindowFlags extra_window_flags) @trusted
{
    return igBeginTooltipEx(tooltip_flags, extra_window_flags);
}

bool BeginTooltipHidden() @trusted
{
    return igBeginTooltipHidden();
}

/++
+ Menus
+/
bool BeginViewportSideBar(const(char)* name, scope ImGuiViewport* viewport, ImGuiDir dir, float size, ImGuiWindowFlags window_flags) @trusted
{
    return igBeginViewportSideBar(name, viewport, dir, size, window_flags);
}

bool BeginMenuWithIcon(const(char)* label, const(char)* icon) @trusted
{
    return igBeginMenuWithIcon(label, icon);
}

bool BeginMenuWithIconEx(const(char)* label, const(char)* icon, bool enabled) @trusted
{
    return igBeginMenuWithIconEx(label, icon, enabled);
}

bool MenuItemWithIcon(const(char)* label, const(char)* icon) @trusted
{
    return igMenuItemWithIcon(label, icon);
}

bool MenuItemWithIconEx(const(char)* label, const(char)* icon, const(char)* shortcut, bool selected, bool enabled) @trusted
{
    return igMenuItemWithIconEx(label, icon, shortcut, selected, enabled);
}

/++
+ Combos
+/
bool BeginComboPopup(ImGuiID popup_id, ImRect bb, ImGuiComboFlags flags) @trusted
{
    return igBeginComboPopup(popup_id, bb, flags);
}

bool BeginComboPreview() @trusted
{
    return igBeginComboPreview();
}

void EndComboPreview() @trusted
{
    igEndComboPreview();
}

/++
+ Keyboard/Gamepad Navigation
+/
void NavInitWindow(scope ImGuiWindow* window, bool force_reinit) @trusted
{
    igNavInitWindow(window, force_reinit);
}

void NavInitRequestApplyResult() @trusted
{
    igNavInitRequestApplyResult();
}

bool NavMoveRequestButNoResultYet() @trusted
{
    return igNavMoveRequestButNoResultYet();
}

void NavMoveRequestSubmit(ImGuiDir move_dir, ImGuiDir clip_dir, ImGuiNavMoveFlags move_flags, ImGuiScrollFlags scroll_flags) @trusted
{
    igNavMoveRequestSubmit(move_dir, clip_dir, move_flags, scroll_flags);
}

void NavMoveRequestForward(ImGuiDir move_dir, ImGuiDir clip_dir, ImGuiNavMoveFlags move_flags, ImGuiScrollFlags scroll_flags) @trusted
{
    igNavMoveRequestForward(move_dir, clip_dir, move_flags, scroll_flags);
}

void NavMoveRequestResolveWithLastItem(scope ImGuiNavItemData* result) @trusted
{
    igNavMoveRequestResolveWithLastItem(result);
}

void NavMoveRequestResolveWithPastTreeNode(ImGuiNavItemData* result, ImGuiTreeNodeStackData* tree_node_data) @trusted
{
    igNavMoveRequestResolveWithPastTreeNode(result, tree_node_data);
}

void NavMoveRequestCancel() @trusted
{
    igNavMoveRequestCancel();
}

void NavMoveRequestApplyResult() @trusted
{
    igNavMoveRequestApplyResult();
}

void NavMoveRequestTryWrapping(scope ImGuiWindow* window, ImGuiNavMoveFlags move_flags) @trusted
{
    igNavMoveRequestTryWrapping(window, move_flags);
}

void NavHighlightActivated(ImGuiID id) @trusted
{
    igNavHighlightActivated(id);
}

void NavClearPreferredPosForAxis(ImGuiAxis axis) @trusted
{
    igNavClearPreferredPosForAxis(axis);
}

void SetNavCursorVisibleAfterMove() @trusted
{
    igSetNavCursorVisibleAfterMove();
}

void NavUpdateCurrentWindowIsScrollPushableX() @trusted
{
    igNavUpdateCurrentWindowIsScrollPushableX();
}

void SetNavWindow(scope ImGuiWindow* window) @trusted
{
    igSetNavWindow(window);
}

void SetNavID(ImGuiID id, ImGuiNavLayer nav_layer, ImGuiID focus_scope_id, ImRect rect_rel) @trusted
{
    igSetNavID(id, nav_layer, focus_scope_id, rect_rel);
}

void SetNavFocusScope(ImGuiID focus_scope_id) @trusted
{
    igSetNavFocusScope(focus_scope_id);
}

/++
+ Focus/Activation
+ This should be part of a larger set of API: FocusItem(offset = 1), FocusItemByID(id), ActivateItem(offset = 1), ActivateItemByID(id) etc. which are
+ much harder to design and implement than expected. I have a couple of private branches on this matter but it's not simple. For now implementing the easy ones.
+/
void FocusItem() @trusted
{
    igFocusItem();
}

void ActivateItemByID(ImGuiID id) @trusted
{
    igActivateItemByID(id);
}

/++
+ Inputs
+ FIXME: Eventually we should aim to move e.g. IsActiveIdUsingKey() into IsKeyXXX functions.
+/
bool IsNamedKey(ImGuiKey key) @trusted
{
    return igIsNamedKey(key);
}

bool IsNamedKeyOrMod(ImGuiKey key) @trusted
{
    return igIsNamedKeyOrMod(key);
}

bool IsLegacyKey(ImGuiKey key) @trusted
{
    return igIsLegacyKey(key);
}

bool IsKeyboardKey(ImGuiKey key) @trusted
{
    return igIsKeyboardKey(key);
}

bool IsGamepadKey(ImGuiKey key) @trusted
{
    return igIsGamepadKey(key);
}

bool IsMouseKey(ImGuiKey key) @trusted
{
    return igIsMouseKey(key);
}

bool IsAliasKey(ImGuiKey key) @trusted
{
    return igIsAliasKey(key);
}

bool IsLRModKey(ImGuiKey key) @trusted
{
    return igIsLRModKey(key);
}

ImGuiKeyChord FixupKeyChord(ImGuiKeyChord key_chord) @trusted
{
    return igFixupKeyChord(key_chord);
}

ImGuiKey ConvertSingleModFlagToKey(ImGuiKey key) @trusted
{
    return igConvertSingleModFlagToKey(key);
}

ImGuiKeyData* GetKeyDataImGuiContextPtr(scope ImGuiContext* ctx, ImGuiKey key) @trusted
{
    return igGetKeyDataImGuiContextPtr(ctx, key);
}

ImGuiKeyData* GetKeyData(ImGuiKey key) @trusted
{
    return igGetKeyData(key);
}

const(char)* GetKeyChordName(ImGuiKeyChord key_chord) @trusted
{
    return igGetKeyChordName(key_chord);
}

ImGuiKey MouseButtonToKey(ImGuiMouseButton button) @trusted
{
    return igMouseButtonToKey(button);
}

bool IsMouseDragPastThreshold(ImGuiMouseButton button) @trusted
{
    return igIsMouseDragPastThreshold(button);
}

bool IsMouseDragPastThresholdEx(ImGuiMouseButton button, float lock_threshold) @trusted
{
    return igIsMouseDragPastThresholdEx(button, lock_threshold);
}

ImVec2 GetKeyMagnitude2d(ImGuiKey key_left, ImGuiKey key_right, ImGuiKey key_up, ImGuiKey key_down) @trusted
{
    return igGetKeyMagnitude2d(key_left, key_right, key_up, key_down);
}

float GetNavTweakPressedAmount(ImGuiAxis axis) @trusted
{
    return igGetNavTweakPressedAmount(axis);
}

int CalcTypematicRepeatAmount(float t0, float t1, float repeat_delay, float repeat_rate) @trusted
{
    return igCalcTypematicRepeatAmount(t0, t1, repeat_delay, repeat_rate);
}

void GetTypematicRepeatRate(ImGuiInputFlags flags, scope float* repeat_delay, scope float* repeat_rate) @trusted
{
    igGetTypematicRepeatRate(flags, repeat_delay, repeat_rate);
}

void TeleportMousePos(ImVec2 pos) @trusted
{
    igTeleportMousePos(pos);
}

void SetActiveIdUsingAllKeyboardKeys() @trusted
{
    igSetActiveIdUsingAllKeyboardKeys();
}

bool IsActiveIdUsingNavDir(ImGuiDir dir) @trusted
{
    return igIsActiveIdUsingNavDir(dir);
}

/++
+ [EXPERIMENTAL] LowLevel: Key/Input Ownership
+  The idea is that instead of "eating" a given input, we can link to an owner id.
+  Ownership is most often claimed as a result of reacting to a press/down event (but occasionally may be claimed ahead).
+  Input queries can then read input by specifying ImGuiKeyOwner_Any (== 0), ImGuiKeyOwner_NoOwner (== 1) or a custom ID.
+  Legacy input queries (without specifying an owner or _Any or _None) are equivalent to using ImGuiKeyOwner_Any (== 0).
+  Input ownership is automatically released on the frame after a key is released. Therefore:
+  for ownership registration happening as a result of a down/press event, the SetKeyOwner() call may be done once (common case).
+  for ownership registration happening ahead of a down/press event, the SetKeyOwner() call needs to be made every frame (happens if e.g. claiming ownership on hover).
+  SetItemKeyOwner() is a shortcut for common simple case. A custom widget will probably want to call SetKeyOwner() multiple times directly based on its interaction state.
+  This is marked experimental because not all widgets are fully honoring the Set/Test idioms. We will need to move forward step by step.
+ Please open a GitHub Issue to submit your usage scenario or if there's a use case you need solved.
+/
ImGuiID GetKeyOwner(ImGuiKey key) @trusted
{
    return igGetKeyOwner(key);
}

void SetKeyOwner(ImGuiKey key, ImGuiID owner_id, ImGuiInputFlags flags) @trusted
{
    igSetKeyOwner(key, owner_id, flags);
}

void SetKeyOwnersForKeyChord(ImGuiKeyChord key, ImGuiID owner_id, ImGuiInputFlags flags) @trusted
{
    igSetKeyOwnersForKeyChord(key, owner_id, flags);
}

void SetItemKeyOwnerImGuiInputFlags(ImGuiKey key, ImGuiInputFlags flags) @trusted
{
    igSetItemKeyOwnerImGuiInputFlags(key, flags);
}

bool TestKeyOwner(ImGuiKey key, ImGuiID owner_id) @trusted
{
    return igTestKeyOwner(key, owner_id);
}

ImGuiKeyOwnerData* GetKeyOwnerData(scope ImGuiContext* ctx, ImGuiKey key) @trusted
{
    return igGetKeyOwnerData(ctx, key);
}

/++
+ [EXPERIMENTAL] HighLevel: Input Access functions w/ support for Key/Input Ownership
+  Important: legacy IsKeyPressed(ImGuiKey, bool repeat=true) _DEFAULTS_ to repeat, new IsKeyPressed() requires _EXPLICIT_ ImGuiInputFlags_Repeat flag.
+  Expected to be later promoted to public API, the prototypes are designed to replace existing ones (since owner_id can default to Any == 0)
+  Specifying a value for 'ImGuiID owner' will test that EITHER the key is NOT owned (UNLESS locked), EITHER the key is owned by 'owner'.
+ Legacy functions use ImGuiKeyOwner_Any meaning that they typically ignore ownership, unless a call to SetKeyOwner() explicitly used ImGuiInputFlags_LockThisFrame or ImGuiInputFlags_LockUntilRelease.
+  Binding generators may want to ignore those for now, or suffix them with Ex() until we decide if this gets moved into public API.
+/
bool IsKeyDownID(ImGuiKey key, ImGuiID owner_id) @trusted
{
    return igIsKeyDownID(key, owner_id);
}

bool IsKeyPressedImGuiInputFlags(ImGuiKey key, ImGuiInputFlags flags) @trusted
{
    return igIsKeyPressedImGuiInputFlags(key, flags);
}

bool IsKeyPressedImGuiInputFlagsEx(ImGuiKey key, ImGuiInputFlags flags, ImGuiID owner_id) @trusted
{
    return igIsKeyPressedImGuiInputFlagsEx(key, flags, owner_id);
}

bool IsKeyReleasedID(ImGuiKey key, ImGuiID owner_id) @trusted
{
    return igIsKeyReleasedID(key, owner_id);
}

bool IsKeyChordPressedImGuiInputFlags(ImGuiKeyChord key_chord, ImGuiInputFlags flags) @trusted
{
    return igIsKeyChordPressedImGuiInputFlags(key_chord, flags);
}

bool IsKeyChordPressedImGuiInputFlagsEx(ImGuiKeyChord key_chord, ImGuiInputFlags flags, ImGuiID owner_id) @trusted
{
    return igIsKeyChordPressedImGuiInputFlagsEx(key_chord, flags, owner_id);
}

bool IsMouseDownID(ImGuiMouseButton button, ImGuiID owner_id) @trusted
{
    return igIsMouseDownID(button, owner_id);
}

bool IsMouseClickedImGuiInputFlags(ImGuiMouseButton button, ImGuiInputFlags flags) @trusted
{
    return igIsMouseClickedImGuiInputFlags(button, flags);
}

bool IsMouseClickedImGuiInputFlagsEx(ImGuiMouseButton button, ImGuiInputFlags flags, ImGuiID owner_id) @trusted
{
    return igIsMouseClickedImGuiInputFlagsEx(button, flags, owner_id);
}

bool IsMouseReleasedID(ImGuiMouseButton button, ImGuiID owner_id) @trusted
{
    return igIsMouseReleasedID(button, owner_id);
}

bool IsMouseDoubleClickedID(ImGuiMouseButton button, ImGuiID owner_id) @trusted
{
    return igIsMouseDoubleClickedID(button, owner_id);
}

/++
+ Shortcut Testing
+ &
+ Routing
+  Set Shortcut() and SetNextItemShortcut() in imgui.h
+  When a policy (except for ImGuiInputFlags_RouteAlways *) is set, Shortcut() will register itself with SetShortcutRouting(),
+ allowing the system to decide where to route the input among other routeaware calls.
+ (* using ImGuiInputFlags_RouteAlways is roughly equivalent to calling IsKeyChordPressed(key) and bypassing route registration and check)
+  When using one of the routing option:
+  The default route is ImGuiInputFlags_RouteFocused (accept inputs if window is in focus stack. Deepmost focused window takes inputs. ActiveId takes inputs over deepmost focused window.)
+  Routes are requested given a chord (key + modifiers) and a routing policy.
+  Routes are resolved during NewFrame(): if keyboard modifiers are matching current ones: SetKeyOwner() is called + route is granted for the frame.
+  Each route may be granted to a single owner. When multiple requests are made we have policies to select the winning route (e.g. deep most window).
+  Multiple read sites may use the same owner id can all access the granted route.
+  When owner_id is 0 we use the current Focus Scope ID as a owner ID in order to identify our location.
+  You can chain two unrelated windows in the focus stack using SetWindowParentWindowForFocusRoute()
+ e.g. if you have a tool window associated to a document, and you want document shortcuts to run when the tool is focused.
+/
bool ShortcutID(ImGuiKeyChord key_chord, ImGuiInputFlags flags, ImGuiID owner_id) @trusted
{
    return igShortcutID(key_chord, flags, owner_id);
}

bool SetShortcutRouting(ImGuiKeyChord key_chord, ImGuiInputFlags flags, ImGuiID owner_id) @trusted
{
    return igSetShortcutRouting(key_chord, flags, owner_id);
}

bool TestShortcutRouting(ImGuiKeyChord key_chord, ImGuiID owner_id) @trusted
{
    return igTestShortcutRouting(key_chord, owner_id);
}

ImGuiKeyRoutingData* GetShortcutRoutingData(ImGuiKeyChord key_chord) @trusted
{
    return igGetShortcutRoutingData(key_chord);
}

/++
+ [EXPERIMENTAL] Focus Scope
+ This is generally used to identify a unique input location (for e.g. a selection set)
+ There is one per window (automatically set in Begin), but:
+  Selection patterns generally need to react (e.g. clear a selection) when landing on one item of the set.
+ So in order to identify a set multiple lists in same window may each need a focus scope.
+ If you imagine an hypothetical BeginSelectionGroup()/EndSelectionGroup() api, it would likely call PushFocusScope()/EndFocusScope()
+  Shortcut routing also use focus scope as a default location identifier if an owner is not provided.
+ We don't use the ID Stack for this as it is common to want them separate.
+/
void PushFocusScope(ImGuiID id) @trusted
{
    igPushFocusScope(id);
}

void PopFocusScope() @trusted
{
    igPopFocusScope();
}

ImGuiID GetCurrentFocusScope() @trusted
{
    return igGetCurrentFocusScope();
}

/++
+ Drag and Drop
+/
bool IsDragDropActive() @trusted
{
    return igIsDragDropActive();
}

bool BeginDragDropTargetCustom(ImRect bb, ImGuiID id) @trusted
{
    return igBeginDragDropTargetCustom(bb, id);
}

void ClearDragDrop() @trusted
{
    igClearDragDrop();
}

bool IsDragDropPayloadBeingAccepted() @trusted
{
    return igIsDragDropPayloadBeingAccepted();
}

void RenderDragDropTargetRect(ImRect bb, ImRect item_clip_rect) @trusted
{
    igRenderDragDropTargetRect(bb, item_clip_rect);
}

/++
+ TypingSelect API
+ (provide Windows Explorer style "select items by typing partial name" + "cycle through items by typing same letter" feature)
+ (this is currently not documented nor used by main library, but should work. See "widgets_typingselect" in imgui_test_suite for usage code. Please let us know if you use this!)
+/
ImGuiTypingSelectRequest* GetTypingSelectRequest() @trusted
{
    return igGetTypingSelectRequest();
}

ImGuiTypingSelectRequest* GetTypingSelectRequestEx(ImGuiTypingSelectFlags flags) @trusted
{
    return igGetTypingSelectRequestEx(flags);
}

int TypingSelectFindMatch(scope ImGuiTypingSelectRequest* req, int items_count, ImGuiGetterCallback get_item_name_func, scope void* user_data, int nav_item_idx) @trusted
{
    return igTypingSelectFindMatch(req, items_count, get_item_name_func, user_data, nav_item_idx);
}

int TypingSelectFindNextSingleCharMatch(scope ImGuiTypingSelectRequest* req, int items_count, ImGuiGetterCallback get_item_name_func, scope void* user_data, int nav_item_idx) @trusted
{
    return igTypingSelectFindNextSingleCharMatch(req, items_count, get_item_name_func, user_data, nav_item_idx);
}

int TypingSelectFindBestLeadingMatch(scope ImGuiTypingSelectRequest* req, int items_count, ImGuiGetterCallback get_item_name_func, scope void* user_data) @trusted
{
    return igTypingSelectFindBestLeadingMatch(req, items_count, get_item_name_func, user_data);
}

/++
+ BoxSelect API
+/
bool BeginBoxSelect(ImRect scope_rect, scope ImGuiWindow* window, ImGuiID box_select_id, ImGuiMultiSelectFlags ms_flags) @trusted
{
    return igBeginBoxSelect(scope_rect, window, box_select_id, ms_flags);
}

void EndBoxSelect(ImRect scope_rect, ImGuiMultiSelectFlags ms_flags) @trusted
{
    igEndBoxSelect(scope_rect, ms_flags);
}

/++
+ MultiSelect API
+/
void MultiSelectItemHeader(ImGuiID id, scope bool* p_selected, scope ImGuiButtonFlags* p_button_flags) @trusted
{
    igMultiSelectItemHeader(id, p_selected, p_button_flags);
}

void MultiSelectItemFooter(ImGuiID id, scope bool* p_selected, scope bool* p_pressed) @trusted
{
    igMultiSelectItemFooter(id, p_selected, p_pressed);
}

void MultiSelectAddSetAll(scope ImGuiMultiSelectTempData* ms, bool selected) @trusted
{
    igMultiSelectAddSetAll(ms, selected);
}

void MultiSelectAddSetRange(scope ImGuiMultiSelectTempData* ms, bool selected, int range_dir, ImGuiSelectionUserData first_item, ImGuiSelectionUserData last_item) @trusted
{
    igMultiSelectAddSetRange(ms, selected, range_dir, first_item, last_item);
}

ImGuiBoxSelectState* GetBoxSelectState(ImGuiID id) @trusted
{
    return igGetBoxSelectState(id);
}

ImGuiMultiSelectState* GetMultiSelectState(ImGuiID id) @trusted
{
    return igGetMultiSelectState(id);
}

/++
+ Internal Columns API (this is not exposed because we will encourage transitioning to the Tables API)
+/
void SetWindowClipRectBeforeSetChannel(scope ImGuiWindow* window, ImRect clip_rect) @trusted
{
    igSetWindowClipRectBeforeSetChannel(window, clip_rect);
}

void BeginColumns(const(char)* str_id, int count, ImGuiOldColumnFlags flags) @trusted
{
    igBeginColumns(str_id, count, flags);
}

void EndColumns() @trusted
{
    igEndColumns();
}

void PushColumnClipRect(int column_index) @trusted
{
    igPushColumnClipRect(column_index);
}

void PushColumnsBackground() @trusted
{
    igPushColumnsBackground();
}

void PopColumnsBackground() @trusted
{
    igPopColumnsBackground();
}

ImGuiID GetColumnsID(const(char)* str_id, int count) @trusted
{
    return igGetColumnsID(str_id, count);
}

ImGuiOldColumns* FindOrCreateColumns(scope ImGuiWindow* window, ImGuiID id) @trusted
{
    return igFindOrCreateColumns(window, id);
}

float GetColumnOffsetFromNorm(ImGuiOldColumns* columns, float offset_norm) @trusted
{
    return igGetColumnOffsetFromNorm(columns, offset_norm);
}

float GetColumnNormFromOffset(ImGuiOldColumns* columns, float offset) @trusted
{
    return igGetColumnNormFromOffset(columns, offset);
}

/++
+ Tables: Candidates for public API
+/
void TableOpenContextMenu() @trusted
{
    igTableOpenContextMenu();
}

void TableOpenContextMenuEx(int column_n) @trusted
{
    igTableOpenContextMenuEx(column_n);
}

void TableSetColumnWidth(int column_n, float width) @trusted
{
    igTableSetColumnWidth(column_n, width);
}

void TableSetColumnSortDirection(int column_n, ImGuiSortDirection sort_direction, bool append_to_sort_specs) @trusted
{
    igTableSetColumnSortDirection(column_n, sort_direction, append_to_sort_specs);
}

int TableGetHoveredRow() @trusted
{
    return igTableGetHoveredRow();
}

float TableGetHeaderRowHeight() @trusted
{
    return igTableGetHeaderRowHeight();
}

float TableGetHeaderAngledMaxLabelWidth() @trusted
{
    return igTableGetHeaderAngledMaxLabelWidth();
}

void TablePushBackgroundChannel() @trusted
{
    igTablePushBackgroundChannel();
}

void TablePopBackgroundChannel() @trusted
{
    igTablePopBackgroundChannel();
}

void TablePushColumnChannel(int column_n) @trusted
{
    igTablePushColumnChannel(column_n);
}

void TablePopColumnChannel() @trusted
{
    igTablePopColumnChannel();
}

void TableAngledHeadersRowEx(ImGuiID row_id, float angle, float max_label_width, ImGuiTableHeaderData* data, int data_count) @trusted
{
    igTableAngledHeadersRowEx(row_id, angle, max_label_width, data, data_count);
}

/++
+ Tables: Internals
+/
ImGuiTable* GetCurrentTable() @trusted
{
    return igGetCurrentTable();
}

ImGuiTable* TableFindByID(ImGuiID id) @trusted
{
    return igTableFindByID(id);
}

bool BeginTableWithID(const(char)* name, ImGuiID id, int columns_count, ImGuiTableFlags flags) @trusted
{
    return igBeginTableWithID(name, id, columns_count, flags);
}

bool BeginTableWithIDEx(const(char)* name, ImGuiID id, int columns_count, ImGuiTableFlags flags, ImVec2 outer_size, float inner_width) @trusted
{
    return igBeginTableWithIDEx(name, id, columns_count, flags, outer_size, inner_width);
}

void TableBeginInitMemory(scope ImGuiTable* table, int columns_count) @trusted
{
    igTableBeginInitMemory(table, columns_count);
}

void TableBeginApplyRequests(scope ImGuiTable* table) @trusted
{
    igTableBeginApplyRequests(table);
}

void TableSetupDrawChannels(scope ImGuiTable* table) @trusted
{
    igTableSetupDrawChannels(table);
}

void TableUpdateLayout(scope ImGuiTable* table) @trusted
{
    igTableUpdateLayout(table);
}

void TableUpdateBorders(scope ImGuiTable* table) @trusted
{
    igTableUpdateBorders(table);
}

void TableUpdateColumnsWeightFromWidth(scope ImGuiTable* table) @trusted
{
    igTableUpdateColumnsWeightFromWidth(table);
}

void TableDrawBorders(scope ImGuiTable* table) @trusted
{
    igTableDrawBorders(table);
}

void TableDrawDefaultContextMenu(scope ImGuiTable* table, ImGuiTableFlags flags_for_section_to_display) @trusted
{
    igTableDrawDefaultContextMenu(table, flags_for_section_to_display);
}

bool TableBeginContextMenuPopup(scope ImGuiTable* table) @trusted
{
    return igTableBeginContextMenuPopup(table);
}

void TableMergeDrawChannels(scope ImGuiTable* table) @trusted
{
    igTableMergeDrawChannels(table);
}

ImGuiTableInstanceData* TableGetInstanceData(scope ImGuiTable* table, int instance_no) @trusted
{
    return igTableGetInstanceData(table, instance_no);
}

ImGuiID TableGetInstanceID(scope ImGuiTable* table, int instance_no) @trusted
{
    return igTableGetInstanceID(table, instance_no);
}

void TableSortSpecsSanitize(scope ImGuiTable* table) @trusted
{
    igTableSortSpecsSanitize(table);
}

void TableSortSpecsBuild(scope ImGuiTable* table) @trusted
{
    igTableSortSpecsBuild(table);
}

ImGuiSortDirection TableGetColumnNextSortDirection(scope ImGuiTableColumn* column) @trusted
{
    return igTableGetColumnNextSortDirection(column);
}

void TableFixColumnSortDirection(scope ImGuiTable* table, scope ImGuiTableColumn* column) @trusted
{
    igTableFixColumnSortDirection(table, column);
}

float TableGetColumnWidthAuto(scope ImGuiTable* table, scope ImGuiTableColumn* column) @trusted
{
    return igTableGetColumnWidthAuto(table, column);
}

void TableBeginRow(scope ImGuiTable* table) @trusted
{
    igTableBeginRow(table);
}

void TableEndRow(scope ImGuiTable* table) @trusted
{
    igTableEndRow(table);
}

void TableBeginCell(scope ImGuiTable* table, int column_n) @trusted
{
    igTableBeginCell(table, column_n);
}

void TableEndCell(scope ImGuiTable* table) @trusted
{
    igTableEndCell(table);
}

ImRect TableGetCellBgRect(ImGuiTable* table, int column_n) @trusted
{
    return igTableGetCellBgRect(table, column_n);
}

const(char)* TableGetColumnNameImGuiTablePtr(ImGuiTable* table, int column_n) @trusted
{
    return igTableGetColumnNameImGuiTablePtr(table, column_n);
}

ImGuiID TableGetColumnResizeID(scope ImGuiTable* table, int column_n) @trusted
{
    return igTableGetColumnResizeID(table, column_n);
}

ImGuiID TableGetColumnResizeIDEx(scope ImGuiTable* table, int column_n, int instance_no) @trusted
{
    return igTableGetColumnResizeIDEx(table, column_n, instance_no);
}

float TableCalcMaxColumnWidth(ImGuiTable* table, int column_n) @trusted
{
    return igTableCalcMaxColumnWidth(table, column_n);
}

void TableSetColumnWidthAutoSingle(scope ImGuiTable* table, int column_n) @trusted
{
    igTableSetColumnWidthAutoSingle(table, column_n);
}

void TableSetColumnWidthAutoAll(scope ImGuiTable* table) @trusted
{
    igTableSetColumnWidthAutoAll(table);
}

void TableRemove(scope ImGuiTable* table) @trusted
{
    igTableRemove(table);
}

void TableGcCompactTransientBuffers(scope ImGuiTable* table) @trusted
{
    igTableGcCompactTransientBuffers(table);
}

void TableGcCompactTransientBuffersImGuiTableTempDataPtr(scope ImGuiTableTempData* table) @trusted
{
    igTableGcCompactTransientBuffersImGuiTableTempDataPtr(table);
}

void TableGcCompactSettings() @trusted
{
    igTableGcCompactSettings();
}

/++
+ Tables: Settings
+/
void TableLoadSettings(scope ImGuiTable* table) @trusted
{
    igTableLoadSettings(table);
}

void TableSaveSettings(scope ImGuiTable* table) @trusted
{
    igTableSaveSettings(table);
}

void TableResetSettings(scope ImGuiTable* table) @trusted
{
    igTableResetSettings(table);
}

ImGuiTableSettings* TableGetBoundSettings(scope ImGuiTable* table) @trusted
{
    return igTableGetBoundSettings(table);
}

void TableSettingsAddSettingsHandler() @trusted
{
    igTableSettingsAddSettingsHandler();
}

ImGuiTableSettings* TableSettingsCreate(ImGuiID id, int columns_count) @trusted
{
    return igTableSettingsCreate(id, columns_count);
}

ImGuiTableSettings* TableSettingsFindByID(ImGuiID id) @trusted
{
    return igTableSettingsFindByID(id);
}

/++
+ Tab Bars
+/
ImGuiTabBar* GetCurrentTabBar() @trusted
{
    return igGetCurrentTabBar();
}

bool BeginTabBarEx(scope ImGuiTabBar* tab_bar, ImRect bb, ImGuiTabBarFlags flags) @trusted
{
    return igBeginTabBarEx(tab_bar, bb, flags);
}

ImGuiTabItem* TabBarFindTabByID(scope ImGuiTabBar* tab_bar, ImGuiID tab_id) @trusted
{
    return igTabBarFindTabByID(tab_bar, tab_id);
}

ImGuiTabItem* TabBarFindTabByOrder(scope ImGuiTabBar* tab_bar, int order) @trusted
{
    return igTabBarFindTabByOrder(tab_bar, order);
}

ImGuiTabItem* TabBarGetCurrentTab(scope ImGuiTabBar* tab_bar) @trusted
{
    return igTabBarGetCurrentTab(tab_bar);
}

int TabBarGetTabOrder(scope ImGuiTabBar* tab_bar, scope ImGuiTabItem* tab) @trusted
{
    return igTabBarGetTabOrder(tab_bar, tab);
}

const(char)* TabBarGetTabName(scope ImGuiTabBar* tab_bar, scope ImGuiTabItem* tab) @trusted
{
    return igTabBarGetTabName(tab_bar, tab);
}

void TabBarRemoveTab(scope ImGuiTabBar* tab_bar, ImGuiID tab_id) @trusted
{
    igTabBarRemoveTab(tab_bar, tab_id);
}

void TabBarCloseTab(scope ImGuiTabBar* tab_bar, scope ImGuiTabItem* tab) @trusted
{
    igTabBarCloseTab(tab_bar, tab);
}

void TabBarQueueFocus(scope ImGuiTabBar* tab_bar, scope ImGuiTabItem* tab) @trusted
{
    igTabBarQueueFocus(tab_bar, tab);
}

void TabBarQueueFocusStr(scope ImGuiTabBar* tab_bar, const(char)* tab_name) @trusted
{
    igTabBarQueueFocusStr(tab_bar, tab_name);
}

void TabBarQueueReorder(scope ImGuiTabBar* tab_bar, scope ImGuiTabItem* tab, int offset) @trusted
{
    igTabBarQueueReorder(tab_bar, tab, offset);
}

void TabBarQueueReorderFromMousePos(scope ImGuiTabBar* tab_bar, scope ImGuiTabItem* tab, ImVec2 mouse_pos) @trusted
{
    igTabBarQueueReorderFromMousePos(tab_bar, tab, mouse_pos);
}

bool TabBarProcessReorder(scope ImGuiTabBar* tab_bar) @trusted
{
    return igTabBarProcessReorder(tab_bar);
}

bool TabItemEx(scope ImGuiTabBar* tab_bar, const(char)* label, scope bool* p_open, ImGuiTabItemFlags flags, scope ImGuiWindow* docked_window) @trusted
{
    return igTabItemEx(tab_bar, label, p_open, flags, docked_window);
}

void TabItemSpacing(const(char)* str_id, ImGuiTabItemFlags flags, float width) @trusted
{
    igTabItemSpacing(str_id, flags, width);
}

ImVec2 TabItemCalcSizeStr(const(char)* label, bool has_close_button_or_unsaved_marker) @trusted
{
    return igTabItemCalcSizeStr(label, has_close_button_or_unsaved_marker);
}

ImVec2 TabItemCalcSize(scope ImGuiWindow* window) @trusted
{
    return igTabItemCalcSize(window);
}

void TabItemBackground(scope ImDrawList* draw_list, ImRect bb, ImGuiTabItemFlags flags, ImU32 col) @trusted
{
    igTabItemBackground(draw_list, bb, flags, col);
}

void TabItemLabelAndCloseButton(scope ImDrawList* draw_list, ImRect bb, ImGuiTabItemFlags flags, ImVec2 frame_padding, const(char)* label, ImGuiID tab_id, ImGuiID close_button_id, bool is_contents_visible, scope bool* out_just_closed, scope bool* out_text_clipped) @trusted
{
    igTabItemLabelAndCloseButton(draw_list, bb, flags, frame_padding, label, tab_id, close_button_id, is_contents_visible, out_just_closed, out_text_clipped);
}

/++
+ Render helpers
+ AVOID USING OUTSIDE OF IMGUI.CPP! NOT FOR PUBLIC CONSUMPTION. THOSE FUNCTIONS ARE A MESS. THEIR SIGNATURE AND BEHAVIOR WILL CHANGE, THEY NEED TO BE REFACTORED INTO SOMETHING DECENT.
+ NB: All position are in absolute pixels coordinates (we are never using window coordinates internally)
+/
void RenderText(ImVec2 pos, const(char)* text) @trusted
{
    igRenderText(pos, text);
}

void RenderTextEx(ImVec2 pos, const(char)* text, const(char)* text_end, bool hide_text_after_hash) @trusted
{
    igRenderTextEx(pos, text, text_end, hide_text_after_hash);
}

void RenderTextWrapped(ImVec2 pos, const(char)* text, const(char)* text_end, float wrap_width) @trusted
{
    igRenderTextWrapped(pos, text, text_end, wrap_width);
}

void RenderTextClipped(ImVec2 pos_min, ImVec2 pos_max, const(char)* text, const(char)* text_end, ImVec2* text_size_if_known) @trusted
{
    igRenderTextClipped(pos_min, pos_max, text, text_end, text_size_if_known);
}

void RenderTextClippedEx(ImVec2 pos_min, ImVec2 pos_max, const(char)* text, const(char)* text_end, ImVec2* text_size_if_known, ImVec2 align_, ImRect* clip_rect) @trusted
{
    igRenderTextClippedEx(pos_min, pos_max, text, text_end, text_size_if_known, align_, clip_rect);
}

void RenderTextClippedWithDrawList(ImDrawList* draw_list, ImVec2 pos_min, ImVec2 pos_max, const(char)* text, const(char)* text_end, ImVec2* text_size_if_known) @trusted
{
    igRenderTextClippedWithDrawList(draw_list, pos_min, pos_max, text, text_end, text_size_if_known);
}

void RenderTextClippedWithDrawListEx(ImDrawList* draw_list, ImVec2 pos_min, ImVec2 pos_max, const(char)* text, const(char)* text_end, ImVec2* text_size_if_known, ImVec2 align_, ImRect* clip_rect) @trusted
{
    igRenderTextClippedWithDrawListEx(draw_list, pos_min, pos_max, text, text_end, text_size_if_known, align_, clip_rect);
}

void RenderTextEllipsis(ImDrawList* draw_list, ImVec2 pos_min, ImVec2 pos_max, float ellipsis_max_x, const(char)* text, const(char)* text_end, ImVec2* text_size_if_known) @trusted
{
    igRenderTextEllipsis(draw_list, pos_min, pos_max, ellipsis_max_x, text, text_end, text_size_if_known);
}

void RenderFrame(ImVec2 p_min, ImVec2 p_max, ImU32 fill_col) @trusted
{
    igRenderFrame(p_min, p_max, fill_col);
}

void RenderFrameEx(ImVec2 p_min, ImVec2 p_max, ImU32 fill_col, bool borders, float rounding) @trusted
{
    igRenderFrameEx(p_min, p_max, fill_col, borders, rounding);
}

void RenderFrameBorder(ImVec2 p_min, ImVec2 p_max) @trusted
{
    igRenderFrameBorder(p_min, p_max);
}

void RenderFrameBorderEx(ImVec2 p_min, ImVec2 p_max, float rounding) @trusted
{
    igRenderFrameBorderEx(p_min, p_max, rounding);
}

void RenderColorRectWithAlphaCheckerboard(scope ImDrawList* draw_list, ImVec2 p_min, ImVec2 p_max, ImU32 fill_col, float grid_step, ImVec2 grid_off) @trusted
{
    igRenderColorRectWithAlphaCheckerboard(draw_list, p_min, p_max, fill_col, grid_step, grid_off);
}

void RenderColorRectWithAlphaCheckerboardEx(scope ImDrawList* draw_list, ImVec2 p_min, ImVec2 p_max, ImU32 fill_col, float grid_step, ImVec2 grid_off, float rounding, ImDrawFlags flags) @trusted
{
    igRenderColorRectWithAlphaCheckerboardEx(draw_list, p_min, p_max, fill_col, grid_step, grid_off, rounding, flags);
}

void RenderNavCursor(ImRect bb, ImGuiID id) @trusted
{
    igRenderNavCursor(bb, id);
}

void RenderNavCursorEx(ImRect bb, ImGuiID id, ImGuiNavRenderCursorFlags flags) @trusted
{
    igRenderNavCursorEx(bb, id, flags);
}

void RenderNavHighlight(ImRect bb, ImGuiID id) @trusted
{
    igRenderNavHighlight(bb, id);
}

void RenderNavHighlightEx(ImRect bb, ImGuiID id, ImGuiNavRenderCursorFlags flags) @trusted
{
    igRenderNavHighlightEx(bb, id, flags);
}

const(char)* FindRenderedTextEnd(const(char)* text) @trusted
{
    return igFindRenderedTextEnd(text);
}

const(char)* FindRenderedTextEndEx(const(char)* text, const(char)* text_end) @trusted
{
    return igFindRenderedTextEndEx(text, text_end);
}

void RenderMouseCursor(ImVec2 pos, float scale, ImGuiMouseCursor mouse_cursor, ImU32 col_fill, ImU32 col_border, ImU32 col_shadow) @trusted
{
    igRenderMouseCursor(pos, scale, mouse_cursor, col_fill, col_border, col_shadow);
}

/++
+ Render helpers (those functions don't access any ImGui state!)
+/
void RenderArrow(scope ImDrawList* draw_list, ImVec2 pos, ImU32 col, ImGuiDir dir) @trusted
{
    igRenderArrow(draw_list, pos, col, dir);
}

void RenderArrowEx(scope ImDrawList* draw_list, ImVec2 pos, ImU32 col, ImGuiDir dir, float scale) @trusted
{
    igRenderArrowEx(draw_list, pos, col, dir, scale);
}

void RenderBullet(scope ImDrawList* draw_list, ImVec2 pos, ImU32 col) @trusted
{
    igRenderBullet(draw_list, pos, col);
}

void RenderCheckMark(scope ImDrawList* draw_list, ImVec2 pos, ImU32 col, float sz) @trusted
{
    igRenderCheckMark(draw_list, pos, col, sz);
}

void RenderArrowPointingAt(scope ImDrawList* draw_list, ImVec2 pos, ImVec2 half_sz, ImGuiDir direction, ImU32 col) @trusted
{
    igRenderArrowPointingAt(draw_list, pos, half_sz, direction, col);
}

void RenderRectFilledRangeH(scope ImDrawList* draw_list, ImRect rect, ImU32 col, float x_start_norm, float x_end_norm, float rounding) @trusted
{
    igRenderRectFilledRangeH(draw_list, rect, col, x_start_norm, x_end_norm, rounding);
}

void RenderRectFilledWithHole(scope ImDrawList* draw_list, ImRect outer, ImRect inner, ImU32 col, float rounding) @trusted
{
    igRenderRectFilledWithHole(draw_list, outer, inner, col, rounding);
}

/++
+ Widgets: Text
+/
void TextEx(const(char)* text) @trusted
{
    igTextEx(text);
}

void TextExEx(const(char)* text, const(char)* text_end, ImGuiTextFlags flags) @trusted
{
    igTextExEx(text, text_end, flags);
}

alias TextAligned = igTextAligned;

alias TextAlignedV = igTextAlignedV;

/++
+ Widgets
+/
bool ButtonWithFlags(const(char)* label) @trusted
{
    return igButtonWithFlags(label);
}

bool ButtonWithFlagsEx(const(char)* label, ImVec2 size_arg, ImGuiButtonFlags flags) @trusted
{
    return igButtonWithFlagsEx(label, size_arg, flags);
}

bool ArrowButtonEx(const(char)* str_id, ImGuiDir dir, ImVec2 size_arg, ImGuiButtonFlags flags) @trusted
{
    return igArrowButtonEx(str_id, dir, size_arg, flags);
}

bool ImageButtonWithFlags(ImGuiID id, ImTextureRef tex_ref, ImVec2 image_size, ImVec2 uv0, ImVec2 uv1, ImVec4 bg_col, ImVec4 tint_col, ImGuiButtonFlags flags) @trusted
{
    return igImageButtonWithFlags(id, tex_ref, image_size, uv0, uv1, bg_col, tint_col, flags);
}

void SeparatorEx(ImGuiSeparatorFlags flags) @trusted
{
    igSeparatorEx(flags);
}

void SeparatorExEx(ImGuiSeparatorFlags flags, float thickness) @trusted
{
    igSeparatorExEx(flags, thickness);
}

void SeparatorTextEx(ImGuiID id, const(char)* label, const(char)* label_end, float extra_width) @trusted
{
    igSeparatorTextEx(id, label, label_end, extra_width);
}

bool CheckboxFlagsImS64Ptr(const(char)* label, scope ImS64* flags, ImS64 flags_value) @trusted
{
    return igCheckboxFlagsImS64Ptr(label, flags, flags_value);
}

bool CheckboxFlagsImU64Ptr(const(char)* label, scope ImU64* flags, ImU64 flags_value) @trusted
{
    return igCheckboxFlagsImU64Ptr(label, flags, flags_value);
}

/++
+ Widgets: Window Decorations
+/
bool CloseButton(ImGuiID id, ImVec2 pos) @trusted
{
    return igCloseButton(id, pos);
}

bool CollapseButton(ImGuiID id, ImVec2 pos) @trusted
{
    return igCollapseButton(id, pos);
}

void Scrollbar(ImGuiAxis axis) @trusted
{
    igScrollbar(axis);
}

bool ScrollbarEx(ImRect bb, ImGuiID id, ImGuiAxis axis, scope ImS64* p_scroll_v, ImS64 avail_v, ImS64 contents_v) @trusted
{
    return igScrollbarEx(bb, id, axis, p_scroll_v, avail_v, contents_v);
}

bool ScrollbarExEx(ImRect bb, ImGuiID id, ImGuiAxis axis, scope ImS64* p_scroll_v, ImS64 avail_v, ImS64 contents_v, ImDrawFlags draw_rounding_flags) @trusted
{
    return igScrollbarExEx(bb, id, axis, p_scroll_v, avail_v, contents_v, draw_rounding_flags);
}

ImRect GetWindowScrollbarRect(scope ImGuiWindow* window, ImGuiAxis axis) @trusted
{
    return igGetWindowScrollbarRect(window, axis);
}

ImGuiID GetWindowScrollbarID(scope ImGuiWindow* window, ImGuiAxis axis) @trusted
{
    return igGetWindowScrollbarID(window, axis);
}

ImGuiID GetWindowResizeCornerID(scope ImGuiWindow* window, int n) @trusted
{
    return igGetWindowResizeCornerID(window, n);
}

ImGuiID GetWindowResizeBorderID(scope ImGuiWindow* window, ImGuiDir dir) @trusted
{
    return igGetWindowResizeBorderID(window, dir);
}

/++
+ Widgets lowlevel behaviors
+/
bool ButtonBehavior(ImRect bb, ImGuiID id, scope bool* out_hovered, scope bool* out_held, ImGuiButtonFlags flags) @trusted
{
    return igButtonBehavior(bb, id, out_hovered, out_held, flags);
}

bool DragBehavior(ImGuiID id, ImGuiDataType data_type, scope void* p_v, float v_speed, scope const(void)* p_min, scope const(void)* p_max, const(char)* format, ImGuiSliderFlags flags) @trusted
{
    return igDragBehavior(id, data_type, p_v, v_speed, p_min, p_max, format, flags);
}

bool SliderBehavior(ImRect bb, ImGuiID id, ImGuiDataType data_type, scope void* p_v, scope const(void)* p_min, scope const(void)* p_max, const(char)* format, ImGuiSliderFlags flags, scope ImRect* out_grab_bb) @trusted
{
    return igSliderBehavior(bb, id, data_type, p_v, p_min, p_max, format, flags, out_grab_bb);
}

bool SplitterBehavior(ImRect bb, ImGuiID id, ImGuiAxis axis, scope float* size1, scope float* size2, float min_size1, float min_size2) @trusted
{
    return igSplitterBehavior(bb, id, axis, size1, size2, min_size1, min_size2);
}

bool SplitterBehaviorEx(ImRect bb, ImGuiID id, ImGuiAxis axis, scope float* size1, scope float* size2, float min_size1, float min_size2, float hover_extend, float hover_visibility_delay, ImU32 bg_col) @trusted
{
    return igSplitterBehaviorEx(bb, id, axis, size1, size2, min_size1, min_size2, hover_extend, hover_visibility_delay, bg_col);
}

/++
+ Widgets: Tree Nodes
+/
bool TreeNodeBehavior(ImGuiID id, ImGuiTreeNodeFlags flags, const(char)* label) @trusted
{
    return igTreeNodeBehavior(id, flags, label);
}

bool TreeNodeBehaviorEx(ImGuiID id, ImGuiTreeNodeFlags flags, const(char)* label, const(char)* label_end) @trusted
{
    return igTreeNodeBehaviorEx(id, flags, label, label_end);
}

void TreeNodeDrawLineToChildNode(ImVec2 target_pos) @trusted
{
    igTreeNodeDrawLineToChildNode(target_pos);
}

void TreeNodeDrawLineToTreePop(scope ImGuiTreeNodeStackData* data) @trusted
{
    igTreeNodeDrawLineToTreePop(data);
}

void TreePushOverrideID(ImGuiID id) @trusted
{
    igTreePushOverrideID(id);
}

bool TreeNodeGetOpen(ImGuiID storage_id) @trusted
{
    return igTreeNodeGetOpen(storage_id);
}

void TreeNodeSetOpen(ImGuiID storage_id, bool open) @trusted
{
    igTreeNodeSetOpen(storage_id, open);
}

bool TreeNodeUpdateNextOpen(ImGuiID storage_id, ImGuiTreeNodeFlags flags) @trusted
{
    return igTreeNodeUpdateNextOpen(storage_id, flags);
}

/++
+ Data type helpers
+/
const(ImGuiDataTypeInfo)* DataTypeGetInfo(ImGuiDataType data_type) @trusted
{
    return igDataTypeGetInfo(data_type);
}

int DataTypeFormatString(scope char* buf, int buf_size, ImGuiDataType data_type, scope const(void)* p_data, const(char)* format) @trusted
{
    return igDataTypeFormatString(buf, buf_size, data_type, p_data, format);
}

void DataTypeApplyOp(ImGuiDataType data_type, int op, scope void* output, scope const(void)* arg_1, scope const(void)* arg_2) @trusted
{
    igDataTypeApplyOp(data_type, op, output, arg_1, arg_2);
}

bool DataTypeApplyFromText(const(char)* buf, ImGuiDataType data_type, scope void* p_data, const(char)* format) @trusted
{
    return igDataTypeApplyFromText(buf, data_type, p_data, format);
}

bool DataTypeApplyFromTextEx(const(char)* buf, ImGuiDataType data_type, scope void* p_data, const(char)* format, scope void* p_data_when_empty) @trusted
{
    return igDataTypeApplyFromTextEx(buf, data_type, p_data, format, p_data_when_empty);
}

int DataTypeCompare(ImGuiDataType data_type, scope const(void)* arg_1, scope const(void)* arg_2) @trusted
{
    return igDataTypeCompare(data_type, arg_1, arg_2);
}

bool DataTypeClamp(ImGuiDataType data_type, scope void* p_data, scope const(void)* p_min, scope const(void)* p_max) @trusted
{
    return igDataTypeClamp(data_type, p_data, p_min, p_max);
}

bool DataTypeIsZero(ImGuiDataType data_type, scope const(void)* p_data) @trusted
{
    return igDataTypeIsZero(data_type, p_data);
}

/++
+ InputText
+/
bool InputTextWithHintAndSize(const(char)* label, const(char)* hint, scope char* buf, int buf_size, ImVec2 size_arg, ImGuiInputTextFlags flags) @trusted
{
    return igInputTextWithHintAndSize(label, hint, buf, buf_size, size_arg, flags);
}

bool InputTextWithHintAndSizeEx(const(char)* label, const(char)* hint, scope char* buf, int buf_size, ImVec2 size_arg, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, scope void* user_data) @trusted
{
    return igInputTextWithHintAndSizeEx(label, hint, buf, buf_size, size_arg, flags, callback, user_data);
}

void InputTextDeactivateHook(ImGuiID id) @trusted
{
    igInputTextDeactivateHook(id);
}

bool TempInputText(ImRect bb, ImGuiID id, const(char)* label, scope char* buf, int buf_size, ImGuiInputTextFlags flags) @trusted
{
    return igTempInputText(bb, id, label, buf, buf_size, flags);
}

bool TempInputScalar(ImRect bb, ImGuiID id, const(char)* label, ImGuiDataType data_type, scope void* p_data, const(char)* format) @trusted
{
    return igTempInputScalar(bb, id, label, data_type, p_data, format);
}

bool TempInputScalarEx(ImRect bb, ImGuiID id, const(char)* label, ImGuiDataType data_type, scope void* p_data, const(char)* format, scope const(void)* p_clamp_min, scope const(void)* p_clamp_max) @trusted
{
    return igTempInputScalarEx(bb, id, label, data_type, p_data, format, p_clamp_min, p_clamp_max);
}

bool TempInputIsActive(ImGuiID id) @trusted
{
    return igTempInputIsActive(id);
}

void SetNextItemRefVal(ImGuiDataType data_type, scope void* p_data) @trusted
{
    igSetNextItemRefVal(data_type, p_data);
}

bool IsItemActiveAsInputText() @trusted
{
    return igIsItemActiveAsInputText();
}

/++
+ Color
+/
void ColorTooltip(const(char)* text, scope const(float)* col, ImGuiColorEditFlags flags) @trusted
{
    igColorTooltip(text, col, flags);
}

void ColorEditOptionsPopup(scope const(float)* col, ImGuiColorEditFlags flags) @trusted
{
    igColorEditOptionsPopup(col, flags);
}

void ColorPickerOptionsPopup(scope const(float)* ref_col, ImGuiColorEditFlags flags) @trusted
{
    igColorPickerOptionsPopup(ref_col, flags);
}

/++
+ Plot
+/
int PlotEx(ImGuiPlotType plot_type, const(char)* label, ImGuiValues_getterCallback values_getter, scope void* data, int values_count, int values_offset, const(char)* overlay_text, float scale_min, float scale_max, ImVec2 size_arg) @trusted
{
    return igPlotEx(plot_type, label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, size_arg);
}

/++
+ Shade functions (write over already created vertices)
+/
void ShadeVertsLinearColorGradientKeepAlpha(scope ImDrawList* draw_list, int vert_start_idx, int vert_end_idx, ImVec2 gradient_p0, ImVec2 gradient_p1, ImU32 col0, ImU32 col1) @trusted
{
    igShadeVertsLinearColorGradientKeepAlpha(draw_list, vert_start_idx, vert_end_idx, gradient_p0, gradient_p1, col0, col1);
}

alias ShadeVertsLinearUV = igShadeVertsLinearUV;

void ShadeVertsTransformPos(scope ImDrawList* draw_list, int vert_start_idx, int vert_end_idx, ImVec2 pivot_in, float cos_a, float sin_a, ImVec2 pivot_out) @trusted
{
    igShadeVertsTransformPos(draw_list, vert_start_idx, vert_end_idx, pivot_in, cos_a, sin_a, pivot_out);
}

/++
+ Garbage collection
+/
void GcCompactTransientMiscBuffers() @trusted
{
    igGcCompactTransientMiscBuffers();
}

void GcCompactTransientWindowBuffers(scope ImGuiWindow* window) @trusted
{
    igGcCompactTransientWindowBuffers(window);
}

void GcAwakeTransientWindowBuffers(scope ImGuiWindow* window) @trusted
{
    igGcAwakeTransientWindowBuffers(window);
}

/++
+ Error handling, State Recovery
+/
bool ErrorLog(const(char)* msg) @trusted
{
    return igErrorLog(msg);
}

void ErrorRecoveryStoreState(scope ImGuiErrorRecoveryState* state_out) @trusted
{
    igErrorRecoveryStoreState(state_out);
}

void ErrorRecoveryTryToRecoverState(scope ImGuiErrorRecoveryState* state_in) @trusted
{
    igErrorRecoveryTryToRecoverState(state_in);
}

void ErrorRecoveryTryToRecoverWindowState(scope ImGuiErrorRecoveryState* state_in) @trusted
{
    igErrorRecoveryTryToRecoverWindowState(state_in);
}

void ErrorCheckUsingSetCursorPosToExtendParentBoundaries() @trusted
{
    igErrorCheckUsingSetCursorPosToExtendParentBoundaries();
}

void ErrorCheckEndFrameFinalizeErrorTooltip() @trusted
{
    igErrorCheckEndFrameFinalizeErrorTooltip();
}

bool BeginErrorTooltip() @trusted
{
    return igBeginErrorTooltip();
}

void EndErrorTooltip() @trusted
{
    igEndErrorTooltip();
}

/++
+ Debug Tools
+/
void DebugAllocHook(scope ImGuiDebugAllocInfo* info, int frame_count, scope void* ptr, size_t size) @trusted
{
    igDebugAllocHook(info, frame_count, ptr, size);
}

void DebugDrawCursorPos() @trusted
{
    igDebugDrawCursorPos();
}

void DebugDrawCursorPosEx(ImU32 col) @trusted
{
    igDebugDrawCursorPosEx(col);
}

void DebugDrawLineExtents() @trusted
{
    igDebugDrawLineExtents();
}

void DebugDrawLineExtentsEx(ImU32 col) @trusted
{
    igDebugDrawLineExtentsEx(col);
}

void DebugDrawItemRect() @trusted
{
    igDebugDrawItemRect();
}

void DebugDrawItemRectEx(ImU32 col) @trusted
{
    igDebugDrawItemRectEx(col);
}

void DebugTextUnformattedWithLocateItem(const(char)* line_begin, const(char)* line_end) @trusted
{
    igDebugTextUnformattedWithLocateItem(line_begin, line_end);
}

void DebugLocateItem(ImGuiID target_id) @trusted
{
    igDebugLocateItem(target_id);
}

void DebugLocateItemOnHover(ImGuiID target_id) @trusted
{
    igDebugLocateItemOnHover(target_id);
}

void DebugLocateItemResolveWithLastItem() @trusted
{
    igDebugLocateItemResolveWithLastItem();
}

void DebugBreakClearData() @trusted
{
    igDebugBreakClearData();
}

bool DebugBreakButton(const(char)* label, const(char)* description_of_location) @trusted
{
    return igDebugBreakButton(label, description_of_location);
}

void DebugBreakButtonTooltip(bool keyboard_only, const(char)* description_of_location) @trusted
{
    igDebugBreakButtonTooltip(keyboard_only, description_of_location);
}

void ShowFontAtlas(scope ImFontAtlas* atlas) @trusted
{
    igShowFontAtlas(atlas);
}

void DebugHookIdInfo(ImGuiID id, ImGuiDataType data_type, scope const(void)* data_id, scope const(void)* data_id_end) @trusted
{
    igDebugHookIdInfo(id, data_type, data_id, data_id_end);
}

void DebugNodeColumns(scope ImGuiOldColumns* columns) @trusted
{
    igDebugNodeColumns(columns);
}

void DebugNodeDrawList(scope ImGuiWindow* window, scope ImGuiViewportP* viewport, scope ImDrawList* draw_list, const(char)* label) @trusted
{
    igDebugNodeDrawList(window, viewport, draw_list, label);
}

void DebugNodeDrawCmdShowMeshAndBoundingBox(scope ImDrawList* out_draw_list, scope ImDrawList* draw_list, scope ImDrawCmd* draw_cmd, bool show_mesh, bool show_aabb) @trusted
{
    igDebugNodeDrawCmdShowMeshAndBoundingBox(out_draw_list, draw_list, draw_cmd, show_mesh, show_aabb);
}

void DebugNodeFont(scope ImFont* font) @trusted
{
    igDebugNodeFont(font);
}

void DebugNodeFontGlyphesForSrcMask(scope ImFont* font, scope ImFontBaked* baked, int src_mask) @trusted
{
    igDebugNodeFontGlyphesForSrcMask(font, baked, src_mask);
}

void DebugNodeFontGlyph(scope ImFont* font, scope ImFontGlyph* glyph) @trusted
{
    igDebugNodeFontGlyph(font, glyph);
}

void DebugNodeTexture(scope ImTextureData* tex, int int_id) @trusted
{
    igDebugNodeTexture(tex, int_id);
}

void DebugNodeTextureEx(scope ImTextureData* tex, int int_id, scope ImFontAtlasRect* highlight_rect) @trusted
{
    igDebugNodeTextureEx(tex, int_id, highlight_rect);
}

void DebugNodeStorage(scope ImGuiStorage* storage, const(char)* label) @trusted
{
    igDebugNodeStorage(storage, label);
}

void DebugNodeTabBar(scope ImGuiTabBar* tab_bar, const(char)* label) @trusted
{
    igDebugNodeTabBar(tab_bar, label);
}

void DebugNodeTable(scope ImGuiTable* table) @trusted
{
    igDebugNodeTable(table);
}

void DebugNodeTableSettings(scope ImGuiTableSettings* settings) @trusted
{
    igDebugNodeTableSettings(settings);
}

void DebugNodeTypingSelectState(scope ImGuiTypingSelectState* state) @trusted
{
    igDebugNodeTypingSelectState(state);
}

void DebugNodeMultiSelectState(scope ImGuiMultiSelectState* state) @trusted
{
    igDebugNodeMultiSelectState(state);
}

void DebugNodeWindow(scope ImGuiWindow* window, const(char)* label) @trusted
{
    igDebugNodeWindow(window, label);
}

void DebugNodeWindowSettings(scope ImGuiWindowSettings* settings) @trusted
{
    igDebugNodeWindowSettings(settings);
}

void DebugNodeWindowsList(scope ImVector_ImGuiWindowPtr* windows, const(char)* label) @trusted
{
    igDebugNodeWindowsList(windows, label);
}

void DebugNodeWindowsListByBeginStackParent(scope ImGuiWindow** windows, int windows_size, scope ImGuiWindow* parent_in_begin_stack) @trusted
{
    igDebugNodeWindowsListByBeginStackParent(windows, windows_size, parent_in_begin_stack);
}

void DebugNodeViewport(scope ImGuiViewportP* viewport) @trusted
{
    igDebugNodeViewport(viewport);
}

void DebugRenderKeyboardPreview(scope ImDrawList* draw_list) @trusted
{
    igDebugRenderKeyboardPreview(draw_list);
}

void DebugRenderViewportThumbnail(scope ImDrawList* draw_list, scope ImGuiViewportP* viewport, ImRect bb) @trusted
{
    igDebugRenderViewportThumbnail(draw_list, viewport, bb);
}
