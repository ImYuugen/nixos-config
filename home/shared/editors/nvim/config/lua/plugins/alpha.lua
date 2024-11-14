return {
	"alpha-nvim",
	after = function()
		local dashboard = require("alpha.themes.dashboard")
		local logo = [[
            Wesh alors la dragonlore
        ]]
		dashboard.section.header.val = vim.split(logo, "\n")
		dashboard.section.buttons.val = {
			dashboard.button("f", " " .. " Find file", "<CMD>Telescope find_files<CR>"),
			dashboard.button("g", "󱎸 " .. " Grep", "<CMD>Telescope live_grep<CR>"),
			dashboard.button("n", " " .. " New file", "<CMD>ene<BAR>startinsert<CR>"),
			dashboard.button("q", " " .. " Quit", "<CMD>qa<CR>"),
		}
        for _, btn in ipairs(dashboard.section.buttons.val) do
            btn.opts.hl = "AlphaButtons"
            btn.opts.hl_shortcut = "AlphaShortcut"
        end
        dashboard.section.header.hl = "AlphaHeader"
        dashboard.section.buttons.hl = "AlphaButtons"
        dashboard.section.footer.hl = "AlphaFooter"
		require("alpha").setup(dashboard.opts)
	end,
}
