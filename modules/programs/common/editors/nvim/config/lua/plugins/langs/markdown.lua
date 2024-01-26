return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MardownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },
}
