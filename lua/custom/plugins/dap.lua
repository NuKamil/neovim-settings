return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'nvim-neotest/nvim-nio',
      'theHamsta/nvim-dap-virtual-text',
    },
    config = function()
      local dap = require 'dap'
      local dapui = require 'dapui'

      local orig_notify = vim.notify
      vim.notify = function(msg, level, opts)
        if type(msg) == 'string' and msg:match('of adapter `coreclr` exited with 1') then
          level = vim.log.levels.DEBUG
        end
        return orig_notify(msg, level, opts)
      end

      require('nvim-dap-virtual-text').setup {}
      dapui.setup()

      dap.listeners.after.event_initialized.dapui_config = function()
        dapui.open()
      end

      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end

      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      vim.keymap.set('n', '<F5>', dap.continue, { desc = 'DAP: Start/Continue' })
      vim.keymap.set('n', '<F10>', dap.step_over, { desc = 'DAP: Step Over' })
      vim.keymap.set('n', '<F11>', dap.step_into, { desc = 'DAP: Step Into' })
      vim.keymap.set('n', '<F12>', dap.step_out, { desc = 'DAP: Step Out' })
      vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = 'DAP: Toggle Breakpoint' })
      vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'DAP: Toggle UI' })

      local function dotnet_store_dir()
        local dir = vim.fn.stdpath('data') .. '/dap_dotnet'
        vim.fn.mkdir(dir, 'p')
        return dir
      end

      local function dotnet_project_key()
        local cwd = vim.fn.getcwd()
        return (cwd:gsub('[:/\\]', '_'))
      end

      local function dotnet_store_file()
        return dotnet_store_dir() .. '/' .. dotnet_project_key() .. '.txt'
      end

      local function read_last_dotnet_dll()
        local f = dotnet_store_file()
        if vim.fn.filereadable(f) == 1 then
          local lines = vim.fn.readfile(f)
          if #lines > 0 then
            return lines[1]
          end
        end
        return nil
      end

      local function write_last_dotnet_dll(path)
        if path and path ~= '' then
          vim.fn.writefile({ path }, dotnet_store_file())
        end
      end

      local function default_dotnet_hint()
        local root = vim.fn.getcwd()
        local dlls = vim.fn.glob(root .. '/bin/Debug/**/*.dll', true, true)
        local skip = { 'testhost.dll', 'vstest', 'Microsoft.', 'System.', 'xunit', 'nunit' }
        local kept = {}

        for _, p in ipairs(dlls) do
          local bad = false
          for _, s in ipairs(skip) do
            if p:find(s, 1, true) then
              bad = true
              break
            end
          end
          if not bad then
            table.insert(kept, p)
          end
        end

        table.sort(kept, function(a, b)
          return vim.fn.getftime(a) > vim.fn.getftime(b)
        end)

        if kept[1] then
          return kept[1]
        end

        return root .. '/bin/Debug/net8.0/<TwojAsm>.dll'
      end

      local function prompt_dotnet_dll()
        local last = read_last_dotnet_dll()
        local hint = last or default_dotnet_hint()
        local picked = vim.fn.input('Path to dll: ', hint, 'file')
        if picked and picked ~= '' then
          write_last_dotnet_dll(picked)
        end
        return picked
      end

      vim.api.nvim_create_user_command('DotnetClearLastDll', function()
        local f = dotnet_store_file()
        if vim.fn.filereadable(f) == 1 then
          vim.fn.delete(f)
          vim.notify 'Usunięto zapamiętaną ścieżkę DLL dla tego projektu.'
        else
          vim.notify('Brak zapamiętanej ścieżki dla tego projektu.', vim.log.levels.INFO)
        end
      end, {})

      vim.schedule(function()
        local sys = (vim.uv or vim.loop).os_uname().sysname
        local is_win = sys:match 'Windows'
        local data = vim.fn.stdpath 'data'

        local candidates = is_win and {
          data .. '\\mason\\packages\\netcoredbg\\netcoredbg\\netcoredbg.exe',
          data .. '\\mason\\bin\\netcoredbg.cmd',
          data .. '\\mason\\bin\\netcoredbg',
        } or {
          data .. '/mason/bin/netcoredbg',
          data .. '/mason/packages/netcoredbg/netcoredbg/netcoredbg',
        }

        local cmd = nil
        for _, p in ipairs(candidates) do
          if vim.fn.executable(p) == 1 then
            cmd = p
            break
          end
        end

        if not cmd then
          vim.notify('Nie znaleziono netcoredbg (Mason). Sprawdź :Mason i zainstaluj netcoredbg', vim.log.levels.ERROR)
          return
        end

        if vim.fn.getenv 'DOTNET_ROOT' == vim.NIL then
          if is_win then
            vim.fn.setenv('DOTNET_ROOT', 'C:\\Program Files\\dotnet')
          else
            vim.fn.setenv('DOTNET_ROOT', '/usr/share/dotnet')
          end
        end

        dap.adapters.coreclr = {
          type = 'executable',
          command = cmd,
          args = { '--interpreter=vscode' },
        }

        dap.configurations.cs = {
          {
            type = 'coreclr',
            name = 'Launch: wybierz / pamiętaj DLL',
            request = 'launch',
            cwd = '${workspaceFolder}',
            justMyCode = false,
            program = prompt_dotnet_dll,
          },
          {
            type = 'coreclr',
            name = 'Attach (pick process)',
            request = 'attach',
            processId = require('dap.utils').pick_process,
          },
        }
      end)

      vim.keymap.set('n', '<leader>dq', function()
        dap.disconnect { terminateDebuggee = true }
        dapui.close()
      end, { desc = 'DAP: Disconnect (graceful)' })
    end,
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = {
      'mason-org/mason.nvim',
      'mfussenegger/nvim-dap',
    },
    opts = {
      ensure_installed = { 'netcoredbg' },
    },
  },
}
