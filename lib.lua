local TestMeta = require("meta")
local Format = require("format")
local Error = require("error")

-- TODO:
-- - [ ] courutines?
-- - [x] formaters for tybels
-- - [ ] global options

-- TODO: custom formaters,
---@class TestOpts

---@see Test can either trow error using errro or assert or can return bool, error which is a custom error
---@alias Test { fn: fun(): Error|nil,  opts: table }

---@class TestFramework
---@field t Test[]
---@field add fun(self: TestFramework, id: string, fn: fun(): Error|nil, opts: table|nil)
---@field run fun(self: TestFramework)
---@field err fun(err: Error)
---@field log fun(msg: string|number)
---@field warn fun(msg: string)
local T = TestMeta({})

T.log = Format.logfmt
T.err = Format.errfmt
T.warn = Format.warnfmt

---@diagnostic disable-next-line: redundant-parameter
function T:add(id, fn, opts)
	self.t[id] = { fn = fn, opts = opts }
end

function T:run()
	for key, test in pairs(self.t) do
		local succes, error = pcall(test.fn)
		self.log(key)
		if not succes then
			if error ~= nil then
				self.err(error)
			else
				self.err(Error({}))
			end
		end
		if succes and type(error) == "table" then
			print(tostring(error))
		end
	end
end

return T
