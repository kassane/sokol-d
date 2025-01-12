// machine generated, do not edit

module sokol.log;

/// Plug this function into the 'logger.func' struct item when initializing any of the sokol
/// headers. For instance for sokol_audio.h it would loom like this:
/// 
/// saudio_setup(&(saudio_desc){
///     .logger = {
///         .func = slog_func
///     }
/// })
extern(C) void slog_func(const(char)*, uint, uint, const(char)*, uint, const(char)*, void*) @system @nogc nothrow;
/// Plug this function into the 'logger.func' struct item when initializing any of the sokol
/// headers. For instance for sokol_audio.h it would loom like this:
/// 
/// saudio_setup(&(saudio_desc){
///     .logger = {
///         .func = slog_func
///     }
/// })
alias func = slog_func;
