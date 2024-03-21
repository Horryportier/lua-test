local Test = require("lib")
local Format = require("format")
local Error = require("error")
local Test_test = require("test_test.t")

--Test:add("foo", function()
--	assert(1 == 2, "1 == 2 is not equal")
--end)
--
--Test:add("bar", function()
--	error("Error", 1)
--end)
--
--Test:add("baz", function()
--	assert(1, "passing")
--	return nil
--end)
Test:add("custom_error", function()
	assert(1, "")
	return Error({
		error_code = "CUSTOM_ERROR_TEST",
		debug = debug.getinfo(1),
		description = "custom error test testting formating and such",
		severity = 3,
	})
end)

Test:add("test from different file", Test_test)

--print(Format.pretty_table({ "hello", "hi", tree = "baka", { 1, 2, 3 } }))

Test:run()
