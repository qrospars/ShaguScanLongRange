local function AddHunterRangeFilter()
  if not ShaguScan or not ShaguScan.filter then return end

  local filter = ShaguScan.filter

  -- Hunter max range (~41y with Hawk Eye)
  -- Uses Auto Shot as range proxy
  filter.huntrange = function(unit)
    if not unit then return false end

    -- Prefer real spell range check
    if IsSpellInRange then
      local result = IsSpellInRange("Auto Shot", unit)
      return result == 1
    end

    -- Fallback to interaction range (~28y)
    if CheckInteractDistance then
      return CheckInteractDistance(unit, 4) and true or false
    end

    return false
  end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:SetScript("OnEvent", AddHunterRangeFilter)