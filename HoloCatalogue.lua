-----------------------------------------------------------------------------------------------
-- Client Lua Script for HoloCatalogue
-- Copyright (c) NCsoft. All rights reserved
-----------------------------------------------------------------------------------------------
 
require "Window"
 
-----------------------------------------------------------------------------------------------
-- HoloCatalogue Module Definition
-----------------------------------------------------------------------------------------------
local HoloCatalogue = {}
local StoredCostume = {}
 
-----------------------------------------------------------------------------------------------
-- Constants
-----------------------------------------------------------------------------------------------
-- e.g. local kiExampleVariableMax = 999
 
-----------------------------------------------------------------------------------------------
-- Initialization
-----------------------------------------------------------------------------------------------
function HoloCatalogue:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self 

    -- initialize variables here

    return o
end

function HoloCatalogue:Init()
	local bHasConfigureFunction = false
	local strConfigureButtonText = ""
	local tDependencies = {
		-- "UnitOrPackageName",
	}
    Apollo.RegisterAddon(self, bHasConfigureFunction, strConfigureButtonText, tDependencies)
end
 

-----------------------------------------------------------------------------------------------
-- HoloCatalogue OnLoad
-----------------------------------------------------------------------------------------------
function HoloCatalogue:OnLoad()
    -- load our form file
	self.xmlDoc = XmlDoc.CreateFromFile("HoloCatalogue.xml")
	self.xmlDoc:RegisterCallback("OnDocLoaded", self)
end

-----------------------------------------------------------------------------------------------
-- HoloCatalogue OnDocLoaded
-----------------------------------------------------------------------------------------------
function HoloCatalogue:OnDocLoaded()

	if self.xmlDoc ~= nil and self.xmlDoc:IsLoaded() then
	    self.wndMain = Apollo.LoadForm(self.xmlDoc, "HoloCatalogueForm", nil, self)
		if self.wndMain == nil then
			Apollo.AddAddonErrorText(self, "Could not load the main window for some reason.")
			return
		end
		
		self.wndMannequin = self.wndMain:FindChild("CostumeWindow")
		if self.wndMannequin == nil then
			Apollo.AddAddonErrorText(self, "Could not load the main window for some reason.")
			return
		end
		
		self.wndCostumeList = self.wndMain:FindChild("CostumeList")
		if self.wndCostumeList == nil then
			Apollo.AddAddonErrorText(self, "Could not load the main window for some reason.")
			return
		end
		
		self.wndNameEditBox = self.wndMain:FindChild("NameEditBox")
		if self.wndNameEditBox == nil then
			Apollo.AddAddonErrorText(self, "Could not load the main window for some reason.")
			return
		end
		
		
	    self.wndMain:Show(false, true)
	
		self:PopulateCostumeList()
		self:UpdatePreview()

		-- if the xmlDoc is no longer needed, you should set it to nil
		-- self.xmlDoc = nil
		
		-- Register handlers for events, slash commands and timer, etc.
		-- e.g. Apollo.RegisterEventHandler("KeyDown", "OnKeyDown", self)
		Apollo.RegisterSlashCommand("hc", "OnHoloCatalogueOn", self)


		-- Do additional Addon initialization here
	end
end

function HoloCatalogue:PopulateCostumeList()
	Apollo.LoadForm(self.xmlDoc, "Costume", self.wndCostumeList, self)
	Apollo.LoadForm(self.xmlDoc, "Costume", self.wndCostumeList, self)
	Apollo.LoadForm(self.xmlDoc, "Costume", self.wndCostumeList, self)
	Apollo.LoadForm(self.xmlDoc, "Costume", self.wndCostumeList, self)
	Apollo.LoadForm(self.xmlDoc, "Costume", self.wndCostumeList, self)
	Apollo.LoadForm(self.xmlDoc, "Costume", self.wndCostumeList, self)
	self.wndCostumeList:ArrangeChildrenTiles(0)
end

function HoloCatalogue:UpdatePreview()
	self.wndMannequin:SetCostume(GameLib.GetPlayerUnit())
end

function HoloCatalogue:AddCostume()

end

-----------------------------------------------------------------------------------------------
-- HoloCatalogue Functions
-----------------------------------------------------------------------------------------------
-- Define general functions here

-- on SlashCommand "/hc"
function HoloCatalogue:OnHoloCatalogueOn()
	self.wndMain:Invoke() -- show the window
end

function HoloCatalogue:OnClose()
	self.wndMain:Close()
end

function HoloCatalogue:ItemSelected( wndHandler, wndControl, eMouseButton )
	self:UpdatePreview()
end

function HoloCatalogue:SelectionChanged(selection)
	self:UpdatePreview()
end


-----------------------------------------------------------------------------------------------
-- StoredCostume Functions
-----------------------------------------------------------------------------------------------

function StoredCostume:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self 

    -- initialize variables here

    return o
end

function StoredCostume:SetCostume()
	
end


-----------------------------------------------------------------------------------------------
-- HoloCatalogue Instance
-----------------------------------------------------------------------------------------------
local HoloCatalogueInst = HoloCatalogue:new()
HoloCatalogueInst:Init()
