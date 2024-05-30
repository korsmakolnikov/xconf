require('snippy').setup({
  snippet_dirs = '~/xconf/nvim/snippets',
  mappings = {
    is = {
      ['<C-n>'] = 'expand_or_advance',
      ['<C-p>'] = 'previous',
    },
  },
})
