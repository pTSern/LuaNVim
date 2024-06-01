
local lspconfig = require'lspconfig'

local cs_path = vim.fn.expand("~/AppData/Local/nvim-data/mason/packages/omnisharp/libexec/OmniSharp.dll")

lspconfig.omnisharp.setup{
   capabilities = capabilities,
   cmd = { "dotnet", cs_path },
   root_dir = lspconfig.util.root_pattern(".git", ".sln", "*.csproj", "Assets", "ProjectSettings"),

   settings = {
      omnisharp = {
         useModernNet = true,
      }
   }
}

