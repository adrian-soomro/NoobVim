local js_dap_status_ok, js_dap_config = pcall(require, 'dap-config/js-dap-config')
if not js_dap_status_ok then
  return
end

local dap_ui_config_status_ok, dap_ui_config = pcall(require, 'dap-config/dap-ui-config')
if not dap_ui_config_status_ok then
  return
end
