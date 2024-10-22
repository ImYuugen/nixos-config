M = {}

M.icons = {
	diagnostics = {
		Hint = " ",
		Info = " ",
		Warn = " ",
		Error = " ",
	},
	git = {
		Added = " ",
		Removed = " ",
		Modified = "󰎃 ",
	},
}

M.dump = function(o)
	print(type(o))
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

M.flatten_spec = function(v)
	local res = {}
	local function flatten(v)
		for k, i in ipairs(v) do
			print(k)
			print(i)
			print("---")
		end
	end
	flatten(v)
	return res
end

return M
