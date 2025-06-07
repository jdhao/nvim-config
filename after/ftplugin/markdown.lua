local function add_reference_at_end(label, url, title)
  vim.schedule(function()
    local bufnr = vim.api.nvim_get_current_buf()
    local line_count = vim.api.nvim_buf_line_count(bufnr)

    -- Prepare reference definition
    local ref_def = "[" .. label .. "]: " .. url
    if title and title ~= "" then
      ref_def = ref_def .. ' "' .. title .. '"'
    end

    -- Check if references section exists
    local buffer_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)

    local has_ref_section = false
    for _, line in ipairs(buffer_lines) do
      if line:match("^%s*<!%-%-.*[Rr]eferences.*%-%->[%s]*$") then
        has_ref_section = true
        break
      end
    end

    local lines_to_add = {}
    -- Add references header if it doesn't exist
    if not has_ref_section then
      if #lines_to_add == 0 then
        table.insert(lines_to_add, "")
      end
      table.insert(lines_to_add, "<!-- References -->")
    end

    table.insert(lines_to_add, ref_def)

    -- Insert at buffer end
    vim.api.nvim_buf_set_lines(bufnr, line_count, line_count, false, lines_to_add)
  end)
end

local function get_ref_link_labels()
  local labels = {}
  local seen = {} -- To avoid duplicates
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  for _, line in ipairs(lines) do
    -- Pattern explanation:
    -- %[.-%] matches [link text] (non-greedy)
    -- %[(.-)%] matches [label] and captures the label content
    local start_pos = 1
    while start_pos <= #line do
      local match_start, match_end, label = string.find(line, "%[.-%]%[(.-)%]", start_pos)
      if not match_start then
        break
      end

      -- Only add unique labels
      if label and label ~= "" and not seen[label] then
        table.insert(labels, label)
        seen[label] = true
      end

      start_pos = match_end + 1
    end
  end

  return labels
end

local function count_consecutive_spaces(str)
  -- Remove leading spaces first
  local trimmed = str:match("^%s*(.*)")
  local count = 0

  -- Count each sequence of one or more consecutive spaces
  for spaces in trimmed:gmatch("%s+") do
    count = count + 1
  end
  return count
end

vim.api.nvim_buf_create_user_command(0, "AddRef", function(opts)
  local args = vim.split(opts.args, " ", { trimempty = true })

  if #args < 2 then
    vim.print("Usage: :AddRef <label> <url>")
    return
  end

  local label = args[1]
  local url = args[2]

  add_reference_at_end(label, url, "")
end, {
  desc = "Add reference link at buffer end",
  nargs = "+",
  complete = function(arg_lead, cmdline, curpos)
    vim.print(string.format("arg_lead: '%s', cmdline: '%s', curpos: %d", arg_lead, cmdline, curpos))

    -- only complete the first argument
    if count_consecutive_spaces(cmdline) > 1 then
      -- we are now starting the second argument, so no completion anymore
      return {}
    end

    local ref_link_labels = get_ref_link_labels()
    return ref_link_labels
  end,
})
