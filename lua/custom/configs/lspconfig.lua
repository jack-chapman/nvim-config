local util = require 'lspconfig.util'
local lspconfig = require 'lspconfig'
local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local function get_typescript_server_path(root_dir)
  local global_ts = '/Users/jackchapman/.volta/tools/image/packages/typescript/lib/node_modules/typescript/lib'
  -- Alternative location if installed as root:
  -- local global_ts = '/usr/local/lib/node_modules/typescript/lib'
  local found_ts = ''
  local function check_dir(path)
    found_ts =  util.path.join(path, 'node_modules', 'typescript', 'lib')
    if util.path.exists(found_ts) then
      return path
    end
  end
  if util.search_ancestors(root_dir, check_dir) then
    return found_ts
  else
    return global_ts
  end
end

lspconfig.volar.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {'typescript', 'javascript', 'vue', 'json', 'css', 'scss', 'sass'},
  on_new_config = function(new_config, new_root_dir)
    new_config.init_options.typescript.tsdk = get_typescript_server_path(new_root_dir)
  end,
}

lspconfig.solargraph.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.rubocop.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.gopls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}
