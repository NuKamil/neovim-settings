return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'saghen/blink.cmp',
    optional = true,
    opts = function(_, opts)
      opts.sources = opts.sources or {}
      opts.sources.default = opts.sources.default or { 'lsp', 'path', 'snippets' }

      if not vim.tbl_contains(opts.sources.default, 'lazydev') then
        table.insert(opts.sources.default, 'lazydev')
      end

      opts.sources.providers = opts.sources.providers or {}
      opts.sources.providers.lazydev = {
        module = 'lazydev.integrations.blink',
        score_offset = 100,
      }
    end,
  },
  {
    'rafamadriz/friendly-snippets',
    dependencies = { 'L3MON4D3/LuaSnip' },
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()

      local ok, ls = pcall(require, 'luasnip')
      if not ok then
        return
      end

      local function dirname(p)
        return vim.fs.dirname(p)
      end

      local function basename_no_ext(p)
        return vim.fn.fnamemodify(p, ':t:r')
      end

      local function find_csproj_dir_and_name(start_dir)
        local found = vim.fs.find(function(name)
          return name:match('%.csproj$')
        end, { path = start_dir, upward = true })[1]

        if not found then
          return nil, nil
        end

        return dirname(found), vim.fn.fnamemodify(found, ':t:r')
      end

      local function compute_namespace(file_path)
        local file_dir = dirname(file_path)
        local proj_dir, proj_name = find_csproj_dir_and_name(file_dir)

        if not proj_dir or not proj_name then
          return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
        end

        local rel = file_dir:sub(#proj_dir + 2)
        if rel == '' then
          return proj_name
        end

        rel = rel:gsub('[/\\]', '.')
        return proj_name .. '.' .. rel
      end

      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local f = ls.function_node

      local function ns()
        return compute_namespace(vim.api.nvim_buf_get_name(0))
      end

      local function class_name()
        return basename_no_ext(vim.api.nvim_buf_get_name(0))
      end

      local function iface_name()
        local n = class_name()
        if n:match('^I[A-Z]') then
          return n
        end
        return 'I' .. n
      end

      ls.add_snippets('cs', {
        s('cls', {
          t 'namespace ',
          f(function()
            return ns()
          end, {}),
          t({ ';', '', '' }),
          t 'public class ',
          f(function()
            return class_name()
          end, {}),
          t({ '', '{', '    ' }),
          i(0),
          t({ '', '}' }),
        }),
        s('iface', {
          t 'namespace ',
          f(function()
            return ns()
          end, {}),
          t({ ';', '', '' }),
          t 'public interface ',
          f(function()
            return iface_name()
          end, {}),
          t({ '', '{', '    ' }),
          i(0),
          t({ '', '}' }),
        }),
      })
    end,
  },
}
