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
		['3 of a Kind'] = '3 of a Kind',
		['Straight'] = 'Straight',
		['Flush'] = 'Flush',
		['Full House'] = 'Full House',
		['4 of a Kind'] = '4 of a Kind',
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
		['%s has no seat available for you'] = '%s has no seat available for you',
		['Call any'] = 'Call any',
		['Check/Fold'] = 'Check/Fold',
		['Sticky'] = 'Sticky',
	},
	{
		__index = function(self, key)
			if debug then ChatFrame3:AddMessage('Please localize: '..tostring(key)) end;
			rawset(self, key, key);
			return key;
		end;
	}
);
