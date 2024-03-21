---@class Utils
---@field paint fun(str: string, fg: Color?, bg: Color?, mod: Modifier?): string
local Utils = {}

---@alias Style { fg: Color, bg: Color, mod: Modifier }

---@enum Color
local colors = {
	["black"] = "black",
	["red"] = "red",
	["green"] = "green",
	["yellow"] = "yellow",
	["blue"] = "blue",
	["purple"] = "purple",
	["cyan"] = "cyan",
	["white"] = "white",
	["default"] = "default",
}
local colors_codes = {
	["black"] = 30,
	["red"] = 31,
	["green"] = 32,
	["yellow"] = 33,
	["blue"] = 34,
	["purple"] = 35,
	["cyan"] = 36,
	["white"] = 37,
	["default"] = 39,
}

---@enum Modifier
local mods = {
	["normal"] = "normal",
	["bold"] = "bold",
	["faint"] = "faint",
	["italic"] = "italic",
	["underline"] = "underline",
	["slow_blink"] = "slow_blink",
	["blink"] = "blink",
	["reverse"] = "reverse",
	["crossed_out"] = "crossed_out",
}
local mods_codes = {
	["normal"] = 0,
	["bold"] = 1,
	["faint"] = 2,
	["italic"] = 3,
	["underline"] = 4,
	["slow_blink"] = 5,
	["blink"] = 6,
	["reverse"] = 7,
	["crossed_out"] = 9,
}

---@param fgcolor Color?
---@param mod Modifier?
---@overload fun(str: string, Style)
---@overload fun(str: string)
function Utils.paint(str, fgcolor, bgcolor, mod)
	local get_style = function()
		if not fgcolor then
			return { fg = "default", bg = "default", mod = "normal" }
		end
		if type(fgcolor) == "string" then
			---@type Style
			return { fg = fgcolor, bg = bgcolor or "default", mod = mod or "normal" }
		end
		if type(fgcolor) == "table" then
			return fgcolor
		end
	end

	local style = get_style()

	local fg_code = colors_codes[style.fg] or colors_codes["default"]
	local bg_code = (colors_codes[style.bg] or colors_codes["default"]) + 10
	local mod_code = mods_codes[style.mod] or mods_codes["normal"]
	return string.format("\027[%d;%d;%dm%s\027[0m", mod_code, bg_code, fg_code, str)
end
return Utils
