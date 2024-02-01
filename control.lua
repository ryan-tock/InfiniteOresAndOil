local refillTime = 0
local oilYield = 0
local moddedYield = 0

function refillOre(event)
    --Checks to see which ore ran out, and attempts to refill that ore
    if event.entity.name == "iron-ore" then
        resetOre("iron",event)
    elseif event.entity.name == "coal" then
        resetOre("coal",event)
    elseif event.entity.name == "copper-ore" then
        resetOre("copper",event)
    elseif event.entity.name == "stone" then
        resetOre("stone",event)
    elseif event.entity.name == "uranium-ore" then
        resetOre("uranium",event)
    else
        resetOre("modded-ores",event)
    end
end
function resetOre(name,event)
    --Checks the permissions to see if that ore should be reset
    if settings.global["refill-"..name].value == true then
        event.entity.amount=1000000
    end    
end
function resetYield()
    --Checks all surfaces for ores
    for _, surface in pairs(game.surfaces) do
        --Finds all resource entities on the current surface
        for _, entity in pairs(surface.find_entities_filtered({type="resource"})) do
            --Checks if the current entity is oil and if the refill oil setting is on
            if entity.name=="crude-oil" and settings.global["refill-oil"].value == true then
                entity.amount = oilYield
            --Checks if the current entity is an infinite resource and if the refill modded yield setting is on
            elseif entity.initial_amount ~= nil and settings.global["refill-modded-yield"].value == true then
                entity.amount = moddedYield
            end
        end
    end
end
function tick(event)
    --The time inputed by the user needs to be converted to game ticks.
    refillTime = settings.global["time-refill"].value * 60

    --The yields that the user inputs is different from the ones displayed in the game, this fixes that.
    oilYield = settings.global["oil-yield"].value * 3000
    moddedYield = settings.global["modded-yield"].value * 3000

    --Checks if it is time to refill oil
    if event.tick % refillTime == 0 then
        resetYield()
    end
end

--Calls the tick function every tick
script.on_event(defines.events.on_tick, tick)

--Calls refillOre whenever an ore patch runs out
script.on_event(defines.events.on_resource_depleted, refillOre);