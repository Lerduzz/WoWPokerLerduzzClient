if( 0 ~= 0) then return end

local debug = false

MyLocalization = setmetatable(
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
		['3 of a Kind'] = 'Trío',
		['Straight'] = 'Escalera',
		['Flush'] = 'Color',
		['Full House'] = 'Full',
		['4 of a Kind'] = 'Poker',
		['Straight Flush'] = 'Escalera de Color',
		['Royal Flush'] = 'Escalera Real',

		["Do you want to start the game?"] = '¿Deseas comenzar la partida?',
		['Start'] = 'Comenzar',
		['Cancel'] = 'Cancelar',
		['Options'] = 'Opciones',
		['Show Cards'] = 'Mostrar Cartas',
		['Use just /poker instead'] = 'Use just /poker instead',
		['has left the table.'] = 'ha dejado la mesa.',
		['Total Pot'] = 'Apuesta Total',
		['wins'] = 'ha ganado',
		['Split'] = 'Dividir',
		['Folded'] = 'Retirado',
		['Showing'] = 'Mostrando',
		['No such player'] = 'No se encuentra el jugador',
		['WoW Poker Lerduzz Options'] = 'Opciones de WoW Poker Lerduzz',
		['These options are saved between sessions'] = 'Estas opciones son guardadas entre sesiones',
		['Starting Chips'] = 'Fichas Iniciales',
		['Set the starting Chips'] = 'Establezca las fichas iniciales',
		['Blinds'] = 'Ciegas',
		['Small Blind'] = 'Ciega Pequeña',
		['Big Blind'] = 'Ciega Grande',
		['Checked'] = 'Pasado',
		['Called'] = 'Igualado',
		['Raised'] = 'Subido',
		['Playing'] = 'Jugando',
		['Winner!'] = '¡Ganador!',
		['Default'] = 'Predeterminado',
		['Showdown'] = 'Confrontación',
		['Your turn'] = 'Tu turno',
		['Minimap Icon'] = 'Ícono en el minimapa',
		['Turn minimap icon on/off'] = 'Activa o desactiva el ícono en el minimapa',
		['%s has no seat available for you'] = '%s no tiene asientos disponibles',
		['Call any'] = 'Igualar todo',
		['Check/Fold'] = 'Pasar/Retirarse',
		['Sticky'] = 'Mantener',
	}
	,
	{__index = function(self, key)
		if debug then ChatFrame3:AddMessage('Please localize: '..tostring(key)) end
		rawset(self, key, key)
		return key
	end
	}
)
