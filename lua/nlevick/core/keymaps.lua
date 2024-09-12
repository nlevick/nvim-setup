-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- General Keymaps -------------------

keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>=", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sx", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sq", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>tt", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tq", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tl", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>th", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tp", "g<Tab>")
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- keymap.set("n", "<leader>pv", vim.cmd.Ex)

keymap.set("n", "<C-o>", "o<Esc>", { desc = "Add line below from normal mode" })

keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line up" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line down" })

keymap.set("n", "J", "mzJ`z", { desc = "Delete onto line above" })
keymap.set("n", "<C-j>", "<C-d>zz", { desc = "Scroll down" })
keymap.set("n", "<C-k>", "<C-u>zz", { desc = "Scroll up" })
-- keymap.set("n", "n", "nzzzv")
-- keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
keymap.set("x", "<leader>p", [["_dP]])

keymap.set({ "n", "v" }, "<leader>Y", [["*y]], { desc = "Copy to clipboard" })
keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })

-- This is going to get me cancelled
keymap.set("i", "<C-c>", "<Esc>")

keymap.set("n", "Q", "<nop>")
-- keymap.set("n", "<leader>f", vim.lsp.buf.format)
-- keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

keymap.set("n", "<leader>a", "ggVG", { desc = "Select all" })
-- keymap.set("n", "<leader>b", [[:ls<CR>:b]])
keymap.set("n", ",b", [[:b#<CR>]])
keymap.set("n", "<C-n>", "<cmd>cnext<CR>zz")
keymap.set("n", "<C-b>", "<cmd>cprev<CR>zz")
-- keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
-- keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
-- keymap.set("n", "<leader>m", [[:mksession! ms<CR>]])
keymap.set("n", "<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- tabs
keymap.set("n", "<leader>1", "1gt")
keymap.set("n", "<leader>2", "2gt")
keymap.set("n", "<leader>3", "3gt")
keymap.set("n", "<leader>4", "4gt")
keymap.set("n", "<leader>5", "5gt")
keymap.set("n", "<leader>6", "6gt")
keymap.set("n", "<leader>7", "7gt")
keymap.set("n", "<leader>8", "8gt")
keymap.set("n", "<leader>9", "9gt")
keymap.set("n", "<leader>0", "[[:tablast<CR>]]")

-- Function to close a specific tab based on a number
local function close_tab(n)
	vim.cmd("tabclose " .. n)
end

-- Create keymaps for closing tabs 1 through 9
for i = 1, 9 do
	vim.keymap.set("n", "<leader>q" .. i, function()
		close_tab(i)
	end, { desc = "Close tab " .. i })
end

keymap.set("n", "<leader>qq", [[:bp<bar>sp<bar>bn<bar>bd<CR>]])
keymap.set("n", "<leader>oo", [[:up|%bd|e#|bd#<CR>]])

keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)
