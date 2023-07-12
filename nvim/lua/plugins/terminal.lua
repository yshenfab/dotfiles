-- terminal
return {
	"akinsho/toggleterm.nvim",
	version = "*",
	opts = {
		size = 10,
		open_mapping = [[<F1>]],
		shading_factor = 2,
		direction = "float",
		float_opts = {
			border = "curved",
			highlights = { border = "Normal", background = "Normal" },
		},
	},
}
