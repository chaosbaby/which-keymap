## what it is about
this is neovim plug to manage you keymaps 
with main features like
1. register a group of keymaps as table like which-key do
2. unregister a group of keymaps
3. unregistered group not show in which panel
4. toggle excmd to a group of keymaps, to make which-key hydra like or normal keymap like
5. auto gen text-objects keymap groups  

## what it is for
1. to make some group of keymaps more convenient like hydra mode
  1. repeat action in plug:
    1. lsp diagnostics
    2. gitsigns hunk
    3. coverage uncovered line
    4. treesitter textobject such as: function, call, assignment etc.
2. disable a group of keymaps also with is show in which panel
3. assign a keymap group to a prefix with ease

## what is the requires
plugs to enhance it  
1. "folke/which-key.nvim"  for hydra mode
2. "nvim-treesitter/nvim-treesitter","nvim-treesitter/nvim-treesitter-textobjects" for textobject keymaps group auto gen.

## how to install it
	{
		"chaoszendao/which-keymap",
		event = "VeryLazy",
        opts = {
        
        }
	},
## how to use it
if you know how to use which-key and treesitter textobjects, you already know how to use it

## comparison with others
1. which-key
  1. deleted keymaps still shown in it panel
  2. no easy way to change to hydra mode
  3. can't easy sign a group of keymaps a prefix after neovim lunched 
1. nvim-hydra
  1. settings for each group
  2. complexed work with which-key

## examples the way to use it
1. command like  :WhichKeyMap hydraToggle prefix|keymap lhs
2. command like :WhichKeyMap Assign group prefix
## some recommendations

