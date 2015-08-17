-- required
LoadAddOn("Blizzard_BattlefieldMinimap")

-- coordes for Interface/Minimap/PartyRaidBlips.blp
local BLIP_TEX_COORDS = {
    ["WARRIOR"]     = { 0,     0.125, 0,    0.25 },
    ["PALADIN"]     = { 0.125, 0.25,  0,    0.25 },
    ["HUNTER"]      = { 0.25,  0.375, 0,    0.25 },
    ["ROGUE"]       = { 0.375, 0.5,   0,    0.25 },
    ["PRIEST"]      = { 0.5,   0.625, 0,    0.25 },
    ["DEATHKNIGHT"] = { 0.625, 0.75,  0,    0.25 },
    ["SHAMAN"]      = { 0.75,  0.875, 0,    0.25 },
    ["MAGE"]        = { 0.875, 1,     0,    0.25 },
    ["WARLOCK"]     = { 0,     0.125, 0.25, 0.5  },
    ["DRUID"]       = { 0.25,  0.375, 0.25, 0.5  },
    ["MONK"]        = { 0.125, 0.25,  0.25, 0.5  },
}

local addon = LibStub("AceAddon-3.0"):NewAddon("EnhancedBGZoneMap")
local tick = CreateFrame("Frame")
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
frame:RegisterEvent("PLAYER_ENTERING_BATTLEGROUND")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("PLAYER_LEAVING_WORLD")
frame:RegisterEvent("UPDATE_WORLD_STATES")
frame:RegisterEvent("WORLD_MAP_UPDATE")

frame:SetScript("OnEvent", function(self, event)
    if (event == "ADDON_LOADED") then
        addon:setupZonemap()
    end
    
    addon:updateMarkers()
    
    if UnitInBattleground("player") then
        tick:Show()
    else
        tick:Hide()
    end
end)

tick:SetScript("OnUpdate", function(self, elapsed)
    addon.last_updated = (addon.last_updated or 0) + elapsed
    if addon.last_updated > 1 then
        addon.last_updated = 0
        addon:updateMarkers()
    end
end)

hooksecurefunc("BattlefieldMinimap_OnUpdate", function()
    addon:updateMarkers()
end)
    
SLASH_UPDATEZONEMAPNAMELABEL1 = "/enhancedbgzonemap"
SLASH_UPDATEZONEMAPNAMELABEL2 = "/zonemap"

SlashCmdList["UPDATEZONEMAPNAMELABEL"] = function (opt)
    addon:updateMarkers()
    print("EnhancedBGZoneMap: updated")
end

function addon:OnInitialize()
    local setter = function(info, val) addon.db.profile[ info[#info] ] = val; addon:setupZonemap() end
    local getter = function(info) return addon.db.profile[ info[#info] ] end
    
    local defaults = {
        profile = {
            hideBorder = false,
            mapScale = 1.5,
            arrowScale = 1,
            pointScale = 0.5,
        }
    }

    local options = {
        type = "group",
        args = {
            mapScale = {
                order = 11,
                type = "range",
                name = "Zonemap frame scale",
                min = 0.5,
                max = 5,
                set = setter,
                get = getter,
            },
            
            arrowScale = {
                order = 12,
                type = "range",
                name = "Allow marker scale",
                min = 0.01,
                max = 3,
                set = setter,
                get = getter,
            },
            pointScale = {
                order = 13,
                type = "range",
                name = "Party player marker",
                min = 0.01,
                max = 3,
                set = setter,
                get = getter,
            },
            hideBorder = {
                order = 15,
                type = "toggle",
                name = "Hide zonemap border",
                width = "full",
                set = setter,
                get = getter,
            },
        }
    }
    
    self.db = LibStub("AceDB-3.0"):New(self.name .. "DB", defaults)
    LibStub("AceConfig-3.0"):RegisterOptionsTable(self.name, options)
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions(self.name)
end

function addon:setupZonemap()
    if addon.db.profile.hideBorder then
        BattlefieldMinimapBackground:Hide()
        BattlefieldMinimapCorner:Hide()
        BattlefieldMinimapCloseButton:Hide()
    else
        BattlefieldMinimapBackground:Show()
        BattlefieldMinimapCorner:Show()
        BattlefieldMinimapCloseButton:Show()
    end
    
    BattlefieldMinimap:SetScale(addon.db.profile.mapScale)
    BattlefieldMinimap:Show()
    
    addon:updateMarkers()
end

function addon:updateMarkers()
    local marker = _G["BattlefieldMinimapPlayer"]
    if marker then
        addon:setMaker(marker)
    end
    
    local memberCount = GetNumGroupMembers()
    for i = 1, memberCount do
        local marker = _G["BattlefieldMinimapRaid" .. i]
        if marker then
            addon:setMaker(marker)
        end
    end
end

function addon:setMaker(marker)
    local default = 24
    if UnitIsUnit(marker.unit, "player") then
        marker:SetHeight(default * addon.db.profile.arrowScale)
        marker:SetWidth(default * addon.db.profile.arrowScale)
    else
        marker:SetHeight(default * addon.db.profile.pointScale)
        marker:SetWidth(default * addon.db.profile.pointScale)
        
        local _, class = UnitClass(marker.unit)
        marker.icon:SetTexture("Interface\\Minimap\\PartyRaidBlips")
        marker.icon:SetTexCoord(unpack(BLIP_TEX_COORDS[class]))
    end
end