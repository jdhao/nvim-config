local builtin = require("statuscol.builtin")
local ffi = require("statuscol.ffidef")
local C = ffi.C

-- only show fold level up to this level
local fold_level_limit = 3
local function foldfunc(args)
  local foldinfo = C.fold_info(args.wp, args.lnum)
  if foldinfo.level > fold_level_limit then
    return " "
  end

  return builtin.foldfunc(args)
end

require("statuscol").setup {
  relculright = false,
  segments = {
    { text = { "%s" }, click = "v:lua.ScSa" },
    { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
    { text = { foldfunc, " " }, condition = { true, builtin.not_empty }, click = "v:lua.ScFa" },
  },
}
