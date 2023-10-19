local M = {}
local util = require("which-keymap.util")
function M.to_keymap_args(mapping)
	-- 转换每个按键映射项
	local mode = mapping.mode
	local lhs = mapping.lhs
	local rhs = mapping.rhs
	local opts = {}
	local optValid = { "silent", "noremap", "desc", "nowait", "silent" }

	-- 遍历每个按键映射项的字段
	for key, value in pairs(mapping) do
		-- 排除 mode、lhs 和 rhs 字段

		-- if key ~= "mode" and key ~= "lhs" and key ~= "rhs" and key ~= "sid" and key ~= "lnum" and key ~= "lnum" then
		if vim.tbl_contains(optValid, key) then
			-- 将字段放到 opts 下
			opts[key] = value
		end
	end

	-- 构建参数
	local args = {
		mode = mode,
		lhs = lhs,
		rhs = rhs,
		opts = opts,
	}

	-- 将参数添加到参数表格中
	return args
end
function M.key_group(mode, prefix)
	local keymaps = vim.api.nvim_get_keymap(mode)
	local keymaps_table = {}
	for _, v in pairs(keymaps) do
		if vim.startswith(v.lhs, prefix) == true then
			table.insert(keymaps_table, v)
		end
	end
	return keymaps_table
end

function M.hydra_toggle(mode, prefix)
	local cmd_formater = "lua Which_show(20,'%s')"
	local formatCmd = "<Cmd>" .. cmd_formater .. "<CR>"
	local keymaps_table = M.key_group(mode, prefix)
	for _, v in pairs(keymaps_table) do
		local args = M.to_keymap_args(v)
		if type(args.rhs) == "string" then
			local excmd
			if prefix == args.lhs then
				excmd = formatCmd:format(prefix:sub(0, -2))
			else
				excmd = formatCmd:format(prefix)
			end
			if args.rhs:find(excmd, 0, true) then
				args.rhs = util.replace(args.rhs, excmd, "")
			else
				args.rhs = args.rhs .. excmd
			end
		end
		vim.keymap.set(args.mode, args.lhs, args.rhs, args.opts)
	end
end

function M.excmd_toggle(mode, prefix, extraCmd)
	local formatCmd = "<Cmd>" .. extraCmd .. "<CR>"
	local keymaps_table = M.key_group(mode, prefix)
	for _, v in pairs(keymaps_table) do
		local args = M.to_keymap_args(v)
		if type(args.rhs) == "string" then
			if args.rhs:find(formatCmd, 0, true) then
				args.rhs = util.replace(args.rhs, formatCmd, "")
			else
				args.rhs = args.rhs .. formatCmd
			end
		end
		vim.keymap.set(args.mode, args.lhs, args.rhs, args.opts)
	end
end

function M.excmd_del(mode, prefix, extraCmd)
	local formatCmd = "<Cmd>" .. extraCmd .. "<CR>"
	local keymaps_table = M.key_group(mode, prefix)
	for _, v in pairs(keymaps_table) do
		local args = M.to_keymap_args(v)
		if type(args.rhs) == "string" then
			args.rhs = util.replace(args.rhs, formatCmd, "")
		end
		vim.keymap.set(args.mode, args.lhs, args.rhs, args.opts)
	end
end

function M.excmd_append(mode, prefix, extraCmd)
	local formatCmd = "<Cmd>" .. extraCmd .. "<CR>"
	local keymaps_table = M.key_group(mode, prefix)
	for _, v in pairs(keymaps_table) do
		local args = M.to_keymap_args(v)
		if type(args.rhs) == "string" then
			args.rhs = args.rhs .. formatCmd
		end
		vim.keymap.set(args.mode, args.lhs, args.rhs, args.opts)
	end
end
return M
