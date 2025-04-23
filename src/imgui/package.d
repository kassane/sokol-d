// Generated on 2025-04-19
/++
This is a D wrapper around the cimgui library (Dear ImGui).
It provides D bindings for the Dear ImGui immediate mode GUI library.

Features:
- Full ImGui API coverage
- @trusted wrapper functions
- Preserves ImGui's original style and naming conventions
- Handles memory management and context safety
+/
module imgui;
version (has_imgui)
{
    public import imgui.dcimgui;

@nogc nothrow:

    // Callback function types
    extern (C) alias ImGuiGetterFunc = const(char)* function(const(void)*, int);
    extern (C) alias ImGuiValues_getterFunc = float function(void*, int);
    extern (C) alias ImGuiOld_callbackFunc = bool function(void*, int, const(char)**);

    // D-friendly wrappers
    scope ImGuiContext* CreateContext(scope ImFontAtlas* shared_font_atlas) @trusted
    {
        return igCreateContext(shared_font_atlas);
    }

    void DestroyContext(scope ImGuiContext* ctx) @trusted
    {
        igDestroyContext(ctx);
    }

    scope ImGuiContext* GetCurrentContext() @trusted
    {
        return igGetCurrentContext();
    }

    void SetCurrentContext(scope ImGuiContext* ctx) @trusted
    {
        igSetCurrentContext(ctx);
    }

    scope ImGuiIO* GetIO() @trusted
    {
        return igGetIO();
    }

    scope ImGuiPlatformIO* GetPlatformIO() @trusted
    {
        return igGetPlatformIO();
    }

    scope ImGuiStyle* GetStyle() @trusted
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

    scope ImDrawData* GetDrawData() @trusted
    {
        return igGetDrawData();
    }

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

    scope const(char)* GetVersion() @trusted
    {
        return igGetVersion();
    }

    void StyleColorsDark(
        scope ImGuiStyle* dst) @trusted
    {
        igStyleColorsDark(dst);
    }

    void StyleColorsLight(
        scope ImGuiStyle* dst) @trusted
    {
        igStyleColorsLight(dst);
    }

    void StyleColorsClassic(
        scope ImGuiStyle* dst) @trusted
    {
        igStyleColorsClassic(dst);
    }

    bool Begin(scope const(char)* name, scope bool* p_open, ImGuiWindowFlags flags) @trusted
    {
        return igBegin(name, p_open, flags);
    }

    void End() @trusted
    {
        igEnd();
    }

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

    bool IsWindowAppearing() @trusted
    {
        return igIsWindowAppearing();
    }

    bool IsWindowCollapsed() @trusted
    {
        return igIsWindowCollapsed();
    }

    bool IsWindowFocused(
        ImGuiFocusedFlags flags) @trusted
    {
        return igIsWindowFocused(
            flags);
    }

    bool IsWindowHovered(
        ImGuiHoveredFlags flags) @trusted
    {
        return igIsWindowHovered(
            flags);
    }

    scope ImDrawList* GetWindowDrawList() @trusted
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

    void SetNextWindowSizeConstraints(ImVec2 size_min, ImVec2 size_max, ImGuiSizeCallback custom_callback, scope
        void* custom_callback_data) @trusted
    {
        igSetNextWindowSizeConstraints(size_min, size_max, custom_callback, custom_callback_data);
    }

    void SetNextWindowContentSize(
        ImVec2 size) @trusted
    {
        igSetNextWindowContentSize(
            size);
    }

    void SetNextWindowCollapsed(bool collapsed, ImGuiCond cond) @trusted
    {
        igSetNextWindowCollapsed(collapsed, cond);
    }

    void SetNextWindowFocus() @trusted
    {
        igSetNextWindowFocus();
    }

    void SetNextWindowScroll(
        ImVec2 scroll) @trusted
    {
        igSetNextWindowScroll(
            scroll);
    }

    void SetNextWindowBgAlpha(
        float alpha) @trusted
    {
        igSetNextWindowBgAlpha(
            alpha);
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

    void SetWindowFontScale(
        float scale) @trusted
    {
        igSetWindowFontScale(scale);
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

    void SetWindowFocusStr(
        scope const(char)* name) @trusted
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

    void SetScrollHereX(
        float center_x_ratio) @trusted
    {
        igSetScrollHereX(
            center_x_ratio);
    }

    void SetScrollHereY(
        float center_y_ratio) @trusted
    {
        igSetScrollHereY(
            center_y_ratio);
    }

    void SetScrollFromPosX(float local_x, float center_x_ratio) @trusted
    {
        igSetScrollFromPosX(local_x, center_x_ratio);
    }

    void SetScrollFromPosY(float local_y, float center_y_ratio) @trusted
    {
        igSetScrollFromPosY(local_y, center_y_ratio);
    }

    void PushFont(scope ImFont* font) @trusted
    {
        igPushFont(font);
    }

    void PopFont() @trusted
    {
        igPopFont();
    }

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

    void PushItemWidth(
        float item_width) @trusted
    {
        igPushItemWidth(item_width);
    }

    void PopItemWidth() @trusted
    {
        igPopItemWidth();
    }

    void SetNextItemWidth(
        float item_width) @trusted
    {
        igSetNextItemWidth(
            item_width);
    }

    float CalcItemWidth() @trusted
    {
        return igCalcItemWidth();
    }

    void PushTextWrapPos(
        float wrap_local_pos_x) @trusted
    {
        igPushTextWrapPos(
            wrap_local_pos_x);
    }

    void PopTextWrapPos() @trusted
    {
        igPopTextWrapPos();
    }

    scope ImFont* GetFont() @trusted
    {
        return igGetFont();
    }

    float GetFontSize() @trusted
    {
        return igGetFontSize();
    }

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

    ImU32 GetColorU32ImVec4(
        ImVec4 col) @trusted
    {
        return igGetColorU32ImVec4(
            col);
    }

    ImU32 GetColorU32ImU32(
        ImU32 col) @trusted
    {
        return igGetColorU32ImU32(
            col);
    }

    ImU32 GetColorU32ImU32Ex(ImU32 col, float alpha_mul) @trusted
    {
        return igGetColorU32ImU32Ex(col, alpha_mul);
    }

    scope ImVec4* GetStyleColorVec4(
        ImGuiCol idx) @trusted
    {
        return igGetStyleColorVec4(
            idx);
    }

    ImVec2 GetCursorScreenPos() @trusted
    {
        return igGetCursorScreenPos();
    }

    void SetCursorScreenPos(
        ImVec2 pos) @trusted
    {
        igSetCursorScreenPos(
            pos);
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

    void SetCursorPos(
        ImVec2 local_pos) @trusted
    {
        igSetCursorPos(
            local_pos);
    }

    void SetCursorPosX(
        float local_x) @trusted
    {
        igSetCursorPosX(local_x);
    }

    void SetCursorPosY(
        float local_y) @trusted
    {
        igSetCursorPosY(local_y);
    }

    ImVec2 GetCursorStartPos() @trusted
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

    void UnindentEx(
        float indent_w) @trusted
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

    void PushID(
        scope const(char)* str_id) @trusted
    {
        igPushID(str_id);
    }

    void PushIDStr(scope const(char)* str_id_begin, scope const(char)* str_id_end) @trusted
    {
        igPushIDStr(str_id_begin, str_id_end);
    }

    void PushIDPtr(
        scope void* ptr_id) @trusted
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

    ImGuiID GetID(
        scope const(char)* str_id) @trusted
    {
        return igGetID(str_id);
    }

    ImGuiID GetIDStr(scope const(char)* str_id_begin, scope const(char)* str_id_end) @trusted
    {
        return igGetIDStr(str_id_begin, str_id_end);
    }

    ImGuiID GetIDPtr(
        scope void* ptr_id) @trusted
    {
        return igGetIDPtr(
            ptr_id);
    }

    ImGuiID GetIDInt(int int_id) @trusted
    {
        return igGetIDInt(
            int_id);
    }

    void TextUnformatted(
        scope const(char)* text) @trusted
    {
        igTextUnformatted(text);
    }

    void TextUnformattedEx(scope const(char)* text, scope const(char)* text_end) @trusted
    {
        igTextUnformattedEx(text, text_end);
    }

    void Text(Args...)(scope const(char)* fmt, Args args) @trusted
    {
        igText(fmt, args);
    }

    void TextV(Args...)(scope const(char)* fmt, Args args) @trusted
    {
        igTextV(fmt, args);
    }

    void TextColored(Args...)(ImVec4 col, scope const(char)* fmt, Args args) @trusted
    {
        igTextColored(col, fmt, args);
    }

    void TextColoredV(Args...)(ImVec4 col, scope const(char)* fmt, Args args) @trusted
    {
        igTextColoredV(col, fmt, args);
    }

    void TextDisabled(Args...)(
        scope const(char)* fmt, Args args) @trusted
    {
        igTextDisabled(fmt, args);
    }

    void TextDisabledV(Args...)(scope const(char)* fmt, Args args) @trusted
    {
        igTextDisabledV(fmt, args);
    }

    void TextWrapped(Args...)(
        scope const(char)* fmt, Args args) @trusted
    {
        igTextWrapped(fmt, args);
    }

    void TextWrappedV(Args...)(scope const(char)* fmt, Args args) @trusted
    {
        igTextWrappedV(fmt, args);
    }

    void LabelText(Args...)(scope const(char)* label, scope const(char)* fmt, Args args) @trusted
    {
        igLabelText(label, fmt, args);
    }

    void LabelTextV(Args...)(scope const(char)* label, scope const(char)* fmt, Args args) @trusted
    {
        igLabelTextV(label, fmt, args);
    }

    void BulletText(
        scope const(char)* fmt) @trusted
    {
        igBulletText(fmt);
    }

    void BulletTextV(Args...)(scope const(char)* fmt, Args args) @trusted
    {
        igBulletTextV(fmt, args);
    }

    void SeparatorText(
        scope const(char)* label) @trusted
    {
        igSeparatorText(label);
    }

    bool Button(
        scope const(char)* label) @trusted
    {
        return igButton(label);
    }

    bool ButtonEx(scope const(char)* label, ImVec2 size) @trusted
    {
        return igButtonEx(label, size);
    }

    bool SmallButton(
        scope const(char)* label) @trusted
    {
        return igSmallButton(
            label);
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

    bool TextLink(
        scope const(char)* label) @trusted
    {
        return igTextLink(label);
    }

    void TextLinkOpenURL(
        scope const(char)* label) @trusted
    {
        igTextLinkOpenURL(label);
    }

    void TextLinkOpenURLEx(scope const(char)* label, scope const(char)* url) @trusted
    {
        igTextLinkOpenURLEx(label, url);
    }

    void Image(ImTextureID user_texture_id, ImVec2 image_size) @trusted
    {
        igImage(user_texture_id, image_size);
    }

    void ImageEx(ImTextureID user_texture_id, ImVec2 image_size, ImVec2 uv0, ImVec2 uv1) @trusted
    {
        igImageEx(user_texture_id, image_size, uv0, uv1);
    }

    void ImageWithBg(ImTextureID user_texture_id, ImVec2 image_size) @trusted
    {
        igImageWithBg(user_texture_id, image_size);
    }

    void ImageWithBgEx(ImTextureID user_texture_id, ImVec2 image_size, ImVec2 uv0, ImVec2 uv1, ImVec4 bg_col, ImVec4 tint_col) @trusted
    {
        igImageWithBgEx(user_texture_id, image_size, uv0, uv1, bg_col, tint_col);
    }

    bool ImageButton(scope const(char)* str_id, ImTextureID user_texture_id, ImVec2 image_size) @trusted
    {
        return igImageButton(str_id, user_texture_id, image_size);
    }

    bool ImageButtonEx(scope const(char)* str_id, ImTextureID user_texture_id, ImVec2 image_size, ImVec2 uv0, ImVec2 uv1, ImVec4 bg_col, ImVec4 tint_col) @trusted
    {
        return igImageButtonEx(str_id, user_texture_id, image_size, uv0, uv1, bg_col, tint_col);
    }

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

    bool ComboCallback(scope const(char)* label, scope int* current_item, ImGuiGetterFunc getter, scope
        void* user_data, int items_count) @trusted
    {
        return igComboCallback(label, current_item, getter, user_data, items_count);
    }

    bool ComboCallbackEx(scope const(char)* label, scope int* current_item, ImGuiGetterFunc getter, scope
        void* user_data, int items_count, int popup_max_height_in_items) @trusted
    {
        return igComboCallbackEx(label, current_item, getter, user_data, items_count, popup_max_height_in_items);
    }

    bool DragFloat(scope const(char)* label, scope float* v) @trusted
    {
        return igDragFloat(label, v);
    }

    bool DragFloatEx(scope const(char)* label, scope float* v, float v_speed, float v_min, float v_max, scope
        char* format, ImGuiSliderFlags flags) @trusted
    {
        return igDragFloatEx(label, v, v_speed, v_min, v_max, format, flags);
    }

    bool DragFloat2(scope const(char)* label, scope float* v) @trusted
    {
        return igDragFloat2(label, v);
    }

    bool DragFloat2Ex(scope const(char)* label, scope float* v, float v_speed, float v_min, float v_max, scope
        char* format, ImGuiSliderFlags flags) @trusted
    {
        return igDragFloat2Ex(label, v, v_speed, v_min, v_max, format, flags);
    }

    bool DragFloat3(scope const(char)* label, scope float* v) @trusted
    {
        return igDragFloat3(label, v);
    }

    bool DragFloat3Ex(scope const(char)* label, scope float* v, float v_speed, float v_min, float v_max, scope
        char* format, ImGuiSliderFlags flags) @trusted
    {
        return igDragFloat3Ex(label, v, v_speed, v_min, v_max, format, flags);
    }

    bool DragFloat4(scope const(char)* label, scope float* v) @trusted
    {
        return igDragFloat4(label, v);
    }

    bool DragFloat4Ex(scope const(char)* label, scope float* v, float v_speed, float v_min, float v_max, scope
        char* format, ImGuiSliderFlags flags) @trusted
    {
        return igDragFloat4Ex(label, v, v_speed, v_min, v_max, format, flags);
    }

    bool DragFloatRange2(scope const(char)* label, scope float* v_current_min, scope
        float* v_current_max) @trusted
    {
        return igDragFloatRange2(label, v_current_min, v_current_max);
    }

    bool DragFloatRange2Ex(scope const(char)* label, scope float* v_current_min, scope
        float* v_current_max, float v_speed, float v_min, float v_max, scope const(char)* format, scope
        char* format_max, ImGuiSliderFlags flags) @trusted
    {
        return igDragFloatRange2Ex(label, v_current_min, v_current_max, v_speed, v_min, v_max, format, format_max, flags);
    }

    bool DragInt(scope const(char)* label, scope int* v) @trusted
    {
        return igDragInt(label, v);
    }

    bool DragIntEx(scope const(char)* label, scope int* v, float v_speed, int v_min, int v_max, scope
        char* format, ImGuiSliderFlags flags) @trusted
    {
        return igDragIntEx(label, v, v_speed, v_min, v_max, format, flags);
    }

    bool DragInt2(scope const(char)* label, scope int* v) @trusted
    {
        return igDragInt2(label, v);
    }

    bool DragInt2Ex(scope const(char)* label, scope int* v, float v_speed, int v_min, int v_max, scope
        char* format, ImGuiSliderFlags flags) @trusted
    {
        return igDragInt2Ex(label, v, v_speed, v_min, v_max, format, flags);
    }

    bool DragInt3(scope const(char)* label, scope int* v) @trusted
    {
        return igDragInt3(label, v);
    }

    bool DragInt3Ex(scope const(char)* label, scope int* v, float v_speed, int v_min, int v_max, scope
        char* format, ImGuiSliderFlags flags) @trusted
    {
        return igDragInt3Ex(label, v, v_speed, v_min, v_max, format, flags);
    }

    bool DragInt4(scope const(char)* label, scope int* v) @trusted
    {
        return igDragInt4(label, v);
    }

    bool DragInt4Ex(scope const(char)* label, scope int* v, float v_speed, int v_min, int v_max, scope
        char* format, ImGuiSliderFlags flags) @trusted
    {
        return igDragInt4Ex(label, v, v_speed, v_min, v_max, format, flags);
    }

    bool DragIntRange2(scope const(char)* label, scope int* v_current_min, scope int* v_current_max) @trusted
    {
        return igDragIntRange2(label, v_current_min, v_current_max);
    }

    bool DragIntRange2Ex(scope const(char)* label, scope int* v_current_min, scope int* v_current_max, float v_speed, int v_min, int v_max, scope
        char* format, scope const(char)* format_max, ImGuiSliderFlags flags) @trusted
    {
        return igDragIntRange2Ex(label, v_current_min, v_current_max, v_speed, v_min, v_max, format, format_max, flags);
    }

    bool DragScalar(scope const(char)* label, ImGuiDataType data_type, scope void* p_data) @trusted
    {
        return igDragScalar(label, data_type, p_data);
    }

    bool DragScalarEx(scope const(char)* label, ImGuiDataType data_type, scope void* p_data, float v_speed, scope void* p_min, scope
        void* p_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
    {
        return igDragScalarEx(label, data_type, p_data, v_speed, p_min, p_max, format, flags);
    }

    bool DragScalarN(scope const(char)* label, ImGuiDataType data_type, scope void* p_data, int components) @trusted
    {
        return igDragScalarN(label, data_type, p_data, components);
    }

    bool DragScalarNEx(scope const(char)* label, ImGuiDataType data_type, scope void* p_data, int components, float v_speed, scope
        void* p_min, scope void* p_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
    {
        return igDragScalarNEx(label, data_type, p_data, components, v_speed, p_min, p_max, format, flags);
    }

    bool SliderFloat(scope const(char)* label, scope float* v, float v_min, float v_max) @trusted
    {
        return igSliderFloat(label, v, v_min, v_max);
    }

    bool SliderFloatEx(scope const(char)* label, scope float* v, float v_min, float v_max, scope
        char* format, ImGuiSliderFlags flags) @trusted
    {
        return igSliderFloatEx(label, v, v_min, v_max, format, flags);
    }

    bool SliderFloat2(scope const(char)* label, scope float* v, float v_min, float v_max) @trusted
    {
        return igSliderFloat2(label, v, v_min, v_max);
    }

    bool SliderFloat2Ex(scope const(char)* label, scope float* v, float v_min, float v_max, scope
        char* format, ImGuiSliderFlags flags) @trusted
    {
        return igSliderFloat2Ex(label, v, v_min, v_max, format, flags);
    }

    bool SliderFloat3(scope const(char)* label, scope float* v, float v_min, float v_max) @trusted
    {
        return igSliderFloat3(label, v, v_min, v_max);
    }

    bool SliderFloat3Ex(scope const(char)* label, scope float* v, float v_min, float v_max, scope
        char* format, ImGuiSliderFlags flags) @trusted
    {
        return igSliderFloat3Ex(label, v, v_min, v_max, format, flags);
    }

    bool SliderFloat4(scope const(char)* label, scope float* v, float v_min, float v_max) @trusted
    {
        return igSliderFloat4(label, v, v_min, v_max);
    }

    bool SliderFloat4Ex(scope const(char)* label, scope float* v, float v_min, float v_max, scope
        char* format, ImGuiSliderFlags flags) @trusted
    {
        return igSliderFloat4Ex(label, v, v_min, v_max, format, flags);
    }

    bool SliderAngle(scope const(char)* label, scope float* v_rad) @trusted
    {
        return igSliderAngle(label, v_rad);
    }

    bool SliderAngleEx(scope const(char)* label, scope float* v_rad, float v_degrees_min, float v_degrees_max, scope
        char* format, ImGuiSliderFlags flags) @trusted
    {
        return igSliderAngleEx(label, v_rad, v_degrees_min, v_degrees_max, format, flags);
    }

    bool SliderInt(scope const(char)* label, scope int* v, int v_min, int v_max) @trusted
    {
        return igSliderInt(label, v, v_min, v_max);
    }

    bool SliderIntEx(scope const(char)* label, scope int* v, int v_min, int v_max, scope
        char* format, ImGuiSliderFlags flags) @trusted
    {
        return igSliderIntEx(label, v, v_min, v_max, format, flags);
    }

    bool SliderInt2(scope const(char)* label, scope int* v, int v_min, int v_max) @trusted
    {
        return igSliderInt2(label, v, v_min, v_max);
    }

    bool SliderInt2Ex(scope const(char)* label, scope int* v, int v_min, int v_max, scope
        char* format, ImGuiSliderFlags flags) @trusted
    {
        return igSliderInt2Ex(label, v, v_min, v_max, format, flags);
    }

    bool SliderInt3(scope const(char)* label, scope int* v, int v_min, int v_max) @trusted
    {
        return igSliderInt3(label, v, v_min, v_max);
    }

    bool SliderInt3Ex(scope const(char)* label, scope int* v, int v_min, int v_max, scope
        char* format, ImGuiSliderFlags flags) @trusted
    {
        return igSliderInt3Ex(label, v, v_min, v_max, format, flags);
    }

    bool SliderInt4(scope const(char)* label, scope int* v, int v_min, int v_max) @trusted
    {
        return igSliderInt4(label, v, v_min, v_max);
    }

    bool SliderInt4Ex(scope const(char)* label, scope int* v, int v_min, int v_max, scope
        char* format, ImGuiSliderFlags flags) @trusted
    {
        return igSliderInt4Ex(label, v, v_min, v_max, format, flags);
    }

    bool SliderScalar(scope const(char)* label, ImGuiDataType data_type, scope void* p_data, scope
        void* p_min, scope void* p_max) @trusted
    {
        return igSliderScalar(label, data_type, p_data, p_min, p_max);
    }

    bool SliderScalarEx(scope const(char)* label, ImGuiDataType data_type, scope void* p_data, scope void* p_min, scope
        void* p_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
    {
        return igSliderScalarEx(label, data_type, p_data, p_min, p_max, format, flags);
    }

    bool SliderScalarN(scope const(char)* label, ImGuiDataType data_type, scope void* p_data, int components, scope
        void* p_min, scope void* p_max) @trusted
    {
        return igSliderScalarN(label, data_type, p_data, components, p_min, p_max);
    }

    bool SliderScalarNEx(scope const(char)* label, ImGuiDataType data_type, scope void* p_data, int components, scope void* p_min, scope
        void* p_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
    {
        return igSliderScalarNEx(label, data_type, p_data, components, p_min, p_max, format, flags);
    }

    bool VSliderFloat(scope const(char)* label, ImVec2 size, scope float* v, float v_min, float v_max) @trusted
    {
        return igVSliderFloat(label, size, v, v_min, v_max);
    }

    bool VSliderFloatEx(scope const(char)* label, ImVec2 size, scope float* v, float v_min, float v_max, scope
        char* format, ImGuiSliderFlags flags) @trusted
    {
        return igVSliderFloatEx(label, size, v, v_min, v_max, format, flags);
    }

    bool VSliderInt(scope const(char)* label, ImVec2 size, scope int* v, int v_min, int v_max) @trusted
    {
        return igVSliderInt(label, size, v, v_min, v_max);
    }

    bool VSliderIntEx(scope const(char)* label, ImVec2 size, scope int* v, int v_min, int v_max, scope
        char* format, ImGuiSliderFlags flags) @trusted
    {
        return igVSliderIntEx(label, size, v, v_min, v_max, format, flags);
    }

    bool VSliderScalar(scope const(char)* label, ImVec2 size, ImGuiDataType data_type, scope
        void* p_data, scope void* p_min, scope void* p_max) @trusted
    {
        return igVSliderScalar(label, size, data_type, p_data, p_min, p_max);
    }

    bool VSliderScalarEx(scope const(char)* label, ImVec2 size, ImGuiDataType data_type, scope
        void* p_data, scope void* p_min, scope void* p_max, scope const(char)* format, ImGuiSliderFlags flags) @trusted
    {
        return igVSliderScalarEx(label, size, data_type, p_data, p_min, p_max, format, flags);
    }

    bool InputText(scope const(char)* label, scope char* buf, size_t buf_size, ImGuiInputTextFlags flags) @trusted
    {
        return igInputText(label, buf, buf_size, flags);
    }

    bool InputTextEx(scope const(char)* label, scope char* buf, size_t buf_size, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, scope
        void* user_data) @trusted
    {
        return igInputTextEx(label, buf, buf_size, flags, callback, user_data);
    }

    bool InputTextMultiline(scope const(char)* label, scope char* buf, size_t buf_size) @trusted
    {
        return igInputTextMultiline(label, buf, buf_size);
    }

    bool InputTextMultilineEx(scope const(char)* label, scope char* buf, size_t buf_size, ImVec2 size, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, scope
        void* user_data) @trusted
    {
        return igInputTextMultilineEx(label, buf, buf_size, size, flags, callback, user_data);
    }

    bool InputTextWithHint(scope const(char)* label, scope const(char)* hint, scope char* buf, size_t buf_size, ImGuiInputTextFlags flags) @trusted
    {
        return igInputTextWithHint(label, hint, buf, buf_size, flags);
    }

    bool InputTextWithHintEx(scope const(char)* label, scope const(char)* hint, scope char* buf, size_t buf_size, ImGuiInputTextFlags flags, ImGuiInputTextCallback callback, scope
        void* user_data) @trusted
    {
        return igInputTextWithHintEx(label, hint, buf, buf_size, flags, callback, user_data);
    }

    bool InputFloat(scope const(char)* label, scope float* v) @trusted
    {
        return igInputFloat(label, v);
    }

    bool InputFloatEx(scope const(char)* label, scope float* v, float step, float step_fast, scope
        char* format, ImGuiInputTextFlags flags) @trusted
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

    bool InputDoubleEx(scope const(char)* label, scope double* v, double step, double step_fast, scope
        char* format, ImGuiInputTextFlags flags) @trusted
    {
        return igInputDoubleEx(label, v, step, step_fast, format, flags);
    }

    bool InputScalar(scope const(char)* label, ImGuiDataType data_type, scope void* p_data) @trusted
    {
        return igInputScalar(label, data_type, p_data);
    }

    bool InputScalarEx(scope const(char)* label, ImGuiDataType data_type, scope void* p_data, scope void* p_step, scope
        void* p_step_fast, scope const(char)* format, ImGuiInputTextFlags flags) @trusted
    {
        return igInputScalarEx(label, data_type, p_data, p_step, p_step_fast, format, flags);
    }

    bool InputScalarN(scope const(char)* label, ImGuiDataType data_type, scope void* p_data, int components) @trusted
    {
        return igInputScalarN(label, data_type, p_data, components);
    }

    bool InputScalarNEx(scope const(char)* label, ImGuiDataType data_type, scope void* p_data, int components, scope void* p_step, scope
        void* p_step_fast, scope const(char)* format, ImGuiInputTextFlags flags) @trusted
    {
        return igInputScalarNEx(label, data_type, p_data, components, p_step, p_step_fast, format, flags);
    }

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

    bool ColorPicker4(scope const(char)* label, scope float* col, ImGuiColorEditFlags flags, scope
        float* ref_col) @trusted
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

    void SetColorEditOptions(
        ImGuiColorEditFlags flags) @trusted
    {
        igSetColorEditOptions(
            flags);
    }

    bool TreeNode(
        scope const(char)* label) @trusted
    {
        return igTreeNode(label);
    }

    bool TreeNodeStr(scope const(char)* str_id, scope const(char)* fmt) @trusted
    {
        return igTreeNodeStr(str_id, fmt);
    }

    bool TreeNodePtr(scope void* ptr_id, scope const(char)* fmt) @trusted
    {
        return igTreeNodePtr(ptr_id, fmt);
    }

    bool TreeNodeV(Args...)(scope const(char)* str_id, scope const(char)* fmt, Args args) @trusted
    {
        return igTreeNodeV(str_id, fmt, args);
    }

    bool TreeNodeVPtr(Args...)(scope void* ptr_id, scope const(char)* fmt, Args args) @trusted
    {
        return igTreeNodeVPtr(ptr_id, fmt, args);
    }

    bool TreeNodeEx(scope const(char)* label, ImGuiTreeNodeFlags flags) @trusted
    {
        return igTreeNodeEx(label, flags);
    }

    bool TreeNodeExStr(scope const(char)* str_id, ImGuiTreeNodeFlags flags, scope const(char)* fmt) @trusted
    {
        return igTreeNodeExStr(str_id, flags, fmt);
    }

    bool TreeNodeExPtr(scope void* ptr_id, ImGuiTreeNodeFlags flags, scope const(char)* fmt) @trusted
    {
        return igTreeNodeExPtr(ptr_id, flags, fmt);
    }

    bool TreeNodeExV(Args...)(scope const(char)* str_id, ImGuiTreeNodeFlags flags, scope const(char)* fmt, Args args) @trusted
    {
        return igTreeNodeExV(str_id, flags, fmt, args);
    }

    bool TreeNodeExVPtr(Args...)(scope void* ptr_id, ImGuiTreeNodeFlags flags, scope const(char)* fmt, Args args) @trusted
    {
        return igTreeNodeExVPtr(ptr_id, flags, fmt, args);
    }

    void TreePush(
        scope const(char)* str_id) @trusted
    {
        igTreePush(str_id);
    }

    void TreePushPtr(
        scope void* ptr_id) @trusted
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

    void SetNextItemStorageID(
        ImGuiID storage_id) @trusted
    {
        igSetNextItemStorageID(
            storage_id);
    }

    bool Selectable(
        scope const(char)* label) @trusted
    {
        return igSelectable(
            label);
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

    scope ImGuiMultiSelectIO* BeginMultiSelect(
        ImGuiMultiSelectFlags flags) @trusted
    {
        return igBeginMultiSelect(
            flags);
    }

    scope ImGuiMultiSelectIO* BeginMultiSelectEx(
        ImGuiMultiSelectFlags flags, int selection_size, int items_count) @trusted
    {
        return igBeginMultiSelectEx(flags, selection_size, items_count);
    }

    scope ImGuiMultiSelectIO* EndMultiSelect() @trusted
    {
        return igEndMultiSelect();
    }

    void SetNextItemSelectionUserData(
        ImGuiSelectionUserData selection_user_data) @trusted
    {
        igSetNextItemSelectionUserData(
            selection_user_data);
    }

    bool IsItemToggledSelection() @trusted
    {
        return igIsItemToggledSelection();
    }

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

    bool ListBoxCallback(scope const(char)* label, scope int* current_item, ImGuiGetterFunc getter, scope
        void* user_data, int items_count) @trusted
    {
        return igListBoxCallback(label, current_item, getter, user_data, items_count);
    }

    bool ListBoxCallbackEx(scope const(char)* label, scope int* current_item, ImGuiGetterFunc getter, scope
        void* user_data, int items_count, int height_in_items) @trusted
    {
        return igListBoxCallbackEx(label, current_item, getter, user_data, items_count, height_in_items);
    }

    void PlotLines(scope const(char)* label, scope const(float)* values, int values_count) @trusted
    {
        igPlotLines(label, values, values_count);
    }

    void PlotLinesEx(scope const(char)* label, scope const(float)* values, int values_count, int values_offset, scope
        char* overlay_text, float scale_min, float scale_max, ImVec2 graph_size, int stride) @trusted
    {
        igPlotLinesEx(label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size, stride);
    }

    void PlotLinesCallback(scope const(char)* label, ImGuiValues_getterFunc values_getter, scope
        void* data, int values_count) @trusted
    {
        igPlotLinesCallback(label, values_getter, data, values_count);
    }

    void PlotLinesCallbackEx(scope const(char)* label, ImGuiValues_getterFunc values_getter, scope
        void* data, int values_count, int values_offset, scope const(char)* overlay_text, float scale_min, float scale_max, ImVec2 graph_size) @trusted
    {
        igPlotLinesCallbackEx(label, values_getter, data, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size);
    }

    void PlotHistogram(scope const(char)* label, scope const(float)* values, int values_count) @trusted
    {
        igPlotHistogram(label, values, values_count);
    }

    void PlotHistogramEx(scope const(char)* label, scope const(float)* values, int values_count, int values_offset, scope
        char* overlay_text, float scale_min, float scale_max, ImVec2 graph_size, int stride) @trusted
    {
        igPlotHistogramEx(label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size, stride);
    }

    void PlotHistogramCallback(scope const(char)* label, ImGuiValues_getterFunc values_getter, scope
        void* data, int values_count) @trusted
    {
        igPlotHistogramCallback(label, values_getter, data, values_count);
    }

    void PlotHistogramCallbackEx(scope const(char)* label, ImGuiValues_getterFunc values_getter, scope
        void* data, int values_count, int values_offset, scope const(char)* overlay_text, float scale_min, float scale_max, ImVec2 graph_size) @trusted
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

    bool BeginMenu(
        scope const(char)* label) @trusted
    {
        return igBeginMenu(
            label);
    }

    bool BeginMenuEx(scope const(char)* label, bool enabled) @trusted
    {
        return igBeginMenuEx(label, enabled);
    }

    void EndMenu() @trusted
    {
        igEndMenu();
    }

    bool MenuItem(
        scope const(char)* label) @trusted
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

    void SetTooltip(
        scope const(char)* fmt) @trusted
    {
        igSetTooltip(fmt);
    }

    void SetTooltipV(Args...)(scope const(char)* fmt, Args args) @trusted
    {
        igSetTooltipV(fmt, args);
    }

    bool BeginItemTooltip() @trusted
    {
        return igBeginItemTooltip();
    }

    void SetItemTooltip(
        scope const(char)* fmt) @trusted
    {
        igSetItemTooltip(fmt);
    }

    void SetItemTooltipV(Args...)(scope const(char)* fmt, Args args) @trusted
    {
        igSetItemTooltipV(fmt, args);
    }

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

    bool BeginPopupContextWindowEx(
        scope const(char)* str_id, ImGuiPopupFlags popup_flags) @trusted
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

    bool IsPopupOpen(scope const(char)* str_id, ImGuiPopupFlags flags) @trusted
    {
        return igIsPopupOpen(str_id, flags);
    }

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

    void TableNextRowEx(
        ImGuiTableRowFlags row_flags, float min_row_height) @trusted
    {
        igTableNextRowEx(row_flags, min_row_height);
    }

    bool TableNextColumn() @trusted
    {
        return igTableNextColumn();
    }

    bool TableSetColumnIndex(
        int column_n) @trusted
    {
        return igTableSetColumnIndex(
            column_n);
    }

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

    void TableHeader(
        scope const(char)* label) @trusted
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

    scope ImGuiTableSortSpecs* TableGetSortSpecs() @trusted
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

    scope const(char)* TableGetColumnName(
        int column_n) @trusted
    {
        return igTableGetColumnName(
            column_n);
    }

    ImGuiTableColumnFlags TableGetColumnFlags(
        int column_n) @trusted
    {
        return igTableGetColumnFlags(
            column_n);
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

    float GetColumnWidth(
        int column_index) @trusted
    {
        return igGetColumnWidth(
            column_index);
    }

    void SetColumnWidth(int column_index, float width) @trusted
    {
        igSetColumnWidth(column_index, width);
    }

    float GetColumnOffset(
        int column_index) @trusted
    {
        return igGetColumnOffset(
            column_index);
    }

    void SetColumnOffset(int column_index, float offset_x) @trusted
    {
        igSetColumnOffset(column_index, offset_x);
    }

    int GetColumnsCount() @trusted
    {
        return igGetColumnsCount();
    }

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

    void SetTabItemClosed(
        scope const(char)* tab_or_docked_window_label) @trusted
    {
        igSetTabItemClosed(
            tab_or_docked_window_label);
    }

    void LogToTTY(
        int auto_open_depth) @trusted
    {
        igLogToTTY(
            auto_open_depth);
    }

    void LogToFile(int auto_open_depth, scope const(char)* filename) @trusted
    {
        igLogToFile(auto_open_depth, filename);
    }

    void LogToClipboard(
        int auto_open_depth) @trusted
    {
        igLogToClipboard(
            auto_open_depth);
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

    void LogTextV(Args...)(scope const(char)* fmt, Args args) @trusted
    {
        igLogTextV(fmt, args);
    }

    bool BeginDragDropSource(
        ImGuiDragDropFlags flags) @trusted
    {
        return igBeginDragDropSource(
            flags);
    }

    bool SetDragDropPayload(scope const(char)* type, scope void* data, size_t sz, ImGuiCond cond) @trusted
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

    scope ImGuiPayload* AcceptDragDropPayload(
        scope const(char)* type, ImGuiDragDropFlags flags) @trusted
    {
        return igAcceptDragDropPayload(type, flags);
    }

    void EndDragDropTarget() @trusted
    {
        igEndDragDropTarget();
    }

    scope ImGuiPayload* GetDragDropPayload() @trusted
    {
        return igGetDragDropPayload();
    }

    void BeginDisabled(
        bool disabled) @trusted
    {
        igBeginDisabled(
            disabled);
    }

    void EndDisabled() @trusted
    {
        igEndDisabled();
    }

    void PushClipRect(ImVec2 clip_rect_min, ImVec2 clip_rect_max, bool intersect_with_current_clip_rect) @trusted
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

    void SetKeyboardFocusHereEx(
        int offset) @trusted
    {
        igSetKeyboardFocusHereEx(
            offset);
    }

    void SetNavCursorVisible(
        bool visible) @trusted
    {
        igSetNavCursorVisible(
            visible);
    }

    void SetNextItemAllowOverlap() @trusted
    {
        igSetNextItemAllowOverlap();
    }

    bool IsItemHovered(
        ImGuiHoveredFlags flags) @trusted
    {
        return igIsItemHovered(
            flags);
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

    bool IsItemClickedEx(
        ImGuiMouseButton mouse_button) @trusted
    {
        return igIsItemClickedEx(
            mouse_button);
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

    scope ImGuiViewport* GetMainViewport() @trusted
    {
        return igGetMainViewport();
    }

    scope ImDrawList* GetBackgroundDrawList() @trusted
    {
        return igGetBackgroundDrawList();
    }

    scope ImDrawList* GetForegroundDrawList() @trusted
    {
        return igGetForegroundDrawList();
    }

    bool IsRectVisibleBySize(
        ImVec2 size) @trusted
    {
        return igIsRectVisibleBySize(
            size);
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

    scope ImDrawListSharedData* GetDrawListSharedData() @trusted
    {
        return igGetDrawListSharedData();
    }

    scope const(char)* GetStyleColorName(
        ImGuiCol idx) @trusted
    {
        return igGetStyleColorName(
            idx);
    }

    void SetStateStorage(
        scope ImGuiStorage* storage) @trusted
    {
        igSetStateStorage(
            storage);
    }

    scope ImGuiStorage* GetStateStorage() @trusted
    {
        return igGetStateStorage();
    }

    ImVec2 CalcTextSize(
        scope const(char)* text) @trusted
    {
        return igCalcTextSize(
            text);
    }

    ImVec2 CalcTextSizeEx(scope const(char)* text, scope const(char)* text_end, bool hide_text_after_double_hash, float wrap_width) @trusted
    {
        return igCalcTextSizeEx(text, text_end, hide_text_after_double_hash, wrap_width);
    }

    ImVec4 ColorConvertU32ToFloat4(
        ImU32 in_) @trusted
    {
        return igColorConvertU32ToFloat4(
            in_);
    }

    ImU32 ColorConvertFloat4ToU32(
        ImVec4 in_) @trusted
    {
        return igColorConvertFloat4ToU32(
            in_);
    }

    void ColorConvertRGBtoHSV(float r, float g, float b, scope float* out_h, scope
        float* out_s, scope float* out_v) @trusted
    {
        igColorConvertRGBtoHSV(r, g, b, out_h, out_s, out_v);
    }

    void ColorConvertHSVtoRGB(float h, float s, float v, scope float* out_r, scope
        float* out_g, scope float* out_b) @trusted
    {
        igColorConvertHSVtoRGB(h, s, v, out_r, out_g, out_b);
    }

    bool IsKeyDown(ImGuiKey key) @trusted
    {
        return igIsKeyDown(key);
    }

    bool IsKeyPressed(
        ImGuiKey key) @trusted
    {
        return igIsKeyPressed(
            key);
    }

    bool IsKeyPressedEx(ImGuiKey key, bool repeat) @trusted
    {
        return igIsKeyPressedEx(key, repeat);
    }

    bool IsKeyReleased(
        ImGuiKey key) @trusted
    {
        return igIsKeyReleased(
            key);
    }

    bool IsKeyChordPressed(
        ImGuiKeyChord key_chord) @trusted
    {
        return igIsKeyChordPressed(
            key_chord);
    }

    int GetKeyPressedAmount(ImGuiKey key, float repeat_delay, float rate) @trusted
    {
        return igGetKeyPressedAmount(key, repeat_delay, rate);
    }

    scope const(char)* GetKeyName(
        ImGuiKey key) @trusted
    {
        return igGetKeyName(key);
    }

    void SetNextFrameWantCaptureKeyboard(
        bool want_capture_keyboard) @trusted
    {
        igSetNextFrameWantCaptureKeyboard(
            want_capture_keyboard);
    }

    bool Shortcut(ImGuiKeyChord key_chord, ImGuiInputFlags flags) @trusted
    {
        return igShortcut(key_chord, flags);
    }

    void SetNextItemShortcut(
        ImGuiKeyChord key_chord, ImGuiInputFlags flags) @trusted
    {
        igSetNextItemShortcut(key_chord, flags);
    }

    void SetItemKeyOwner(
        ImGuiKey key) @trusted
    {
        igSetItemKeyOwner(key);
    }

    bool IsMouseDown(
        ImGuiMouseButton button) @trusted
    {
        return igIsMouseDown(
            button);
    }

    bool IsMouseClicked(
        ImGuiMouseButton button) @trusted
    {
        return igIsMouseClicked(
            button);
    }

    bool IsMouseClickedEx(ImGuiMouseButton button, bool repeat) @trusted
    {
        return igIsMouseClickedEx(button, repeat);
    }

    bool IsMouseReleased(
        ImGuiMouseButton button) @trusted
    {
        return igIsMouseReleased(
            button);
    }

    bool IsMouseDoubleClicked(
        ImGuiMouseButton button) @trusted
    {
        return igIsMouseDoubleClicked(
            button);
    }

    bool IsMouseReleasedWithDelay(
        ImGuiMouseButton button, float delay) @trusted
    {
        return igIsMouseReleasedWithDelay(button, delay);
    }

    int GetMouseClickedCount(
        ImGuiMouseButton button) @trusted
    {
        return igGetMouseClickedCount(
            button);
    }

    bool IsMouseHoveringRect(ImVec2 r_min, ImVec2 r_max) @trusted
    {
        return igIsMouseHoveringRect(r_min, r_max);
    }

    bool IsMouseHoveringRectEx(ImVec2 r_min, ImVec2 r_max, bool clip) @trusted
    {
        return igIsMouseHoveringRectEx(r_min, r_max, clip);
    }

    bool IsMousePosValid(
        scope ImVec2* mouse_pos) @trusted
    {
        return igIsMousePosValid(
            mouse_pos);
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

    ImVec2 GetMouseDragDelta(
        ImGuiMouseButton button, float lock_threshold) @trusted
    {
        return igGetMouseDragDelta(button, lock_threshold);
    }

    void ResetMouseDragDelta() @trusted
    {
        igResetMouseDragDelta();
    }

    void ResetMouseDragDeltaEx(
        ImGuiMouseButton button) @trusted
    {
        igResetMouseDragDeltaEx(
            button);
    }

    ImGuiMouseCursor GetMouseCursor() @trusted
    {
        return igGetMouseCursor();
    }

    void SetMouseCursor(
        ImGuiMouseCursor cursor_type) @trusted
    {
        igSetMouseCursor(
            cursor_type);
    }

    void SetNextFrameWantCaptureMouse(
        bool want_capture_mouse) @trusted
    {
        igSetNextFrameWantCaptureMouse(
            want_capture_mouse);
    }

    scope const(char)* GetClipboardText() @trusted
    {
        return igGetClipboardText();
    }

    void SetClipboardText(
        scope const(char)* text) @trusted
    {
        igSetClipboardText(text);
    }

    void LoadIniSettingsFromDisk(
        scope const(char)* ini_filename) @trusted
    {
        igLoadIniSettingsFromDisk(
            ini_filename);
    }

    void LoadIniSettingsFromMemory(
        scope const(char)* ini_data, size_t ini_size) @trusted
    {
        igLoadIniSettingsFromMemory(ini_data, ini_size);
    }

    void SaveIniSettingsToDisk(
        scope const(char)* ini_filename) @trusted
    {
        igSaveIniSettingsToDisk(
            ini_filename);
    }

    scope const(char)* SaveIniSettingsToMemory(
        scope size_t* out_ini_size) @trusted
    {
        return igSaveIniSettingsToMemory(
            out_ini_size);
    }

    void DebugTextEncoding(
        scope const(char)* text) @trusted
    {
        igDebugTextEncoding(
            text);
    }

    void DebugFlashStyleColor(
        ImGuiCol idx) @trusted
    {
        igDebugFlashStyleColor(
            idx);
    }

    void DebugStartItemPicker() @trusted
    {
        igDebugStartItemPicker();
    }

    bool DebugCheckVersionAndDataLayout(
        scope const(char)* version_str, size_t sz_io, size_t sz_style, size_t sz_vec2, size_t sz_vec4, size_t sz_drawvert, size_t sz_drawidx) @trusted
    {
        return igDebugCheckVersionAndDataLayout(
            version_str, sz_io, sz_style, sz_vec2, sz_vec4, sz_drawvert, sz_drawidx);
    }

    void DebugLog(
        scope const(char)* fmt) @trusted
    {
        igDebugLog(fmt);
    }

    void DebugLogV(Args...)(scope const(char)* fmt, Args args) @trusted
    {
        igDebugLogV(fmt, args);
    }

    void SetAllocatorFunctions(
        ImGuiMemAllocFunc alloc_func, ImGuiMemFreeFunc free_func, scope
        void* user_data) @trusted
    {
        igSetAllocatorFunctions(alloc_func, free_func, user_data);
    }

    void GetAllocatorFunctions(
        scope ImGuiMemAllocFunc* p_alloc_func, scope
        ImGuiMemFreeFunc* p_free_func, scope void** p_user_data) @trusted
    {
        igGetAllocatorFunctions(p_alloc_func, p_free_func, p_user_data);
    }

    scope void* MemAlloc(
        size_t size) @trusted
    {
        return igMemAlloc(size);
    }

    void MemFree(scope void* ptr) @trusted
    {
        igMemFree(ptr);
    }

    void ImageImVec4(ImTextureID user_texture_id, ImVec2 image_size, ImVec2 uv0, ImVec2 uv1, ImVec4 tint_col, ImVec4 border_col) @trusted
    {
        igImageImVec4(user_texture_id, image_size, uv0, uv1, tint_col, border_col);
    }

    void PushButtonRepeat(
        bool repeat) @trusted
    {
        igPushButtonRepeat(
            repeat);
    }

    void PopButtonRepeat() @trusted
    {
        igPopButtonRepeat();
    }

    void PushTabStop(
        bool tab_stop) @trusted
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

    void ShowStackToolWindow(
        scope bool* p_open) @trusted
    {
        igShowStackToolWindow(
            p_open);
    }

    bool ComboObsolete(scope const(char)* label, scope int* current_item, ImGuiOld_callbackFunc old_callback, scope
        void* user_data, int items_count) @trusted
    {
        return igComboObsolete(label, current_item, old_callback, user_data, items_count);
    }

    bool ComboObsoleteEx(scope const(char)* label, scope int* current_item, ImGuiOld_callbackFunc old_callback, scope
        void* user_data, int items_count, int popup_max_height_in_items) @trusted
    {
        return igComboObsoleteEx(label, current_item, old_callback, user_data, items_count, popup_max_height_in_items);
    }

    bool ListBoxObsolete(scope const(char)* label, scope int* current_item, ImGuiOld_callbackFunc old_callback, scope
        void* user_data, int items_count) @trusted
    {
        return igListBoxObsolete(label, current_item, old_callback, user_data, items_count);
    }

    bool ListBoxObsoleteEx(scope const(char)* label, scope int* current_item, ImGuiOld_callbackFunc old_callback, scope
        void* user_data, int items_count, int height_in_items) @trusted
    {
        return igListBoxObsoleteEx(label, current_item, old_callback, user_data, items_count, height_in_items);
    }

    void SetItemAllowOverlap() @trusted
    {
        igSetItemAllowOverlap();
    }

    void PushAllowKeyboardFocus(
        bool tab_stop) @trusted
    {
        igPushAllowKeyboardFocus(
            tab_stop);
    }

    void PopAllowKeyboardFocus() @trusted
    {
        igPopAllowKeyboardFocus();
    }

}
