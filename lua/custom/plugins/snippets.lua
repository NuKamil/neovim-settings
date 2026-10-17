vim.pack.add { 'https://github.com/rafamadriz/friendly-snippets' }
require('luasnip.loaders.from_vscode').lazy_load()

local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

local function namespace()
  local file_path = vim.api.nvim_buf_get_name(0)
  local file_dir = vim.fs.dirname(file_path)

  local csproj = vim.fs.find(function(name)
    return name:match '%.csproj$'
  end, { path = file_dir, upward = true })[1]

  if not csproj then
    return vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
  end

  local project_dir = vim.fs.dirname(csproj)
  local project_name = vim.fn.fnamemodify(csproj, ':t:r')
  local relative_dir = file_dir:sub(#project_dir + 2)

  if relative_dir == '' then
    return project_name
  end

  return project_name .. '.' .. relative_dir:gsub('[/\\]', '.')
end

local function class_name()
  return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':t:r')
end

local function interface_name()
  local name = class_name()
  if name:match '^I[A-Z]' then
    return name
  end
  return 'I' .. name
end

local function declaration(trigger, keyword, name_function)
  return s(trigger, {
    t 'namespace ',
    f(namespace, {}),
    t { ';', '', '' },
    t('public ' .. keyword .. ' '),
    f(name_function, {}),
    t { '', '{', '    ' },
    i(0),
    t { '', '}' },
  })
end

ls.add_snippets('cs', {
  declaration('clsK', 'class', class_name),
  declaration('sclsK', 'sealed class', class_name),
  declaration('recK', 'record', class_name),
  declaration('srecK', 'sealed record', class_name),
  declaration('ifaceK', 'interface', interface_name),
})
