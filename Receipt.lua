local f = CreateFrame("frame")
local about = LibStub("tekKonfig-AboutPanel").new(nil, "Receipt")


f:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)
f:RegisterEvent("MERCHANT_SHOW")
f:RegisterEvent("MERCHANT_CLOSED")

-- UTILITY
local initial_money = 0
local function PrintF(fmsg, ...) ChatFrame1:AddMessage(string.format("|cFFFFFF00"..fmsg.."|r", ...)); end

--[[  FormatMoney is a slight modification of code snippet by Tekkub
      (http://tekkub.net) which was posted at 
      http://gist.github.com/44479. My function worked the smae but
      Tekkub just did it prettier. ]]
  
local function FormatMoney(money)
  if not money then return end
  
  local money = abs(money)
  local g, s, c = floor(money/10000), floor((money/100)%100), money%100
  
  if g > 0 then return string.format("|cffffd700%dg|cffc7c7cf%02ds|cffeda55f%02dc", g, s, c)
  elseif s > 0 then return string.format("|cffc7c7cf%ds|cffeda55f%02dc", s, c)
  else return string.format("|cffeda55f%dc", c) end
end

function f:MERCHANT_SHOW()
  initial_money = GetMoney()
end

function f:MERCHANT_CLOSED()
  local delta = GetMoney() - initial_money
  
  if delta == 0 then return
  elseif delta > 0 then PrintF("You earned %s", FormatMoney(delta))
  else PrintF("You spent %s", FormatMoney(delta)) end
  
  -- Reset so MERCHANT_CLOSED being called twice doesn't make us spam the user
  initial_money = GetMoney()
end