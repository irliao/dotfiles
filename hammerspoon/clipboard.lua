-- Clipboard in menu bar with history persistent across launches

-- TODO: convert this file to exportable module, then move bindings below to hotkey.lua
-- TODO: implement exporting to file or print using this Hammerspoon command: hs.inspect(hs.settings.get("HSClipboardHistory"))

local module = {
  consider_ignore=true,  -- Respect the `ignore` settings
  ignore = {
      ["de.petermaurer.TransientPasteboardType"] = true, -- Transient : Textpander, TextExpander, Butler
      ["com.typeit4me.clipping"]                 = true, -- Transient : TypeIt4Me
      ["Pasteboard generator type"]              = true, -- Transient : Typinator
      ["com.agilebits.onepassword"]              = true, -- Confidential : 1Password
      ["org.nspasteboard.TransientType"]         = true, -- Universal, Transient
      ["org.nspasteboard.ConcealedType"]         = true, -- Universal, Concealed
      ["org.nspasteboard.AutoGeneratedType"]     = true, -- Universal, Automatic
  }
}

local logger = hs.logger.new('Clipboard')

-- Feel free to change those settings
local hist_size = 50 -- How many items to keep on history
local label_length = 100 -- How wide (in characters) the dropdown menu should be. Copies larger than this will have their label truncated and end with "…" (unicode for elipsis ...)
-- TODO: verify if the honor flag below is behaving as intended
local honor_clearcontent = true --asmagill request. If any application clears the pasteboard, we also remove it from the history https://groups.google.com/d/msg/hammerspoon/skEeypZHOmM/Tg8QnEj_N68J

local settingsKey = "com.hs.clipboard.history.me" -- key to access clipboard_history stored in hs.settings
local clipboardMenuBar = hs.menubar.new():setTooltip("clipboard")
-- TODO: implement chooser with same clipboard history
-- local chooser = hs.chooser.new(function (choice)
--   if not choice then
--     hs.alert("none chosen")
--   else
--     hs.alert("chosen")
--   end
-- end)
local pasteboard = require("hs.pasteboard")
local settings = require("hs.settings") -- http://www.hammerspoon.org/docs/hs.settings.html

--Array to store the clipboard history
clipboard_history = settings.get(settingsKey) or {} --If no history is saved on the system, create an empty history

-- watcher will by default poll every 0.25s
module.pbWatcher = hs.pasteboard.watcher.new(function(newPbValue)
  savePbContentToClipboard(newPbValue)
end)

-- Internal method: Verify whether the pasteboard contents matches one of the identifiers that need to be ignored.
-- Code from https://github.com/asmagill/hammerspoon-config/blob/master/utils/_menus/newClipper.lua
local function shouldBeStored()
    if not module.consider_ignore then return true end
    for _,v in ipairs(hs.pasteboard.pasteboardTypes()) do
        if module.ignore[v] then return false end
    end
    for _, v in ipairs(hs.pasteboard.contentTypes()) do
        if module.ignore[v] then return false end
    end
    return true
end

function setMenuBarIcon()
  if (#clipboard_history == 0) then
    clipboardMenuBar:setIcon("assets/clipboard_empty.png")
  else
    clipboardMenuBar:setIcon("assets/clipboard_filled.png")
  end
end

-- After selecting an item from clipboard to paste, set current pasteboard to selection and reenter the selection to clipboard (so its the latest)
function putOnPaste(textToPaste, keysPressed)
    pasteboard.setContents(textToPaste)
    hs.eventtap.keyStroke({"cmd"}, "v")
    savePbContentToClipboard(textToPaste)
end

-- Clears the clipboard and history
function clearAll()
  pasteboard.clearContents()
  clipboard_history = {}
  settings.set(settingsKey,clipboard_history)
  setMenuBarIcon()
  hs.alert("Clipboard Cleared")
  logger.i("Pasteboard Cleared")
end

-- Clears the last added to the history
function clearLastItem()
  table.remove(clipboard_history,#clipboard_history)
  settings.set(settingsKey,clipboard_history)
  setMenuBarIcon()
end

-- Inserts the currently copied item to clipboard history
function pasteboardToClipboard(item)
  -- Remove all exact matches found
  for key, value in ipairs(clipboard_history) do
      if value == item then
          table.remove(clipboard_history, key)
      end
  end

  -- Remove oldest entry if going over size
  if (#clipboard_history > 0 and #clipboard_history >= hist_size) then
    table.remove(clipboard_history, 1)
  end

  table.insert(clipboard_history, item)
  settings.set(settingsKey, clipboard_history) -- updates the saved history
  setMenuBarIcon() -- updates the menu counter
end

-- Clipboard shown in Menubar window
populateMenu = function(key)
  setMenuBarIcon() -- Update the counteclipboard.luar every time the menu is refreshed
  menuData = {}
  if (#clipboard_history == 0) then
    table.insert(menuData, {title="None", disabled = true}) -- If the history is empty, display "None"
  else
    for k,v in pairs(clipboard_history) do
      if (string.len(v) > label_length) then
        table.insert(menuData, 1, {title=string.sub(v,0,label_length).."…", fn = function() putOnPaste(v, key) end }) -- Truncate long strings
      else
        table.insert(menuData, 1, {title=v, fn = function() putOnPaste(v, key) end })
      end
    end
  end
  table.insert(menuData, {title="-"})
  table.insert(menuData, {title="Clear All", fn = function() clearAll() end })

  return menuData
end

-- Clipboard shown in Chooser window
populateChooser = function(key)
   menuData = {}
   if (#clipboard_history == 0) then
      table.insert(menuData, {text="", subtext = "Clipboard history is empty"}) -- If the history is empty, display "None"
   else
      for k,v in pairs(clipboard_history) do
         if (type(v) == "string") then
            table.insert(menuData,1, {text=v, subText=""})
         else
            if type(v) == "userdata" then
               table.insert(menuData,1, {text="(image)", subText = "", image=v })
            else
               table.insert(menuData,1, {text=v, subText = ""})
            end
         end -- end if else
      end-- end for
   end-- end if else
   -- footer
   -- table.insert(menuData, {title="-"})
   -- table.insert(menuData, {title="Clear All", fn = function() clearAll() end })
   -- if (key.alt == true or mod.config.paste_on_select) then
   --    table.insert(menuData, {title="Direct Paste Mode ✍", disabled=true})
   -- end
   return menuData
end

-- If the pasteboard owner has changed, we add the current item to our history and update the counter.
function savePbContentToClipboard(clipboard_content)
    if not shouldBeStored() then
      hs.alert('Pasteboard not saved, item listed in ignoreList')
      return
    end

    current_clipboard = clipboard_content -- pasteboard.getContents()
    -- asmagill requested this feature. It prevents the history from keeping items removed by password managers
    if (current_clipboard == nil and honor_clearcontent) then
      clearLastItem()
    else
      pasteboardToClipboard(current_clipboard)
    end
end

function showChooser()
  if chooser == nil then
    return
  end
  chooser:choices(populateChooser)
  chooser:show()
end

function showClipboardMenuBarAtMouse()
  if clipboardMenuBar == nil then
    return
  end
  clipboardMenuBar:popupMenu(hs.mouse.absolutePosition())
end

setMenuBarIcon() --Avoid wrong title if the user already has something on his saved history
clipboardMenuBar:setMenu(populateMenu)

function module.printClipboardHistory()
  for k, v in ipairs(clipboard_history) do
    logger.i(v)
  end
end

hs.hotkey.bind({"ctrl", "cmd"}, "V", function() showClipboardMenuBarAtMouse() end)
hs.hotkey.bind({"ctrl", "alt"}, "V", function() showChooser() end)
hs.hotkey.bind({"ctrl", "cmd"}, "DELETE", function() clearAll() end)

return module
