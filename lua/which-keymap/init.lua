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
	-- local cmd_formater = "lua Which_show(20,'%s')"
	for _, key in ipairs(fargs) do
		local prefix = " " .. key
		-- M.excmd_toggle("n", prefix, cmd_formater:format(prefix))
		excmd.hydra_toggle("n", prefix)
	end
end, { nargs = "+" })

return M
