---@class CLMainImpl : Impl
local Impl = NewSyncImpl("Main")

function Impl:Init()
  self:LogInfo("%s initialized", self:GetName())
  self:NUIHandlers()
  self.showUI = false
  self.promise = nil
  lib.callback.register('nvn_request_id', function()
    if self.promise then return end
    self.promise = promise.new()
    self:ShowUI()
    local result = Citizen.Await(self.promise)
    self.promise = nil
    return result
  end)
  RegisterCommand("testtt", function()
    print("z")
    self:ShowUI()
  end, false)
end

function Impl:NUIHandlers()
  RegisterNUICallback("confirm", function(body, resultCallback)
    resultCallback("ok")
    if self.promise then
      self.promise:resolve(body)
    end
    self:HideUI()
  end)

  RegisterNUICallback("skip", function(_, resultCallback)
    resultCallback("ok")
    if self.promise then
      self.promise:resolve('skip')
    end
    self:HideUI()
  end)
end

function Impl:OnReady()
  self:LogInfo("%s ready", self:GetName())
end

function Impl:ShowUI()
  if self.showUI then return end
  self.showUI = true
  SendNUIMessage({
    event = "main:setShow",
    data = self.showUI
  })
  SetNuiFocus(self.showUI, self.showUI)
end

function Impl:HideUI()
  if not self.showUI then return end
  self.showUI = false
  SendNUIMessage({
    event = "main:setShow",
    data = self.showUI
  })
  SetNuiFocus(self.showUI, self.showUI)
end

Impl.start()
