if (SERVER) then
  
	AddCSLuaFile ("shared.lua")
	SWEP.Weight 			= 5
	SWEP.AutoSwitchTo 		= false
	SWEP.AutoSwitchFrom 		= false
end

if (CLIENT) then

	SWEP.PrintName 			= "DON'T SPAWN/NOT WEAPON"
	SWEP.Slot 				= 4
	SWEP.SlotPos 			= 1
	SWEP.DrawAmmo 			= true
	SWEP.DrawCrosshair 		= false
	SWEP.ViewModelFOV			= 80
	SWEP.ViewModelFlip		= true
	SWEP.CSMuzzleFlashes		= false
	SWEP.BounceWeaponIcon = false
SWEP.DrawWeaponInfoBox = false

end


SWEP.HoldType				= "grenade"


SWEP.Spawnable 				= false
SWEP.AdminSpawnable 			= false
SWEP.UseHands				= true

SWEP.ViewModel 				= "models/weapons/cstrike/c_eq_fraggrenade.mdl"
SWEP.WorldModel 				= "models/weapons/w_eq_fraggrenade.mdl"
SWEP.ViewModelFlip 				= false
SWEP.ViewModelFOV				= 60
SWEP.Primary.ClipSize 			= 1
SWEP.Primary.DefaultClip 		= 1
SWEP.Primary.Automatic 			= false
SWEP.Primary.Ammo 			= "grenade"

SWEP.Secondary.ClipSize 		= -1
SWEP.Secondary.DefaultClip 		= -1
SWEP.Secondary.Automatic 		= false
SWEP.Secondary.Ammo 			= "none"

SWEP.Primed 				= 0
SWEP.Throw 					= CurTime()
SWEP.PrimaryThrow				= true

/*---------------------------------------------------------
Initialize
---------------------------------------------------------*/
function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
end

/*---------------------------------------------------------
Holster
---------------------------------------------------------*/
function SWEP:Holster()
	self.Primed = 0
	self.Throw = CurTime()
	self.Owner:DrawViewModel(true)
	return true
end

/*---------------------------------------------------------
Holster
---------------------------------------------------------*/
function SWEP:Reload()
	self.Owner:DrawViewModel(true)
	self.Weapon:DefaultReload(ACT_VM_DRAW)
end

/*---------------------------------------------------------
Think
---------------------------------------------------------*/
function SWEP:Think()
	if ((self:Clip1() > 0)) then
		self.Owner:DrawViewModel(true)
	else
		self.Owner:DrawViewModel(false)
	end

	if self.Primed == 1 and not self.Owner:KeyDown(IN_ATTACK) and self.PrimaryThrow then
		if self.Throw < CurTime() then
			self.Primed = 2
			self.Throw = CurTime() + 1.5

			self.Weapon:SendWeaponAnim(ACT_VM_THROW)
			self.Owner:SetAnimation(PLAYER_ATTACK1)

			timer.Simple( 0.35, function()
				if (!self or !IsValid(self)) then return end
				self:ThrowFar()
			end)
		end

	elseif self.Primed == 1 and not self.Owner:KeyDown(IN_ATTACK2) and not self.PrimaryThrow then
		if self.Throw < CurTime() then
			self.Primed = 2
			self.Throw = CurTime() + 1.5

			self.Weapon:SendWeaponAnim(ACT_VM_THROW)
			self.Owner:SetAnimation(PLAYER_ATTACK1)

			timer.Simple( 0.35, function()
				if (!self or !IsValid(self)) then return end
				self:ThrowShort()
			end)
		end
	end
end

/*---------------------------------------------------------
ThrowFar
---------------------------------------------------------*/
function SWEP:ThrowFar()

	
	if self.Primed != 2 then return end

	local tr = self.Owner:GetEyeTrace()

	if (!SERVER) then return end

	local ent = ents.Create ("ent_explosivegrenade")

			local v = self.Owner:GetShootPos()
				v = v + self.Owner:GetForward() * 2
				v = v + self.Owner:GetRight() * 3
				v = v + self.Owner:GetUp() * -3
			ent:SetPos( v )

	ent:SetAngles(Angle(math.random(1,100),math.random(1,100),math.random(1,100)))
	ent.GrenadeOwner = self.Owner
	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if !IsValid(phys) then self.Weapon:SendWeaponAnim(ACT_VM_DRAW) self.Primed = 0 return end

	if self.Owner:KeyDown( IN_FORWARD ) then
		self.Force = 800
	elseif self.Owner:KeyDown( IN_BACK ) then
		self.Force = 800
	elseif self.Owner:KeyDown( IN_MOVELEFT ) then
		self.Force = 800
	elseif self.Owner:KeyDown( IN_MOVERIGHT ) then
		self.Force = 800
	else
		self.Force = 800
	end

	phys:ApplyForceCenter(self.Owner:GetAimVector() * self.Force * 2 + Vector(0, 0, 0))
	phys:AddAngleVelocity(Vector(math.random(-500,500),math.random(-500,500),math.random(-500,500)))

	self:TakePrimaryAmmo(1)
	-- self:Reload()

	timer.Simple(0.6,
	function()

		if self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
			--self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
			self.Primed = 0
		else
			self.Primed = 0
		--	self.Weapon:Remove()
		--	self.Owner:ConCommand("lastinv")
		end
	end)
end

/*---------------------------------------------------------
ThrowShort
---------------------------------------------------------*/
function SWEP:ThrowShort()

	if self.Primed != 2 then return end

	local tr = self.Owner:GetEyeTrace()

	if (!SERVER) then return end

	local ent = ents.Create ("ent_explosivegrenade")

			local v = self.Owner:GetShootPos()
				v = v + self.Owner:GetForward() * 2
				v = v + self.Owner:GetRight() * 3
				v = v + self.Owner:GetUp() * -3
			ent:SetPos( v )

	ent:SetAngles(Angle(math.random(1,100),math.random(1,100),math.random(1,100)))
	ent.GrenadeOwner = self.Owner
	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if !IsValid(phys) then self.Weapon:SendWeaponAnim(ACT_VM_DRAW) self.Primed = 0 return end

	if self.Owner:KeyDown( IN_FORWARD ) then
		self.Force = 200
	elseif self.Owner:KeyDown( IN_BACK ) then
		self.Force = 200
	elseif self.Owner:KeyDown( IN_MOVELEFT ) then
		self.Force = 200
	elseif self.Owner:KeyDown( IN_MOVERIGHT ) then
		self.Force = 200
	else
		self.Force = 200
	end

	phys:ApplyForceCenter(self.Owner:GetAimVector() * self.Force * 2 + Vector(0, 0, 0))
	phys:AddAngleVelocity(Vector(math.random(-500,500),math.random(-500,500),math.random(-500,500)))

	self:TakePrimaryAmmo(1)
	-- self:Reload()

	timer.Simple(0.6,
	function()

		if self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
			--self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
			self.Primed = 0
		else
			self.Primed = 0
		--	self.Weapon:Remove()
		--	self.Owner:ConCommand("lastinv")
		end
	end)
end

/*---------------------------------------------------------
PrimaryAttack
---------------------------------------------------------*/
function SWEP:PrimaryAttack()

	if self.Throw < CurTime() and self.Primed == 0 and self:CanPrimaryAttack() then
		self.Weapon:SendWeaponAnim(ACT_VM_PULLPIN)
		self.Primed = 1
		self.Throw = CurTime() + 1
		self.PrimaryThrow = true
	end
end

/*---------------------------------------------------------
SecondaryAttack
---------------------------------------------------------*/
function SWEP:SecondaryAttack()

	if self.Throw < CurTime() and self.Primed == 0 and self:CanPrimaryAttack() then
		self.Weapon:SendWeaponAnim(ACT_VM_PULLPIN)
		self.Primed = 1
		self.Throw = CurTime() + 1
		self.PrimaryThrow = false
	end
end

/*---------------------------------------------------------
Deploy
---------------------------------------------------------*/
function SWEP:Deploy()

	if (self:Clip1() > 0) then
		self.Throw = CurTime() + 0.75
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
		self.Owner:DrawViewModel(true)
	else
		self.Throw = CurTime() + 0.75
		self.Owner:DrawViewModel(false)
	end
	-- return true
end



function SWEP:DrawHud2()

end
