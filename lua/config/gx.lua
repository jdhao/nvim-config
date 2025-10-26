---@diagnostic disable-next-line: missing-fields
require("gx").setup {
  handlers = {
    jira = {
      name = "jira", -- set name of handler
      handle = function(mode, line, _)
        local ticket = require("gx.helper").find(line, mode, "(%a%a%a+%-%d+)")

        local dotenv = require("dotenv")
        local env_path = vim.fs.joinpath(vim.fn.stdpath("config"), ".env")
        dotenv.load_dotenv(env_path)
        local company_name = dotenv.get("COMPANY_NAME")

        if ticket and #ticket < 20 then
          local ticket_link = string.format("http://jira.%s/browse/%s", company_name, ticket)
          return ticket_link
        end
      end,
    },
  },
}
