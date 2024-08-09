local keymap = vim.keymap
local gitlinker = require("gitlinker")

gitlinker.setup {
  callbacks = {
    ["dev.azure.com"] = function(url_data)
      vim.print(url_data)
      local url = require"gitlinker.hosts".get_base_https_url(url_data)

      if url_data.lstart then
        if url_data.lend == nil then
          url_data.lend = url_data.lstart
        end
        url = url .. "?path=/" .. url_data.file .. "&version=GC" .. url_data.rev .. "&line=" .. url_data.lstart .. "&lineEnd=" .. url_data.lend .. "&lineStartColumn=1" .. "&lineEndColumn=120"
      end
      return url
    end
  },
  mappings = nil,
}

keymap.set({ "n", "v" }, "<leader>gl", function()
  local mode = string.lower(vim.fn.mode())
  gitlinker.get_buf_range_url(mode)
end, {
  silent = true,
  desc = "Git: get permlink",
})

keymap.set("n", "<leader>gbr", function()
  gitlinker.get_repo_url({
    action_callback = gitlinker.actions.open_in_browser
  })
end, {
  silent = true,
  desc = "Git: browse repo in browser",
})
