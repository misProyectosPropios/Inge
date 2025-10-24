!classDefinition: #SPlusPlus category: #TLENG!
Object subclass: #SPlusPlus
	instanceVariableNames: 'instrucciones variablesLocales'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TLENG'!

!SPlusPlus methodsFor: 'functionality' stamp: 'IF 10/24/2025 12:55:21'!
run
	|ret|
	ret := 0.
	instrucciones do: [ :instruccion | 
		instruccion = 'y++' ifTrue: [ret := ret + 1].
		instruccion = 'y--' ifTrue: [ret := (ret - 1) max: 0].
"
		instruccion = 'Z0++' ifTrue: [self incrementarVariableLocalEnPos: 1].
		instruccion = 'Z1++' ifTrue: [self incrementarVariableLocalEnPos: 2].
		instruccion = 'Z2++' ifTrue: [self incrementarVariableLocalEnPos: 3]."
		
		"Generalizo ZIUnmatched comment quote ->"
		((instruccion at: 1) = $Z) ifTrue: [self modificarVariableLocalConInstrucicon: instruccion].
	].
	^ ret.! !


!SPlusPlus methodsFor: 'initialization' stamp: 'IF 10/24/2025 12:08:21'!
initializeWithUnaSerieDePasos: unaSerieDePasos
	instrucciones := unaSerieDePasos ! !

!SPlusPlus methodsFor: 'initialization' stamp: 'IF 10/24/2025 12:30:02'!
initializeWithUnaSerieDePasos: unaSerieDePasos conCantidadVariablesLocales: unaCantidadDeVariablesLocales
	instrucciones := unaSerieDePasos.
	variablesLocales := Array new: unaCantidadDeVariablesLocales .
	
	1 to: unaCantidadDeVariablesLocales do: [:pos | variablesLocales at: pos put: 0]! !


!SPlusPlus methodsFor: 'testing' stamp: 'IF 10/24/2025 12:33:20'!
memoriaVariablesLocalesEsIgual: unaCollecionDeValoresEsperadosDeMemoria
	^ unaCollecionDeValoresEsperadosDeMemoria = variablesLocales ! !


!SPlusPlus methodsFor: 'as yet unclassified' stamp: 'IF 10/24/2025 12:56:40'!
decrementarVariableLocalEnPos: unaPosicion
	variablesLocales at: unaPosicion put: (((variablesLocales at: unaPosicion) - 1) max: 0)! !

!SPlusPlus methodsFor: 'as yet unclassified' stamp: 'IF 10/24/2025 12:31:52'!
incrementarVariableLocalEnPos: unaPosicion
	variablesLocales at: unaPosicion put: ((variablesLocales at: unaPosicion) + 1)! !

!SPlusPlus methodsFor: 'as yet unclassified' stamp: 'IF 10/24/2025 12:56:19'!
modificarVariableLocalConInstrucicon: instruccionAAnalizar
	|a numeroDeVariableLocal|
	a := instruccionAAnalizar last: 2.

	a = '++' ifTrue: [
		numeroDeVariableLocal :=  instruccionAAnalizar allButFirst readStream upToAll: '++'.
		self incrementarVariableLocalEnPos: numeroDeVariableLocal asNumber + 1].
	
	a = '--' ifTrue: [
		numeroDeVariableLocal :=  instruccionAAnalizar allButFirst readStream upToAll: '--'.
		self decrementarVariableLocalEnPos: numeroDeVariableLocal asNumber + 1].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SPlusPlus class' category: #TLENG!
SPlusPlus class
	instanceVariableNames: ''!

!SPlusPlus class methodsFor: 'as yet unclassified' stamp: 'IF 10/24/2025 12:10:30'!
crearNuevoProgramaConListaDePasos: unaSerieDePasos
	^ self new initializeWithUnaSerieDePasos: unaSerieDePasos ! !

!SPlusPlus class methodsFor: 'as yet unclassified' stamp: 'IF 10/24/2025 12:26:50'!
crearNuevoProgramaConListaDePasos: unaSerieDePasos conCantidadVariablesLocales: unaCantidadDeVariablesLocales.
	^ self new initializeWithUnaSerieDePasos: unaSerieDePasos conCantidadVariablesLocales: unaCantidadDeVariablesLocales ! !


!classDefinition: #TestRunSPlusPlus category: #TLENG!
TestCase subclass: #TestRunSPlusPlus
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TLENG'!

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'IF 10/24/2025 12:09:56'!
test01
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #().
	self assert: programa run = 0! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'IF 10/24/2025 12:10:51'!
test02
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('y++').
	self assert: programa run = 1! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'IF 10/24/2025 12:11:04'!
test03
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('y++' 'y++').
	self assert: programa run = 2! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'IF 10/24/2025 12:14:43'!
test04
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('y--').
	self assert: programa run = 0! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'IF 10/24/2025 12:14:48'!
test05
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('y++' 'y--').
	self assert: programa run = 0! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'IF 10/24/2025 12:18:03'!
test06
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('y++' 'Z0--') conCantidadVariablesLocales: 1.
	self assert: programa run = 1! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'IF 10/24/2025 12:28:32'!
test07
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('y++' 'Z0--') conCantidadVariablesLocales: 1.
	programa run.
	self deny: (programa memoriaVariablesLocalesEsIgual: #(1)).! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'IF 10/24/2025 12:29:07'!
test08
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('y++' 'Z0++') conCantidadVariablesLocales: 1.
	programa run.
	self assert: (programa memoriaVariablesLocalesEsIgual: #(1)).! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'IF 10/24/2025 12:36:51'!
test09
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('y++' 'Z0++' 'Z1++') conCantidadVariablesLocales: 2.
	programa run.
	self assert: (programa memoriaVariablesLocalesEsIgual: #(1 1)).! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'IF 10/24/2025 12:40:00'!
test10
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('y++' 'Z0++' 'Z2++') conCantidadVariablesLocales: 3.
	programa run.
	self assert: (programa memoriaVariablesLocalesEsIgual: #(1 0 1)).! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'IF 10/24/2025 12:55:48'!
test11
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('y++' 'Z0++' 'Z0--') conCantidadVariablesLocales: 1.
	programa run.
	self assert: (programa memoriaVariablesLocalesEsIgual: #(0)).! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'IF 10/24/2025 12:56:47'!
test12
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('y++' 'Z0++' 'Z0--') conCantidadVariablesLocales: 1.
	programa run.
	self assert: (programa memoriaVariablesLocalesEsIgual: #(0)).! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'IF 10/24/2025 12:59:33'!
test13
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('pass') conCantidadVariablesLocales: 0.
	self assert: programa run = 0.! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'IF 10/24/2025 13:00:16'!
test14
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #() conCantidadVariablesLocales: 1.
	self assert: programa run = 0.! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 17 54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 61 59 56 53 112 116 104 110 108 17 124 117 112 127 17 83 112 117 124 127 39 61 53 56 59 53 55 52 58 58 52 110 108 117 108 121 112 106 17 127 63 61 102 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 100 17 95 56 56 17 92 117 112 127 39 105 124 112 115 123 39 118 117 39 86 106 123 39 39 62 39 57 55 57 60 39 56 59 65 55 63 65 57 62 39 74 118 116 119 112 115 108 121 65 39 60 53 59 53 55 39 57 55 56 61 55 61 55 64 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 93 84 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 84 118 117 39 86 106 123 39 61 39 56 57 65 58 59 65 57 56 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 108 107 58 60 59 63 61 39 87 115 124 110 112 117 122 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 17 48 113 41 17 56 55 53 59 56 53 56 55 61 53 58 59 17 119 106 58 59 53 115 104 105 56 56 55 61 53 115 104 105 118 122 53 109 106 108 117 53 124 105 104 53 104 121 17 119 106 58 59 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 59 91 56 58 65 55 55 65 58 57 53 58 56 62 60 59 59 52 55 58 65 55 55 17 54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 91 83 76 85 78 53 122 123 17 61 62 59 60 17 52 52 52 52 52 52 52 52 52 52 17 17))!