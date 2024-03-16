
vim.keymap.set("n", "<leader>d", ":call VSCodeNotify('editor.action.revealDefinition')<CR>")
vim.keymap.set("n", "<leader>r", ":call VSCodeNotify('editor.action.referenceSearch.trigger')<CR>")
vim.keymap.set("n", "<leader>R", ":call VSCodeNotify('editor.action.rename')<CR>")
vim.keymap.set("n", "<leader>t", ":call VSCodeNotify('editor.action.showDefinitionPreviewHover')<CR>")
vim.keymap.set("n", "<leader>o", ":call VSCodeNotify('workbench.action.quickOpen')<CR>")
vim.keymap.set("n", "]e", ":call VSCodeNotify('editor.action.marker.next')<CR>")
vim.keymap.set("n", "[e", ":call VSCodeNotify('editor.action.marker.prev')<CR>")
vim.keymap.set("n", "]g", ":call VSCodeNotify('workbench.action.editor.nextChange')<CR>")
vim.keymap.set("n", "[g", ":call VSCodeNotify('workbench.action.editor.previousChange')<CR>")

vim.g.tmux_navigator_no_mappings = 1
vim.keymap.set("n", "<c-h>", ":call VSCodeNotify('workbench.action.focusPreviousGroup')<CR>")
vim.keymap.set("n", "<c-l>", ":call VSCodeNotify('workbench.action.focusNextGroup')<CR>")

