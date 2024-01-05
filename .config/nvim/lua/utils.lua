---@param o any
---@param depth int
local function dump_recurse(o, depth)
	local pad_char = "  "
	local padding = string.rep(pad_char, depth)
	if type(o) == 'table' then
		local s = '{\n'
		for k, v in pairs(o) do
			if type(k) ~= 'number' then k = '"' .. k .. '"' end
			s = s .. pad_char .. padding .. '[' .. k .. '] = ' .. dump_recurse(v, depth + 1) .. ',\n'
		end
		return s .. padding .. '}'
	else
		if type(o) == 'string' then
			return '"' .. o .. '"'
		end
		return tostring(o)
	end
end

function Dump(o)
	return dump_recurse(o, 0)
end

return Dump
