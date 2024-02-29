local keymap  = require("utils.keymap")

return {
    setup = function ()
        keymap.insert.delete("<C-BS>")
        keymap.insert.apply("<C-H>", "<C-W>")
    end
}
