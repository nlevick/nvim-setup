
function ColorMyPencils(color)
	-- color = color or "noctis_obscuro"
	-- color = color or "slate"
	color = color or "monokai_ristretto"
	vim.cmd.colorscheme(color)

	-- vim.api.nvim_set_hl(0, "Normal", {bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none" })
    vim.api.nvim_set_hl(0, 'LineNrAbove', { fg='#51B3EC', bold=true })
    vim.api.nvim_set_hl(0, 'LineNr', { fg='white', bold=true })
    vim.api.nvim_set_hl(0, 'LineNrBelow', { fg='#FB508F', bold=true })
end

ColorMyPencils()
