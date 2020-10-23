--[[ Credits by MalikTM ]]-- ! Don't Edit this Disclaimer !


keys = {
    -- Letter E
    ["E"] = 0xCEFD9220,
}

function whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end

local keyopen = false

Citizen.CreateThread(function()
    WarMenu.CreateMenu('Cookin', "Cooking")
    WarMenu.SetSubTitle('Cookin', 'Eating some meat today?' )

    local _source = source
    while true do

        local ped = GetPlayerPed(-1)
        local coords = GetEntityCoords(PlayerPedId())

        if WarMenu.IsMenuOpened('Cookin') then
            if WarMenu.MenuButton('Cook some Meat', "Cookin") then
                TriggerServerEvent("maliko:cookmeat")
                TriggerEvent("chiudimenu")
                print("Yes")
               -- TriggerEvent("chiudimenu")
			end
            WarMenu.Display()
        end
        Citizen.Wait(0)
    end
end)


RegisterNetEvent("chiudimenu")
AddEventHandler("chiudimenu", function()
    WarMenu.CloseMenu('Cookin')
    keyopen = true
end)


Citizen.CreateThread(function()
    
    while true do 
        Citizen.Wait(100)
        local Malik = PlayerPedId()
        local Coords = GetEntityCoords(Malik)
        --local campfire = GetClosestObjectOfType(Coords.x, Coords.y, Coords.z, 1.5, p_campfire02x, 0, 0, 0)
        local campfire = DoesObjectOfTypeExistAtCoords(Coords.x, Coords.y, Coords.z, 2.5, GetHashKey("p_campfire02x"), 0)
       -- print(campfire)
        if campfire ~= false then 
            TriggerEvent("vorp:TipBottom", "Press [E] to cook", 2000) -- from client side
            if whenKeyJustPressed(keys["E"]) then
                if keyopen == false then
                WarMenu.OpenMenu('Cookin')
                else end
            end
        end
    end
end)



RegisterNetEvent("maliko:cookingmeat")
AddEventHandler("maliko:cookingmeat", function()
    local playerPed = PlayerPedId()
    TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 15000, true, false, false, false)
    exports['progressBars']:startUI(15000, "You're cooking some meat...")
    Citizen.Wait(15000)
    TriggerServerEvent("maliko:meatcooked")
    keyopen = false
end)
