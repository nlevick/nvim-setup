return {
	-- {
	-- 	"tanvirtin/monokai.nvim",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("monokai").setup({ palette = require("monokai").ristretto })
	-- 		vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#65D1FF", bold = true })
	-- 		vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#ff9e64", bold = true })
	-- 	end,
	-- },
	{
		"folke/tokyonight.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			local bg = "#011628"
			local bg_dark = "#011423"
			local bg_highlight = "#143652"
			local bg_search = "#0A64AC"
			local bg_visual = "#275378"
			local fg = "#CBE0F0"
			local fg_dark = "#B4D0E9"
			local border = "#547998"
			local terminal_black = "#6D76A4"

			require("tokyonight").setup({
				style = "night",
				on_colors = function(colors)
					colors.bg = bg
					colors.bg_dark = bg_dark
					colors.bg_float = bg_dark
					colors.bg_highlight = bg_highlight
					colors.bg_popup = bg_dark
					colors.bg_search = bg_search
					colors.bg_sidebar = bg_dark
					colors.bg_statusline = bg_dark
					colors.bg_visual = bg_visual
					colors.border = border
					colors.fg = fg
					colors.fg_dark = fg_dark
					colors.fg_float = fg
					colors.fg_sidebar = fg_dark
					colors.terminal_black = terminal_black
				end,
			})
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight]])
			vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#22a4be", bold = true })
			vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#e06f88", bold = true })
		end,
	},
}
