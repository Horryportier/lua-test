local test_table_meta = {
	--- FIX: buffer oveloflow when using tihs code
	---@param self TestFramework
	---@param key string|number
	--	__newindex = function(self, key, value)
	--		if self[key] ~= nil then
	--			error(string.format("TEST WITH KEY OF %s ALREADY EXIST!", key), 1)
	--		end
	--		self[key] = value
	--	end,
}

return function(table)
	table = { t = setmetatable({}, test_table_meta) }
	return table
end
