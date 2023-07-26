local status, mason = pcall(require, "mason")
if not status then
  vim.notify("mason Not Found!")
  return
end

local status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status then
  vim.notify("mason-lspconfig Not Found!")
  return
end

local status, lspconfig = pcall(require, "lspconfig")
if not status then
  vim.notify("lspconfig Not Found!")
  return
end

mason.setup()

mason_lspconfig.setup({
  ensure_installed = {
    "lua_ls",
    "tsserver",
    "tailwindcss",
    "bashls",
    "cssls",
    "dockerls",
    "emmet_ls",
    "html",
    "jsonls",
    "pyright",
    "rust_analyzer",
    "taplo",
    "yamlls",
--    "gopls",
  }
})

-- 安装列表
-- { key: 服务器名， value: 配置文件 }
-- key 必须为下列网址列出的 server name，不可以随便写
-- https://github.com/williamboman/nvim-lsp-installer#available-lsps
local servers = {
  lua_ls = require("lsp.server_config.lua"), -- lua/lsp/config/lua.lua
  --bashls = require("lsp.server_config.bash"),
  --pyright = require("lsp.server_config.pyright"),
  html = require("lsp.server_config.html"),
  cssls = require("lsp.server_config.css"),
  emmet_ls = require("lsp.server_config.emmet"),
  --jsonls = require("lsp.server_config.json"),
  --tsserver = require("lsp.server_config..typescript"),
  --yamlls = require("lsp.server_config.yamlls"),
  --dockerls = require("lsp.server_config.docker"),
  --tailwindcss = require("lsp.server_config.tailwindcss"),
  --rust_analyzer = require("lsp.server_config.rust"),
  --taplo = require("lsp.server_config.taplo"), -- toml
  --gopls = require("lsp.server_config.gopls"),
  -- remark_ls = require("lsp.server_config.markdown"),
  --clangd = require("lsp.server_config.clangd"),
  --cmake = require("lsp.server_config.cmake"),
}

for name, config in pairs(servers) do
  if config ~= nil and type(config) == "table" then
    -- 自定义初始化配置文件必须实现on_setup 方法
    config.on_setup(lspconfig[name])
  else
    -- 使用默认参数
    lspconfig[name].setup({})
  end
end

require("lsp.ui")
