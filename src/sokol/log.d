/++
+ Machine generated D bindings for Sokol library.
+ 
+     Generated on: 2025-06-29 13:29:17
+ 
+     Source header: sokol_log.h
+     Module: sokol.log
+ 
+     Do not edit manually; regenerate using gen_d.py.
+/
module sokol.log;

/++
+ Plug this function into the 'logger.func' struct item when initializing any of the sokol
+     headers. For instance for sokol_audio.h it would look like this:
+ 
+     saudio_setup(&(saudio_desc){
+         .logger = {
+             .func = slog_func
+         }
+     });
+/
extern(C) void slog_func(const(char)* tag, uint log_level, uint log_item, const(char)* message, uint line_nr, const(char)* filename, void* user_data) @system @nogc nothrow pure;
/++
+ Plug this function into the 'logger.func' struct item when initializing any of the sokol
+     headers. For instance for sokol_audio.h it would look like this:
+ 
+     saudio_setup(&(saudio_desc){
+         .logger = {
+             .func = slog_func
+         }
+     });
+/
alias func = slog_func;
