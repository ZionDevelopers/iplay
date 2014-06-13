--[[

 /$$ /$$$$$$$  /$$                    
|__/| $$__  $$| $$                    
 /$$| $$  \ $$| $$  /$$$$$$  /$$   /$$
| $$| $$$$$$$/| $$ |____  $$| $$  | $$
| $$| $$____/ | $$  /$$$$$$$| $$  | $$
| $$| $$      | $$ /$$__  $$| $$  | $$
| $$| $$      | $$|  $$$$$$$|  $$$$$$$
|__/|__/      |__/ \_______/ \____  $$
                             /$$  | $$
                            |  $$$$$$/
                             \______/ 

The next generation of Garry's Mod media player addon!  

Copyright (c) 2014 Nexus <http://www.nexusbr.net>

Author: Nexus <talk@nexusbr.net>, <http://steamcommunity.com/profiles/76561197983103320>
GitHub Repository: https://github.com/ZionDevelopers/iplay

This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License.
To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/
]]--

AddCSLuaFile()

-- Upper Case First
---@param string str
---@return string
function string:ucf()
    return self:gsub("^%l", string.upper)
end

-- Loading Log
---@param string text
---@return void
iPlay.loading = function (text)
  -- Check if iPlay is still loading
  if iPlay.loadingAddon == false then
    return
  end
  
  -- Set Max Size
  local size = 32
  -- If Text Len < max size
  if(string.len(text) < size) then
    -- Format the text to be Text+Spaces*LeftSize
    text = text .. string.rep( " ", size-string.len(text) )
  else
    --If Text is too much big then cut and add ...
    text = string.Left( text, size-3 ) .. "..."
  end
  --Log Messsage
  Msg( "||  "..text.."||\n" )
end

-- Load library
---@param string filename
---@param string mode
---@return void
iPlay.lib = function(filename, mode)
  -- Filename Path
  local filepath = nil
  
  -- Check library mode
  if mode == "sv" then
    folder = "server"
  elseif mode == "sh" then
    folder = "shared"
  elseif mode == "cl" then
    folder = "client"
  else
    return
  end
  
  if file.Exists("iplay/"..folder.."/"..filename..".lua", "LUA") then
    -- Format filepath
    filepath = "iplay/"..folder.."/"..filename..".lua"
  else
    -- Format filepath
    filepath = filename..".lua"
  end
  
  -- Check if file exists
  if file.Exists(filepath, "LUA") then
    -- Check library mode
    if mode == "sv" then
      -- If SERVER
      if SERVER then   
        -- Loading log
        iPlay.loading(" "..filename:ucf())     
        -- Require file
        include (filepath)
      end
    elseif mode == "sh" then
      -- Loading log
      iPlay.loading(" "..filename:ucf())  
      -- If SERVER
      if SERVER then
        -- Send lua to the Client
        AddCSLuaFile(filepath)        
      end
      
      -- Require file
      include (filepath)
    elseif mode == "cl" then
      if CLIENT then
        -- Loading log
        iPlay.loading(" "..filename:ucf())  
        include (filepath)
      end
    else
    end
  end
end