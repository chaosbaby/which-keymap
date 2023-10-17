local M = {}
function M.replace(str, find, replace)
	local startPos, endPos = string.find(str, find, 0, true)
	while startPos do
		str = string.sub(str, 1, startPos - 1) .. replace .. string.sub(str, endPos + 1)
		startPos, endPos = string.find(str, find)
	end
	return str
end
return M
