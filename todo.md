## what it is about
this is neovim plug to manage you keymaps 
with main features like
1. - [X] register a group of keymaps as table like which-key do @finish(2023-10-19 21:48)
2. - [X] unregister a group of keymaps @finish(2023-10-19 21:48)
3. - [X] unregistered group not show in which panel @finish(2023-10-19 21:48)
4. - [X] toggle excmd to a group of keymaps, to make which-key hydra like or normal keymap like @finish(2023-10-19 21:48)
5. - [X] auto gen text-objects keymap groups   @finish(2023-10-19 21:48)

## what it is for
1. to make some group of keymaps more convenient like hydra mode
  1. repeat action in plug:
    1. - [X] lsp diagnostics @finish(2023-10-19 21:48)
    2. - [X] gitsigns hunk @finish(2023-10-19 21:48)
    3. - [X] coverage uncovered line @finish(2023-10-19 21:48)
    4. - [X] treesitter textobject such as: function, call, assignment etc. @finish(2023-10-19 21:49)
2. - [X] disable a group of keymaps also with is show in which panel @finish(2023-10-19 21:49)
3. - [X] assign a keymap group to a prefix with ease @finish(2023-10-19 21:49)

## what is the requires
plugs to enhance it  
1. - [X] "folke/which-key.nvim"  for hydra mode @finish(2023-10-19 21:49)
2. - [X] "nvim-treesitter/nvim-treesitter","nvim-treesitter/nvim-treesitter-textobjects" for textobject keymaps group auto gen. @finish(2023-10-19 21:49)

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
1. - [X] command like  :WhichHydraToogle prefix|keymap @finish(2023-10-20 02:03) @used(254m)
1. - [X] command like  :WhichHydraOn prefix|keymap @finish(2023-10-20 02:03) @used(254m)
1. - [X] command like  :WhichHydraOff prefix|keymap @finish(2023-10-20 02:03) @used(254m)
2. - [ ] command like :WhichKeyMap Assign group prefix @start(2023-10-19 21:49)
## some recommendations

