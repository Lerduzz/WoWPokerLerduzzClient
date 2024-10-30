if(0 ~= 0) then return end;

local debug = false;

WPL_Locale = setmetatable(
	{
		['WoW Poker Lerduzz'] = 'WoW Poker Lerduzz',
		['Fold'] = 'Fold',
		['Call'] = 'Call',
		['All In'] = 'All In',
		['Raise'] = 'Raise',
		['Check'] = 'Check',

		['High Card'] = 'High Card',
		['One Pair'] = 'One Pair',
		['Two Pairs'] = 'Two Pairs',
		['Three of a Kind'] = 'Three of a Kind',
		['Straight'] = 'Straight',
		['Flush'] = 'Flush',
		['Full House'] = 'Full House',
		['Four of a Kind'] = 'Four of a Kind',
		['Straight Flush'] = 'Straight Flush',
		['Royal Flush'] = 'Royal Flush',

		["Do you want to start a game of poker?"] = 'Do you want to start a game of poker?',
		['Start'] = 'Start',
		['Cancel'] = 'Cancel',
		['Show Cards'] = 'Show Cards',
		['has left the table.'] = 'has left the table.',
		['wins'] = 'wins',
		['Split'] = 'Split',
		['Folded'] = 'Folded',
		['Showing'] = 'Showing',
		['Blinds'] = 'Blinds',
		['Small Blind'] = 'Small Blind',
		['Big Blind'] = 'Big Blind',
		['Checked'] = 'Checked',
		['Called'] = 'Called',
		['Raised'] = 'Raised',
		['Playing'] = 'Playing',
		['Winner!'] = 'Winner!',
		['Returned'] = 'Returned',
		['Default'] = 'Default',
		['Showdown'] = 'Showdown',
		['Call any'] = 'Call any',
		['Check/Fold'] = 'Check/Fold',
		['Sticky'] = 'Sticky',
		['Player not found.'] = 'Player not found.',
		['Not enough gold.'] = 'Not enough gold.',
		['Gold out of range.'] = 'Gold out of range.',
		['Table is full of gold.'] = 'Table is full of gold.',
		['There are no seats available at this time.'] = 'There are no seats available at this time.',
	},
	{
		__index = function(self, key)
			if debug then ChatFrame3:AddMessage('Please localize: '..tostring(key)) end;
			rawset(self, key, key);
			return key;
		end;
	}
);
