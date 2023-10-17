local _, which_key = pcall(require, "which-key")
local M = {
	default_opts = {
		silent = true,
		noremap = true,
	},
	default_which_key_opts = {
		mode = "n",
		prefix = "<leader>",
		silent = true,
		noremap = true,
	},
}
function M.keymap(mode, lhs, rhs, opts)
	local options = vim.tbl_deep_extend("force", M.default_opts, opts or {})
	options["mode"] = mode
	if type(rhs) == "function" or mode == "i" then
		return
	end
	if type(mode) == "table" and vim.tbl_contains(mode, "i") then
		return
	end
	if options.buffer then
		return
	end
	pcall(which_key.register, { [lhs] = { rhs, options.desc } }, options)
end

function M.unkeymap(mode, lhs, opts)
	local options = opts or {}
	options["mode"] = mode
	pcall(which_key.register, { [lhs] = "which_key_ignore" }, options)
end

function Decrator_prerun(func, prefun)
	return function(...)
		prefun(...)
		local result = func(...)
		return result
	end
end
function Apply_keymap_decrator()
	vim.keymap.set = Decrator_prerun(vim.keymap.set, M.keymap)
	vim.keymap.del = Decrator_prerun(vim.keymap.del, M.unkeymap)
end
Apply_keymap_decrator()

function M.register(tbl, o)
	local opts = vim.tbl_deep_extend("force", M.default_which_key_opts, o or {})
	local prefix = opts.prefix
	local mode = opts.mode
	opts.prefix = nil
	opts.mode = nil
	M.register_group(mode, prefix, tbl, opts)
end

function M.register_group(mode, prefix, tbl_keymap, opts)
	if vim.tbl_isempty(tbl_keymap) then
		return
	end
	if vim.tbl_islist(tbl_keymap) then
		local desc = tbl_keymap[2] or tbl_keymap[1] or ""
		opts.desc = desc
		vim.keymap.set(mode, prefix, tbl_keymap[1], opts)
	else
		for key, cmd_group in pairs(tbl_keymap) do
			if key == "name" then
				if type(cmd_group) == "string" then
					M.keymap(mode, prefix, cmd_group)
				end
			else
				M.register_group(mode, prefix .. key, cmd_group, opts)
			end
		end
	end
end

function M.unregister_group(mode, prefix, tbl_keymap)
	if vim.tbl_isempty(tbl_keymap) then
		return
	end
	if vim.tbl_islist(tbl_keymap) then
		vim.keymap.del(mode, prefix)
	else
		for key, cmd_group in pairs(tbl_keymap) do
			if key == "name" then
				if type(cmd_group) == "string" then
					M.unkeymap(mode, prefix, { desc = cmd_group })
					-- vim.keymap.del(mode, prefix)
				end
			else
				M.unregister_group(mode, prefix .. key, cmd_group)
			end
		end
	end
end

function M.unregister(tbl, o)
	local opts = vim.tbl_deep_extend("force", M.default_which_key_opts, o or {})
	local prefix = opts.prefix
	local mode = opts.mode
	opts.prefix = nil
	opts.mode = nil
	M.unregister_group(mode, prefix, tbl)
end
return M
