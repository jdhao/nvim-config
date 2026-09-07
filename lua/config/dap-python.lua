-- Requires `debugpy` installed in whichever Python interpreter is resolved
-- below, e.g.: `<python> -m pip install debugpy`.

-- Prefer the currently active virtualenv, then a project-local `.venv`, then
-- fall back to the interpreter configured for Neovim's python provider, so
-- stepping into imported modules resolves against the same environment the
-- project actually runs with.
local function resolve_python()
  local venv = os.getenv("VIRTUAL_ENV")
  if venv then
    return vim.fs.joinpath(venv, "bin", "python3")
  end

  local project_venv = vim.fs.joinpath(vim.fn.getcwd(), ".venv", "bin", "python3")
  if vim.uv.fs_stat(project_venv) then
    return project_venv
  end

  return vim.g.python3_host_prog or "python3"
end

require("dap-python").setup(resolve_python())
