return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		local version = vim.version()
		local nvim_version = string.format("v%d.%d.%d", version.major, version.minor, version.patch)

		-- Define the total width of the ASCII art (based on the longest line)
		local total_width = 53

		-- local padding = total_width - #nvim_version
		local padding = math.floor((total_width - #nvim_version) / 2)
		local version_line = string.rep(" ", padding) .. nvim_version

		-- Set header
		dashboard.section.header.val = {
			"                                                     ",
			"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
			"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
			"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
			"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
			"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
			"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
			"                                                     ",
			version_line,
		}

		-- Set menu
		dashboard.section.buttons.val = {
			dashboard.button("e", "  > New File", "<cmd>ene<CR>"),
			dashboard.button("SPC yy", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
			dashboard.button("SPC ff", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
			dashboard.button("SPC fa", "  > Find Word", "<cmd>Telescope live_grep_args<CR>"),
			dashboard.button("SPC fr", "⧗  > Recent files", "<cmd>Telescope oldfiles<CR>"),
			dashboard.button("SPC mr", "󰁯  > Restore Session For Current Directory", "<cmd>AutoSession restore<CR>"),
			dashboard.button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
		}

		dashboard.section.footer.val = {
			"",
			"sabbe saṅkhārā aniccā",
			"sabbe saṅkhārā dukkhā",
			"sabbe dhammā anattā",
		}

		-- Send config to alpha
		alpha.setup(dashboard.opts)

		-- Disable folding on alpha buffer
		vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
	end,
}
