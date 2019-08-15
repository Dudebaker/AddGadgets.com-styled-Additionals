-- ReadWriteFile
-- @version 1.0.0
-- @autor 	Dudebaker
-- @license Creative Commons Attribution-Noncommercial-Share Alike 3.0 License
 
function Initialize()
	FilePath  	 = SELF:GetOption('FilePath', "")
	Read 	 	 = tonumber(SELF:GetOption('Read', "0"))
	Write 	 	 = tonumber(SELF:GetOption('Write', "0"))
	MeterName	 = SELF:GetOption('MeterName', "Meter")	
	MeasureName	 = SELF:GetOption('MeasureName', "Measure")
end
 
function Update()
	if(FilePath ~= "") then
		if(Read == 1) then
			if(MeterName ~= "") then
				SKIN:Bang("!SetOption", MeterName, "Text", ReadFile(FilePath))
			end
		elseif (Write == 1) then
			if(MeasureName ~= "") then
				WriteFile(FilePath, SKIN:GetMeasure(MeasureName):GetStringValue())
			end 
		end
	end 
end

-- https://docs.rainmeter.net/snippets/read-write-file/

function ReadFile(FilePath)
	-- HANDLE RELATIVE PATH OPTIONS.
	FilePath = SKIN:MakePathAbsolute(FilePath)

	-- OPEN FILE.
	local File = io.open(FilePath)

	-- HANDLE ERROR OPENING FILE.
	if not File then
		print('ReadFile: unable to open file at ' .. FilePath)
		return
	end

	-- READ FILE CONTENTS AND CLOSE.
	local Contents = File:read('*all')
	File:close()

	return Contents
end

function WriteFile(FilePath, Contents)
	-- HANDLE RELATIVE PATH OPTIONS.
	FilePath = SKIN:MakePathAbsolute(FilePath)

	-- OPEN FILE.
	local File = io.open(FilePath, 'w')

	-- HANDLE ERROR OPENING FILE.
	if not File then
		print('WriteFile: unable to open file at ' .. FilePath)
		return
	end

	-- WRITE CONTENTS AND CLOSE FILE
	File:write(Contents)
	File:close()

	return true
end