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
  self.Browser:SetMouseInputEnabled(true)
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

  if self.NoScreen then return end
  if not self.DrawScale then return end

  render.SuppressEngineLighting(true)

  if self.IsProjector then
    local tr = self:GetProjectorTrace()

    if tr.Hit then
      local ang = tr.HitNormal:Angle()
      ang:RotateAroundAxis(ang:Forward(), 90)
      ang:RotateAroundAxis(ang:Right(), -90)

      local width = tr.HitPos:Distance(self.Entity:LocalToWorld(self.Entity:OBBCenter())) * 0.001
      local height = width / 2
      local pos = tr.HitPos - ang:Right() * height * self.HTMLHeight / 2
        - ang:Forward() * width * self.HTMLWidth / 2
        + ang:Up() * 2

      -- This makes the screen show all the time
      self:SetRenderBoundsWS(Vector(-1100, -1100, -1100) + tr.HitPos,
        Vector(1100, 1100, 1100) + tr.HitPos)

      cam.Start3D2D(pos, ang, width)
      surface.SetDrawColor(0, 0, 0, 255)
      surface.DrawRect(0, 0, 1024, 512)
      self:DrawScreen(1024 / 2, 512 / 2)
      cam.End3D2D()
    end
  else
    local shiftMultiplier = 1
    if not self.DrawCenter then
      shiftMultiplier = 2
    end

    local pos = self.Entity:LocalToWorld(self.ScreenOffset -
      Vector(0, self.DrawShiftX * self.DrawScale, self.DrawShiftY * shiftMultiplier * self.DrawScale))
    local ang = self.Entity:GetAngles()

    ang:RotateAroundAxis(ang:Right(), self.RotateAroundRight)
    ang:RotateAroundAxis(ang:Up(), self.RotateAroundUp)
    ang:RotateAroundAxis(ang:Forward(), self.RotateAroundForward)

    -- This makes the screen show all the time
    self:SetRenderBoundsWS(Vector(-1100, -1100, -1100) + self:GetPos(),
      Vector(1100, 1100, 1100) + self:GetPos())

    cam.Start3D2D(pos, ang, self.DrawScale)
    surface.SetDrawColor(0, 0, 0, 255)
    surface.DrawRect(-self.DrawShiftX, -self.DrawShiftY * shiftMultiplier, self.DrawWidth, self.DrawHeight)
    self:DrawScreen(self.DrawWidth / 2 - self.DrawShiftX,
      self.DrawHeight / 2 - self.DrawShiftY * shiftMultiplier)
    cam.End3D2D()
  end

  render.SuppressEngineLighting(false)
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