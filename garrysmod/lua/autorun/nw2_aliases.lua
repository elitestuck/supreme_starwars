function GAMEMODE:CanEditVariable(ent, pl, key, val, editor)
	return false
end

ENTITY.SetNWAngle = ENTITY.SetNW2Angle
ENTITY.SetNWBool = ENTITY.SetNW2Bool
ENTITY.SetNWEntity = ENTITY.SetNW2Entity
ENTITY.SetNWVector = ENTITY.SetNW2Vector
ENTITY.SetNWFloat = ENTITY.SetNW2Float
ENTITY.SetNWInt = ENTITY.SetNW2Int
ENTITY.SetNWString = ENTITY.SetNW2String
ENTITY.GetNWAngle = ENTITY.GetNW2Angle
ENTITY.GetNWBool = ENTITY.GetNW2Bool
ENTITY.GetNWEntity = ENTITY.GetNW2Entity
ENTITY.GetNWVector = ENTITY.GetNW2Vector
ENTITY.GetNWFloat = ENTITY.GetNW2Float
ENTITY.GetNWInt = ENTITY.GetNW2Int
ENTITY.GetNWString = ENTITY.GetNW2String

ENTITY.SetNetworkedNumber = ENTITY.SetNW2Int
ENTITY.SetNetworkedEntity = ENTITY.SetNW2Entity
ENTITY.GetNetworkedString = ENTITY.GetNW2String
ENTITY.SetNetworkedInt = ENTITY.SetNW2Int
ENTITY.SetNetworkedBool = ENTITY.SetNW2Bool
ENTITY.SetNetworkedVector = ENTITY.SetNW2Vector
ENTITY.SetNetworkedVar = ENTITY.SetNW2Var
ENTITY.SetNetworkedFloat = ENTITY.SetNW2Float
ENTITY.SetNetworkedString = ENTITY.SetNW2String
ENTITY.GetNetworkedEntity = ENTITY.GetNW2Entity
ENTITY.GetNetworkedBool = ENTITY.GetNW2Bool
ENTITY.GetNetworkedVector = ENTITY.GetNW2Vector
ENTITY.GetNetworkedInt = ENTITY.GetNW2Int
ENTITY.GetNetworkedFloat = ENTITY.GetNW2Float
ENTITY.GetNetworkedVar = ENTITY.GetNW2Var
ENTITY.SetNetworkedAngle = ENTITY.SetNW2Angle
ENTITY.GetNetworkedAngle = ENTITY.GetNW2Angle

hook.Remove('PlayerTick', 'TickWidgets')
hook.Add('CanProperty', 'BlockProperty', function(pl)
	return false
end)