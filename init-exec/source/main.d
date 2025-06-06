module main;
immutable generate =
`
module app;

import sapp = sokol.app;
import log = sokol.log;

void main()
{
	sapp.Desc runner = {
		window_title: "sokol-app",
		init_cb: &init,
		frame_cb: &frame,
		cleanup_cb: &cleanup,
		width: 640,
		height: 480,
		win32_console_attach: false,
		icon: {sokol_default: true},
		logger: {func: &log.func}
	};
	sapp.run(runner);
}

extern (C)
{
	static void init()
	{
		// TODO: init code goes here
	}

	static void frame()
	{
		// TODO: frame code goes here
	}

	static void cleanup()
	{
		// TODO: cleanup code goes here
	}
}
`;

int main(string[] args)
{
	import std;

	auto sourceFolder = buildPath(getcwd(), "source");
	auto appFilePath = buildPath(sourceFolder, "app.d");
	if (exists(sourceFolder))
	{
		writefln!"[ERROR] A dub package already exists in the directory %s."(getcwd());
		writeln(
			"[ERROR] Please choose an empty directory to initialize your new sokol-d app.");
		return -1;
	}
	mkdir(sourceFolder);
	std.file.write(appFilePath, generate);
	return 0;
}
