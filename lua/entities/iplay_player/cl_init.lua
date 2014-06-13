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

-- Load library
iPlay.lib("entities/iplay_player/shared", "sh")

language.Add("iplay_player", "iPlay Player")
language.Add("Undone_iplay_player", "Undone iPlay Player")
language.Add("Undone_#iplay_player", "Undone iPlay Player")
language.Add("Cleanup_iplay_player", "iPlay Player")
language.Add("Cleaned_iplay_player", "Cleaned up the iPlay Player")

function ENT:Initialize()
  self.Entity:DrawShadow(false)

  self.HadStarted = false
  self.CurrentPage = nil
  self.Playing = false
  self.LowFramerateMode = false
  self.DrawCenter = false
  self.NoScreen = false
  self.PlayerData = {}

  self:UpdateScreenBounds()
end

function ENT:CreateBrowser()
  self.Browser = vgui.Create("iPlayHTML")
  self.Browser:SetMouseInputEnabled(false)
  self.Browser:SetSize(self.HTMLWidth, self.HTMLHeight)
  self.Browser:SetPaintedManually(true)
  self.Browser:SetVerticalScrollbarEnabled(false)
end

function ENT:DestructBrowser()
  if self.HadStarted then
    self.HadStarted = false
    PlayX.CrashDetectionEnd()
  end

  if self.Browser and self.Browser:IsValid() then
    self.Browser:Remove()
  end

  self.Browser = nil
end

function ENT:Draw()
  self.Entity:DrawModel()
end

function ENT:DrawScreen(centerX, centerY)
  if self.Browser and self.Browser:IsValid() then
    if not self.LowFramerateMode then
      if not self.BrowserMat then return end

      render.SetMaterial(self.BrowserMat)
      -- GC issue here?
      render.DrawQuad(Vector(0, 0, 0), Vector(self.HTMLWidth, 0, 0),
        Vector(self.HTMLWidth, self.HTMLHeight, 0),
        Vector(0, self.HTMLHeight, 0))
    end
  end
end

function ENT:Think()
  if self.LowFramerateMode or self.NoScreen then
    self.BrowserMat = nil
  end

  if not self.Browser then
    self.BrowserMat = nil
  else
    self.Browser:UpdateHTMLTexture()
    self.BrowserMat = self.Browser:GetHTMLMaterial()
  end

  self:NextThink(CurTime() + 0.1)
end