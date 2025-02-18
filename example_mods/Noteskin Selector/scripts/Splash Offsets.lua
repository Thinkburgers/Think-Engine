
function onUpdatePost()
	initSaveData('arrowData', 'noteData')
    noteskinData = getDataFromSave('arrowData', 'noteData')
	pixelStage = getPropertyFromClass('PlayState', 'isPixelStage')

	for i = 0, getProperty('grpNoteSplashes.length')-1 do
		if not pixelStage then
			-- [Vanilla Notesplash Offset] --
			if noteskinData == 'Vanilla' then
				setPropertyFromGroup('grpNoteSplashes', i, 'offset.x', -30)
				setPropertyFromGroup('grpNoteSplashes', i, 'offset.y', -30)
			end
		end
	end
end