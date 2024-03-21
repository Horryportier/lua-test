local TestMeta = require("meta")

-- TODO:
-- - [ ] courutines?
-- - [ ] formaters for tybels
-- - [ ] global options
-- - [ ] logs

-- TODO: custom formaters,
---@class TestOpts

-- NOTE: figure out how to do error
---@alias Error string|table|number|boolean

---@alias Test { fn: fun(): Error|nil,  opts: table }

---@class TestFramework
---@field t Test[]
---@field add fun(self: TestFramework, id: string, fn: fun(): Error|nil, opts: table?)
---@field run fun(self: TestFramework)
---@field errfmt fun(err: Error)
---@field logfmt fun(msg: string)
---@field warnfmt fun(msg: string)
local T = TestMeta({})

function T:add(id, fn, opts)
	self.t[id] = { fn = fn, opts = opts }
end

T.logfmt = function(msg)
	print("\027[32m" .. msg .. "\027[0m")
end

T.errfmt = function(err)
	print("\027[31m" .. tostring(err) .. "\027[0m")
end

T.warnfmt = function(msg)
	print("\027[33m" .. tostring(msg) .. "\027[0m")
end

function T:run()
	for key, test in pairs(self.t) do
		local succes, error = pcall(test.fn)
		self.logfmt(tostring(key))
		if not succes then
			if error ~= nil then
				self.errfmt(error)
			else
				self.errfmt("nil")
			end
		end
	end
end

return T
