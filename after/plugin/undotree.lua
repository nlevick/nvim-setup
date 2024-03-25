vim.keymap.set("n", "<leader>u", function()
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
    vim.cmd("UndotreeToggle | UndotreeFocus")
end)

