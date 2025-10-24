---@diagnostic disable-next-line: missing-fields
require("gx").setup {
  handlers = {
    jira = {
      name = "jira", -- set name of handler
      handle = function(mode, line, _)
        local ticket = require("gx.helper").find(line, mode, "(%a%a%a+%-%d+)")
        vim.print("ticket, mode, line", ticket, mode, line)

        if ticket and #ticket < 20 then
          local ticket_link = string.format("http://jira.%s/browse/%s", vim.env.COMPANY_NAME, ticket)
          return ticket_link
        end
      end,
    },
  },
}
