--
-- unfinishedBales
-- This is the specialization for unfinishedBales
--

--***************************************************************
source(Utils.getFilename("mogliBase.lua", g_currentModDirectory))
_G[g_currentModName..".mogliBase"].newClass( "unfinishedBales", "spec_unfinishedBales" )
--***************************************************************

function unfinishedBales.globalsReset( createIfMissing )

	unfinishedBalesGlobals = {}

	unfinishedBalesGlobals.minFillLevel      = 0.0
	
	unfinishedBalesGlobals.debug             = false

	local file
	file = unfinishedBales.baseDirectory.."unfinishedBalesConfig.xml"
	if fileExists(file) then	
		unfinishedBales.globalsLoad( file, "unfinishedBalesGlobals", unfinishedBalesGlobals )	
	else
		print("ERROR: NO GLOBALS IN "..file)
	end
	
	file = getUserProfileAppPath().. "modsSettings/FS19_UnfinishedBales/config.xml"
	if fileExists(file) then	
		print('Loading "'..file..'"...')
		unfinishedBales.globalsLoad( file, "unfinishedBalesGlobals", unfinishedBalesGlobals )	
	end

	unfinishedBalesGlobals.mathPi2           = 0.5 * math.pi
end

unfinishedBales.globalsReset( false )

function unfinishedBales.debugPrint( ... )
	if unfinishedBalesGlobals.debug then
		print( ... )
	end
end

function unfinishedBales.prerequisitesPresent(specializations)
	return true
end

function unfinishedBales.registerEventListeners(vehicleType)
	SpecializationUtil.registerEventListener(vehicleType, "onUpdate", unfinishedBales)
end 

--***************************************************************
-- onUpdate 
--***************************************************************
function unfinishedBales:onUpdate(dt)
	local baler    = self.spec_baler
	local fillUnit = self.spec_fillUnit
	local spec     = self.spec_unfinishedBales
	
	if baler == nil then 
		return 
	end 
	
	local c = self:getFillUnitCapacity( baler.fillUnitIndex )
	if c ~= nil then 
		if not ( baler.canUnloadUnfinishedBale ) then 
			if spec.canUnloadUnfinishedBale == nil then 
				spec.unfinishedBalesApplied  = true 
				spec.canUnloadUnfinishedBale = false 
				spec.unfinishedBaleThreshold = baler.unfinishedBaleThreshold  
			end 
		end 
		if spec.unfinishedBalesApplied then 
			baler.canUnloadUnfinishedBale = true 
			baler.unfinishedBaleThreshold = unfinishedBalesGlobals.minFillLevel * c
		end 
	end 
end 

