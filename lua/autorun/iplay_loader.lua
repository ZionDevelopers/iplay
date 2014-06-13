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

local started = os.clock()

iPlay = {}
iPlay.version = "0.0.0.4"
iPlay.updatedOn = os.date( "%y-%m-%d %I:%M:%S %p", file.Time( "autorun/iplay_loader.lua", "LUA" ) )
iPlay.loadingAddon = true

if SERVER then
  AddCSLuaFile()
  AddCSLuaFile("iplay/shared/library.lua")
end

-- "Stole" from wiremod
if VERSION < 140403 and VERSION > 5 then
  -- VERSION > 5 check added June 2013, to address issues regarding the Steampipe update sometimes setting VERSION to 1.
  ErrorNoHalt("iPlay only supports Garry's Mod 13+.\n")
  return
end

-- Require shared library
include ("iplay/shared/library.lua")

-- Loading logs
Msg( "\n/====================================\\\n")
Msg( "||               iPlay              ||\n" )
Msg( "||----------------------------------||\n" )
iPlay.loading("Version "..iPlay.version)
iPlay.loading("Updated on "..iPlay.updatedOn)
Msg( "||----------------------------------||\n" )
Msg( "||  Loading...                      ||\n" )

-- Loading log
iPlay.loading(" Autorun")

-- Require loader
iPlay.lib("loader", "sh")

Msg( "||  Loaded in "..math.Round(os.clock() - started, 2) .. " seconds!         ||\n" )
Msg( "\\====================================/\n\n" )

-- Disable loading messages
iPlay.loadingAddon = false