local progress_handle
local fidget = require("fidget")
local progress = require("fidget.progress")

require("xcodebuild").setup({
      show_build_progress_bar = false,
      logs = {
        auto_open_on_success_tests = false,
        auto_open_on_failed_tests = false,
        auto_open_on_success_build = false,
        auto_open_on_failed_build = false,
        auto_focus = false,
        auto_close_on_app_launch = true,
        only_summary = true,
        notify = function(message, severity)
          if progress_handle then
            progress_handle.message = message
            if not message:find("Loading") then
              progress_handle:finish()
              progress_handle = nil
              if vim.trim(message) ~= "" then
                fidget.notify(message, severity)
              end
            end
          else
            fidget.notify(message, severity)
          end
        end,
        notify_progress = function(message)

          if progress_handle then
            progress_handle.title = ""
            progress_handle.message = message
          else
            progress_handle = progress.handle.create({
              message = message,
              lsp_client = { name = "xcodebuild.nvim" },
            })
          end
        end,
      },
      code_coverage = {
        enabled = true,
      },
    })

    -- stylua: ignore start
    vim.keymap.set("n", "<leader>X", "<cmd>XcodebuildPicker<cr>", { desc = "Show Xcodebuild Actions" })
    vim.keymap.set("n", "<leader>xf", "<cmd>XcodebuildProjectManager<cr>", { desc = "Show Project Manager Actions" })

    vim.keymap.set("n", "<leader>xb", "<cmd>XcodebuildBuild<cr>", { desc = "Build Project" })
    vim.keymap.set("n", "<leader>xB", "<cmd>XcodebuildBuildForTesting<cr>", { desc = "Build For Testing" })
    vim.keymap.set("n", "<leader>xr", "<cmd>XcodebuildBuildRun<cr>", { desc = "Build & Run Project" })

    vim.keymap.set("n", "<leader>xt", "<cmd>XcodebuildTest<cr>", { desc = "Run Tests" })
    vim.keymap.set("v", "<leader>xt", "<cmd>XcodebuildTestSelected<cr>", { desc = "Run Selected Tests" })
    vim.keymap.set("n", "<leader>xT", "<cmd>XcodebuildTestClass<cr>", { desc = "Run This Test Class" })

    vim.keymap.set("n", "<leader>xl", "<cmd>XcodebuildToggleLogs<cr>", { desc = "Toggle Xcodebuild Logs" })
    vim.keymap.set("n", "<leader>xc", "<cmd>XcodebuildToggleCodeCoverage<cr>", { desc = "Toggle Code Coverage" })
    vim.keymap.set("n", "<leader>xC", "<cmd>XcodebuildShowCodeCoverageReport<cr>", { desc = "Show Code Coverage Report" })
    vim.keymap.set("n", "<leader>xe", "<cmd>XcodebuildTestExplorerToggle<cr>", { desc = "Toggle Test Explorer" })
    vim.keymap.set("n", "<leader>xs", "<cmd>XcodebuildFailingSnapshots<cr>", { desc = "Show Failing Snapshots" })

    vim.keymap.set("n", "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", { desc = "Select Device" })
    vim.keymap.set("n", "<leader>xp", "<cmd>XcodebuildSelectTestPlan<cr>", { desc = "Select Test Plan" })
    vim.keymap.set("n", "<leader>xq", "<cmd>Telescope quickfix<cr>", { desc = "Show QuickFix List" })

    vim.keymap.set("n", "<leader>xx", "<cmd>XcodebuildQuickfixLine<cr>", { desc = "Quickfix Line" })
    vim.keymap.set("n", "<leader>xa", "<cmd>XcodebuildCodeActions<cr>", { desc = "Show Code Actions" })

