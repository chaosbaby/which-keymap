local M = {}
local excmd = require("which-keymap.excmd")
local group = require("which-keymap.group")
local textobj = require("which-keymap.textobj_keygroup")
M.excmd_toggle = excmd.excmd_toggle
M.excmd_del = excmd.excmd_del
M.excmd_append = excmd.excmd_append
M.register = group.register
M.unregister = group.unregister
M.textobj = textobj

local cmd = vim.api.nvim_create_user_command

cmd("WhichHydraToogle", function(com)
	local fargs = com.fargs
	local prefixs = {}
	for _, key in ipairs(fargs) do
		table.insert(prefixs, " " .. key)
	end

	excmd.hydra_toggle("n", prefixs)
end, { nargs = "+" })

cmd("WhichHydraOn", function(com)
	local fargs = com.fargs
	local prefixs = {}
	for _, key in ipairs(fargs) do
		table.insert(prefixs, " " .. key)
	end
	excmd.hydra_toggle("n", prefixs, "add")
end, { nargs = "+" })

cmd("WhichHydraOff", function(com)
	local fargs = com.fargs
	local prefixs = {}
	for _, key in ipairs(fargs) do
		table.insert(prefixs, " " .. key)
	end

	excmd.hydra_toggle("n", prefixs, "del")
end, { nargs = "+" })

cmd("KeymapGroup", function(com)
	local fargs = com.fargs
	local prefixs = {}
	for _, key in ipairs(fargs) do
		table.insert(prefixs, " " .. key)
	end
	local keymaps = excmd.key_group("n", prefixs)

	vim.print(keymaps)
end, { nargs = "+" })

return M
