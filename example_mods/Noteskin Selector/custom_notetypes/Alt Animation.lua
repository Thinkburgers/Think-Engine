function onCreate()
	
	initSaveData('arrowData', 'noteData')
	initSaveData('arrowData', 'splashData')
	initSaveData('arrowData', 'playerOnlyData')

    noteskinData = getDataFromSave('arrowData', 'noteData')
	splashTypeData = getDataFromSave('arrowData', 'splashData')
	playerOnly = getDataFromSave('arrowData', 'playerOnlyData')
	pixelStage = getPropertyFromClass('PlayState', 'isPixelStage')

	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Alt Animation' then
			if not pixelStage then

				if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
					if playerOnly == 'Yes' or noteskinData  == 'Default' then
						setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_assets')
					else
						setPropertyFromGroup('unspawnNotes', i, 'texture', 'Noteskins/' .. noteskinData  .. '/NOTE_assets')
					end
				end

				if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
					if noteskinData  == 'Default' then
						setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE_assets')
					else
						setPropertyFromGroup('unspawnNotes', i, 'texture', 'Noteskins/' .. noteskinData  .. '/NOTE_assets')
					end
					setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false)
				end

			    -- [Splash System] --
				if splashTypeData == 'None' then
					setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'Noteskins/noSplashes')
				end
				if splashTypeData == 'Custom' then
					setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'Noteskins/' .. noteskinData .. '/noteSplashes')
				end
				if splashTypeData == 'Default' then
					setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture',  'noteSplashes')
				end
				if splashTypeData == 'Vanilla' then
					setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture',  'Noteskins/Vanilla/noteSplashes')
				end
			end
		end
	end
end

altNotes = {'singLEFT-Alt', 'singDOWN-Alt', 'singUP-Alt', 'singRIGHT-Alt'} -- Left Down Up Right
function goodNoteHit(id, noteData, noteType, isSustainNote)
	for i=0,3 do
		if direction == i then
			if noteType == 'Alt Animation' then
				playAnim('boyfriend' or 'dad', getProperty(altNotes[i+1]))
			end
		end
	end
end