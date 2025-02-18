
--[[ How To Use ] --

  [Basic]
     The noteskin name should be the name of the folder in the Noteskin folder.
     Make sure the name of the noteskin is NOTE_assets and the name of the notesplash is noteSplashes.

  [Splash Types]
     1. Default, This will make your splashes use the basic noteSplashes.
     2. Custom, This will make your splashes use the custom splashes in your noteskin folder.
     3. None, This will completely hide your notesplshes.

  [bgColor]
     The color of the background in the Noteskin Selector
	 Use Hex Codes
	 Remomended Website: https://htmlcolorcodes.com ]]


-- [Edit Selection] --
Selection = {
	{Noteskin = 'Default', splashType = 'Default', bgColor = 'FFDC00'},
	{Noteskin = 'Vanilla', splashType = 'Vanilla', bgColor = 'FFDC00'},
	{Noteskin = 'Snowen', splashType = 'Custom', bgColor = '8811E6'} -- Example
}

-- [Main Code] --

-- [DONT TOUCH] --
noteNum = 1
stopAcceptSpam = false
stopBackSpam = false


function onCreate()
	-- [Stage Shitz] --
	    setProperty('skipCountdown', true)
		setPropertyFromClass('lime.app.Application', 'current.window.title', "Friday Night Funkin': Psych Engine: Noteskin Selector")
		changePresence('In The Selections')

        -- [Texts] --
		
	        makeLuaText('curTxt', ' Current Noteskin:', 0, 0, 0)
	        setTextSize('curTxt', 20)
	        addLuaText('curTxt')

	        makeLuaText('skinName', '', 1000, 140, 250)
	        setTextSize('skinName', 40)
	        addLuaText('skinName')

	        makeLuaText('splashTxt', '', 1000, 140, 420)
	        setTextSize('splashTxt', 40)
     	    addLuaText('splashTxt')

      	    makeLuaText('topTxt', 'Noteskin Selector', 1000, 140, 0)
	        setTextSize('topTxt', 40)
	        addLuaText('topTxt')

    	    makeLuaText('lowTxt', 'Created By Snowen', 1000, 140, 40) -- Dont You Dare Remove My Name.
    	    setTextSize('lowTxt', 20)
    	    addLuaText('lowTxt')

    	    makeLuaText('bottonTxt', ' Press Escape/Backspace To Return, Press Left/Right To Scroll, Press Enter/Space to Select', 0, 0, 695)
	        setTextSize('bottonTxt', 20)
    	    addLuaText('bottonTxt')

        -- [Background] --
    	    makeLuaSprite('BG', 'menuDesat', 0, 0)
    	    setObjectCamera('BG', 'hud')
    	    addLuaSprite('BG')

        -- [Stolen Code From n_bonnies Funkin' Character Select] --
		    -- [Left Arrow] --
				makeAnimatedLuaSprite('leftArrow', 'NOTE_assets', 50, 300)
				addAnimationByPrefix('leftArrow', 'idle', 'arrowLEFT', 24, true)
				addAnimationByPrefix('leftArrow', 'press', 'left confirm', 24, true)
				setObjectCamera('leftArrow', 'other')
				scaleObject('leftArrow', 0.7, 0.7)
				addLuaSprite('leftArrow', true)
				playAnim('leftArrow', 'idle', true)

			-- [Right Arrow] --
				makeAnimatedLuaSprite('rightArrow', 'NOTE_assets', 1100, 300)
				addAnimationByPrefix('rightArrow', 'idle', 'arrowRIGHT', 24, true)
				addAnimationByPrefix('rightArrow', 'press', 'right confirm', 24, true)
				setObjectCamera('rightArrow', 'other')
				scaleObject('rightArrow', 0.7, 0.7)
				addLuaSprite('rightArrow', true)

end

function onUpdate()
	initSaveData('arrowData', 'noteData')
	initSaveData('arrowData', 'splashData')
	curNoteskin = getDataFromSave('arrowData', 'noteData')
	scrollSystem() -- Top Loader Lol.

    -- [Noteskin Changin'] --
	for i = 0, getProperty('playerStrums.length')-1 do
		if Selection[noteNum].Noteskin == 'Default' then
			setPropertyFromGroup('playerStrums', i, 'texture', 'NOTE_assets')
		else
			-- Rodney: That seems so random don't do subfolders like that thats just awkward.
			-- Me: :smiling_imp:
			setPropertyFromGroup('playerStrums', i, 'texture', 'Noteskins/' .. Selection[noteNum].Noteskin .. '/NOTE_assets')
		end
	end

	-- [Note Position] --
	
		if getPropertyFromClass('ClientPrefs', 'middleScroll') == true then
			setPropertyFromClass('ClientPrefs', 'middleScroll', false)
			wasMid = true
		end
		if getPropertyFromClass('ClientPrefs', 'downScroll') == true then
			setPropertyFromClass('ClientPrefs', 'downScroll', false)
			wasDown = true
		end
	
		for i = 0,3 do
			setPropertyFromGroup('playerStrums', 0, 'x', defaultPlayerStrumX0 - 320)
			setPropertyFromGroup('playerStrums', 1, 'x', defaultPlayerStrumX1 - 320)
			setPropertyFromGroup('playerStrums', 2, 'x', defaultPlayerStrumX2 - 320)
			setPropertyFromGroup('playerStrums', 3, 'x', defaultPlayerStrumX3 - 320)
			setPropertyFromGroup('playerStrums', 0, 'y', defaultPlayerStrumX0 - 430)
			setPropertyFromGroup('playerStrums', 1, 'y', defaultPlayerStrumX0 - 430)
			setPropertyFromGroup('playerStrums', 2, 'y', defaultPlayerStrumX0 - 430)
			setPropertyFromGroup('playerStrums', 3, 'y', defaultPlayerStrumX0 - 430)
		end
	
		for i = 0, getProperty("unspawnNotes.length") do
			if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
				setPropertyFromGroup('unspawnNotes', i, 'visible', false);
			end
		end
	   
		for i = 0, 3 do
			setPropertyFromGroup('opponentStrums', i, 'visible', false);
		end

	-- [Stage Shitz] --
	    setPropertyFromClass('flixel.FlxG', 'mouse.visible', true)
		setProperty('timeBar.visible', false)
		setProperty('timeBarBG.visible', false)
		setProperty('timeTxt.visible', false)
		setProperty('iconP1.visible', false)
		setProperty('iconP2.visible', false)
		setProperty('scoreTxt.visible', false)
		setProperty('healthBar.visible', false)
		setProperty('healthBarBG.visible', false)

        -- [Texts] --
			setTextString('curTxt', ' Current Noteskin: ' .. curNoteskin)
			setTextString('skinName', Selection[noteNum].Noteskin)
			setTextString('splashTxt', 'Splash Type: ' .. Selection[noteNum].splashType)

        -- [Background] --
			setProperty('BG.color', getColorFromHex(Selection[noteNum].bgColor))

	    -- [Accept/Back with mouse controls] --
		    if not stopAcceptSpam then
				if keyJustPressed('accept') or mousePressed('right') then
					stopAcceptSpam = true
					playSound('confirmMenu', 0.7)
					doTweenAlpha('TL', 'leftArrow', 0, 0.8, 'linear')
					doTweenAlpha('TR', 'rightArrow', 0, 0.8, 'linear')
					doTweenAlpha('T0', 'curTxt', 0, 0.8, 'linear')
					doTweenAlpha('T1', 'bottonTxt', 0, 0.8, 'linear')
					doTweenAlpha('T2', 'skinName', 0, 0.8, 'linear')
					doTweenAlpha('T3', 'topTxt', 0, 0.8, 'linear')
					doTweenAlpha('T4', 'lowTxt', 0, 0.8, 'linear')
					doTweenAlpha('T5', 'splashTxt', 0, 0.8, 'linear')
					runTimer('wait', 1.5)
				end
			end

			if not stopBackSpam then
				if keyJustPressed('back') or mousePressed('middle') then
					stopBackSpam = true
					playSound('cancelMenu', 0.7)
					canEnd = true
					endSong()
				end
			end

end

function scrollSystem()

	if keyJustPressed('left') then
		playAnim('leftArrow', 'press', 'left confirm')
		runTimer('Lidle', 0.1)
		setProperty('leftArrow.x', 30)
		doTweenX('leftTween', 'leftArrow', 50, 1, 'circOut')
		playSound('scrollMenu', 0.7)
		if noteNum == 1 then
			noteNum = #Selection
		else
			noteNum = noteNum - 1
		end
		setNoteskin(Selection[noteNum].Noteskin, Selection[noteNum].splashType, Selection[noteNum].bgColor)
	end

	if keyJustPressed('right') then
		playAnim('rightArrow', 'press', 'right confirm')
		runTimer('Ridle', 0.1)
		setProperty('rightArrow.x', 1120)
		doTweenX('rightTween', 'rightArrow', 1100, 1, 'circOut')
		playSound('scrollMenu', 0.7)
		if noteNum + 1 >= #Selection + 1 then
			noteNum = 1          
		else
			noteNum = noteNum + 1
		end
		setNoteskin(Selection[noteNum].Noteskin, Selection[noteNum].splashType, Selection[noteNum].bgColor)
	end

	if keyJustPressed('accept') or mousePressed('right') then
		setDataFromSave('arrowData', 'noteData', Selection[noteNum].Noteskin)
		setDataFromSave('arrowData', 'splashData', Selection[noteNum].splashType)
	end

	-- [Mouse Support] --
		if getMouseX('hud') > getProperty('leftArrow.x') and getMouseY('hud') > getProperty('leftArrow.y') and getMouseX('hud') < getProperty('leftArrow.x') + getProperty('leftArrow.width') and getMouseY('hud') < getProperty('leftArrow.y') + getProperty('leftArrow.height') and mouseReleased() then
			playAnim('leftArrow', 'press', 'left confirm')
			runTimer('Lidle', 0.1)
			setProperty('leftArrow.x', 30)
			doTweenX('leftTween', 'leftArrow', 50, 1, 'circOut')
			playSound('scrollMenu', 0.7)
			if noteNum == 1 then
				noteNum = #Selection
			else
				noteNum = noteNum - 1
			end
			setNoteskin(Selection[noteNum].Noteskin, Selection[noteNum].splashType, Selection[noteNum].bgColor)
		end

		if getMouseX('hud') > getProperty('rightArrow.x') and getMouseY('hud') > getProperty('rightArrow.y') and getMouseX('hud') < getProperty('rightArrow.x') + getProperty('rightArrow.width') and getMouseY('hud') < getProperty('rightArrow.y') + getProperty('rightArrow.height') and mouseReleased() then
			playAnim('rightArrow', 'press', 'right confirm')
			runTimer('Ridle', 0.1)
			setProperty('rightArrow.x', 1120)
			doTweenX('rightTween', 'rightArrow', 1100, 1, 'circOut')
			playSound('scrollMenu', 0.7)
			if noteNum + 1 >= #Selection + 1 then
				noteNum = 1          
			else
				noteNum = noteNum + 1
			end
			setNoteskin(Selection[noteNum].Noteskin, Selection[noteNum].splashType, Selection[noteNum].bgColor)
		end



end

-- [Some More Stage Stuff] --
    -- [No Pausing] --
	function onPause() 
		return Function_Stop
	end

	-- [Song Cant End] --
	function onEndSong()
		if not canEnd then
			return Function_Stop
		end
	end

	-- [Restores Shit] --
	function onDestroy()
		setPropertyFromClass('lime.app.Application', 'current.window.title', "Friday Night Funkin': Psych Engine")
		setPropertyFromClass('flixel.FlxG', 'mouse.visible', false)
		if wasMid then
			setPropertyFromClass('ClientPrefs', 'middleScroll', true)
		end
		if wasDown then
			setPropertyFromClass('ClientPrefs', 'downScroll', true)
		end
	end

	-- [Timers] --
	function onTimerCompleted(tag)
		if tag == 'wait' then
			endSong()
			canEnd = true
		end
		if tag == 'Lidle' then
			playAnim('leftArrow', 'idle', true)
		end
		if tag == 'Ridle' then
			playAnim('rightArrow', 'idle', true)
		end
	end