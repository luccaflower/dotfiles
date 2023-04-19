vim.g.mapleader = ' '
local function global_keymap(mode, shortcut, cmd, desc)
  vim.api.nvim_set_keymap(mode, shortcut, cmd,
    { noremap = true, silent = true, desc = desc })
end

-- Jump to start and end of line using the home row keys
global_keymap('', 'H', '^', 'Start of line')
global_keymap('', 'L', '$', 'End of line')

-- Vifm
global_keymap('n', '<leader>f', ':Vifm<CR>', 'Open file manager')

-- ; as :
global_keymap('n', ';', ':', '')

-- Copy to clipboard
global_keymap('v', '<leader>y', '"+y', 'Yank selection to clipboard')
global_keymap('n', '<leader>Y', '"+yg', 'Yank rest of line to clipboard')
global_keymap('n', '<leader>y', '"+y', 'Yank to clipboard')
global_keymap('n', '<leader>yy', '"+yy', 'Yank line to clipboard')

-- Paste from clipboard
global_keymap('n', '<leader>p', '"+p', 'Paste from clipboard after cursor')
global_keymap('n', '<leader>P', '"+P', 'Paste from clipboard before cursor')
global_keymap('v', '<leader>p', '"+p', 'Paste from clipboard after cursor')
global_keymap('v', '<leader>P', '"+P', 'Paste from clipboard before cursor')

global_keymap('n', '<leader>s', ':Rg<CR>', 'Search for file')

-- Open new file adjacent to current file
--nnoremap <leader>o :e <C-R>=expand("%:p:h") . "/" <CR>
global_keymap(
  'n', '<leader>o', ':e <C-R>=expand("%:p:h") . "/" <CR>',
  'Open adjacent file')

-- Ctrl+h to stop searching
global_keymap('n', '<C-h>', ':nohlsearch<CR>', 'Remove higlights')
global_keymap('v', '<C-h>', ':nohlsearch<CR>', 'Remove higlights')

-- Quick-save
global_keymap('n', '<leader>w', ':w<CR>', 'Save file')

-- Left and right can switch buffers
global_keymap('n', '<Tab><left>', ':bp<CR>', 'Switch to left buffer')
global_keymap('n', '<Tab><right>', ':bn<CR>', 'Switch to right buffer')
global_keymap('n', '<leader>x', ':bd<CR>', 'Close current buffer')
global_keymap('n', '<leader><leader>', '<C-^>', 'Toggle buffers')

global_keymap('n', '<leader>,', ':set invlist<CR>', 'Toggle hidden characters')
global_keymap('n', '<leader>q', 'g<C-G>', 'Show stats')


-- I can type :help on my own, thanks.
global_keymap('', '<F1>', '<Esc>', '')
global_keymap('i', '<F1>', '<Esc>', '')

global_keymap('', '<leader>i', ':e $MYVIMRC<CR>', 'Open init.vim')

-- Move by line
global_keymap('n', 'j', 'gj', '')
global_keymap('n', 'k', 'gk', '')

global_keymap('', '<C-P>', ':Files<CR>', 'Files')
global_keymap('n', '<leader>ö', ':Buffers<CR>', 'Buffers')
