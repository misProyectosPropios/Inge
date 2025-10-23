!classDefinition: #MarsRover category: #'Mars-rover'!
Object subclass: #MarsRover
	instanceVariableNames: 'posicion direccion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-rover'!
!MarsRover commentStamp: 'IF 10/23/2025 14:39:24' prior: 0!
Main comment stating the purpose of this class and relevant relationship to other classes.

Possible useful expressions for doIt or printIt.

Structure:
 instVar1		type -- comment about the purpose of instVar1
 instVar2		type -- comment about the purpose of instVar2

Any further useful comments about the general approach of this implementation!


!MarsRover methodsFor: 'as yet unclassified' stamp: 'IF 10/17/2025 21:14:48'!
estaEnPosicion: unaPosicion
	^ unaPosicion = posicion ! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'IF 10/23/2025 14:54:27'!
estaMirandoHacia: unaDireccion
	^ unaDireccion = direccion ! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'IF 10/23/2025 15:10:36'!
haciaAdelante
	|movimientoSegunDireccion|
	
	movimientoSegunDireccion := Dictionary newFrom:{#N -> (0@1) . #E -> (1@0) . #S -> (0@-1) . #O -> (-1@0)}.
	posicion := posicion + movimientoSegunDireccion at: direccion.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'IF 10/23/2025 15:21:41'!
haciaAtras
	self rotarHaciaAtras.
	self haciaAdelante.
	self rotarHaciaAtras.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'IF 10/17/2025 21:47:33'!
inicializaEn: unaPosicion
	posicion := unaPosicion .! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'IF 10/23/2025 14:28:27'!
inicializaEnPosicion: unaPosicion mirandoA: unPuntoCardinal
	posicion := unaPosicion .
	direccion := unPuntoCardinal.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'IF 10/17/2025 21:12:15'!
initialize
	posicion := 0@0.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'IF 10/23/2025 14:57:16'!
isAt: aPosition heading: aDirection
	^ posicion = aPosition and: [direccion = aDirection]! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'IF 10/23/2025 15:40:10'!
process: unaSerieDeAcciones
	|accionDeLetra|
	(unaSerieDeAcciones isKindOf: String) ifFalse: [self error: 'Solamento hacepto streengs'].
	
	accionDeLetra := Dictionary newFrom: {$f -> [self haciaAdelante]. $b -> [self haciaAtras]. $r -> [self rotarHaciaDerecha ]. $l -> [self rotarHaciaIzquierda ].}.
	unaSerieDeAcciones do: [:letra | 
		(accionDeLetra at: letra ifAbsent: [^ self]) value 
	].
! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'IF 10/23/2025 15:21:35'!
rotarHaciaAtras

	self rotarHaciaDerecha.
	self rotarHaciaDerecha! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'IF 10/23/2025 14:53:58'!
rotarHaciaDerecha
	|rotacionesADerecha|
	rotacionesADerecha := Dictionary newFrom:{#N -> #E . #E -> #S . #S -> #O . #O -> #N}.
	direccion := rotacionesADerecha at: direccion.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'IF 10/23/2025 15:21:35'!
rotarHaciaIzquierda
	
	self rotarHaciaAtras.
	self rotarHaciaDerecha.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'Mars-rover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'IF 10/23/2025 14:39:03'!
at: aPosition heading: aDirection
	^ self new inicializaEnPosicion: aPosition mirandoA: aDirection ! !


!classDefinition: #TestMarsRover category: #'Mars-rover'!
TestCase subclass: #TestMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars-rover'!

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/23/2025 15:40:10'!
test01cadenaVaciaNoCambiaLaPosicionDelRover
	|rover|	
	rover := MarsRover at: 0@0 heading: #N .
	rover process: ''.
	self assert: (rover isAt: 0@0 heading: #N)! !

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/23/2025 15:40:10'!
test02cadenaFMueveRoverUnaPosicionHaciaAdelante
	|rover|	
	rover := MarsRover at: 0@0 heading: #N .
	rover process: 'f'.
	self assert: (rover isAt: 0@1 heading: #N)! !

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/23/2025 15:40:10'!
test03cadenaMuchasFsMueveRoverHaciaAdelanteTantasVecesComoFs
	|rover|	
	rover := MarsRover at: 0@0 heading: #N.
	rover process: 'ff'.
	self assert: (rover isAt: 0@2 heading: #N)! !

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/23/2025 15:40:10'!
test04cadenaBMueveRoverHaciaAtrasUnaPosicion
	|rover|	
	rover := MarsRover at: 0@0 heading: #N .
	rover process: 'b'.
	self assert: (rover isAt: 0@-1 heading: #N)! !

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/23/2025 15:40:10'!
test05cadenaMuchasBsMueveRoverHaciaAtrasTantasVecesComoBs
	|rover|	
	rover := MarsRover at: 0@0 heading: #N .
	rover process: 'bb'.
	self assert: (rover isAt: 0@-2 heading: #N)! !

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/23/2025 15:40:10'!
test06cadenaMismasBsQueFsTerminaEnElOrigen
	|rover|	
	rover := MarsRover at: 0@0 heading: #N .
	rover process: 'fbfb'.
	self assert: (rover isAt: 0@0 heading: #N)! !

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/23/2025 15:40:10'!
test07cadenaDiferenteCantidaDeBsQueFsTerminaMovida
	|rover|	
	rover := MarsRover at: 0@0 heading: #N .
	rover process: 'fbffb'.
	self assert: (rover isAt: 0@1 heading: #N)! !

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/23/2025 15:40:10'!
test08posicionInicialFueraDeOrigenEsRespetada
	|rover|	
	rover := MarsRover at: 1@1 heading: #N .
	rover process: 'f'.
	self assert: (rover isAt: 1@2 heading: #N)! !

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/23/2025 15:40:10'!
test09posicionInicialFueraDeOrigenEsRespetada
	|rover|	
	rover := MarsRover at: 1@1 heading: #N .
	rover process: 'f'.
	self assert: (rover isAt: 1@2 heading: #N)! !

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/23/2025 15:40:10'!
test10rotacionHaciaDerechaMiraAlEste
	|rover|	
	rover := MarsRover at: 0@0 heading: #N .
	rover process: 'r'.
	self assert: (rover isAt: 0@0 heading: #E).
! !

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/23/2025 15:40:10'!
test11rotacionHaciaDerechaDejaDeMirarANorte
	|rover|	
	rover := MarsRover at: 0@0 heading: #N .
	rover process: 'r'.
	self deny: (rover isAt: 0@0 heading: #N)! !

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/23/2025 15:40:10'!
test12rotacionHaciaDerechaDerechaMiraHaciaSur
	|rover|	
	rover := MarsRover at: 0@0 heading: #N .
	rover process: 'rr'.
	self assert: (rover isAt: 0@0 heading: #S)! !

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/23/2025 15:40:10'!
test13rotacionHaciaDerechaSeMueveHaciaEste
	|rover|	
	rover := MarsRover at: 0@0 heading: #N .
	rover process: 'rf'.
	self assert: (rover isAt: 1@0 heading: #E)! !

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/23/2025 15:40:10'!
test14rotacionHaciaDerechaSeMueveHaciaSur
	|rover|	
	rover := MarsRover at: 0@0 heading: #N .
	rover process: 'rb'.
	self assert: (rover isAt: -1@0 heading: #E)! !

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/23/2025 15:40:10'!
test15rotacionHaciaDerechaDerechaSeMueveHaciaSur
	|rover|	
	rover := MarsRover at: 0@0 heading: #N .
	rover process: 'rrb'.
	self assert: (rover isAt: 0@1 heading: #S)! !

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/23/2025 15:40:10'!
test16rotacionHaciaIzquierdaMiraHaciaOeste
	|rover|	
	rover := MarsRover at: 0@0 heading: #N .
	rover process: 'l'.
	self assert: (rover isAt: 0@0 heading: #O)! !

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/23/2025 15:40:10'!
test17rotacionHaciaIzquierdaIzquierdaMiraHaciaSur
	|rover|	
	rover := MarsRover at: 0@0 heading: #N .
	rover process: 'll'.
	self assert: (rover isAt: 0@0 heading: #S)! !

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/23/2025 15:40:10'!
test18rotacionHaciaIzquierdaMueveOeste
	|rover|	
	rover := MarsRover at: 0@0 heading: #N .
	rover process: 'lf'.
	self assert: (rover isAt: -1@0 heading: #O)! !

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/23/2025 15:40:10'!
test19tomarSerieDeAccionesRecibeStringSolamente
	|rover|	
	rover := MarsRover at: 0@0 heading: #N .
	self should: [rover process: $l.] raise: Error-MessageNotUnderstood! !

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/23/2025 15:40:10'!
test20dejaDeEjecutarUnaVezEncuentraAccionNoDefinida
	|rover|	
	rover := MarsRover at: 0@0 heading: #N .
	rover process: 'p'.
	self assert: (rover isAt: 0@0 heading: #N)! !

!TestMarsRover methodsFor: 'tests' stamp: 'IF 10/23/2025 15:40:10'!
test20noHaceNadaConAccionNoDefinida
	|rover|	
	rover := MarsRover at: 0@0 heading: #S .
	rover process: 'rrbpb'.
	self assert: (rover isAt: 0@-1 heading: #N)! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 107 107 54 115 112 117 124 127 61 59 47 56 48 54 115 112 117 124 127 61 59 17 54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 107 107 54 115 112 117 124 127 61 59 47 56 48 54 115 112 117 124 127 61 59 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 61 59 56 53 112 116 104 110 108 17 124 117 112 127 17 83 112 117 124 127 39 61 53 56 59 53 55 52 58 58 52 110 108 117 108 121 112 106 17 127 63 61 102 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 100 17 95 56 56 17 92 117 112 127 39 105 124 112 115 123 39 118 117 39 86 106 123 39 39 62 39 57 55 57 60 39 56 59 65 55 63 65 57 62 39 74 118 116 119 112 115 108 121 65 39 60 53 59 53 55 39 57 55 56 61 55 61 55 64 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 93 84 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 84 118 117 39 86 106 123 39 61 39 56 57 65 58 59 65 57 56 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 108 107 58 60 59 63 61 39 87 115 124 110 112 117 122 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 17 48 114 60 17 56 55 53 59 56 53 56 55 62 53 60 58 17 119 106 60 58 53 115 104 105 56 56 55 62 53 115 104 105 118 122 53 109 106 108 117 53 124 105 104 53 104 121 17 119 106 60 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 58 91 56 59 65 56 58 65 59 55 53 61 59 62 59 60 57 52 55 58 65 55 55 17 54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 84 104 121 122 52 121 118 125 108 121 53 122 123 17 62 55 64 57 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 58 91 56 60 65 59 56 65 57 58 53 62 55 61 58 63 52 55 58 65 55 55 17 54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 107 107 54 115 112 117 124 127 61 59 47 56 48 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 84 104 121 122 52 121 118 125 108 121 77 112 117 104 115 53 122 123 17 63 60 55 62 17 52 52 52 52 52 52 52 52 52 52 17 17))!