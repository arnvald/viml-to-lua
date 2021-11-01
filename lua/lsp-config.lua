local util = require 'lspconfig/util'
local function setup_servers()
  require'lspinstall'.setup()
  local servers = require'lspinstall'.installed_servers()
  for _, server in pairs(servers) do
    if server == 'typescript' then
      print(util.root_pattern("package.json", "tsconfig.json", ".git")())
      require'lspconfig'[server].setup {
        on_attach = custom_attach,
        root_dir = function (pattern) return util.root_pattern("package.json", "tsconfig.json", ".git")(pattern) or vim.loop.cwd() end ,
        filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
        cmd = { "typescript-language-server", "--stdio" }
      }
    else
      require'lspconfig'[server].setup{}
    end
  end
end

setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function ()
  setup_servers() -- reload installed servers
  vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

