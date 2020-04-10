--DO NOT EDIT OR REUPLOAD THIS FILE

include("shared.lua")

function ENT:Initialize()
end

local function DrawCircle( X, Y, radius )
	local segmentdist = 360 / ( 2 * math.pi * radius / 2 )
	
	for a = 0, 360, segmentdist do
		surface.DrawLine( X + math.cos( math.rad( a ) ) * radius, Y - math.sin( math.rad( a ) ) * radius, X + math.cos( math.rad( a + segmentdist ) ) * radius, Y - math.sin( math.rad( a + segmentdist ) ) * radius )
		
		surface.DrawLine( X + math.cos( math.rad( a ) ) * radius, Y - math.sin( math.rad( a ) ) * radius, X + math.cos( math.rad( a + segmentdist ) ) * radius, Y - math.sin( math.rad( a + segmentdist ) ) * radius )
	end
end

function ENT:LFSHudPaintPassenger( X, Y, ply )
	if ply == self:GetGunner() then
		local EyeAngles = ply:EyeAngles()
		
		local RearGunActive = self:GetGXHairRG()

		local X = ScrW() * 0.5
		local Y = ScrH() * 0.5

		if RearGunActive then
			surface.SetDrawColor( 255, 255, 255, 255 )
		else
			surface.SetDrawColor( 255, 0, 0, 255 )
		end
		
		DrawCircle( X, Y, 10 )
		surface.DrawLine( X + 10, Y, X + 20, Y ) 
		surface.DrawLine( X - 10, Y, X - 20, Y ) 
		surface.DrawLine( X, Y + 10, X, Y + 20 ) 
		surface.DrawLine( X, Y - 10, X, Y - 20 ) 
		
		-- shadow
		surface.SetDrawColor( 0, 0, 0, 80 )
		DrawCircle( X + 1, Y + 1, 10 )
		surface.DrawLine( X + 11, Y + 1, X + 21, Y + 1 ) 
		surface.DrawLine( X - 9, Y + 1, X - 16, Y + 1 ) 
		surface.DrawLine( X + 1, Y + 11, X + 1, Y + 21 ) 
		surface.DrawLine( X + 1, Y - 19, X + 1, Y - 16 ) 
	end
end


function ENT:LFSCalcViewFirstPerson( view, ply )
	return self:LFSCalcViewThirdPerson( view, ply, true )
end

function ENT:LFSCalcViewThirdPerson( view, ply, FirstPerson )
	local Pod = ply:GetVehicle()

	if ply == self:GetDriver() and not FirstPerson then
		view.origin = view.origin + self:GetUp() * 100
	end
	
	if ply == self:GetGunner() then
		local radius = 800
		radius = radius + radius * Pod:GetCameraDistance()
		
		local StartPos = self:LocalToWorld( Vector(-400,0,250) ) + view.angles:Up() * 250
		local EndPos = StartPos - view.angles:Forward() * radius
		
		local WallOffset = 4

		local tr = util.TraceHull( {
			start = StartPos,
			endpos = EndPos,
			filter = function( e )
				local c = e:GetClass()
				local collide = not c:StartWith( "prop_physics" ) and not c:StartWith( "prop_dynamic" ) and not c:StartWith( "prop_ragdoll" ) and not e:IsVehicle() and not c:StartWith( "gmod_" ) and not c:StartWith( "player" ) and not e.LFS
				
				return collide
			end,
			mins = Vector( -WallOffset, -WallOffset, -WallOffset ),
			maxs = Vector( WallOffset, WallOffset, WallOffset ),
		} )
		
		view.drawviewer = true
		view.origin = tr.HitPos
		
		if tr.Hit and not tr.StartSolid then
			view.origin = view.origin + tr.HitNormal * WallOffset
		end
	end
	
	return view
end

function ENT:DamageFX()
	local HP = self:GetHP()
	if HP == 0 or HP > self:GetMaxHP() * 0.5 then return end
	
	self.nextDFX = self.nextDFX or 0
	
	if self.nextDFX < CurTime() then
		self.nextDFX = CurTime() + 0.05
		
		local effectdata = EffectData()
			effectdata:SetOrigin( self:LocalToWorld( Vector(-397.16,0,260.93) ) )
		util.Effect( "lfs_blacksmoke", effectdata )
	end
end

function ENT:ExhaustFX()
	local FullThrottle = self:GetThrottlePercent() >= 35
	
	if self.OldFullThrottle ~= FullThrottle then
		self.OldFullThrottle = FullThrottle
		if FullThrottle then 
			self:EmitSound( "LAATi_BOOST" )
		end
	end
end

function ENT:CanSound()
	self.NextSound = self.NextSound or 0
	return self.NextSound < CurTime()
end

function ENT:CanSound2()
	self.NextSound2 = self.NextSound2 or 0
	return self.NextSound2 < CurTime()
end

function ENT:DelayNextSound( fDelay )
	if not isnumber( fDelay ) then return end
	
	self.NextSound = CurTime() + fDelay
end

function ENT:DelayNextSound2( fDelay )
	if not isnumber( fDelay ) then return end
	
	self.NextSound2 = CurTime() + fDelay
end

function ENT:CalcEngineSound( RPM, Pitch, Doppler )
	if self.ENG then
		self.ENG:ChangePitch(  math.Clamp(math.Clamp(  80 + Pitch * 25, 50,255) + Doppler,0,255) )
		self.ENG:ChangeVolume( math.Clamp( -1 + Pitch * 6, 0.5,1) )
	end
	
	if self.DIST then
		local ply = LocalPlayer()
		local DistMul = math.min( (self:GetPos() - ply:GetPos()):Length() / 8000, 1) ^ 2
		self.DIST:ChangePitch(  math.Clamp( 100 + Doppler * 0.2,0,255) )
		self.DIST:ChangeVolume( math.Clamp( -1.5 + Pitch * 6, 0.5,1) * DistMul )
	end
	
	local OnGround = self:GetIsGroundTouching()
	if self.OldGroundTouching == nil then self.OldGroundTouching = true end
	
	if OnGround ~= self.OldGroundTouching then
		self.OldGroundTouching = OnGround
		if not OnGround then
			if self:CanSound() then
				self:EmitSound( "LAATi_TAKEOFF" )
				self:DelayNextSound( 3 )
				self:DelayNextSound2( 1.5 )
			end
		else
			if self:CanSound2() then
				self:EmitSound( "LAATi_LANDING" )
				self:DelayNextSound( 1.5 )
				self:DelayNextSound2( 3 )
			end
		end
	end
end

function ENT:EngineActiveChanged( bActive )
	if bActive then
		self.ENG = CreateSound( self, "LAATi_ENGINE" )
		self.ENG:PlayEx(0,0)
		
		self.DIST = CreateSound( self, "LAATi_DIST" )
		self.DIST:PlayEx(0,0)
	else
		self:SoundStop()
	end
end

function ENT:OnRemove()
	self:SoundStop()
end

function ENT:SoundStop()
	if self.ENG then
		self.ENG:Stop()
	end
	
	if self.DIST then
		self.DIST:Stop()
	end
end

function ENT:AnimFins()
end

function ENT:AnimRotor()
end

function ENT:AnimCabin()
end

function ENT:AnimLandingGear()
end

function ENT:Draw()
	self:DrawModel()
end
