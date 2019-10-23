
if SERVER then
	if game.GetMap() == "rp_ineu_valley2_v1a" or game.GetMap() == "gm_boreas" then
		timer.Create( "OutlandTimer", 1800, 1, function()
			local endmessage = "The ceasefire has ended!"
			for k,v in pairs( player.GetAll() ) do
				v:ChatPrint( "NOTICE: "..endmessage )
			end
			DarkRP.notifyAll( 0, 6, endmessage )
		end )

		hook.Add( "PlayerInitialSpawn", "OutlandCeasefireNotice", function( ply )
			if timer.Exists( "OutlandTimer" ) then
				timer.Simple( 10, function()
					local ceasefiremessage = "The ceasefire is currently in effect. Use this time to set up a base."
					ply:ChatPrint( "NOTICE: "..ceasefiremessage )
					DarkRP.notify( ply, 0, 6, ceasefiremessage )
				end )
			end
		end )

		local function SpawnVehicles()
			local carpos = {}
			if game.GetMap() == "rp_ineu_valley2_v1a" then
				carpos = {
					Vector( 4160, 6848, 512 ),
					Vector( 2684, 10425, 541 ),
					Vector( -1524, 13488, 256 ),
					Vector( -4842, 11112, 0 ),
					Vector( -13267, 11801, 0 ),
					Vector( -12493, 12003, 0 ),
					Vector( -5030, 3256, 0 ),
					Vector( -4155, 1150, 0 ),
					Vector( -2920, 605, -2 ),
					Vector( 2435, 204, 512 ),
					Vector( 7320, -3983, 17 ),
					Vector( -13013, 6372, 1024 )
				}
			else
				carpos = {
					Vector( -3010, -2426, -6445 ),
					Vector( 3278, -7007, -6406 ),
					Vector( 10177, -10680, -6600 ),
					Vector( 7392, 2424, -5674 ),
					Vector( 498, 5165, -5035 ),
					Vector( -389, 3430, -6399 ),
					Vector( -10541, 5820, -6399 ),
					Vector( -11264, 4806, -8683 ),
					Vector( -10009, -7392, -10284 )
				}
			end

			local vehicles = {
				{ "models/source_vehicles/car001a_hatchback_skin0.mdl", "scripts/vehicles/hl2_hatchback.txt" },
				{ "models/source_vehicles/car001a_hatchback_skin1.mdl", "scripts/vehicles/hl2_hatchback.txt" },
				{ "models/source_vehicles/car001b_hatchback/vehicle.mdl", "scripts/vehicles/hl2_hatchback.txt" },
				{ "models/source_vehicles/car001b_hatchback/vehicle_skin1.mdl", "scripts/vehicles/hl2_hatchback.txt" },
				{ "models/source_vehicles/car002a.mdl", "scripts/vehicles/hl2_hatchback.txt" },
				{ "models/source_vehicles/car002b/vehicle.mdl", "scripts/vehicles/hl2_hatchback.txt" },
				{ "models/source_vehicles/car003a.mdl", "scripts/vehicles/hl2_cars.txt" },
				{ "models/source_vehicles/car003b/vehicle.mdl", "scripts/vehicles/rubbishcar.txt" },
				{ "models/source_vehicles/car003b_rebel.mdl", "scripts/vehicles/hl2_cars.txt" },
				{ "models/source_vehicles/car004a.mdl", "scripts/vehicles/hl2_cars.txt" },
				{ "models/source_vehicles/car004b/vehicle.mdl", "scripts/vehicles/rubbishcar.txt" },
				{ "models/source_vehicles/car005a.mdl", "scripts/vehicles/hl2_cars.txt" },
				{ "models/source_vehicles/car005b/vehicle.mdl", "scripts/vehicles/rubbishcar.txt" },
				{ "models/source_vehicles/truck001c_01.mdl", "scripts/vehicles/truck001c_01.txt" },
				{ "models/source_vehicles/truck001c_02.mdl", "scripts/vehicles/truck001c_01.txt" },
				{ "models/source_vehicles/truck002a_cab.mdl", "scripts/vehicles/truck002a_cab.txt" },
				{ "models/source_vehicles/truck003a_01.mdl", "scripts/vehicles/truck003a_01.txt" },
				{ "models/source_vehicles/van001a_01.mdl", "scripts/vehicles/van001a-vehicle_van.txt" },
				{ "models/source_vehicles/van001a_01_nodoor.mdl", "scripts/vehicles/van001a-vehicle_van.txt" },
				{ "models/source_vehicles/van001b_01.mdl", "scripts/vehicles/van001a-vehicle_van.txt" },
				{ "models/source_vehicles/van001b_01_nodoor.mdl", "scripts/vehicles/van001a-vehicle_van.txt" },
				{ "models/buggy.mdl", "scripts/vehicles/jeep_test.txt" }
			}
			
			for k,v in ipairs( carpos ) do
				local randveh = table.Random( vehicles )
				local car = ents.Create( "prop_vehicle_jeep" )
				car:SetModel( randveh[1] )
				car:SetKeyValue( "vehiclescript", randveh[2] )
				car:SetPos( v )
				car:Spawn()
				car:Activate()
			end
		end


		local function SpawnItems()
			local position = {}
			if game.GetMap() == "rp_ineu_valley2_v1a" then
				position = {
					Vector( 11904, 8654, 384 ),
					Vector( 11472, 9826, 384 ),
					Vector( 12744, 7863, 384 ),
					Vector( 14085, 563, -1483 ),
					Vector( 14319, 3859, -448 ),
					Vector( 15200, 6006, -448 ),
					Vector( 13377, 6642, -448 ),
					Vector( 14345, 7908, -435 ),
					Vector( 11692, 7969, -448 ),
					Vector( 13880, 3822, -448 )
				}
			else
				position = {
					Vector( -9144, -12037, -10471 ),
					Vector( -4462, -7715, -6373 ),
					Vector( -449, 4337, -6399 ),
					Vector( 1134, 2854, -6639 ),
					Vector( 1129, -14054, -7999 ),
					Vector( -14002, -6118, -7822 ),
					Vector( -361, 5257, -6631 ),
					Vector( 1737, 6007, -6743 )
				}
			end
			for k,v in ipairs( position ) do
				local e = ents.Create("outland_item_spawner")
				e:SetPos( v )
				e:Spawn()
				e:SetMoveType( MOVETYPE_NONE )
			end
		end

		hook.Add( "InitPostEntity", "OutlandItems", function()
			SpawnVehicles()
			SpawnItems()
		end )
	end
end