--------||Script made by Super.Cool.Ninja||--------


local function findPedModel(hash)
    if type(hash) == "string" then hash = GetHashKey(hash) end
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(0)
    end
end


local function ClearPedsModel()
    for i=1, #Config.Locations do
        local myPeds = Config.Locations[i]["myPedsLocation"]
        if DoesEntityExist(myPeds["entity"]) then
            DeletePed(myPeds["entity"])
            SetPedAsNoLongerNeeded(myPeds["entity"])
        end
    end
end

--------||Create all peds that u insert into the Config File||--------
Citizen.CreateThread(function()
    for i=1, #Config.Locations do
        local myPeds = Config.Locations[i]["myPedsLocation"]
        if myPeds then
            myPeds["hash"] = myPeds["hash"]
            findPedModel(myPeds["hash"])
            if not DoesEntityExist(myPeds["entity"]) then
                myPeds["entity"] = CreatePed(4, myPeds["hash"], myPeds["x"], myPeds["y"], myPeds["z"] -1, myPeds["h"])
                SetEntityAsMissionEntity(myPeds["entity"])
                SetBlockingOfNonTemporaryEvents(myPeds["entity"], true)
                FreezeEntityPosition(myPeds["entity"], true)
                SetEntityInvincible(myPeds["entity"], true)
            end
            SetModelAsNoLongerNeeded(myPeds["hash"])
        end
    end
end)


--------||Clear all peds, to optimize the server||--------
AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        ClearPedsModel()
    end
end)