local colorscheme = "monokai-pro"
local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. ciolorscheme .. " Not Found！")
  return
end

