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
return M
