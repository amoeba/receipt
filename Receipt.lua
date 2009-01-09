local f = CreateFrame("frame")
f:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)
f:RegisterEvent("MERCHANT_SHOW")
f:RegisterEvent("MERCHANT_CLOSED")

-- UTILITY

function f:Print(msg) ChatFrame1:AddMessage(msg); end
function f:PrintF(fmsg, ...) ChatFrame1:AddMessage(string.format("|cFF33FF99Receipt|r "..fmsg, ...)); end

--[[  FormatMoney is a slight modification of code snippet by Tekkub
      (http://tekkub.net) which was posted at 
      http://gist.github.com/44479. My function worked the smae but
      Tekkub just did it prettier. ]]
  
local function FormatMoney(money)
  if not money then return end
  
  local money = money
  local g, s, c = floor(money/10000), floor((money/100)%100), money%100
  
  if g > 0 then return string.format("|cffffd700%dg|cffc7c7cf%02ds|cffeda55f%02dc", g, s, c)
  elseif s > 0 then return string.format("|cffc7c7cf%ds|cffeda55f%02dc", s, c)
  else return string.format("|cffc7c7cf%dc", c) end
end

function f:MERCHANT_SHOW()
  self:Print("MERCHANT_SHOW")
  local money = GetMoney()
  self:Print(money)
  self:PrintF("%s", FormatMoney(money))
end

function f:MERCHANT_CLOSED()
end