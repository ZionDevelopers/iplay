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

-- Load vON
if von == nil then
  iPlay.lib("von", "sh")
end

-- Load libraries
iPlay.lib("html", "cl")
iPlay.lib("htmlcontrols", "cl")
iPlay.lib("init", "sv")
