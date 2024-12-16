AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( "shared.lua" )

local function Notify( ply, type, dur, msg )
	if DarkRP then
		DarkRP.notify( ply, type, dur, msg )
	else
		HLU_Notify( ply, msg, type, dur )
	end
end

function ENT:ApplyType( type ) --This needs to be called externally sometime after the NPC is spawned for the items to show up
	self:SetNPCType( type )
	self:SetModel( ItemNPCType[type].Model )
end

function ENT:Initialize()
    self:SetModel( "models/breen.mdl" )
	self:SetMoveType( MOVETYPE_NONE )
	self:SetSolid( SOLID_BBOX )
	self:SetCollisionGroup( COLLISION_GROUP_PLAYER )
	self:SetUseType( SIMPLE_USE )
    local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
	end
end

util.AddNetworkString( "ItemNPCMenu" )
function ENT:AcceptInput( input, activator )
	if !activator:IsPlayer() then return end
	if self:GetNPCType() == 0 then
		Notify( activator, 1, 6, "ERROR: NPC isn't fully initialized." )
		return
	end
	local canUse = ItemNPCType[self:GetNPCType()].CanUse
	if canUse and canUse( activator ) == false then return end
	if hook.Run( "ItemNPC_CanUse", activator, self ) == false then return end
	net.Start( "ItemNPCMenu" )
	net.WriteEntity( self )
	net.Send( activator )
end

function ENT:Think()
	local type = self:GetNPCType()
	local typeTbl = ItemNPCType[type]
	local anim = typeTbl.Anim
	if typeTbl and anim then
		self:SetSequence( anim )
	end
end

util.AddNetworkString( "CreateItem" )
net.Receive( "CreateItem", function( len, ply )
	local self = net.ReadEntity()
	local item = net.ReadInt( 15 )
	local name = ItemNPC[item].Name or "Invalid Item"
	local price = ItemNPC[item].Price or 0
	local max = ItemNPC[item].Max
	local canBuyFunc = ItemNPC[item].CanBuy
	local give = ItemNPC[item].Give
	local class = ItemNPC[item].SpawnClass
	local offset = ItemNPC[item].SpawnOffset
	local spawnFunc = ItemNPC[item].SpawnFunc
	local spawnOverride = ItemNPC[item].SpawnOverride
	local money = DarkRP and ply:getDarkRPVar( "money" ) or nil
	if canBuyFunc then
		local canBuy, err = canBuyFunc( ply, self )
		if canBuy == false then
			if err then
				Notify( ply, 1, 6, err )
			end
			return
		end
	end
	if hook.Run( "ItemNPC_CanBuy", ply, self, item ) == false then return end
	local newPrice = hook.Run( "ItemNPC_ModifyPrice", ply, self, item )
	price = newPrice or price
	if money and money < price then
		Notify( ply, 1, 6, "You don't have enough money to purchase this item!" )
		return
	end
	if give then
		ply:Give( give )
		hook.Run( "ItemNPC_PostBuy", ply, self, item, price )
	end
	if spawnOverride then
		spawnOverride( ply, self )
		hook.Run( "ItemNPC_PostBuy", ply, self, item, price )
	elseif class then
		if max and max > 0 and #ents.FindByClass( class ) >= max then
			Notify( ply, 1, 6, "Global limit reached. Remove some instances of this entity to spawn it again." )
			return
		end
		local pos = offset or vector_origin
		local e = ents.Create( class )
		e:SetPos( self:GetPos() + pos )
		e:Spawn()
		if spawnFunc then
			spawnFunc( ply, e )
		end
		hook.Run( "ItemNPC_PostBuy", ply, self, item, price, e )
	end
	Notify( ply, 0, 6, "You have purchased a "..name.."." )
	if price > 0 then
		if DarkRP then
			ply:addMoney( -price )
		else
			ply:RemoveFunds( price )
		end
	end
end )

print( "Item NPC v2.1.1 by OPGman successfully loaded." )
