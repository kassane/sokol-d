module cimgui.cimgui;

@nogc nothrow extern (C)
{
    bool igBegin(scope const(char)* name, scope bool* p_open, ImGuiWindowFlags flags);
    void igEnd();
    void igSetNextWindowPos(const ImVec2 pos, ImGuiCond cond, const ImVec2 pivot);
    void igSetNextWindowSize(const ImVec2 size, ImGuiCond cond);
    bool igColorEdit3(scope const(char)* label, ref float[3] col, ImGuiColorEditFlags flags);
    bool igBeginChild_Str(scope const(char)* str_id, const ImVec2 size, bool border, ImGuiWindowFlags flags);
    void igText(scope const(char)* fmt, ...);
    void igSameLine(float offset_from_start_x, float spacing);
    scope ImGuiListClipper* ImGuiListClipper_ImGuiListClipper();
    void ImGuiListClipper_destroy(scope ImGuiListClipper* self);
    void ImGuiListClipper_Begin(scope ImGuiListClipper* self, int items_count, float items_height);
    void ImGuiListClipper_End(scope ImGuiListClipper* self);
    void igEndChild();
    void igSeparator();
    float igGetTextLineHeight();
    bool ImGuiListClipper_Step(scope ImGuiListClipper* self);

    struct ImGuiContext;

    struct ImVec2
    {
        float x = 0.0f;
        float y = 0.0f;
    }

    enum ImGuiColorEditFlags_
    {
        ImGuiColorEditFlags_None = 0,
        ImGuiColorEditFlags_NoAlpha = 1 << 1,
        ImGuiColorEditFlags_NoPicker = 1 << 2,
        ImGuiColorEditFlags_NoOptions = 1 << 3,
        ImGuiColorEditFlags_NoSmallPreview = 1 << 4,
        ImGuiColorEditFlags_NoInputs = 1 << 5,
        ImGuiColorEditFlags_NoTooltip = 1 << 6,
        ImGuiColorEditFlags_NoLabel = 1 << 7,
        ImGuiColorEditFlags_NoSidePreview = 1 << 8,
        ImGuiColorEditFlags_NoDragDrop = 1 << 9,
        ImGuiColorEditFlags_NoBorder = 1 << 10,
        ImGuiColorEditFlags_AlphaBar = 1 << 16,
        ImGuiColorEditFlags_AlphaPreview = 1 << 17,
        ImGuiColorEditFlags_AlphaPreviewHalf = 1 << 18,
        ImGuiColorEditFlags_HDR = 1 << 19,
        ImGuiColorEditFlags_DisplayRGB = 1 << 20,
        ImGuiColorEditFlags_DisplayHSV = 1 << 21,
        ImGuiColorEditFlags_DisplayHex = 1 << 22,
        ImGuiColorEditFlags_Uint8 = 1 << 23,
        ImGuiColorEditFlags_Float = 1 << 24,
        ImGuiColorEditFlags_PickerHueBar = 1 << 25,
        ImGuiColorEditFlags_PickerHueWheel = 1 << 26,
        ImGuiColorEditFlags_InputRGB = 1 << 27,
        ImGuiColorEditFlags_InputHSV = 1 << 28,
        ImGuiColorEditFlags_DefaultOptions_
            = ImGuiColorEditFlags_Uint8 | ImGuiColorEditFlags_DisplayRGB
            | ImGuiColorEditFlags_InputRGB | ImGuiColorEditFlags_PickerHueBar,
        ImGuiColorEditFlags_DisplayMask_ = ImGuiColorEditFlags_DisplayRGB
            | ImGuiColorEditFlags_DisplayHSV | ImGuiColorEditFlags_DisplayHex,
        ImGuiColorEditFlags_DataTypeMask_ = ImGuiColorEditFlags_Uint8 | ImGuiColorEditFlags_Float,
        ImGuiColorEditFlags_PickerMask_
            = ImGuiColorEditFlags_PickerHueWheel | ImGuiColorEditFlags_PickerHueBar,
        ImGuiColorEditFlags_InputMask_ = ImGuiColorEditFlags_InputRGB | ImGuiColorEditFlags_InputHSV
    }

    enum ImGuiWindowFlags_
    {
        ImGuiWindowFlags_None = 0,
        ImGuiWindowFlags_NoTitleBar = 1 << 0,
        ImGuiWindowFlags_NoResize = 1 << 1,
        ImGuiWindowFlags_NoMove = 1 << 2,
        ImGuiWindowFlags_NoScrollbar = 1 << 3,
        ImGuiWindowFlags_NoScrollWithMouse = 1 << 4,
        ImGuiWindowFlags_NoCollapse = 1 << 5,
        ImGuiWindowFlags_AlwaysAutoResize = 1 << 6,
        ImGuiWindowFlags_NoBackground = 1 << 7,
        ImGuiWindowFlags_NoSavedSettings = 1 << 8,
        ImGuiWindowFlags_NoMouseInputs = 1 << 9,
        ImGuiWindowFlags_MenuBar = 1 << 10,
        ImGuiWindowFlags_HorizontalScrollbar = 1 << 11,
        ImGuiWindowFlags_NoFocusOnAppearing = 1 << 12,
        ImGuiWindowFlags_NoBringToFrontOnFocus = 1 << 13,
        ImGuiWindowFlags_AlwaysVerticalScrollbar = 1 << 14,
        ImGuiWindowFlags_AlwaysHorizontalScrollbar = 1 << 15,
        ImGuiWindowFlags_AlwaysUseWindowPadding = 1 << 16,
        ImGuiWindowFlags_NoNavInputs = 1 << 18,
        ImGuiWindowFlags_NoNavFocus = 1 << 19,
        ImGuiWindowFlags_UnsavedDocument = 1 << 20,
        ImGuiWindowFlags_NoNav = ImGuiWindowFlags_NoNavInputs | ImGuiWindowFlags_NoNavFocus,
        ImGuiWindowFlags_NoDecoration = ImGuiWindowFlags_NoTitleBar
            | ImGuiWindowFlags_NoResize | ImGuiWindowFlags_NoScrollbar | ImGuiWindowFlags_NoCollapse,
        ImGuiWindowFlags_NoInputs = ImGuiWindowFlags_NoMouseInputs
            | ImGuiWindowFlags_NoNavInputs | ImGuiWindowFlags_NoNavFocus,
        ImGuiWindowFlags_NavFlattened = 1 << 23,
        ImGuiWindowFlags_ChildWindow = 1 << 24,
        ImGuiWindowFlags_Tooltip = 1 << 25,
        ImGuiWindowFlags_Popup = 1 << 26,
        ImGuiWindowFlags_Modal = 1 << 27,
        ImGuiWindowFlags_ChildMenu = 1 << 28
    }

    enum ImGuiCond_
    {
        ImGuiCond_None = 0,
        ImGuiCond_Always = 1 << 0,
        ImGuiCond_Once = 1 << 1,
        ImGuiCond_FirstUseEver = 1 << 2,
        ImGuiCond_Appearing = 1 << 3
    }

    alias ImGuiCond = int;
    alias ImGuiColorEditFlags = int;
    alias ImGuiWindowFlags = int;

    struct ImGuiListClipper
    {
        ImGuiContext* Ctx = null;
        int DisplayStart = 0;
        int DisplayEnd = 0;
        int ItemsCount = 0;
        float ItemsHeight = 0.0f;
        float StartPosY = 0.0f;
        void* TempData = null;
    }
}
