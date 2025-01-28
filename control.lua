local refillTime = 0
local oilYield = 0
local sulfuricYield = 0
local fluorineYield = 0
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
    elseif event.entity.name == "calcite" then
        resetOre('calcite',event)
    elseif event.entity.name == "tungsten-ore" then
        resetOre('tungsten',event)
    elseif event.entity.name == "scrap" then
        resetOre('scrap',event)
    elseif event.entity.name == "lithium-brine" then
        resetOre('lithium',event)
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
            --game.print(entity.name);
            --Checks if the current entity is oil or a space age resource and fills it if the appropriate setting is on
            if entity.name=="crude-oil" and settings.global["refill-oil"].value == true then
                entity.amount = oilYield
            elseif entity.name=="sulfuric-acid-geyser" and settings.global["refill-sulfuric-acid"].value == true then
                entity.amount = sulfuricYield
            elseif entity.name=="fluorine-vent" and settings.global["refill-fluorine"].value == true then
                entity.amount = fluorineYield
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

    --Checks if it is time to refill oil
    if event.tick % refillTime == 0 then
        --The yields that the user inputs is different from the ones displayed in the game, this fixes that.
        oilYield = settings.global["oil-yield"].value * 3000
        if script.active_mods['space-age'] then
            sulfuricYield = settings.global["sulfuric-acid-yield"].value * 3000
            fluorineYield = settings.global["fluorine-yield"].value * 1000
        end
        moddedYield = settings.global["modded-yield"].value * 3000
        resetYield()
    end
end

--Calls the tick function every tick
script.on_event(defines.events.on_tick, tick)

--Calls refillOre whenever an ore patch runs out
script.on_event(defines.events.on_resource_depleted, refillOre);