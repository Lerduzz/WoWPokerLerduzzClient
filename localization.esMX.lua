if(0 ~= 0) then return end;

local debug = false;

WPL_Locale = setmetatable(
	{
		['WoW Poker Lerduzz'] = 'WoW Poker Lerduzz',
		['Fold'] = 'Retirarse',
		['Call'] = 'Igualar',
		['All In'] = 'Jugar todo',
		['Raise'] = 'Subir',
		['Check'] = 'Pasar',

		['High Card'] = 'Carta Alta',
		['One Pair'] = 'Una Pareja',
		['Two Pairs'] = 'Dos Parejas',
		['Three of a Kind'] = 'Trío',
		['Straight'] = 'Escalera',
		['Flush'] = 'Color',
		['Full House'] = 'Full',
		['Four of a Kind'] = 'Poker',
		['Straight Flush'] = 'Escalera de Color',
		['Royal Flush'] = 'Escalera Real',

		["Do you want to start a game of poker?"] = '¿Deseas comenzar una partida de poker?',
		['Start'] = 'Comenzar',
		['Cancel'] = 'Cancelar',
		['Show Cards'] = 'Mostrar Cartas',
		['has left the table.'] = 'ha dejado la mesa.',
		['wins'] = 'ha ganado',
		['Split'] = 'Dividir',
		['Folded'] = 'Retirado',
		['Showing'] = 'Mostrando',
		['Blinds'] = 'Ciegas',
		['Small Blind'] = 'Ciega Pequeña',
		['Big Blind'] = 'Ciega Grande',
		['Checked'] = 'Pasado',
		['Called'] = 'Igualado',
		['Raised'] = 'Subido',
		['Playing'] = 'Jugando',
		['Winner!'] = '¡Ganador!',
		['Returned'] = 'Devuelto',
		['Default'] = 'Predeterminado',
		['Showdown'] = 'Confrontación',
		['Call any'] = 'Igualar todo',
		['Check/Fold'] = 'Pasar/Retirarse',
		['Sticky'] = 'Mantener',
		['Error joining poker table'] = 'Error al unirse a la mesa de poker',
		['Player not found!'] = '¡Jugador no encontrado!',
		['Not enough gold!'] = '¡No tienes suficiente oro!',
		['Gold out of range!'] = '¡Oro fuera del rango permitido!',
		['Table is full of gold!'] = '¡La mesa ha alcanzado el límite de oro!',
		['There are no seats available at this time!'] = '¡No hay asientos disponibles en este momento!',
		['Ok'] = 'Aceptar',
	},
	{
		__index = function(self, key)
			if debug then ChatFrame3:AddMessage('Por favor traducir: '..tostring(key)) end;
			rawset(self, key, key)
			return key
		end;
	}
);
