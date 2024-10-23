if( 0 ~= 0) then return end

local debug = false

MyLocalization = setmetatable(
	{
		['WoW Poker Lerduzz'] = 'WoW Poker Lerduzz',
		['Quit'] = 'Quit',
		['Sit Out'] = 'Sit Out',
		['Play'] = 'Play',
		['Fold'] = 'Fold',
		['Call'] = 'Call',
		['All In'] = 'All In',
		['Raise'] = 'Raise',
		['Chips'] = 'Chips',

		['High Card'] = 'High Card',
		['One Pair'] = 'One Pair',
		['Two Pairs'] = 'Two Pairs',
		['3 of a Kind'] = '3 of a Kind',
		['Straight'] = 'Straight',
		['Flush'] = 'Flush',
		['Full House'] = 'Full House',
		['4 of a Kind'] = '4 of a Kind',
		['Straight Flush'] = 'Straight Flush',
		['Royal Flush'] = 'Royal Flush',
		
		["Do you want to start the game?"] = 'Do you want to start the game?',
		['Start'] = 'Start',
		['Cancel'] = 'Cancel',
		['Options'] = 'Options',
		['Sit Out'] = 'Sit Out',
		['Show Cards'] = 'Show Cards',
		['%s has seated you in Seat %d'] = '%s has seated you in Seat %d',
		['Check'] = 'Check',
		['Use just /poker instead'] = 'Use just /poker instead',
		['has left the table.'] = 'has left the table.',
		['Total Pot'] = 'Total Pot',
		['wins'] = 'wins',
		['Split'] = 'Split',
		['Folded'] = 'Folded',
		['Showing'] = 'Showing',
		['No such player'] = 'No such player',
		['WoW Poker Lerduzz Options'] = 'WoW Poker Lerduzz Options',
		['These options are saved between sessions'] = 'These options are saved between sessions',
		['Starting Chips'] = 'Starting Chips',
		['Set the starting Chips'] = 'Set the starting Chips',
		['Blinds'] = 'Blinds',
		['Small Blind'] = 'Small Blind',
		['Big Blind'] = 'Big Blind',
		['Checked'] = 'Checked',
		['Called'] = 'Called',
		['Raised'] = 'Raised',
		['Playing'] = 'Playing',
		['Sitting Out'] = 'Sitting Out',
		['Winner!'] = 'Winner!',
		['Default'] = 'Default',
		['Showdown'] = 'Showdown',
		['Your turn'] = 'Your turn',
		['Minimap Icon'] = 'Minimap Icon',
		['Turn minimap icon on/off'] = 'Turn minimap icon on/off',
		['%s has no seat available for you'] = '%s has no seat available for you',
		['Call any'] = 'Call any',
		['Check/Fold'] = 'Check/Fold',
		['Sticky'] = 'Sticky',
	}
	,
	{__index = function(self, key)
		if debug then ChatFrame3:AddMessage('Please localize: '..tostring(key)) end
		rawset(self, key, key)
		return key
	end
	}
)
