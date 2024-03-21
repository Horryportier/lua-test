local Test = require("lib")

Test:add("foo", function()
	assert(1 == 2, "1 == 2 is not equal")
	return "err"
end)

Test:add("bar", function()
	error("Error", 1)
	return "err"
end)

--print(inspect(Test.t))

Test:run()
