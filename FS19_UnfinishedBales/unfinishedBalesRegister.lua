unfinishedBalesRegister = {};
unfinishedBalesRegister.g_currentModDirectory = g_currentModDirectory
unfinishedBalesRegister.specName = "unfinishedBales"

function unfinishedBalesRegister:beforeFinalizeVehicleTypes()

	if unfinishedBales == nil then 
		print("Failed to add specialization unfinishedBales")
	else 
		for k, typeDef in pairs(g_vehicleTypeManager.vehicleTypes) do
			if typeDef ~= nil and k ~= "locomotive" then 
				local isBaler       = false
				local isFillUnit    = false
				local isNotModified = true 
				for name, spec in pairs(typeDef.specializationsByName) do
					if     name == "baler"   then 
						isBaler = true 
					elseif name == "fillUnit"  then 
						isFillUnit = true 
					elseif name == unfinishedBalesRegister.specName then 
						isNotModified = false  
					end 
				end 
				if isNotModified and isBaler and isFillUnit then 
					print("  adding unfinishedBales to vehicleType '"..tostring(k).."'")
					typeDef.specializationsByName[unfinishedBalesRegister.specName] = unfinishedBales
					table.insert(typeDef.specializationNames, unfinishedBalesRegister.specName)
					table.insert(typeDef.specializations, unfinishedBales)	
				end 
			end 
		end 	
	end 
end 
VehicleTypeManager.finalizeVehicleTypes = Utils.prependedFunction(VehicleTypeManager.finalizeVehicleTypes, unfinishedBalesRegister.beforeFinalizeVehicleTypes)

function unfinishedBalesRegister:loadMap(name)
	print("--- loading "..g_i18n:getText("ubVERSION").." by mogli ---")

	g_i18n.texts["ubVERSION"] = g_i18n:getText("ubVERSION")
end;

function unfinishedBalesRegister:deleteMap()
  
end;

function unfinishedBalesRegister:keyEvent(unicode, sym, modifier, isDown)

end;

function unfinishedBalesRegister:mouseEvent(posX, posY, isDown, isUp, button)

end;

function unfinishedBalesRegister:update(dt)
	
end;

function unfinishedBalesRegister:draw()
  
end;

addModEventListener(unfinishedBalesRegister);