---@param s string
---@return boolean
local function empty(s)
	return s == nil or s == ''
end

---@param o any
---@param depth number
---@return string
local function dump_recurse(o, depth)
	local pad_char = "  "
	local padding = string.rep(pad_char, depth)
	if type(o) == 'table' then
		local s = '{\n'
		for k, v in pairs(o) do
			if type(k) ~= 'number' then k = '"' .. k .. '"' end
			s = s .. pad_char .. padding .. '[' .. k .. '] = '
				.. dump_recurse(v, depth + 1) .. ',\n'
		end
		return s .. padding .. '}'
	else
		if type(o) == 'string' then
			return '"' .. o .. '"'
		end
		return tostring(o)
	end
end

-- Dumps object recursively to prettified string
---@param o table
---@return string
local function dump(o)
	return dump_recurse(o, 0)
end

---@param str string
---@param delim string
---@return table
local function split(str, delim)
	delim = delim or " "

	local result = {}
	if empty(str) then
		return result
	end

	for line in str:gmatch("[^" .. delim .. "]+") do
		table.insert(result, line)
	end
	return result
end

Utils = {
	dump = dump,
	split = split,
}
return Utils
