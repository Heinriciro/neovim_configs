local packer = require("packer")
packer.startup({
  function(use)
    -- Packer 可以管理自己本身
    use 'wbthomason/packer.nvim'
    -- 你的插件列表...

    use {
      "loctvl842/monokai-pro.nvim",
      config = function()
        require("plugin_configs.monokai")
      end,
    }

    use {
      "kyazdani42/nvim-tree.lua",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("plugin_configs.nvim-tree")
      end,
    }

    use {
      "akinsho/bufferline.nvim",
      tag = "*",
      requires = {
        'nvim-tree/nvim-web-devicons',
        "moll/vim-bbye",
      },
      config = function()
        require("plugin_configs.bufferline")
      end,
    }

    use { 
      "nvim-lualine/lualine.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("plugin_configs.nvim-lualine")
      end,
    }

    use "arkav/lualine-lsp-progress"

    -- telescope （新增）
    use { 
      'nvim-telescope/telescope.nvim',
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("plugin_configs.telescope")
      end,
    }

    use { 
      'nvim-telescope/telescope-fzf-native.nvim',
      run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    }

    -- dashboard-nvim (新增)
    use {
      "glepnir/dashboard-nvim",
      requires = "nvim-tree/nvim-web-devicons",
      config = function()
        require("plugin_configs.dashboard")
      end,
    }

    use {
      "ahmedkhalf/project.nvim",
      config = function()
        require("plugin_configs.project")
      end,
    }

    -- nvim-tree-sitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("plugin_configs.tree-sitter")
      end,
    }
  end,
  config = {
    -- 并发数限制
    max_jobs = 16,
    -- 自定义源
    git = {
      -- default_url_format = "https://hub.fastgit.xyz/%s",
      -- default_url_format = "https://mirror.ghproxy.com/https://github.com/%s",
      -- default_url_format = "https://gitcode.net/mirrors/%s",
      -- default_url_format = "https://gitclone.com/github.com/%s",
    },
    display = {
      open_fn = function()
        return require("packer.util").float({border = "single"})
      end,
    },
  },
})

-- 每次保存 plugins.lua 自动安装插件
pcall(
  vim.cmd,
  [[
    augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
    augroup end
  ]]
)

