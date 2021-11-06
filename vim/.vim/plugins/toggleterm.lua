require("toggleterm").setup{
    direction = 'float',
    size = 40,
    open_mapping = [[<c-\>]],
    float_opts = {
        -- The border key is *almost* the same as 'nvim_win_open'
        -- see :h nvim_win_open for details on borders however
        -- the 'curved' border is a custom border type
        -- not natively supported but implemented in this plugin.
        border = 'shadow',
        winblend = 3,
        highlights = {
            border = "Normal",
            background = "Normal",
        }
    }
}

