package = "lua-custom-test"
version = "0.0-5"
source = {
	url = "git://github.com/Horryportier/lua-test/",
	tag = "v0.0-5",
}
description = {
	summary = "testing framwork with custom errors",
	detailed = [[
   	lua-custom-test is testing framwork with ability to create 
	custom errors with nice formating 
   ]],
	homepage = "https://github.com/Horryportier/lua-test/",
	license = "MIT/X11",
}
dependencies = {
	"lua >= 5.1, < 5.4",
}
build = {
	type = "builtin",
	modules = {
		test = "lib.lua",
		error = "error.lua",
		format = "format.lua",
		utils = "utils.lua",
	},
}
