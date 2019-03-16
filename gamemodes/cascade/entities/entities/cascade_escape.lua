AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Cascade Escape Entity"
ENT.Author = "Lambda Gaming"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.Category = "Superadmin Only"

function ENT:SpawnFunction( ply, tr )
	if !tr.Hit then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 1
	local ent = ents.Create( "cascade_escape" )
	ent:SetPos( SpawnPos + ent:GetUp() * 10 )
	ent:Spawn()
	ent:Activate()
	return ent
end

function ENT:Initialize()
    self:SetModel( "models/decay/vehicles/truck_research.mdl" )
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_VPHYSICS)
	if SERVER then
		self:SetUseType(SIMPLE_USE)
	end
 
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:Use( caller, activator )
	if caller:Team() == TEAM_ADMINC or caller:Team() == TEAM_SCIENTIST or caller:Team() == TEAM_SECURITYC or caller:Team() == TEAM_ZOMBIE or caller:Team() == TEAM_VORT then
		--caller:SetPos( table.Random( deadpos ) )
		caller:Spawn()
		caller:ChatPrint( "You have escaped. You will remain in the spawn room until the round restarts." )
		for k,v in pairs( player.GetAll() ) do
			v:ChatPrint( caller:Nick().." has escaped the facility!" )
		end
		caller:changeTeam( TEAM_VISITORC, true, true )
	end
	if caller:Team() == TEAM_MEDICBMC then
		--caller:SetPos( table.Random( deadpos ) )
		caller:Spawn()
		caller:ChatPrint( "You have escaped. You will remain in the spawn room until the round restarts." )
		for k,v in pairs( player.GetAll() ) do
			v:ChatPrint( caller:Nick().." has escaped the facility!" )
		end
		for a,b in pairs( ents.FindInSphere( self:GetPos(), 200 ) ) do
			if b:IsPlayer() and b:Team() == TEAM_MARINEC then
				b:addMoney( 600 )
				DarkRP.notify( b, 1, 6, "You have been rewarded for escorting a medic out of the facility." )
			end
		end
		caller:changeTeam( TEAM_VISITORC, true, true )
	end
	if caller:Team() == TEAM_MARINEC then
		caller:ChatPrint( "Where do you think your going, soldier? Get back in there and complete the mission." )
	end
	if caller:Team() == TEAM_VISITORC then
		caller:ChatPrint( "H.....how did you even....get here?" )
		for k,v in pairs( player.GetAll() ) do
			v:ChatPrint( "uhh op "..caller:Nick().." somehow tried to escape as a visitor, you should ban him" )
		end
	end
end

if CLIENT then
    function ENT:Draw()
        self:DrawModel()
    end
end