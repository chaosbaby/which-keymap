local group = require("which-keymap.group")
local M = {
	prefix = "o",
}

M.defines = {
	m = "function.outer",
	f = "call.outer",
	d = "conditional.outer",
	o = "loop.outer",
	s = "statement.outer",
	a = "parameter.outer",
	c = "comment.outer",
	b = "block.outer",
	l = "class.outer",
	r = "frame.outer",
	t = "attribute.outer",
	e = "scopename.outer",
	M = "function.inner",
	F = "call.inner",
	D = "conditional.inner",
	O = "loop.inner",
	A = "parameter.inner",
	B = "block.inner",
	L = "class.inner",
	R = "frame.inner",
	T = "attribute.inner",
	E = "scopename.inner",
	g = "assignment.outer",
	G = "assignment.inner",
	n = "assignment.lhs",
	N = "assignment.rhs",
	u = "return.outer",
	U = "return.inner",

	[1] = "_start",
	[2] = "_end",
	[3] = "number.inner",
}

function Which_show(time, prefix)
	local function WhichKeyShow()
		local cmdStr = ("lua require('which-key').show('%s')"):format(prefix)
		vim.cmd(cmdStr)
	end
	vim.defer_fn(WhichKeyShow, time)
end
M.defines_retro = {}
-- vim.tbl_deep_extend("keep", M.defines, M.defines_retro)
M.defines_retro = vim.tbl_extend("keep", M.defines, M.defines_retro)
M.defines_retro = vim.tbl_add_reverse_lookup(M.defines_retro)
-- vim.print(M.defines_retro)

function Available_textobjects()
	local shared = require("nvim-treesitter.textobjects.shared")
	local available_textobjects = shared.available_textobjects(vim.bo.ft)
	vim.print(available_textobjects)
	return available_textobjects
end
function M.form_textobj_keymaps(prefix)
	local excmd_fmt = "<Cmd>lua Which_show(20,' %s')<CR>"
	-- local shared = require("nvim-treesitter.textobjects.shared")
	-- local available_textobjects = shared.available_textobjects(vim.bo.ft)
	local keys = vim.tbl_keys(M.defines)
	local keymaps = {}
	for _, key in ipairs(keys) do
		local name = M.defines_retro[key]
		if key ~= nil then
			local _excmd = excmd_fmt:format(prefix .. key)
			keymaps[key] = {
				name = name,
				j = { (":TSTextobjectGotoNextEnd @%s<CR>%s"):format(name, _excmd), "next end" },
				k = { (":TSTextobjectGotoPreviousEnd @%s<CR>%s"):format(name, _excmd), "prev end" },
				J = { (":TSTextobjectGotoNextStart @%s<CR>%s"):format(name, _excmd), "next start" },
				K = { (":TSTextobjectGotoPreviousStart @%s<CR>%s"):format(name, _excmd), "prev start" },
			}
		else
			vim.print(key, name)
		end
	end
	-- vim.print(keymaps)
	group.register({ [prefix] = keymaps })
	return keymaps
end

--[[ function M.form_textobj_keymaps(prefix)
	local excmd_fmt = "<Cmd>lua Which_show(20,' %s')<CR>"
	-- local shared = require("nvim-treesitter.textobjects.shared")
	-- local available_textobjects = shared.available_textobjects(vim.bo.ft)
	local available_textobjects = vim.tbl_values(M.defines)
	vim.print(available_textobjects)
	local keymaps = {}
	for _, name in ipairs(available_textobjects) do
		local key = M.defines_retro[name]
		if key ~= nil then
			local _excmd = excmd_fmt:format(prefix .. key)
			keymaps[key] = {
				name = name,
				j = { (":TSTextobjectGotoNextEnd @%s<CR>%s"):format(name, _excmd), "next end" },
				k = { (":TSTextobjectGotoPreviousEnd @%s<CR>%s"):format(name, _excmd), "prev end" },
				J = { (":TSTextobjectGotoNextStart @%s<CR>%s"):format(name, _excmd), "next start" },
				K = { (":TSTextobjectGotoPreviousStart @%s<CR>%s"):format(name, _excmd), "prev start" },
			}
		else
			vim.print(key, name)
		end
	end
	-- local bufnr = vim.fn.bufnr()
	-- group.register({ [prefix] = keymaps }, { buffer = bufnr })
	group.register({ [prefix] = keymaps })
	return keymaps
end ]]

function Key_group(mode, prefix)
	local keymaps = vim.api.nvim_get_keymap(mode)
	local keymaps_table = {}
	for _, v in pairs(keymaps) do
		if vim.startswith(v.lhs, prefix) == true then
			table.insert(keymaps_table, v)
		end
	end
	vim.print(keymaps_table)
	return keymaps_table
end

function Key_buf_group(mode, prefix)
	local bufnr = vim.fn.bufnr()
	local keymaps = vim.api.nvim_buf_get_keymap(bufnr, mode)
	local keymaps_table = {}
	for _, v in pairs(keymaps) do
		if vim.startswith(v.lhs, prefix) == true then
			table.insert(keymaps_table, v)
		end
	end
	vim.print(keymaps_table)
	return keymaps_table
end
-- vim.api.nvim_create_autocmd("FileType", {
--
-- 	callback = function()
-- 		M.form_textobj_keymaps(M.prefix)
-- 	end,
-- })
-- vim.api.nvim_create_autocmd("FileType", {
-- 	callback = function()
-- 		a.run(function()
-- 			M.form_textobj_keymaps(M.prefix)
-- 		end)
-- 	end,
-- })

return M