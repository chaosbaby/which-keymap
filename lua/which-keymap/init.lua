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
	vim.print(fargs)
	for _, key in ipairs(fargs) do
		local prefix = " " .. key
		excmd.hydra_toggle("n", prefix)
	end
end, { nargs = "+" })

cmd("WhichHydraOn", function(com)
	local fargs = com.fargs
	vim.print(fargs)
	for _, key in ipairs(fargs) do
		local prefix = " " .. key
		excmd.hydra_toggle("n", prefix, "add")
	end
end, { nargs = "+" })

cmd("WhichHydraOff", function(com)
	local fargs = com.fargs
	vim.print(fargs)
	for _, key in ipairs(fargs) do
		local prefix = " " .. key
		excmd.hydra_toggle("n", prefix, "del")
	end
end, { nargs = "+" })

return M
