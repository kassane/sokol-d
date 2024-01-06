module sokol.utils;

// helper function to convert a C string to a D string
string cStrTod(inout(char)* c_str) nothrow {
    auto start = c_str;
    auto end = cast(char*) c_str;
    for (; *end; end++){}
    return cast(string) c_str[0 .. end - start];
}