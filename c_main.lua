local enabled = true 
local debug = true
local ped = nil  
local pos = nil  
local penInVeh = nil  
local veh = nil
local timer = 0
local maxTipTime = 4
local tipTime = 0
local maxTipAmount = 500
local basePay = 300
local currentStore = "none"
local currentRoute = {
    ["store"] = nil,
    ["routeId"] = nil,
    ["stopId"] = nil  
}
local currentblip = nil  
local stores = {
    ["Wigwam"] = {
        startLocation = {x = -861.700, y = -1140.270, z = 7.390, h = 340.0},
        vehicleSpawn = {
            x = -847.770,
            y = -1138.140,
            z = 6.290,
            h = 208.740,
            hash = "foodbike2",
            livery = 8
        },
        maxTipAmount = 500,
        maxTipTime = 4,
        basePay = 300,
        noDamageBonus = 150,
        possibleRoutes = {
            [1] = { -- Little Seoul
                [1] = {
                    car = {x = -678.350,y = -1102.260,z = 14.000,h = 351.31},
                    door = {x = -667.51,y = -1105.99,z = 14.63,h = 259.39}
                },
                [2] = {
                    car = {x = -615.87,y = -778.53,z = 24.68,h = 185.81},
                    door = {x = -580.08,y = -778.42,z = 25.02,h = 278.79}
                },
                [3] = {
                    car = {x = -854.75,y = -703.22,z = 26.50,h = 357.50},
                    door = {x = -827.10,y = -696.84,z = 28.06,h = 265.78}
                },
                [4] = {
                    car = {x = -827.14,y = -841.56,z = 19.16,h = 273.86},
                    door = {x = -831.31,y = -865.62,z = 20.71,h = 184.49}
                },
                [5] = {
                    car = {x = -753.86,y = -913.69,z = 18.75,h = 168.66},
                    door = {x = -766.38, y = -917.11, z = 21.30, h = 85.73}
                },
            },
            [2] = { -- South Vespucci
                [1] = {
                    car = {x = -827.43, y = -1218.36, z = 6.42, h = 328.71},
                    door = {x = -822.5, y = -1223.89, z = 7.37, h = 354.91}
                },
                [2] = {
                    car = {x = -950.76,y = -1082.47,z = 1.63, h = 70.58},
                    door = {x = -952.64,y = -1077.67,z = 2.67,h = 33.82}
                },
                [3] = {
                    car = {x = -1325.04,y = -1047.04,z = 6.86,h = 225.92},
                    door = {x = -1320.32,y = -1044.91,z = 7.46,h = 296.35}
                },
                [4] = {
                    car = {x = -1271.21,y = -1362.68,z = 3.78,h = 92.4},
                    door = {x = -1273.16,y = -1371.89,z = 4.3,h = 195.59}
                },
                [5] = {
                    car = {x = -1042.88,y = -1598.72,z = 4.21,h = 308.55},
                    door = {x = -1036.85, y = -1605.20, z = 4.97, h = 209.71}
                },
            },
        }
    },
    ["UpNAtom"] = {
        startLocation = {x = 1591.21, y = 6451.04, z = 25.32, h = 325.67},
        vehicleSpawn = {
            x = 1580.97,
            y = 6449.5,
            z = 24.37,
            h = 106.12,
            hash = "foodcar6",
            livery = 0
        },
        maxTipAmount = 500,
        maxTipTime = 5,
        basePay = 100,
        noDamageBonus = 150,
        possibleRoutes = {
            [1] = { -- Paleto 1
                [1] = {
                    car = {x = 24.33,y = 6656.2,z = 30.8,h = 9.71},
                    door = {x = 35.24,y = 6662.76,z = 32.19,h = 344.47}
                },
                [2] = {
                    car = {x = -144.00,y = 6439.67,z = 30.71,h = 217.15},
                    door = {x = -149.97,y = 6416.01,z = 31.92,h = 319.26}
                },
                [3] = {
                    car = {x = -230.40,y = 6315.08,z = 30.68,h = 130.38},
                    door = {x = -248.20,y = 6332.89,z = 32.43,h = 47.91}
                },
                [4] = {
                    car = {x = -441.97,y = 6027.43,z = 30.64,h = 212.94},
                    door = {x = -447.56,y = 6013.50,z = 31.72,h = 124.82}
                },
                [5] = {
                    car = {x = -358.85,y = 6329.17,z = 29.14,h = 40.1},
                    door = {x = -359.37, y = 6334.83, z = 29.85, h = 40.35}
                },
            },
            --[[[2] = { -- Paleto 2
                [1] = {
                    car = {x = -827.43, y = -1218.36, z = 6.42, h = 328.71},
                    door = {x = -822.5, y = -1223.89, z = 7.37, h = 354.91}
                },
                [2] = {
                    car = {x = -950.76,y = -1082.47,z = 1.63, h = 70.58},
                    door = {x = -952.64,y = -1077.67,z = 2.67,h = 33.82}
                },
                [3] = {
                    car = {x = -1325.04,y = -1047.04,z = 6.86,h = 225.92},
                    door = {x = -1320.32,y = -1044.91,z = 7.46,h = 296.35}
                },
                [4] = {
                    car = {x = -1271.21,y = -1362.68,z = 3.78,h = 92.4},
                    door = {x = -1273.16,y = -1371.89,z = 4.3,h = 195.59}
                },
                [5] = {
                    car = {x = -1042.88,y = -1598.72,z = 4.21,h = 308.55},
                    door = {x = -1036.85, y = -1605.20, z = 4.97, h = 209.71}
                },
            },]]
        }
    },
    ["Bite"] = {
        startLocation = {x = -1539.16, y = -427.63, z = 36.59, h = 232.56},
        vehicleSpawn = {
            x = -1533.450,
            y = -431.460,
            z = 35.440,
            h = 227.420,
            hash = "foodcar5",
            livery = 6
        },
        maxTipAmount = 500,
        maxTipTime = 5,
        basePay = 100,
        noDamageBonus = 150,
        possibleRoutes = {
            [1] = { -- Vespucci
                [1] = {
                    car = {x = -1403.750, y = -729.640, z = 23.060, h = 307.590},
                    door = {x = -1392.470, y = -731.430, z = 24.210, h = 220.600}
                },
            },
        }
    }
}

local function LoadNewRoute(location)
    SetBlipRoute(currentblip, false)
    RemoveBlip(currentblip)
    local loc = location
    local rnd = math.random(1, #stores[loc].possibleRoutes)
    print(rnd)
    currentRoute["store"] = loc
    currentRoute["routeId"] = rnd  
    currentRoute["stopId"] = 1
    currentblip = AddBlipForCoord(stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].car.x, stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].car.y, stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].car.z)
    SetBlipRoute(currentblip, true)
end

local function ReturnToStore()
    currentRoute["routeId"] = nil  
    currentRoute["stopId"] = nil
    currentblip = AddBlipForCoord(stores[currentRoute["store"]].startLocation.x, stores[currentRoute["store"]].startLocation.y, stores[currentRoute["store"]].startLocation.z)
    SetBlipRoute(currentblip, true) 
end

local function LoadNextStop()
    SetBlipRoute(currentblip, false)
    RemoveBlip(currentblip)
    local newstop = currentRoute["stopId"] + 1
    if newstop > #stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]] then
        ReturnToStore()
    else
        currentRoute["stopId"] = newstop
        currentblip = AddBlipForCoord(stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].car.x, stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].car.y, stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].car.z)
        SetBlipRoute(currentblip, true) 
    end
end

local function SpawnVehicle(location)
    local hash = GetHashKey(stores[location].vehicleSpawn.hash)
    RequestModel(hash)
    while not HasModelLoaded(hash) do  
        RequestModel(hash)
        Wait(100)
    end
    veh = CreateVehicle(hash, stores[location].vehicleSpawn.x, stores[location].vehicleSpawn.y, stores[location].vehicleSpawn.z, stores[location].vehicleSpawn.h, true, false)
    SetVehicleLivery(veh, stores[location].vehicleSpawn.livery)
    TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
    SetVehicleNumberPlateText(veh, "F00DY")
end

local function GivePaycheck()
    if currentRoute["stopId"] == nil then
        if GetVehicleEngineHealth(veh) > 1000 then
            bonus = stores[currentStore].noDamageBonus
        else
            bonus = 0.0
        end
        local amount = stores[currentStore].basePay + (150 * tipTime) + bonus
        --TriggerServerEvent("addMoney", amount)
        exports.pNotify:SendNotification(
            {
            text = "You got paid $"..amount.." for your services.<br/>Base Pay: $"..stores[currentStore].basePay.."<br/>Speed Bonus: $"..(150 * tipTime).."<br/>Prestine Vehicle Bonus: $"..bonus, 
            type = "info", 
            timeout = 5000,
            layout = "centerLeft"
            }
        )
        SetBlipRoute(currentblip, false)
        RemoveBlip(currentblip)
        currentStore = "none"
        currentRoute["store"] = nil
        currentRoute["routeId"] = nil  
        currentRoute["stopId"] = nil
    else
        exports.pNotify:SendNotification(
            {
            text = "You need to finish your route first dumbass.", 
            type = "error", 
            timeout = 5000,
            layout = "centerLeft"
            }
        )
    end
end


local function DrawMarkers()
    if pedInVeh then
        if currentRoute["stopId"] ~= nil then
            if GetDistanceBetweenCoords(pos, stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].car.x, stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].car.y, stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].car.z, true) < 15 then 
                DrawMarker(
                    27, 
                    stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].car.x, 
                    stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].car.y, 
                    stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].car.z, 
                    0.0, 0.0, 0.0, 0.0, 0.0, 
                    stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].car.h, 
                    10.0, 10.0, 10.0, 255, 255, 255, 255, false, false, 2, false, nil, nil, false
                )
                DrawMarker(
                    36, 
                    stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].car.x, 
                    stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].car.y, 
                    stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].car.z+1, 
                    0.0, 0.0, 0.0, 0.0, 0.0, 
                    stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].car.h, 
                    1.0, 1.0, 1.0, 255, 255, 255, 255, false, false, 2, false, nil, nil, false
                )
            end
        end
    elseif currentRoute["stopId"] ~= nil then 
        if GetDistanceBetweenCoords(pos, stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].door.x, stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].door.y, stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].door.z, true) < 15 then 
            DrawMarker(
                27, 
                stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].door.x, 
                stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].door.y, 
                stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].door.z, 
                0.0, 0.0, 0.0, 0.0, 0.0, 
                stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].door.h, 
                1.0, 1.0, 1.0, 255, 255, 255, 255, false, false, 2, false, nil, nil, false
            )
            DrawMarker(
                2, 
                stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].door.x, 
                stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].door.y, 
                stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].door.z+1, 
                0.0, 0.0, 0.0, 0.0, 180.0, 
                stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].door.h, 
                1.0, 1.0, 1.0, 255, 255, 255, 255, false, false, 2, false, nil, nil, false
            )
        end
    end
end

Citizen.CreateThread(function()

    if debug then  
        for k, v in pairs(stores) do 
            local blip = AddBlipForCoord(v.startLocation.x, v.startLocation.y, v.startLocation.z)
            SetBlipColour(blip, 1)
            for i = 1, #stores[k].possibleRoutes do
                for z = 1, #stores[k].possibleRoutes[i] do  
                    local blip = AddBlipForCoord(stores[k].possibleRoutes[i][z].car.x, stores[k].possibleRoutes[i][z].car.y, stores[k].possibleRoutes[i][z].car.z)
                    SetBlipColour(blip, 2)
                    local blip2 = AddBlipForCoord(stores[k].possibleRoutes[i][z].door.x, stores[k].possibleRoutes[i][z].door.y, stores[k].possibleRoutes[i][z].door.z)
                    SetBlipColour(blip2, 3)
                end
            end
        end
    end

    while enabled do
        Wait(7)
        DrawMarkers()
        ped = PlayerPedId()
        pos = GetEntityCoords(ped, true)
        pedInVeh = IsPedInAnyVehicle(ped, false)
        for k, v in pairs(stores) do  
            if GetDistanceBetweenCoords(pos, v.startLocation.x, v.startLocation.y, v.startLocation.z, true) < 2 then
                if not pedInVeh then 
                    if currentStore == "none" then
                        DrawText3D(pos.x, pos.y, pos.z, "Press [~g~ENTER~w~] to start the job.")
                        if IsControlJustPressed(0, 191) then -- ENTER
                            LoadNewRoute(k)
                            SpawnVehicle(k)
                            currentStore = k
                            timer = GetGameTimer()
                            tipTime = maxTipTime
                        end
                    elseif currentStore == k then
                        DrawText3D(pos.x, pos.y, pos.z, "Press [~g~ENTER~w~] to collect your paycheck.")
                        if IsControlJustPressed(0, 191) then -- ENTER
                            GivePaycheck()
                        end
                    end
                else  
                    DrawText3D(pos.x, pos.y, pos.z, "You can't do that you fuck.")
                end
            end
        end
        if currentRoute["stopId"] ~= nil then 
            if pedInVeh then
                if GetDistanceBetweenCoords(pos, stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].car.x, stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].car.y, stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].car.z, true) < 1.5 then  
                    DrawText3D(pos.x, pos.y, pos.z, "Exit vehicle and deliver good to the door.")
                else 
                    DrawText3D(pos.x, pos.y, pos.z, "Drive to the next delivery point.")
                end
            else
                if GetDistanceBetweenCoords(pos, stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].door.x, stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].door.y, stores[currentRoute["store"]].possibleRoutes[currentRoute["routeId"]][currentRoute["stopId"]].door.z, true) < 1.2 then
                    DrawText3D(pos.x, pos.y, pos.z, "Press [~g~ENTER~w~] to deliver the goods")
                    if IsControlJustPressed(0, 191) then
                        LoadNextStop()
                    end
                end
            end
        end
        if currentStore ~= "none" then
            if GetGameTimer() - timer >= 30000 then
                tipTime = tipTime - 0.5
                timer = GetGameTimer()
                print("Tip Time = "..tipTime)
            end
        end
    end

end)

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end
