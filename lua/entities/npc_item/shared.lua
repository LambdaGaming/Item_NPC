
ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "Item NPC"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.Category = "Item NPC"

function ENT:SetupDataTables()
	self:NetworkVar( "Int", 0, "NPCType" )
end

ItemNPC = {} --Initializes the item table, don't touch
ItemNPCType = {} --Initializes the type table, don't touch

--Template Type
--[[
	ItemNPCType[1] = {
		Name = "Template NPC Type", --Name of the NPC type
		Model = "models/breen.mdl", --Model of the NPC
		MenuColor = Color( 49, 53, 61, 200 ), --Color of the menu background
		MenuTextColor = color_white, --Color of the menu background text
		ButtonColor = Color( 230, 93, 80, 255 ), --Color of the buttons
		ButtonTextColor = color_white, --Color of the button text
		Allowed = { --Jobs that are allowed to use the NPC, leave empty brackets for all jobs
			[TEAM_MAYOR] = true,
			[TEAM_CHIEF] = true
		}
	}
]]

ItemNPCType[1] = {
	Name = "DarkRP Weapon Dealer",
	Model = "models/breen.mdl",
	MenuColor = Color( 49, 53, 61, 200 ),
	MenuTextColor = color_white,
	ButtonColor = Color( 230, 93, 80, 255 ),
	ButtonTextColor = color_white,
	Allowed = {}
}

--Template Item
--[[
	ItemNPC["weapon_crowbar"] = { --Add the entity name of the item in the brackets with quotes
	Name = "Crowbar", --Name of the item, different from the item's entity name (Required)
	Description = "Tool you can swing", --Description of the item (Required)
	Price = 100, --Price of the item (Required, set to 0 if you want to make the item free)
	Type = 1, --NPC type that this item will be associated with (Required, keep at 1 if you haven't added new types)
	SpawnCheck = --Function that gets called before the item is spawned, useful for checking things like team-specific items (Optional, removing this will cause the spawn check to not run on the item)
		function( ply, self )
			if ply:Team() == TEAM_MAYOR then
				return false --Prevents the mayor job from buying this item
			end
			return true --If the check above passes, then return true. Always leave this here, even if you don't add a check
		end,
	SpawnFunction = --Function to spawn the item, don't modify anything outside of the entity name unless you know what you're doing (Required)
		function( ply, self ) --In this function you are able to modify the player who is crafting, the table itself, and the item that is being crafted
			local e = ents.Create( "weapon_crowbar" ) --Replace the entity name with the one at the very top inside the brackets
			e:SetPos( self:GetPos() - Vector( 0, 0, -5 ) ) --A negative Z coordinate is added here to prevent items from spawning on top of the table and being consumed, you'll have to change it if you use a different model otherwise keep it as it is
			e:Spawn()
		end
	}
]]

--On top of configuring your item here, don't forget to add the entity name to the list of allowed ents in craft_config.lua! Failure to do so will result in errors!

ItemNPC["weapon_glock2"] = {
	Name = "Glock",
	Description = "Small 9mm pistol",
	Model = "models/weapons/w_pist_glock18.mdl",
	Price = 100,
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_glock2" )
		end
}

ItemNPC["weapon_m42"] = {
	Name = "M4",
	Description = "Large .223 rifle",
	Model = "models/weapons/w_rif_m4a1.mdl",
	Price = 600,
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_m42" )
		end
}

ItemNPC["weapon_mac102"] = {
	Name = "MAC 10",
	Description = "Small 9mm SMG",
	Model = "models/weapons/w_smg_mac10.mdl",
	Price = 200,
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_mac102" )
		end
}

ItemNPC["weapon_mp52"] = {
	Name = "MP5",
	Description = "Large 9mm SMG",
	Model = "models/weapons/w_smg_mp5.mdl",
	Price = 300,
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_mp52" )
		end
}

ItemNPC["weapon_p2282"] = {
	Name = "P228",
	Description = "Small 9mm pistol",
	Model = "models/weapons/w_pist_p228.mdl",
	Price = 100,
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_p2282" )
		end
}

ItemNPC["weapon_pumpshotgun2"] = {
	Name = "Pump Shotgun",
	Description = "12 guage shotgun",
	Model = "models/weapons/w_shot_m3super90.mdl",
	Price = 800,
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_pumpshotgun2" )
		end
}

ItemNPC["lockpick"] = {
	Name = "Lockpick",
	Description = "Tool to pick through locked doors",
	Model = "models/weapons/w_crowbar.mdl",
	Price = 150,
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "lockpick" )
		end
}

ItemNPC["ls_sniper"] = {
	Name = "Silenced Sniper Rifle",
	Description = "Large sniper rifle",
	Model = "models/weapons/w_snip_g3sg1.mdl",
	Price = 600,
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "ls_sniper" )
		end
}

ItemNPC["weapon_ak472"] = {
	Name = "AK-47",
	Description = "Large rifle",
	Model = "models/weapons/w_rif_ak47.mdl",
	Price = 600,
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_ak472" )
		end
}

ItemNPC["weapon_deagle2"] = {
	Name = "Deagle",
	Description = "Large pistol",
	Model = "models/weapons/w_pist_deagle.mdl",
	Price = 400,
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_deagle2" )
		end
}

ItemNPC["weapon_fiveseven2"] = {
	Name = "FiveSeven",
	Description = "Small pistol",
	Model = "models/weapons/w_pist_fiveseven.mdl",
	Price = 200,
	Type = 1,
	SpawnFunction =
		function( ply, self )
			ply:Give( "weapon_fiveseven2" )
		end
}