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

local classColorFormats = {
    ["DEATHKNIGHT"] = "|cFFC41F3B%s|r",
    ["DRUID"] = "|cFFFF7D0A%s|r",
    ["HUNTER"] = "|cFFABD473%s|r",
    ["MAGE"] = "|cFF69CCF0%s|r",
    ["MONK"] = "|cFF00FF96%s|r",
    ["PALADIN"] = "|cFFF58CBA%s|r",
    ["PRIEST"] = "|cFFFFFFFF%s|r",
    ["ROGUE"] = "|cFFFFF569%s|r",
    ["SHAMAN"] = "|cFF0070DE%s|r",
    ["WARLOCK"] = "|cFF9482C9%s|r",
    ["WARRIOR"] = "|cFFC79C6E%s|r",
}

-- my "ino tadataka" workds
local areaCoords = {
    ID443 = {
        area = "Warsong Gulch",
        info = {
            topLeft     = { label = "Ally %s", x1 = 0.453, x2 = 0.57, y1 = 0.08, y2 = 0.3 },
            bottomLeft  = { label = "Horde %s", x1 = 0.44, x2 = 0.56, y1 = 0.73, y2 = 0.95 },
        }
    },
    ID461 = {
        area = "Arathi Basin",
        info = {
            topLeft     = { label = "St %s", x1 = 0.33, x2 = 0.4, y1 = 0.24, y2 = 0.319 },
            topRight    = { label = "%s GM", x1 = 0.53, x2 = 0.6, y1 = 0.27, y2 = 0.37 },
            middleLeft  = { label = "AB %s", x1 = 0.432, x2 = 0.49, y1 = 0.38, y2 = 0.49 },
            bottomLeft  = { label = "LM %s", x1 = 0.37, x2 = 0.44, y1 = 0.540, y2 = 0.65 },
            bottomRight = { label = "%s Farm", x1 = 0.55, x2 = 0.62, y1 = 0.558, y2 = 0.638 },
        }
    },
    ID482 = {
        area = "Eye of the Storm",
        info = {
            topLeft     = { label = "MT %s", x1 = 0.38, x2 = 0.419, y1 = 0.395, y2 = 0.446 },
            topRight    = { label = "%s DR", x1 = 0.55, x2 = 0.582, y1 = 0.382, y2 = 0.44 },
            middleLeft  = { label = "Mid %s", x1 = 0.465, x2 = 0.5, y1 = 0.44, y2 = 0.54 },
            bottomLeft  = { label = "FRR %s", x1 = 0.39, x2 = 0.425, y1 = 0.558, y2 = 0.61 },
            bottomRight = { label = "%s BET", x1 = 0.546, x2 = 0.58, y1 = 0.55, y2 = 0.6 },
        }
    },
    ID626 = {
        area = "Twin Peaks",
        info = {
            topLeft     = { label = "Ally %s", x1 = 0.545, x2 = 0.65, y1 = 0.1, y2 = 0.29 },
            bottomLeft  = { label = "Horde %s", x1 = 0.43, x2 = 0.55, y1 = 0.74, y2 = 0.94 },
        }
    },
    ID736 = {
        area = "Battle for Gilneas",
        info = {
            topLeft     = { label = "Mine %s", x1 = 0.58, x2 = 0.652, y1 = 0.368, y2 = 0.452 },
            bottomLeft  = { label = "LH %s", x1 = 0.317, x2 = 0.395, y1 = 0.58, y2 = 0.68 },
            bottomRight = { label = "%s WW", x1 = 0.59, x2 = 0.66, y1 = 0.64, y2 = 0.76 },
        }
    },
    ID856 = {
        area = "Temple of Kotmogu",
        info = {
            topLeft     = { label = "Purple %s", x1 = 0.359, x2 = 0.43, y1 = 0.36, y2 = 0.464 },
            topRight    = { label = "%s Orange", x1 = 0.545, x2 = 0.620, y1 = 0.36, y2 = 0.464 },
            bottomLeft  = { label = "Green %s", x1 = 0.359, x2 = 0.43, y1 = 0.6, y2 = 0.702 },
            bottomRight = { label = "%s Blue", x1 = 0.545, x2 = 0.620, y1 = 0.6, y2 = 0.702 },
        }
    },
    ID860 = {
        area = "Silvershard Mines",
        info = {
            topLeft     = { label = "Earth %s", x1 = 0.15, x2 = 0.35, y1 = 0.28, y2 = 0.47 },
            topRight    = { label = "%s Top", x1 = 0.67, x2 = 0.8, y1 = 0.15, y2 = 0.33 },
            bottomLeft  = { label = "Water %s", x1 = 0.35, x2 = 0.482, y1 = 0.55, y2 = 0.9 },
            bottomRight = { label = "%s Lava", x1 = 0.63, x2 = 0.75, y1 = 0.55, y2 = 0.84 },
        }
    },
    ID935 = {
        area = "Deepwind Gorge",
        info = {
            topLeft     = { label = "Panda %s", x1 = 0.54, x2 = 0.63, y1 = 0.08, y2 = 0.206 },
            middleLeft  = { label = "Mid %s", x1 = 0.476, x2 = 0.581, y1 = 0.417, y2 = 0.568 },
            bottomLeft  = { label = "Goblin %s", x1 = 0.41, x2 = 0.5, y1 = 0.784, y2 = 0.9 },
        }
    },
}


local addon = LibStub("AceAddon-3.0"):NewAddon("EnhancedBGZoneMap")
local tick = CreateFrame("Frame")
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:RegisterEvent("PLAYER_ENTERING_BATTLEGROUND")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("PLAYER_LEAVING_WORLD")
frame:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
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

hooksecurefunc("BattlefieldMinimap_OnUpdate", function()
    addon:updateMarkers()
end)

SLASH_UPDATEZONEMAPNAMELABEL1 = "/enhancedbgzonemap"
SLASH_UPDATEZONEMAPNAMELABEL2 = "/zonemap"

SlashCmdList["UPDATEZONEMAPNAMELABEL"] = function (opt)
    addon:updateMarkers()
    print("EnhancedBGZoneMap: updated")
end

tick:SetScript("OnUpdate", function(self, elapsed)
    addon.last_updated = (addon.last_updated or 0) + elapsed
    if addon.last_updated > 1 then -- check by 1 sec
        addon.last_updated = 0
        addon:updateMarkers()
    end
end)


function addon:OnInitialize()
    local setter = function(info, val) addon.db.profile[ info[#info] ] = val; addon:setupZonemap() end
    local getter = function(info) return addon.db.profile[ info[#info] ] end
    
    local defaults = {
        profile = {
            mapScale = 1.5,
            arrowScale = 1,
            pointScale = 0.5,
            hideBorder = false,
            feature443 = false,
            feature461 = false,
            feature482 = false,
            feature626 = false,
            feature736 = false,
            feature856 = false,
            feature860 = false,
            feature935 = false,
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
                name = "Party member scale",
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

            desc = {
                order = 20,
                type = "description",
                fontSize = "medium",
                name = "\n\n[R.A.D.A.R] Field features (this is BETA!! You have been warned!!!)\n",
                width = "full",
            },

            feature443 = { order = 21, type = "toggle", name = "Warsong Gulch", width = "full", set = setter, get = getter },
            feature461 = { order = 22, type = "toggle", name = "Arathi Basin", width = "full", set = setter, get = getter },
            feature482 = { order = 23, type = "toggle", name = "Eye of the Storm", width = "full", set = setter, get = getter },
            feature626 = { order = 24, type = "toggle", name = "Twin Peaks", width = "full", set = setter, get = getter },
            feature736 = { order = 25, type = "toggle", name = "Battle for Gilneas", width = "full", set = setter, get = getter },
            feature856 = { order = 26, type = "toggle", name = "Temple of Kotmogu", width = "full", set = setter, get = getter },
            feature860 = { order = 27, type = "toggle", name = "Silvershard Mine", width = "full", set = setter, get = getter },
            feature935 = { order = 28, type = "toggle", name = "Deepwind Gorge", width = "full", set = setter, get = getter },
        }
    }
    
    self.db = LibStub("AceDB-3.0"):New(self.name .. "DB", defaults)
    LibStub("AceConfig-3.0"):RegisterOptionsTable(self.name, options)
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions(self.name)
    
    self.info = {}
    self.markers = {}
    self:setupInfoFrames()
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
    
    addon:updateInfo()
end

function addon:setMaker(marker)
    local x, y = GetPlayerMapPosition(marker.unit)
    local name = GetUnitName(marker.unit)
    local _, classID = UnitClass(marker.unit)
    
    local default = 24
    
    if UnitIsUnit(marker.unit, "player") then
        marker:SetHeight(default * addon.db.profile.arrowScale)
        marker:SetWidth(default * addon.db.profile.arrowScale)
    else
        marker:SetHeight(default * addon.db.profile.pointScale)
        marker:SetWidth(default * addon.db.profile.pointScale)
        
        marker.icon:SetTexture("Interface\\Minimap\\PartyRaidBlips")
        if BLIP_TEX_COORDS[classID] then
            marker.icon:SetTexCoord(unpack(BLIP_TEX_COORDS[classID]))
        end
    end
    
    if (UnitIsDeadOrGhost(marker.unit) or not classID) then
        addon.markers[ marker.unit ] = nil
    else
        addon.markers[ marker.unit ] = {
            x = x,
            y = y,
            name = name,
            classID = classID,
        }
    end
end

function addon:updateInfo()
    for key in pairs(addon.info) do
        addon.info[key]:Hide()
    end
    
    local mapID = GetCurrentMapAreaID()
    if (not UnitInBattleground("player") or
        not addon.db.profile["feature" .. mapID] or
        not areaCoords["ID" .. mapID]) then
        return
    end
    
    for posID, posInfo in pairs(areaCoords["ID" .. mapID].info) do
        local num = 0
        local sub = ""
        for unit, meta in pairs(addon.markers) do
            if (meta.x >= posInfo.x1 and meta.x <= posInfo.x2 and
                meta.y >= posInfo.y1 and meta.y <= posInfo.y2) then
                num = num + 1
                sub = sub .. string.format(classColorFormats[meta.classID], string.strsub(meta.name, 0,3)) .. " "
            end
        end
        
        local frame = addon.info[ posID ]
        local count = ""
        if num > 0 then
            count = "(" .. num .. ")"
        end
        frame:SetText(posInfo.label:format(count))
        frame:Show()
        
        if num > 0 and num <= 5 then
            local subframe = addon.info[ posID .. "Sub" ]
            subframe:SetText(subframe)
            subframe:Show()
        end
    end
end

function addon:setupInfoFrames()
    local basesize = addon.db.profile.mapScale * 9
    local subsize = basesize * 0.7

    local label = frame:CreateFontString("NameText", "ARTWORK", "GameFontHighlightSmall")
    label:SetFont("Fonts\\FRIZQT__.TTF", basesize)
    label:SetPoint("TOPLEFT", BattlefieldMinimap, 10, -10)
    label:SetJustifyH("LEFT")
    label:SetJustifyV("TOP")
    label:Hide()
    addon.info.topLeft = label

    local label = frame:CreateFontString()
    label:SetFont("Fonts\\FRIZQT__.TTF", subsize)
    label:SetWordWrap(true)
    label:SetSize(basesize * 5, basesize * 2)
    label:SetPoint("TOPLEFT", BattlefieldMinimap, 10, -10 - basesize)
    label:SetJustifyH("LEFT")
    label:SetJustifyV("TOP")
    label:Hide()
    addon.info.topLeftSub = label

    local label = frame:CreateFontString("NameText", "ARTWORK", "GameFontHighlightSmall")
    label:SetFont("Fonts\\FRIZQT__.TTF", basesize)
    label:SetPoint("TOPRIGHT", BattlefieldMinimap, -20, -10)
    label:SetJustifyH("RIGHT")
    label:SetJustifyV("TOP")
    label:Hide()
    addon.info.topRight = label

    local label = frame:CreateFontString()
    label:SetFont("Fonts\\FRIZQT__.TTF", subsize)
    label:SetWordWrap(true)
    label:SetSize(basesize * 5, basesize * 2)
    label:SetPoint("TOPRIGHT", BattlefieldMinimap, -20, -10 - basesize)
    label:SetJustifyH("RIGHT")
    label:SetJustifyV("TOP")
    label:Hide()
    addon.info.topRightSub = label

    local label = frame:CreateFontString("NameText", "ARTWORK", "GameFontHighlightSmall")
    label:SetFont("Fonts\\FRIZQT__.TTF", basesize)
    label:SetPoint("TOPLEFT", BattlefieldMinimap, 10, -10 -basesize * 5)
    label:SetJustifyH("LEFT")
    label:SetJustifyV("TOP")
    label:Hide()
    addon.info.middleLeft = label

    local label = frame:CreateFontString()
    label:SetFont("Fonts\\FRIZQT__.TTF", subsize)
    label:SetWordWrap(true)
    label:SetSize(basesize * 5, basesize * 2)
    label:SetPoint("TOPLEFT", BattlefieldMinimap, 10, -10 -basesize * 6)
    label:SetJustifyH("LEFT")
    label:SetJustifyV("TOP")
    label:Hide()
    addon.info.middleLeftSub = label

    local label = frame:CreateFontString("NameText", "ARTWORK", "GameFontHighlightSmall")
    label:SetFont("Fonts\\FRIZQT__.TTF", basesize)
    label:SetPoint("TOPLEFT", BattlefieldMinimap, "BOTTOMLEFT", 10, 20 + basesize * 3)
    label:SetJustifyH("LEFT")
    label:SetJustifyV("BOTTOM")
    label:Hide()
    addon.info.bottomLeft = label

    local label = frame:CreateFontString()
    label:SetFont("Fonts\\FRIZQT__.TTF", subsize)
    label:SetWordWrap(true)
    label:SetSize(basesize * 5, basesize * 2)
    label:SetPoint("TOPLEFT", BattlefieldMinimap, "BOTTOMLEFT", 10, 20 + basesize * 2.5)
    label:SetJustifyH("LEFT")
    label:SetJustifyV("BOTTOM")
    label:Hide()
    addon.info.bottomLeftSub = label

    local label = frame:CreateFontString("NameText", "ARTWORK", "GameFontHighlightSmall")
    label:SetFont("Fonts\\FRIZQT__.TTF", basesize)
    label:SetPoint("TOPRIGHT", BattlefieldMinimap, "BOTTOMRIGHT", -20, 20 + basesize * 3)
    label:SetJustifyH("RIGHT")
    label:SetJustifyV("BOTTOM")
    label:Hide()
    addon.info.bottomRight = label

    local label = frame:CreateFontString()
    label:SetFont("Fonts\\FRIZQT__.TTF", subsize)
    label:SetWordWrap(true)
    label:SetSize(basesize * 5, basesize * 2)
    label:SetPoint("TOPRIGHT", BattlefieldMinimap, "BOTTOMRIGHT", -20, 20 + basesize * 2.5)
    label:SetJustifyH("RIGHT")
    label:SetJustifyV("BOTTOM")
    label:Hide()
    addon.info.bottomRightSub = label
end
