!classDefinition: #MarsRover category: #'Mars-rover'!
Object subclass: #MarsRover
	instanceVariableNames: 'posicion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-rover'!


!MarsRover methodsFor: 'as yet unclassified' stamp: 'IF 10/17/2025 21:14:48'!
estaEnPosicion: unaPosicion
	^ unaPosicion = posicion ! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'IF 10/17/2025 21:55:58'!
haciaAdelante

	^ posicion := posicion + (0@1)! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'IF 10/17/2025 21:56:06'!
haciaAtras

	^ posicion := posicion + (0@-1)! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'IF 10/17/2025 21:47:33'!
inicializaEn: unaPosicion
	posicion := unaPosicion .! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'IF 10/17/2025 21:12:15'!
initialize
	posicion := 0@0.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'IF 10/17/2025 21:42:17'!
tomarSerieDeAcciones: unaSerieDeAcciones
	
	unaSerieDeAcciones do: [:value | 
		value = $f 
		ifTrue:  [self haciaAdelante]
		ifFalse: [self haciaAtras]
	].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'Mars-rover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'IF 10/17/2025 22:02:17'!
nuevoEnX: coordX Y: coordY c: a 
	^ self new inicializaEn: coordX @ coordY
! !


!classDefinition: #TestMarsRover category: #'Mars-rover'!
TestCase subclass: #TestMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-rover'!

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/17/2025 21:45:36'!
test01cadenaVaciaNoCambiaLaPosicionDelRover
	|rover|	
	rover := MarsRover nuevoEnX: 0 Y: 0.
	rover tomarSerieDeAcciones: ''.
	self assert: (rover estaEnPosicion: 0@0)! !

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/17/2025 21:47:57'!
test02cadenaFMueveRoverUnaPosicionHaciaAdelante
	|rover|	
	rover := MarsRover nuevoEnX: 0 Y: 0.
	rover tomarSerieDeAcciones: 'f'.
	self assert: (rover estaEnPosicion: 0@1)! !

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/17/2025 21:48:00'!
test03cadenaMuchasFsMueveRoverHaciaAdelanteTantasVecesComoFs
	|rover|	
	rover := MarsRover nuevoEnX: 0 Y: 0.
	rover tomarSerieDeAcciones: 'ff'.
	self assert: (rover estaEnPosicion: 0@2)! !

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/17/2025 21:48:03'!
test04cadenaBMueveRoverHaciaAtrasUnaPosicion
	|rover|	
	rover := MarsRover nuevoEnX: 0 Y: 0.
	rover tomarSerieDeAcciones: 'b'.
	self assert: (rover estaEnPosicion: 0@-1)! !

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/17/2025 21:48:06'!
test05cadenaMuchasBsMueveRoverHaciaAtrasTantasVecesComoBs
	|rover|	
	rover := MarsRover nuevoEnX: 0 Y: 0.
	rover tomarSerieDeAcciones: 'bb'.
	self assert: (rover estaEnPosicion: 0@-2)! !

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/17/2025 21:48:12'!
test06cadenaMismasBsQueFsTerminaEnElOrigen
	|rover|	
	rover := MarsRover nuevoEnX: 0 Y: 0.
	rover tomarSerieDeAcciones: 'fbfb'.
	self assert: (rover estaEnPosicion: 0@0)! !

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/17/2025 21:57:35'!
test07cadenaDiferenteCantidaDeBsQueFsTerminaMovida
	|rover|	
	rover := MarsRover nuevoEnX: 0 Y: 0.
	rover tomarSerieDeAcciones: 'fbffb'.
	self assert: (rover estaEnPosicion: 0@1)! !

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/17/2025 21:52:33'!
test08posicionInicialFueraDeOrigenEsRespetada
	|rover|	
	rover := MarsRover nuevoEnX: 1 Y: 1.
	rover tomarSerieDeAcciones: 'f'.
	self assert: (rover estaEnPosicion: 1@2)! !

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/17/2025 22:00:17'!
test09posicionInicialFueraDeOrigenEsRespetada
	|rover|	
	rover := MarsRover nuevoEnX: 1 Y: 1.
	rover tomarSerieDeAcciones: 'f'.
	self assert: (rover estaEnPosicion: 1@2)! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 17 54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 61 59 56 53 112 116 104 110 108 17 124 117 112 127 17 83 112 117 124 127 39 61 53 56 59 53 55 52 58 58 52 110 108 117 108 121 112 106 17 127 63 61 102 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 100 17 95 56 56 17 92 117 112 127 39 105 124 112 115 123 39 118 117 39 86 106 123 39 39 62 39 57 55 57 60 39 56 59 65 55 63 65 57 62 39 74 118 116 119 112 115 108 121 65 39 60 53 59 53 55 39 57 55 56 61 55 61 55 64 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 93 84 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 84 118 117 39 86 106 123 39 61 39 56 57 65 58 59 65 57 56 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 108 107 58 60 59 63 61 39 87 115 124 110 112 117 122 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 17 48 117 68 17 56 55 53 59 56 53 56 56 55 53 61 56 17 119 106 61 56 53 115 104 105 56 56 56 55 53 115 104 105 118 122 53 109 106 108 117 53 124 105 104 53 104 121 17 119 106 61 56 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 56 62 91 57 57 65 55 58 65 55 59 53 60 55 62 57 60 57 52 55 58 65 55 55 17 54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 84 104 121 122 52 121 118 125 108 121 53 122 123 17 58 63 55 62 17 52 52 52 52 52 52 52 52 52 52 17 17))!