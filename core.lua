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

local mapid2area = {
    ["443"] = "wsg",
    ["461"] = "ab",
    ["482"] = "eots",
    ["813"] = "eots",
    ["626"] = "tp",
    ["736"] = "gilneas",
    ["856"] = "temple",
    ["881"] = "temple",
    ["860"] = "mines",
    ["935"] = "panda",
}

-- my "Ino Tadataka" works!
local areaCoords = {
    ["wsg"] = {
        area = "Warsong Gulch",
        info = {
            topLeft     = { label = "Ally", x1 = 0.453, x2 = 0.57, y1 = 0.08, y2 = 0.3 },
            bottomLeft  = { label = "Horde", x1 = 0.44, x2 = 0.56, y1 = 0.73, y2 = 0.95 },
        }
    },
    ["ab"] = {
        area = "Arathi Basin",
        info = {
            topLeft     = { label = "ST", x1 = 0.33, x2 = 0.4, y1 = 0.24, y2 = 0.319 },
            topRight    = { label = "GM", x1 = 0.53, x2 = 0.6, y1 = 0.27, y2 = 0.37 },
            middleLeft  = { label = "BS", x1 = 0.432, x2 = 0.49, y1 = 0.38, y2 = 0.49 },
            bottomLeft  = { label = "LM", x1 = 0.37, x2 = 0.44, y1 = 0.540, y2 = 0.65 },
            bottomRight = { label = "Farm", x1 = 0.55, x2 = 0.62, y1 = 0.558, y2 = 0.638 },
        }
    },
    ["eots"] = {
        area = "Eye of the Storm",
        info = {
            topLeft     = { label = "MT", x1 = 0.38, x2 = 0.419, y1 = 0.395, y2 = 0.446 },
            topRight    = { label = "DR", x1 = 0.55, x2 = 0.582, y1 = 0.382, y2 = 0.44 },
            middleLeft  = { label = "Mid", x1 = 0.465, x2 = 0.5, y1 = 0.44, y2 = 0.54 },
            bottomLeft  = { label = "FRR", x1 = 0.39, x2 = 0.425, y1 = 0.558, y2 = 0.61 },
            bottomRight = { label = "BET", x1 = 0.546, x2 = 0.58, y1 = 0.55, y2 = 0.6 },
        }
    },
    ["tp"] = {
        area = "Twin Peaks",
        info = {
            topLeft     = { label = "Ally", x1 = 0.545, x2 = 0.65, y1 = 0.1, y2 = 0.29 },
            bottomLeft  = { label = "Horde", x1 = 0.43, x2 = 0.55, y1 = 0.74, y2 = 0.94 },
        }
    },
    ["gilneas"] = {
        area = "Battle for Gilneas",
        info = {
            topRight    = { label = "Mine", x1 = 0.58, x2 = 0.652, y1 = 0.368, y2 = 0.452 },
            bottomLeft  = { label = "LH", x1 = 0.317, x2 = 0.395, y1 = 0.58, y2 = 0.68 },
            bottomRight = { label = "WW", x1 = 0.59, x2 = 0.66, y1 = 0.64, y2 = 0.76 },
        }
    },
    ["temple"] = {
        area = "Temple of Kotmogu",
        info = {
            topLeft     = { label = "Purple", x1 = 0.359, x2 = 0.43, y1 = 0.36, y2 = 0.464 },
            topRight    = { label = "Orange", x1 = 0.545, x2 = 0.620, y1 = 0.36, y2 = 0.464 },
            bottomLeft  = { label = "Green", x1 = 0.359, x2 = 0.43, y1 = 0.6, y2 = 0.702 },
            bottomRight = { label = "Blue", x1 = 0.545, x2 = 0.620, y1 = 0.6, y2 = 0.702 },
        }
    },
    ["mines"] = {
        area = "Silvershard Mines",
        info = {
            topLeft     = { label = "Earth", x1 = 0.15, x2 = 0.35, y1 = 0.28, y2 = 0.47 },
            topRight    = { label = "Top", x1 = 0.67, x2 = 0.8, y1 = 0.15, y2 = 0.33 },
            bottomLeft  = { label = "Water", x1 = 0.35, x2 = 0.482, y1 = 0.55, y2 = 0.9 },
            bottomRight = { label = "Lava", x1 = 0.63, x2 = 0.75, y1 = 0.55, y2 = 0.84 },
        }
    },
    ["panda"] = {
        area = "Deepwind Gorge",
        info = {
            topLeft     = { label = "Panda", x1 = 0.54, x2 = 0.63, y1 = 0.08, y2 = 0.206 },
            middleLeft  = { label = "Mid", x1 = 0.476, x2 = 0.581, y1 = 0.417, y2 = 0.568 },
            bottomLeft  = { label = "Goblin", x1 = 0.41, x2 = 0.5, y1 = 0.784, y2 = 0.9 },
        }
    },
}


local addon = LibStub("AceAddon-3.0"):NewAddon("EnhancedBGZoneMap")
local frame = CreateFrame("Frame", nil, UIParent)
local tick = CreateFrame("Frame", nil, frame)
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
            feature_wsg = true,
            feature_ab = true,
            feature_eots = true,
            feature_tp = true,
            feature_gilneas = true,
            feature_temple = true,
            feature_mines = true,
            feature_panda = true,
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
                name = "\n\nField features (this is BETA!! You have been warned!!!)\n",
                width = "full",
            },

            feature_wsg = { order = 21, type = "toggle", name = "Warsong Gulch", width = "full", set = setter, get = getter },
            feature_ab = { order = 22, type = "toggle", name = "Arathi Basin", width = "full", set = setter, get = getter },
            feature_eots = { order = 23, type = "toggle", name = "Eye of the Storm", width = "full", set = setter, get = getter },
            feature_tp = { order = 24, type = "toggle", name = "Twin Peaks", width = "full", set = setter, get = getter },
            feature_gilneas = { order = 25, type = "toggle", name = "Battle for Gilneas", width = "full", set = setter, get = getter },
            feature_temple = { order = 26, type = "toggle", name = "Temple of Kotmogu", width = "full", set = setter, get = getter },
            feature_mines = { order = 27, type = "toggle", name = "Silvershard Mine", width = "full", set = setter, get = getter },
            feature_panda = { order = 28, type = "toggle", name = "Deepwind Gorge", width = "full", set = setter, get = getter },
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
    addon.markers = {}
    
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
        marker.unit = "player"
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

--[[
        if string.match(key, "Sub") then
            addon.info[key]:SetText("Test Test Test Test Test Test Test Test Test Test")
        else
            addon.info[key]:SetText("Point (2)")
        end
        addon.info[key]:Show()
--]]
    end
    
    
    local mapID = GetCurrentMapAreaID()
    local areaID = mapid2area["" .. mapID]
    if (not UnitInBattleground("player") or
        not areaID or
        not addon.db.profile["feature_" .. areaID]) then
        return
    end
        
    local coords = areaCoords[ areaID ]
    for posID, posInfo in pairs(coords.info) do
        local num = 0
        local sub = ""
        for unit, meta in pairs(addon.markers) do
            if (meta.x >= posInfo.x1 and meta.x <= posInfo.x2 and
                meta.y >= posInfo.y1 and meta.y <= posInfo.y2) then
                num = num + 1
                sub = sub .. string.format(classColorFormats[meta.classID], string.sub(meta.name, 0, 4)) .. " "
            end
        end
        
        local frame = addon.info[ posID ]
        local count = ""
        if num > 0 then
            count = " (" .. num .. ")"
        end
        frame:SetText(posInfo.label .. count)
        frame:Show()
        
        if num > 0 and num < 9 then
            local subframe = addon.info[ posID .. "Sub" ]
            subframe:SetText(sub)
            subframe:Show()
        end
    end
end

function addon:setupInfoFrames()
    local padding = addon.db.profile.mapScale * 13 
    local basesize = addon.db.profile.mapScale * 9
    local subsize = basesize * 0.7

    -- top left
    local label = frame:CreateFontString("NameText", "ARTWORK", "GameFontHighlightSmall")
    label:SetFont("Fonts\\FRIZQT__.TTF", basesize)
    label:SetPoint("TOPLEFT", BattlefieldMinimap, padding, -1 * padding)
    label:SetJustifyH("LEFT")
    label:SetJustifyV("TOP")
    label:Hide()
    addon.info.topLeft = label

    local label = frame:CreateFontString("NameText", "ARTWORK", "GameFontHighlightSmall")
    label:SetFont("Fonts\\FRIZQT__.TTF", subsize)
    label:SetWordWrap(true)
    label:SetSize(subsize * 10, subsize * 3)
    label:SetPoint("TOPLEFT", addon.info.topLeft, "BOTTOMLEFT", 1, -2)
    label:SetJustifyH("LEFT")
    label:SetJustifyV("TOP")
    label:Hide()
    addon.info.topLeftSub = label

    -- top right
    local label = frame:CreateFontString("NameText", "ARTWORK", "GameFontHighlightSmall")
    label:SetFont("Fonts\\FRIZQT__.TTF", basesize)
    label:SetPoint("TOPRIGHT", BattlefieldMinimap, -2 * padding, -1 * padding)
    label:SetJustifyH("LEFT")
    label:SetJustifyV("TOP")
    label:Hide()
    addon.info.topRight = label

    local label = frame:CreateFontString("NameText", "ARTWORK", "GameFontHighlightSmall")
    label:SetFont("Fonts\\FRIZQT__.TTF", subsize)
    label:SetWordWrap(true)
    label:SetSize(subsize * 10, subsize * 3)
    label:SetPoint("TOPLEFT", addon.info.topRight, "BOTTOMLEFT", 1, -2)
    label:SetJustifyH("LEFT")
    label:SetJustifyV("TOP")
    label:Hide()
    addon.info.topRightSub = label

    -- middle left
    local label = frame:CreateFontString("NameText", "ARTWORK", "GameFontHighlightSmall")
    label:SetFont("Fonts\\FRIZQT__.TTF", basesize)
    label:SetPoint("TOPLEFT", BattlefieldMinimap, padding, -basesize * 5.5)
    label:SetJustifyH("LEFT")
    label:SetJustifyV("TOP")
    label:Hide()
    addon.info.middleLeft = label

    local label = frame:CreateFontString("NameText", "ARTWORK", "GameFontHighlightSmall")
    label:SetFont("Fonts\\FRIZQT__.TTF", subsize)
    label:SetWordWrap(true)
    label:SetSize(subsize * 10, subsize * 3)
    label:SetPoint("TOPLEFT", addon.info.middleLeft, "BOTTOMLEFT", 1, -2)
    label:SetJustifyH("LEFT")
    label:SetJustifyV("TOP")
    label:Hide()
    addon.info.middleLeftSub = label

    -- bottom left
    local label = frame:CreateFontString("NameText", "ARTWORK", "GameFontHighlightSmall")
    label:SetFont("Fonts\\FRIZQT__.TTF", basesize)
    label:SetPoint("TOPLEFT", BattlefieldMinimap, "BOTTOMLEFT", padding, padding + basesize * 3.5)
    label:SetJustifyH("LEFT")
    label:SetJustifyV("TOP")
    label:Hide()
    addon.info.bottomLeft = label

    local label = frame:CreateFontString("NameText", "ARTWORK", "GameFontHighlightSmall")
    label:SetFont("Fonts\\FRIZQT__.TTF", subsize)
    label:SetWordWrap(true)
    label:SetSize(subsize * 10, subsize * 3)
    label:SetPoint("TOPLEFT", addon.info.bottomLeft, "BOTTOMLEFT", 1, -2)
    label:SetJustifyH("LEFT")
    label:SetJustifyV("TOP")
    label:Hide()
    addon.info.bottomLeftSub = label

    -- bottom right
    local label = frame:CreateFontString("NameText", "ARTWORK", "GameFontHighlightSmall")
    label:SetFont("Fonts\\FRIZQT__.TTF", basesize)
    label:SetPoint("TOPRIGHT", BattlefieldMinimap, "BOTTOMRIGHT", -2 * padding, padding + basesize *  3.5)
    label:SetJustifyH("LEFT")
    label:SetJustifyV("TOP")
    label:Hide()
    addon.info.bottomRight = label

    local label = frame:CreateFontString("NameText", "ARTWORK", "GameFontHighlightSmall")
    label:SetFont("Fonts\\FRIZQT__.TTF", subsize)
    label:SetWordWrap(true)
    label:SetSize(subsize * 10, subsize * 3)
    label:SetPoint("TOPLEFT", addon.info.bottomRight, "BOTTOMLEFT", 1, -2)
    label:SetJustifyH("LEFT")
    label:SetJustifyV("TOP")
    label:Hide()
    addon.info.bottomRightSub = label
end
