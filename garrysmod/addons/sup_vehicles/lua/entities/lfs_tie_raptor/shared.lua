ENT.Type            = "anim"
DEFINE_BASECLASS( "lunasflightschool_basescript" )

ENT.PrintName = "TIE Raptor"
ENT.Author = "KingPommes"
ENT.Information = ""
ENT.Category = "[LFS] Star Wars"

ENT.Spawnable		= true
ENT.AdminSpawnable		= false

ENT.MDL = "models/sfp_tieraptor/sfp_tieraptor.mdl"

ENT.GibModels = {
	"models/XQM/wingpiece2.mdl",
	"models/XQM/wingpiece2.mdl",
	"models/XQM/jetwing2medium.mdl",
	"models/XQM/jetwing2medium.mdl",
	"models/props_phx/misc/propeller3x_small.mdl",
	"models/props_c17/TrapPropeller_Engine.mdl",
	"models/props_junk/Shoe001a.mdl",
	"models/XQM/jetbody2fuselage.mdl",
	"models/XQM/jettailpiece1medium.mdl",
	"models/XQM/pistontype1huge.mdl",
	
	"models/kingpommes/starwars/tie/gib_cockpit.mdl",
	"models/kingpommes/starwars/tie/gib_fighter1.mdl",
	"models/kingpommes/starwars/tie/gib_fighter2.mdl",
}


ENT.AITEAM = 1  -- 0 = FFA  1 = bad guys  2 = good guys

ENT.Mass = 2000  -- lower this value if you encounter spazz
ENT.Inertia = Vector(150000,150000,150000)  -- you must increase this when you increase mass or it will spazz
ENT.Drag = -1  -- drag is a good air brake but it will make diving speed worse

ENT.SeatPos = Vector(10, 0, 80)
ENT.SeatAng = Angle(0,-90,0)

ENT.IdleRPM = 1  -- idle rpm. this can be used to tweak the minimum flight speed
ENT.MaxRPM = 2500  -- rpm at 100% throttle
ENT.LimitRPM = 3200  -- max rpm when holding throttle key

ENT.RotorPos = Vector(0,0,70)  -- make sure you set these correctly or your plane will act wierd
ENT.WingPos = Vector(100,0,70) -- make sure you set these correctly or your plane will act wierd
ENT.ElevatorPos = Vector(-300,0,70) -- make sure you set these correctly or your plane will act wierd
ENT.RudderPos = Vector(-300,0,70) -- make sure you set these correctly or your plane will act wierd

ENT.MaxVelocity = 2800 -- max theoretical velocity at 0 degree climb

ENT.MaxThrust = 20000 -- max power of rotor

ENT.MaxTurnPitch = 800 -- max turning force in pitch, lower this value if you encounter spazz
ENT.MaxTurnYaw = 600
ENT.MaxTurnRoll = 300

ENT.MaxPerfVelocity = 1500

ENT.MaxHealth = 600
--ENT.MaxShield = 200  -- uncomment this if you want to use deflector shields. Dont use excessive amounts because it regenerates.

ENT.Stability = 0.7 -- lower this value if you encounter spazz. You can increase this up to 1 to aid turning performance at MaxPerfVelocity-speeds but be careful

ENT.VerticalTakeoff = true
ENT.VtolAllowInputBelowThrottle = 10
ENT.MaxThrustVtol = 10000

ENT.MaxPrimaryAmmo = 4000
ENT.MaxSecondaryAmmo = -1