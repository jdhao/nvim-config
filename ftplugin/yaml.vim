" Turn off syntax highlighting for large YAML files.
if line('$') > 500
  setlocal syntax=OFF
endif
