local lspconfig = require('lspconfig')
local lsp_keymaps = function(bufnr)
  local opts = { noremap = true, silent = true }
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  --
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>',
    opts)
  buf_set_keymap('n', '<space>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e',
    '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>',
    opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
end

local on_attach = function(bufnr)
  lsp_keymaps(bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

local on_attach_with_format = function(client, bufnr)
  on_attach(bufnr)
  vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
end

local on_attach_no_format = function(client, bufnr)
  on_attach(bufnr)
end

local servers = {
  "dockerls",
  "rust_analyzer",
  "texlab",
  "solargraph",
  "bashls"
}

local cmp = require 'cmp'

--completion
local lspkind_comparator = function(conf)
  local lsp_types = require('cmp.types').lsp
  return function(entry1, entry2)
    local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
    local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]

    local priority1 = conf.kind_priority[kind1] or 0
    local priority2 = conf.kind_priority[kind2] or 0

    if priority1 == priority2 then
      return nil
    end
    return priority2 < priority1
  end
end

local cmp_kinds = {
  Class = ' ',
  Color = ' ',
  Constant = 'ﲀ ',
  Constructor = ' ',
  Enum = '練',
  EnumMember = ' ',
  Event = ' ',
  Field = ' ',
  File = '',
  Folder = ' ',
  Function = ' ',
  Interface = 'ﰮ ',
  Keyword = ' ',
  Method = ' ',
  Module = ' ',
  Operator = '',
  Property = ' ',
  Reference = ' ',
  Snippet = ' ',
  Struct = ' ',
  Text = ' ',
  TypeParameter = ' ',
  Unit = '塞',
  Value = ' ',
  Variable = ' ',
}

local luasnip = require('luasnip')
require('luasnip.loaders.from_vscode').lazy_load()
local kind_priority = {
  Snippet = 9,
  Keyword = 8,
  Variable = 7,
  Function = 6,
  Method = 5,
  Field = 4,
  Property = 4,
  Constant = 3,
  Enum = 3,
  EnumMember = 3,
  Event = 3,
  Operator = 3,
  Reference = 3,
  Struct = 3,
  File = 2,
  Folder = 2,
  Class = 2,
  Color = 2,
  Module = 2,
  Constructor = 1,
  Interface = 1,
  Text = 1,
  TypeParameter = 1,
  Unit = 1,
  Value = 1,
  Buffers = 0,
}
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = string.format('%s %s', cmp_kinds[vim_item.kind],
        vim_item.kind)
      vim_item.menu = ({
        nvim_lsp = '[LSP]',
        luasnip = '[Snp]',
        buffer = '[Buf]',
        nvim_lua = '[Lua]',
        path = '[Pth]',
        calc = '[Clc]',
        emoji = '[Emj]',
      })[entry.source.name]

      return vim_item
    end,
  },
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      lspkind_comparator({ kind_priority = kind_priority }),
      cmp.config.compare.recently_used,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  mapping = {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' })
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'luasnip' },

  })
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local configure_lsp = function(lsp, attach, settings)
  lspconfig[lsp].setup {
    capabilities = capabilities,
    on_attach = attach,
    flags = {
      debounce_text_changes = 150,
    },
    settings = settings
  }
end

for _, lsp in ipairs(servers) do
  configure_lsp(lsp, on_attach_with_format, {})
end

local lua_ls_settings = {
  Lua = {
    runtime = {
      -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
      version = 'LuaJIT',
      -- Setup your lua path
      path = vim.split(package.path, ';')
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = { 'vim' }
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = {
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
      }
    }
  }
}

configure_lsp("lua_ls", on_attach_with_format, lua_ls_settings)

-- Java configuration
local home = os.getenv('HOME')
local root_markers = { '.git' }
local root_dir = require('jdtls.setup').find_root(root_markers)
local workspace_folder = home ..
    "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
local nvim_config = home .. '/.config/nvim'
local jdtls = require('jdtls')
local jdtls_cmd = {
  'java',
  '-Declipse.application=org.eclipse.jdt.ls.core.id1',
  '-Dosgi.bundles.defaultStartLevel=4',
  '-Declipse.product=org.eclipse.jdt.ls.core.product',
  '-Dlog.protocol=true',
  '-Dlog.level=ALL',
  '-Xmx1g',
  '--add-modules=ALL-SYSTEM',
  '--add-opens', 'java.base/java.util=ALL-UNNAMED',
  '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
  '-jar',
  vim.fn.glob(
    home ..
    '/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
  '-configuration',
  home .. '/.local/share/nvim/mason/packages/jdtls/config_linux',
  '-data', workspace_folder
}
local completions = {
  favoriteStaticMembers = {
    "org.assertj.core.api.Assertions.assertThat",
    "org.assertj.core.api.Assertions.assertThatThrownBy",
    "java.util.Objects.requireNonNull",
    "java.util.Objects.requireNonNullElse",
  },
  filteredTypes = {
    "com.sun.*",
    "io.micrometer.shaded.*",
    "java.awt.*",
    "jdk.*",
    "sun.*",
  },
}
local extendedClientCapabilities = jdtls.extendedClientCapabilities;
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true;

local java_config = {
  cmd = jdtls_cmd,
  completion = completions,
  root_dir = jdtls.setup.find_root({ '.git' }),
  on_attach = function(client, bufnr)
    on_attach_with_format(client, bufnr)
    jdtls.setup.add_commands()
    local opts = { silent = true, buffer = bufnr }
    vim.keymap.set('n', "<leader>ji", jdtls.organize_imports, opts)
    vim.keymap.set('n', "<leader>jt", jdtls.test_class, opts)
    vim.keymap.set('n', "<leader>jv", jdtls.extract_variable, opts)
    vim.keymap.set('v', '<leader>jm',
      [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]], opts)
    vim.keymap.set('n', "<leader>jc", jdtls.extract_constant, opts)
  end,
  init_options = {
    extendedClientCapabilities = extendedClientCapabilities,
  },
  settings = {
    java = {
      format = {
        settings = {
          url = nvim_config .. '/codestyle/java.xml'
        }
      }
    }
  },
}
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "java" },
  callback = function()
    jdtls.start_or_attach(java_config)
  end,
  group = nvim_java_group,
})

vim.lsp.handlers["textDocuments/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

require("mason").setup()
require("mason-lspconfig").setup()

-- Rust-tools
require('rust-tools').setup({
  runnables = {
    use_telescope = false
  },
  debuggables = {
    use_telescope = false
  },
})

-- Scala
local metals = require("metals")
local metals_config = metals.bare_config()
metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = { "akka.actor.typed.javadsl",
    "com.github.swagger.akka.javadsl" },
}
metals_config.capabilities = capabilities
metals_config.on_attach = on_attach_with_format

local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals",
  { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt" },
  callback = function()
    metals.initialize_or_attach(metals_config)
  end,
  group = nvim_metals_group,
})

-- Rainbow brackets
require 'nvim-treesitter.configs'.setup {
  rainbow = {
    enable = true,
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}


-- Discord Rich Presence
require('presence'):setup({
  neovim_image_text = "vim user btw"
})

-- Indent guides
require('indent_guides').setup({})
