local QBCore = exports['qb-core']:GetCoreObject()

function NearTaxi(src)
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    for k,v in pairs(Config.NPCLocations.DeliverLocations) do
        local dist = #(coords - vector3(v.x,v.y,v.z))
        if dist < 20 then
            return true
        end
    end
end

RegisterNetEvent('qb-taxi:server:NpcPay', function(Payment)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "taxi" then
        if NearTaxi(src) then
            local randomAmount = math.random(1, 5)
            local r1, r2 = math.random(1, 5), math.random(1, 5)
            if randomAmount == r1 or randomAmount == r2 then Payment = Payment + math.random(75, 150) end 
            --Payment = math.random(250, 500)
            Player.Functions.AddMoney('cash', Payment)
            local chance = math.random(1, 100)
            if chance < 80 then
                Player.Functions.AddItem("joint", 1, false)
                TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["joint"], "add")
            end
        else
            DropPlayer(src, 'Attempting To Exploit')
        end
    else
        DropPlayer(src, 'Attempting To Exploit')
    end
end)
