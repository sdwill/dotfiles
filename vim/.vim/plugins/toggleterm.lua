require("toggleterm").setup{
    direction = 'tab',
    size = 40,
    open_mapping = [[<c-\>]],
    float_opts = {
        -- The border key is *almost* the same as 'nvim_win_open'
        -- see :h nvim_win_open for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = 'curved',
        winblend = 3,
        width = 100,
        height = 100,
        highlights = {
            border = "Normal",
            background = "Normal",
        }
    }
}

