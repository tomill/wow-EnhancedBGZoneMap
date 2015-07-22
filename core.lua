LoadAddOn("Blizzard_BattlefieldMinimap")

-- coordes for Interface/Minimap/PartyRaidBlips
local BLIP_TEX_COORDS = { 
    ["WARRIOR"]     = { 0, 0.125, 0, 0.25 }, 
    ["PALADIN"]     = { 0.125, 0.25, 0, 0.25 }, 
    ["HUNTER"]      = { 0.25, 0.375, 0, 0.25 }, 
    ["ROGUE"]       = { 0.375, 0.5, 0, 0.25 }, 
    ["PRIEST"]      = { 0.5, 0.625, 0, 0.25 }, 
    ["DEATHKNIGHT"] = { 0.625, 0.75, 0, 0.25 }, 
    ["SHAMAN"]      = { 0.75, 0.875, 0, 0.25 }, 
    ["MAGE"]        = { 0.875, 1, 0, 0.25 }, 
    ["WARLOCK"]     = { 0, 0.125, 0.25, 0.5 }, 
    ["DRUID"]       = { 0.25, 0.375, 0.25, 0.5 }, 
    ["MONK"]        = { 0.125, 0.25, 0.25, 0.5 }, 
}

local mapScale = 1.8
local pointScale = 1.2
local arrowScale = 1.3
local nameScale = 0.6
local nameLength = 2

local classCount = { }

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
frame:RegisterEvent("PLAYER_ENTERING_BATTLEGROUND")


local function setupZonemap()
    BattlefieldMinimapBackground:Hide()
    BattlefieldMinimapCorner:Hide()
    BattlefieldMinimapCloseButton:Hide()
    BattlefieldMinimap:SetScale(mapScale)
    BattlefieldMinimap:Show()
end


local function setMakerSize(marker)
    if marker.scaleChanged then return end
    
    local h = marker:GetHeight()
    local w = marker:GetWidth()
    if UnitIsUnit(marker.unit, "player") then
        marker:SetHeight(h * arrowScale)
        marker:SetWidth(w * arrowScale)
    else
        marker:SetHeight(h * pointScale)
        marker:SetWidth(w * pointScale)
    end
    
    marker:SetFrameStrata("HIGH")
    marker.scaleChanged = true
end


local function setMakerTexture(marker)
    local _, class = UnitClass(marker.unit)
    marker.icon:SetTexture("Interface\\Minimap\\PartyRaidBlips")
    marker.icon:SetTexCoord(unpack(BLIP_TEX_COORDS[class]))
end

local function setNameLabel(marker)
    if not marker.nametext then
        marker.nametext = marker:CreateFontString(marker:GetName() .. "NameText", "ARTWORK", "GameFontHighlightSmall")
        marker.nametext:SetFont("Fonts\\FRIZQT__.TTF", marker:GetHeight() * nameScale)
    end
    
    marker.nametext:Hide()
    
    local _, class = UnitClass(marker.unit)
    if (classCount[class] and classCount[class] > 1) then
        local name = UnitName(marker.unit)
        name = string.sub(name, 0, nameLength)
        
        local color = RAID_CLASS_COLORS[class]
        marker.nametext:SetText(name)
        marker.nametext:SetTextColor(color.r, color.g, color.b)
        
        if (tonumber(string.sub(marker.unit, -1)) % 2 == 0) then
            marker.nametext:SetPoint("LEFT", marker, "RIGHT")
        else
            marker.nametext:SetPoint("RIGHT", marker, "LEFT")
        end
        
        marker.nametext:Show()
    end
end

-- local unit2pos = {}
-- local matrix2num = {}
-- local function getPosition(unit)
--     local x, y = GetPlayerMapPosition(unit)
--     x = string.format("%d", (x + 0.001) * 10) .. ""
--     y = string.format("%d", (y + 0.001) * 10) .. ""
--     
--     unit2pos[unit] = { x = x, y = y }
--     local matrix = x .. "-" .. y
--     matrix2num[matrix] = (matrix2num[matrix] or 0) + 1
-- end


local function updateZonemap()
    if not UnitInBattleground("player") then
        return
    end 
    
    local marker = _G["BattlefieldMinimapPlayer"]
    if marker then
        setMakerSize(marker)
    end
    
    local memberCount = GetNumGroupMembers()
    for i = 1, memberCount do
        local marker = _G["BattlefieldMinimapRaid" .. i]
        if marker then
            setMakerSize(marker)
            setMakerTexture(marker)
            setNameLabel(marker)
        end
    end
end


hooksecurefunc("BattlefieldMinimap_OnUpdate", function()
    updateZonemap()
end)
    
frame:SetScript("OnEvent", function(self, event)
    if (event == "ADDON_LOADED") then
        setupZonemap()
        frame:UnregisterEvent("ADDON_LOADED")
        return
    end
    
    classCount = { }
    local memberCount = GetNumGroupMembers()
    for i = 1, memberCount do
        local _, class = UnitClass("raid" .. i)
        classCount[class] = (classCount[class] or 0) + 1
    end
    
    local _, class = UnitClass("player")
    classCount[class] = (classCount[class] or 0) - 1
    
    if (event == "GROUP_ROSTER_UPDATE") then
        updateZonemap()
    end
end)


SLASH_UPDATEZONEMAPNAMELABEL1 = "/enhancedbgzonemap"
SLASH_UPDATEZONEMAPNAMELABEL2 = "/zonemap"

SlashCmdList["UPDATEZONEMAPNAMELABEL"] = function (opt)
    updateZonemap()
    print("EnhancedBGZoneMap updated")
end