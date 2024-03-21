---@type Utils
local Utils = require("utils")
local paint = Utils.paint

local Fmt = { opts = {
	color = true,
} }

function Fmt.logfmt(msg)
	if Fmt.opts.color then
		print(paint(msg, "green"))
		return
	end
	print(msg)
end
function Fmt.errfmt(err)
	if Fmt.opts.color then
		print(paint(tostring(err), "red"))
		return
	end
	print(tostring(err))
end

function Fmt.warnfmt(msg)
	if Fmt.opts.color then
		print(paint(tostring(msg), "yellow"))
		return
	end
	print(msg)
end

local function left_pad(str, fill, pad)
	return string.rep(fill, pad, "") .. str
end
local type_fmt = function(value)
	if not Fmt.opts.color then
		return "%s = %s"
	end
	if type(value) == "function" or type(value) == "userdata" or type(value) == "thread" then
		return paint("%s", "green") .. " = " .. paint("%s", "purple")
	end
	return paint("%s", "green") .. " = " .. paint("%s", "blue")
end

---@param str string
---@param other string
---@param newline boolean?
---@return string
local function string_append(str, other, newline)
	str = str .. other
	if newline then
		str = str .. "\n"
	end
	return str
end

---@param t table
---@param _offset number?
---@param inner_table boolean?
function Fmt.pretty_table(t, _offset, inner_table)
	local str = ""
	local offset = (_offset or 0)
	local print_key_value = function(key, value, of)
		str = string_append(str, left_pad(string.format(type_fmt(value), key, tostring(value)), " ", of), true)
	end
	if not inner_table then
		str = string_append(str, left_pad("{", " ", offset), true)
	end
	for key, value in pairs(t) do
		if type(value) == "table" then
			if Fmt.opts.color then
				str = string_append(
					str,
					left_pad(string.format(paint("%s", "green") .. " = {", key), " ", offset + 2),
					true
				)
			else
				str = string_append(
					str,
					left_pad(string.format("%s =  {", string.rep(" ", offset or 2), key), " ", offset + 2),
					true
				)
			end
			str = string_append(str, Fmt.pretty_table(value, offset + 2, true), true)
		else
			print_key_value(key, value, offset + 2)
		end
	end
	str = string_append(str, left_pad("}", " ", offset))
	return str
end

---@param err Error
---@return string
function Fmt.format_error(err)
	local fmt = [[
type: %s severity: %s
desc: %s
debug_info: 
%s]]
	return string.format(
		fmt,
		paint(err.error_code, "red"),
		paint(tostring(err.severity), "cyan"),
		paint(err.description, "yellow"),
		Fmt.pretty_table(err.debug)
	)
end

return Fmt
