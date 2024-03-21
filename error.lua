---@class Error
---@field error_code string?
---@field description string?
---@field debug debuginfo?
---@field severity number?
local E = {}

local Format = require("format")

E.mt = {
	---@param self Error
	__tostring = function(self)
		print(Format.format_error(self))
	end,
	---@param t Error
	---@return Error
	__call = function(_, t)
		---@type Error
		local new_err = setmetatable({
			error_code = t.error_code or "UNKNOWN",
			description = t.description or "NONE",
			debug = t.debug or {},
			severity = t.severity or 0,
			custom_error = true,
		}, E.mt)
		return new_err
	end,
}

return setmetatable(E, E.mt)
