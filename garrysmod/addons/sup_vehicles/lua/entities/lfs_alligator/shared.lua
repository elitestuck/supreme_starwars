--DO NOT EDIT OR REUPLOAD THIS FILE

ENT.Type            = "anim"
DEFINE_BASECLASS( "lunasflightschool_basescript" )

ENT.PrintName = "Alligator Fighter"
ENT.Author = "Nashatok"
ENT.Information = ""
ENT.Category = "[LFS] Star Wars"

ENT.Spawnable			= true
ENT.AdminSpawnable		= false

ENT.MDL = "models/sweaw/ships/rep_alligator_servius.mdl"

ENT.AITEAM = 2

ENT.Mass = 5000
ENT.Inertia = Vector(400000,400000,400000)
ENT.Drag = 1

ENT.HideDriver = true
ENT.SeatPos = Vector(-50,0,40)
ENT.SeatAng = Angle(0,-90,0)

ENT.IdleRPM = 1
ENT.MaxRPM = 2600
ENT.LimitRPM = 3200

ENT.RotorPos = Vector(25,0,30)
ENT.WingPos = Vector(50,0,20)
ENT.ElevatorPos = Vector(-300,0,50)
ENT.RudderPos = Vector(-200,0,50)

ENT.MaxVelocity = 2000

ENT.MaxThrust = 50000

ENT.MaxTurnPitch = 800
ENT.MaxTurnYaw = 600
ENT.MaxTurnRoll = 300

ENT.MaxPerfVelocity = 1500

ENT.MaxHealth = 1200
ENT.MaxShield = 400

ENT.Stability = 0.7

ENT.VerticalTakeoff = true
ENT.VtolAllowInputBelowThrottle = 10
ENT.MaxThrustVtol = 12000

ENT.MaxPrimaryAmmo = 2000
ENT.MaxSecondaryAmmo = 6