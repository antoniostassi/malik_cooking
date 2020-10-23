--[[ Credits by MalikTM ]]-- ! Don't Edit this Disclaimer !local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()


RegisterServerEvent("maliko:cookmeat")
AddEventHandler("maliko:cookmeat",function()
    print("Error")
    local _source = source
    local count = VorpInv.getItemCount(_source, "meat")

    if count >= 1 then
    VorpInv.subItem(source, "meat", 1)
    TriggerClientEvent("maliko:cookingmeat", _source)
    else 
    TriggerClientEvent("vorp:TipRight", _source, "You don't have any meat!", 3000)
    end
end)

RegisterServerEvent("maliko:meatcooked")
AddEventHandler("maliko:meatcooked", function()

    VorpInv.addItem(source, "consumable_meat_greavy", 1)
    TriggerClientEvent("vorp:TipRight", source, "You cooked some meat!", 3000)

end)


RegisterNetEvent('malik:additem')
AddEventHandler('malik:additem', function(item)
local _source = source
VorpInv.addItem(_source, item, 1)

end)
