ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config.Events["esx:getSharedObject"], function(obj) ESX = obj end)
		Citizen.Wait(100)
	end
end)

local displayStarterPack = false

RegisterNetEvent("tStarterPack:openMenu")
AddEventHandler('tStarterPack:openMenu', function()
	SetDisplay(not displayStarterPack)
end)

RegisterNUICallback("close", function(data)
    SetDisplay(false)
end)

RegisterNUICallback("1", function(data)
  SetResourceKvp("ChoosedPack", "legal")
  ChoosedPack = GetResourceKvpString("ChoosedPack")
  SetDisplay(false)
end)

RegisterNUICallback("2", function(data)
  SetResourceKvp("ChoosedPack", "illegal")
  ChoosedPack = GetResourceKvpString("ChoosedPack")
  SetDisplay(false)
end)

RegisterNUICallback("3", function(data)
  SetResourceKvp("ChoosedPack", "aucun")
  ChoosedPack = GetResourceKvpString("ChoosedPack")
  SetDisplay(false)
end)

function SetDisplay(bool)
  displayStarterPack = bool
  SetNuiFocus(bool, bool)
  SendNUIMessage({
      type = "openStarterPack",
      status = bool
  })
end

CreateThread(function()
  while true do
      if ChoosedPack == "legal" then
        TriggerServerEvent('tStarterPack:legalPack')
        ChoosedPack = nil
      elseif ChoosedPack == "illegal" then
        TriggerServerEvent('tStarterPack:illegalPack')
        ChoosedPack = nil
      elseif ChoosedPack == "aucun" then
        TriggerServerEvent('tStarterPack:aucunPack')
        ChoosedPack = nil
      end
      Citizen.Wait(80)
  end
end)

TriggerEvent("chat:addSuggestion", "/starterpack", "Selectionnez votre pack de démarrage", nil)
RegisterCommand("starterpack", function()
  TriggerServerEvent('tStarterPack:checkIfNoStarterPack')
end, false)