include( "shared.lua" )

surface.CreateFont( "ItemNPCOverheadText", {
	font = "Circular Std Bold",
	size = 200,
	weight = 800
} )

local offset = Vector( 0, 0, 80 )
function ENT:Draw()
	self:DrawModel()
	local origin = self:GetPos()
	local ply = LocalPlayer()
	if ply:GetPos():DistToSqr( origin ) >= 589824 then return end

	local type = self:GetNPCType()
	local name = ItemNPCType[type].Name or "Invalid NPC"
	local pos = origin + offset
	local ang = ( ply:EyePos() - pos ):Angle()
	ang.p = 0
	ang:RotateAroundAxis( ang:Right(), 90 )
	ang:RotateAroundAxis( ang:Up(), 90 )
	ang:RotateAroundAxis( ang:Forward(), 180 )
	cam.Start3D2D( pos, ang, 0.035 )
		draw.SimpleText( name, "ItemNPCOverheadText", 0, 0, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
	cam.End3D2D()
end

local defaultMenuColor = Color( 49, 53, 61, 200 )
local defaultMenuTextColor = color_white
local gray = Color( 75, 75, 75, 100 )
local function DrawItemMenu( ent ) --Panel that draws the main menu
	local type = ent:GetNPCType()
	local ply = LocalPlayer()
	local menuColor = ItemNPCType[type].MenuColor or defaultMenuColor
	local menuTextColor = ItemNPCType[type].MenuTextColor or defaultMenuTextColor
	local name = ItemNPCType[type].Name or "Invalid NPC"
	local mainframe = vgui.Create( "DFrame" )
	mainframe:SetTitle( name )
	mainframe:SetSize( 500, 800 )
	mainframe:Center()
	mainframe:MakePopup()
	mainframe.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, gray )
	end

	local listframe = vgui.Create( "DScrollPanel", mainframe )
	listframe:Dock( FILL )
	for k,v in ipairs( ItemNPC ) do
		if v.Type != type then
			continue
		end
		local itemName = v.Name or "Invalid Item"
		local itembackground = vgui.Create( "DButton", listframe )
		itembackground:SetPos( 0, 10 )
		itembackground:SetSize( 450, 100 )
		itembackground:Dock( TOP )
		itembackground:DockMargin( 0, 0, 0, 10 )
		itembackground:Center()
		itembackground:SetText( "" )
		itembackground.Paint = function( self, w, h )
			draw.RoundedBox( 10, 0, 0, w, h, Color( menuColor.r, menuColor.g, menuColor.b, 255 ) )
		end
		itembackground.DoClick = function()
			net.Start( "CreateItem" )
			net.WriteEntity( ent )
			net.WriteInt( k, 15 ) --Max 16k items
			net.SendToServer()
			mainframe:Close()
		end

		local modifiedPrice = hook.Run( "ItemNPC_ModifyPrice", LocalPlayer(), ent, k )
		local realPrice = modifiedPrice or v.Price or 0
		local title = vgui.Create( "DLabel", itembackground )
		title:SetFont( "Trebuchet24" )
		title:SetColor( menuTextColor )
		if realPrice > 0 then
			title:SetText( itemName.." - $"..realPrice )
		else
			title:SetText( itemName.." - Free" )
		end
		title:SizeToContents()
		title:Dock( TOP )
		local w,h = itembackground:GetSize()
		local tw, th = title:GetSize()
		local center = ( w * 0.5 ) - ( tw * 0.5 )
		title:DockMargin( center + 10, 0, 0, 0 )

		if v.Model then
			local itemicon = vgui.Create( "SpawnIcon", itembackground )
			itemicon:SetModel( v.Model )
			itemicon:SetToolTip( false )
			itemicon:Dock( LEFT )
			itemicon:SetSize( 75, 75 )
			itemicon.DoClick = function()
				mainframe:ToggleVisible()

				local modelpanel = vgui.Create( "DFrame" )
				modelpanel:SetTitle( itemName )
				modelpanel:SetSize( 350, 350 )
				modelpanel:Center()
				modelpanel:MakePopup()
				modelpanel.OnClose = function()
					mainframe:ToggleVisible()
				end
				modelpanel.Paint = function( self, w, h )
					draw.RoundedBox( 0, 0, 0, w, h, menuColor )
				end

				local modelpanel2 = vgui.Create( "DAdjustableModelPanel", modelpanel )
				modelpanel2:SetPos( 0, 0 )
				modelpanel2:SetSize( 320, 320 )
				modelpanel2:SetModel( v.Model )
				modelpanel2:SetCamPos( Vector( -10, 0, 0 ) )
			end
		end

		local itemdesc = vgui.Create( "DLabel", itembackground )
		itemdesc:SetFont( "Trebuchet18" )
		itemdesc:SetColor( menuTextColor )
		itemdesc:SetText( v.Description or "No description available." )
		itemdesc:SetWrap( true )
		itemdesc:Dock( FILL )
		itemdesc:DockMargin( 50, 0, 0, 0 )
	end
end

net.Receive( "ItemNPCMenu", function( len, ply ) --Receiving the net message to open the menu
	local ent = net.ReadEntity()
	DrawItemMenu( ent )
end )
