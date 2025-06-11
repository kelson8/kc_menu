-- Credit to bMenu for below code
-- https://github.com/BerkieBb/bMenu

---@param isFullMenuClose boolean
---@param keyPressed? string
---@param previousMenu? string
function CloseMenu(isFullMenuClose, keyPressed, previousMenu)
    if isFullMenuClose or not keyPressed or not previousMenu or keyPressed == 'Escape' then
        lib.hideMenu(false)
        MenuOpen = false
        return
    end

    lib.showMenu(previousMenu)
end