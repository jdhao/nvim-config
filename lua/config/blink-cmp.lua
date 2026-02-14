require("blink.cmp").setup {
  -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
  -- 'super-tab' for mappings similar to vscode (tab to accept)
  -- 'enter' for enter to accept
  -- 'none' for no mappings
  --
  keymap = {
    preset = "default",
    ["<Tab>"] = { "select_next", "fallback" },
    ["<S-Tab>"] = { "select_prev", "fallback" },
    ["<Enter>"] = { "select_and_accept", "fallback" },
    ["<C-U>"] = { "scroll_documentation_up", "fallback" },
    ["<C-D>"] = { "scroll_documentation_down", "fallback" },
  },

  appearance = {
    -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- Adjusts spacing to ensure icons are aligned
    nerd_font_variant = "mono",
  },

  -- (Default) Only show the documentation popup when manually triggered
  completion = {
    documentation = {
      auto_show = true,
    },
  },

  -- Default list of enabled providers defined so that you can extend it
  -- elsewhere in your config, without redefining it, due to `opts_extend`
  sources = {
    default = { "lsp", "path", "buffer", "omni" },
    providers = {
      -- Use the thesaurus source
      thesaurus = {
        name = "blink-cmp-words",
        module = "blink-cmp-words.thesaurus",
        -- All available options
        opts = {
          -- A score offset applied to returned items.
          -- By default the highest score is 0 (item 1 has a score of -1, item 2 of -2 etc..).
          score_offset = 0,

          -- Default pointers define the lexical relations listed under each definition,
          -- see Pointer Symbols below.
          -- Default is as below ("antonyms", "similar to" and "also see").
          definition_pointers = { "!", "&", "^" },

          -- The pointers that are considered similar words when using the thesaurus,
          -- see Pointer Symbols below.
          -- Default is as below ("similar to", "also see" }
          similarity_pointers = { "&", "^" },

          -- The depth of similar words to recurse when collecting synonyms. 1 is similar words,
          -- 2 is similar words of similar words, etc. Increasing this may slow results.
          similarity_depth = 2,
        },
      },

      -- Use the dictionary source
      dictionary = {
        name = "blink-cmp-words",
        module = "blink-cmp-words.dictionary",
        -- All available options
        opts = {
          -- The number of characters required to trigger completion.
          -- Set this higher if completion is slow, 3 is default.
          dictionary_search_threshold = 3,

          -- See above
          score_offset = 0,

          -- See above
          definition_pointers = { "!", "&", "^" },
        },
      },
    },
    per_filetype = {
      text = { "dictionary" },
      markdown = { "dictionary" },
    },
  },

  -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
  -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
  -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
  --
  -- See the fuzzy documentation for more information
  fuzzy = { implementation = "prefer_rust_with_warning" },
  cmdline = {
    completion = {
      menu = {
        auto_show = true,
      },
    },
    keymap = {
      ["<Enter>"] = { "select_and_accept", "fallback" },
    },
  },
}
