-- [Settings] --
playerOnly = false -- After Changing it pls restart the song twice for it to work properly.



-- [Do Not Touch] --

function onCreate()
	if songName == 'Noteskin Selector' then
		addLuaScript('Main Script') -- load selector
		Block = true
	end

	if playerOnly then
		playerOnlyData = 'Yes'
	else
		playerOnlyData = 'No'
	end
end

function onUpdate(elapsed)

	initSaveData('arrowData', 'noteData')
	initSaveData('arrowData', 'splashData')
	initSaveData('arrowData', 'playerOnlyData')
	setDataFromSave('arrowData', 'playerOnlyData', playerOnlyData)

    noteskinData = getDataFromSave('arrowData', 'noteData')
	splashTypeData = getDataFromSave('arrowData', 'splashData')
	pixelStage = getPropertyFromClass('PlayState', 'isPixelStage')

	for i = 0, getProperty('playerStrums.length')-1 do
		if not pixelStage and not Block then
			if noteskinData == 'Default' then
				setPropertyFromGroup('playerStrums', i, 'texture', 'NOTE_assets')
				if getPropertyFromGroup('notes', i, 'noteType') == ('' or 'Alt Animation' or 'Hey!' or 'GF Sing' or 'No Animation') then
					if getPropertyFromGroup('notes', i, 'mustPress') then
						setPropertyFromGroup('notes', i, 'texture', 'NOTE_assets')
					end
				end
			else
				setPropertyFromGroup('playerStrums', i, 'texture', 'noteskins/' .. noteskinData .. '/NOTE_assets')
				if getPropertyFromGroup('notes', i, 'noteType') == ('' or 'Alt Animation' or 'Hey!' or 'GF Sing' or 'No Animation') then
					if getPropertyFromGroup('notes', i, 'mustPress') then
						setPropertyFromGroup('notes', i, 'texture', 'noteskins/' .. noteskinData .. '/NOTE_assets')
					end
				end
			end

            -- [Splash System] --
			if splashTypeData == 'None' then
				setPropertyFromGroup('notes', i, 'noteSplashTexture', 'noteskins/noSplashes')
			end
			if splashTypeData == 'Custom' then
				setPropertyFromGroup('notes', i, 'noteSplashTexture', 'noteskins/' .. noteskinData .. '/noteSplashes')
			end
			if splashTypeData == 'Default' then
				setPropertyFromGroup('notes', i, 'noteSplashTexture', 'noteSplashes')
			end
			if splashTypeData == 'Vanilla' then
				setPropertyFromGroup('notes', i, 'noteSplashTexture', 'noteskins/Vanilla/noteSplashes')
			end

		end
	end

	for i = 0, getProperty('opponentStrums.length')-1 do
		if not pixelStage and not playerOnly and not Block then
			if noteskinData == 'Default' then
				setPropertyFromGroup('opponentStrums', i, 'texture', 'NOTE_assets')
				if not getPropertyFromGroup('notes', i, 'mustPress') and getPropertyFromGroup('notes', i, 'noteType') == ('' or 'Hey!' or 'No Animation' or 'GF Sing') then
					setPropertyFromGroup('notes', i, 'texture', 'NOTE_assets')
				end
			else
				setPropertyFromGroup('opponentStrums', i, 'texture', 'noteskins/' .. noteskinData .. '/NOTE_assets')
				if not getPropertyFromGroup('notes', i, 'mustPress') and getPropertyFromGroup('notes', i, 'noteType') == ('' or 'Hey!' or 'No Animation' or 'GF Sing') then
					setPropertyFromGroup('notes', i, 'texture', 'noteskins/' .. noteskinData .. '/NOTE_assets')
				end
			end
		end
	end
end