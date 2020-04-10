local PANEL = {}

local adminicon = Material("icon16/shield.png")
local equippedicon = Material("icon16/eye.png")
local groupicon = Material("icon16/group.png")

local canbuycolor = Color(85,153,0, 255)
local cantbuycolor = Color(204,24,30, 125)
local ownedcolor = Color(39,147,232, 125)

function PANEL:Init()
	self.Info = ""
	self.InfoHeight = 14
end

function PANEL:DoClick()
	local points = PS.Config.CalculateBuyPrice(LocalPlayer(), self.Data)

	if not LocalPlayer():PS_HasItem(self.Data.ID) and not LocalPlayer():PS_HasPoints(points) then
		notification.AddLegacy("Вам не хватает "..PS.Config.PointsName.." на это!", NOTIFY_GENERIC, 5)
	end

	local menu = DermaMenu(self)

	if LocalPlayer():PS_HasItem(self.Data.ID) then
		menu:AddOption('Продать', function()
			Derma_Query('Вы уверены в том, что хотите продать ' .. self.Data.Name .. '?', 'Продажа',
				'Да', function() LocalPlayer():PS_SellItem(self.Data.ID) end,
				'Нет', function() end
			)
		end)
	elseif LocalPlayer():PS_HasPoints(points) then
		menu:AddOption('Купить', function()
			Derma_Query('Вы уверены в том, что хотите купить ' .. self.Data.Name .. '?', 'Продажа',
				'Да', function() LocalPlayer():PS_BuyItem(self.Data.ID) end,
				'Нет', function() end
			)
		end)
	end
    menu:SetSkin("serverguard");

	if LocalPlayer():PS_HasItem(self.Data.ID) then
		menu:AddSpacer()

		if LocalPlayer():PS_HasItemEquipped(self.Data.ID) then
			menu:AddOption('Снять', function()
				LocalPlayer():PS_HolsterItem(self.Data.ID)
			end)
		else
			menu:AddOption('Одеть', function()
				LocalPlayer():PS_EquipItem(self.Data.ID)
			end)
		end

		if LocalPlayer():PS_HasItemEquipped(self.Data.ID) and self.Data.Modify then
			menu:AddSpacer()

			menu:AddOption('Модифицировать...', function()
				PS.Items[self.Data.ID]:Modify(LocalPlayer().PS_Items[self.Data.ID].Modifiers)
			end)
		end
	end

	menu:Open()
end

function PANEL:SetData(data)
	self.Data = data
	self.Info = data.Name

	if data.Model and not data.Material then
		local DModelPanel = vgui.Create('DModelPanel', self)
		DModelPanel:SetModel(data.Model)

		DModelPanel:Dock(FILL)

		if data.Skin then
			DModelPanel:SetSkin(data.Skin)
		end

		local PrevMins, PrevMaxs = DModelPanel.Entity:GetRenderBounds()
		DModelPanel:SetCamPos(PrevMins:Distance(PrevMaxs) * Vector(0.5, 0.5, 0.5))
		DModelPanel:SetLookAt((PrevMaxs + PrevMins) / 2)

		function DModelPanel:LayoutEntity(ent)
			if self:GetParent().Hovered then
				ent:SetAngles(Angle(0, ent:GetAngles().y + 2, 0))
			end

			local ITEM = PS.Items[data.ID]

			ITEM:ModifyClientsideModel(LocalPlayer(), ent, Vector(), Angle())
		end

		function DModelPanel:DoClick()
			self:GetParent():DoClick()
		end

		function DModelPanel:OnCursorEntered()
			self:GetParent():OnCursorEntered()
		end

		function DModelPanel:OnCursorExited()
			self:GetParent():OnCursorExited()
		end

	else
		local DImageButton = vgui.Create('DImageButton', self)
		DImageButton:SetMaterial(data.Material)
		DImageButton.m_Image.FrameTime = 0

		-- DImageButton:Dock(FILL)
        DImageButton:SetSize(100,100)
        DImageButton:SetPos(10,10)

		function DImageButton:DoClick()
			self:GetParent():DoClick()
		end

		function DImageButton:OnCursorEntered()
			self:GetParent():OnCursorEntered()
		end

		function DImageButton:OnCursorExited()
			self:GetParent():OnCursorExited()
		end

		-- function DImageButton.m_Image:Paint(w, h)
		-- 	if not self:GetParent():GetParent().Data.NoScroll and self:GetParent():GetParent().Hovered then
		-- 		self.FrameTime = self.FrameTime + 1
		-- 	end

		-- 	self:PaintAt( 0, self.FrameTime % self:GetTall() - self:GetTall() , self:GetWide(), self:GetTall() )
		-- 	self:PaintAt( 0, self.FrameTime % self:GetTall(), 					self:GetWide(), self:GetTall() )
		-- end
	end

	if data.Description then
		self:SetTooltip(data.Description)
	end
end

function PANEL:PaintOver()
	if self.Data.AdminOnly then
		surface.SetMaterial(adminicon)
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.DrawTexturedRect(5, 5, 16, 16)
	end

	if LocalPlayer():PS_HasItemEquipped(self.Data.ID) then
		surface.SetMaterial(equippedicon)
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.DrawTexturedRect(self:GetWide() - 5 - 16, 5, 16, 16)
	end

	if self.Data.AllowedUserGroups and #self.Data.AllowedUserGroups > 0 then
		surface.SetMaterial(groupicon)
		surface.SetDrawColor(Color(255, 255, 255, 255))
		surface.DrawTexturedRect(5, self:GetTall() - self.InfoHeight - 5 - 16, 16, 16)
	end

	local points = PS.Config.CalculateBuyPrice(LocalPlayer(), self.Data)

	if LocalPlayer():PS_HasPoints(points) then
		self.BarColor = canbuycolor
	else
		self.BarColor = cantbuycolor
	end

	if LocalPlayer():PS_HasItem(self.Data.ID) then
		self.BarColor = ownedcolor
	end

	-- surface.SetDrawColor(self.BarColor)
	-- surface.DrawRect(0, self:GetTall() - self.InfoHeight, self.InfoHeight, self.InfoHeight)
    -- draw.Arc( 0, self:GetTall() - self.InfoHeight, 0, 360, 30, 30, 30, self.BarColor )
    draw.RoundedBox(self.InfoHeight/2, 0, self:GetTall() - self.InfoHeight, self.InfoHeight, self.InfoHeight, self.BarColor)

	draw.SimpleText(self.Info, "font_base_small", self.InfoHeight+2, self:GetTall() - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)

	if LocalPlayer().PS_Items and LocalPlayer().PS_Items[self.Data.ID] and LocalPlayer().PS_Items[self.Data.ID].Modifiers and LocalPlayer().PS_Items[self.Data.ID].Modifiers.color then
		surface.SetDrawColor(LocalPlayer().PS_Items[self.Data.ID].Modifiers.color)
		surface.DrawRect(self:GetWide() - 5 - 16, 26, 16, 16)
	end
end

function PANEL:OnCursorEntered()
	self.Hovered = true

	if LocalPlayer():PS_HasItem(self.Data.ID) then
		self.Info = '+' .. PS.Config.CalculateSellPrice(LocalPlayer(), self.Data)
	else
		self.Info = '-' .. PS.Config.CalculateBuyPrice(LocalPlayer(), self.Data)
	end

	PS:SetHoverItem(self.Data.ID)
end

function PANEL:OnCursorExited()
	self.Hovered = false
	self.Info = self.Data.Name

	PS:RemoveHoverItem()
end

vgui.Register('DPointShopItem', PANEL, 'DPanel')
