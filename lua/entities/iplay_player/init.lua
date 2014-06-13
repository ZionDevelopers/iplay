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

iPlay.lib("entities/iplay_player/shared", "sh")
iPlay.lib("entities/iplay_player/cl_init", "cl")

resource.AddFile("materials/vgui/entities/iplay_player.vmt")

function ENT:Initialize()
    self.Entity:PhysicsInit(SOLID_VPHYSICS)
    self.Entity:SetMoveType(MOVETYPE_VPHYSICS)
    self.Entity:SetSolid(SOLID_VPHYSICS)
    self.Entity:DrawShadow(false)
    self.Entity:SetUseType(SIMPLE_USE)
end

function ENT:SpawnFunction(ply, tr)
    print ("Spawning iPlay!")
end

function ENT:Use( activator, caller, use_type, value )
    print ("Hello there!")
end

local function iPlayEntityDuplicator(ply, model, pos, ang)    
    local ent = ents.Create("iplay_player")
    ent:SetModel(model)
    ent:SetPos(pos)
    ent:SetAngles(ang)
    ent:Spawn()
    ent:Activate()
    
    if ply.AddCleanup then
        ply:AddCleanup("iplay_player", ent)
    end
    
    return ent
end

duplicator.RegisterEntityClass("iplay_player", iPlayEntityDuplicator, "Model", "Pos", "Ang")
