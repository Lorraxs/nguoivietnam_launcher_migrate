---@class SVMainImpl : Impl
local Impl = NewSyncImpl("Main")

function Impl:Init()
  self:LogInfo("%s initialized", self:GetName())
  exports("RequestPlayerId", function(playerSrc)
    return self:RequestPlayerId(playerSrc)
  end)
end

function Impl:OnReady()
  self:LogInfo("%s ready", self:GetName())
end

function Impl:RequestPlayerId(playerSrc)
  local result = lib.callback.await('nvn_request_id', playerSrc)
  return result
end

Impl.start()
