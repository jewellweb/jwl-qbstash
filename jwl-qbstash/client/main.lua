--[[
              # #     # #                  # #     # #   
              # #     # #	    # # #      # #     # #
              # #     # #	   # # # #     # #     # #
         	  # #     # #     # #   # #    # #     # #
              # # 	  # #    # #     # #   # #     # #
        # #	  # #	  # #   # #       # #  # #     # #
        # # # # #	   # # # #         # # # #     # # # # # #
         # # # #        # # #           # # #      # # # # # #        
--]]

local PlayerData = {}

QBCore = nil

local coreLoaded = false
Citizen.CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Citizen.Wait(200)
    end
    coreLoaded = true
end)


RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
end)


RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(job)
    PlayerData.job = job
end)


function OpenStashMenu(station)
	QBCore.UI.Menu.CloseAll()
	QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'armory', {
		title    = "Depo",
		align    = 'top-left',
		elements = {
			{label = "Eşya Al", value = 'buy_items'}, -- BURASI EŞYA SATIN ALMA BÖLÜMÜ
			{label = 'Envanter', value = 'put_stock'}, -- BURASI DEPO
		}
	}, function(data, menu)
		if data.current.value == 'buy_items' then
			menu.close()
			TriggerServerEvent("inventory:server:OpenInventory", "shop", "ballas", Config.Items) -- HANGİ MESLEK DEPOYU AÇABİLİR (BALLAS YAZAN YER) ALTTAKİNİ DEĞİŞTİRMEYİ UNUTMAYIN!
		elseif data.current.value == 'put_stock' then
			menu.close()
			TriggerEvent("inventory:client:SetCurrentStash", "jwlDepo", QBCore.Key)
			TriggerServerEvent("inventory:server:OpenInventory", "stash", "jwlDepo", {maxweight = 4000000, slots = 500,}) -- DEPO KİLOSU VE DEPO SLOT SAYISI
		end

	end, function(data, menu)
		menu.close()
	end)
end


Citizen.CreateThread(function()
	while true do
		local time = 5000
		if PlayerData.job and PlayerData.job.name == 'ballas' then -- HANGİ MESLEK DEPOYU AÇABİLİR (BALLAS YAZAN YER)
			time = 1000                                           
			local playerPed = PlayerPedId()
			local playerCoords = GetEntityCoords(playerPed)

			for merryNum, location in pairs(Config.JWLDepo) do
				for k,coord in ipairs(location.Stash) do
					local distance = #(playerCoords - coord)
					if distance < 2 then
						time = 1
						local text = ""
						if distance < 1 then
							text = "[E] " -- HAVADA GÖZÜKEN YAZI
							if IsControlJustPressed(0, 38) then
								OpenStashMenu()
							end
						end
						QBCore.Functions.DrawText3D(coord.x,coord.y,coord.z, text.."Depo") -- HAVADA GÖZÜKEN YAZI V2
					end
				end
			end
		end
	Citizen.Wait(time)
	end
end)