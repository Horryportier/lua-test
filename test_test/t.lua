local Error = require("error")

return function()
	return Error({ debug = debug.getinfo(1) })
end
