!classDefinition: #Instrucciones category: #TLENG!
Object subclass: #Instrucciones
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TLENG'!


!classDefinition: #Asignaciones category: #TLENG!
Instrucciones subclass: #Asignaciones
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TLENG'!

!Asignaciones methodsFor: 'as yet unclassified' stamp: 'IF 10/26/2025 20:22:33'!
ejecutarInstruccionEnPrograma: unPrograma
	unPrograma ejecutarAsignacion: self.! !


!classDefinition: #While category: #TLENG!
Instrucciones subclass: #While
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TLENG'!

!While methodsFor: 'as yet unclassified' stamp: 'IF 10/26/2025 20:18:45'!
ejecutarInstruccionEnPrograma: unPrograma
	unPrograma correrWhileConInstrucciones: self.! !


!classDefinition: #SPlusPlus category: #TLENG!
Object subclass: #SPlusPlus
	instanceVariableNames: 'instrucciones variablesLocales ret variableAVerificar nombreVariableAVerificar variablesParametros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TLENG'!

!SPlusPlus methodsFor: 'functionality' stamp: 'a 10/24/2025 16:28:14'!
correrWhileConInstrucciones: unSetDeInstrucciones
	 
	nombreVariableAVerificar := unSetDeInstrucciones at: 1.
	self obtenerVariableAModificar.
	
	[variableAVerificar = 0] whileFalse: [
		unSetDeInstrucciones do: [:instruccion | 
			self ejectuarInstruccion: instruccion.
			self obtenerVariableAModificar. ]
	]. 
! !

!SPlusPlus methodsFor: 'functionality' stamp: 'IF 10/26/2025 20:21:57'!
ejectuarInstruccion: unaInstruccion
	
	"unaInstruccion ejecutar."
	(unaInstruccion isKindOf: Array) ifTrue: [
			self correrWhileConInstrucciones: unaInstruccion
	]
	ifFalse: [
		self ejecutarAsignacion: unaInstruccion.
	].
	! !

!SPlusPlus methodsFor: 'functionality' stamp: 'IF 10/26/2025 20:21:57'!
ejecutarAsignacion: unaInstruccion

	self modificarResultadoConInstrucicon: unaInstruccion.
		(unaInstruccion at: 1) = $Z ifTrue: [self modificarVariableLocalConInstrucicon: unaInstruccion].
		(unaInstruccion at: 1) = $X ifTrue: [self modificarVariableParametroConInstrucicon: unaInstruccion ]! !

!SPlusPlus methodsFor: 'functionality' stamp: 'IF 10/26/2025 19:25:36'!
obtenerVariableAModificar
	|aVerificar numeroAObtener|
	aVerificar := nombreVariableAVerificar at: 1.
	aVerificar = $Y 
	ifTrue: [variableAVerificar := ret.]
	ifFalse: [
		numeroAObtener := nombreVariableAVerificar allButFirst asNumber + 1.
		aVerificar = $Z ifTrue: [
			variableAVerificar := variablesLocales at: numeroAObtener
		].
		aVerificar = $X ifTrue: [
			variableAVerificar := variablesParametros at: numeroAObtener
		].
	]! !

!SPlusPlus methodsFor: 'functionality' stamp: 'IF 10/26/2025 18:54:42'!
run
	 ^ self runConParametros: #().! !

!SPlusPlus methodsFor: 'functionality' stamp: 'IF 10/26/2025 18:25:03'!
runConParametros: valoresDeParametros
	 variablesParametros := valoresDeParametros copy.
	
	ret := 0.
	instrucciones do: [ :instruccion | 
		self ejectuarInstruccion: instruccion.
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


!SPlusPlus methodsFor: 'testing' stamp: 'IF 10/26/2025 18:46:37'!
memoriaParametrosEsIgual: unaCollecionDeValoresEsperadosDeMemoria
	^ unaCollecionDeValoresEsperadosDeMemoria = variablesParametros ! !

!SPlusPlus methodsFor: 'testing' stamp: 'IF 10/24/2025 12:33:20'!
memoriaVariablesLocalesEsIgual: unaCollecionDeValoresEsperadosDeMemoria
	^ unaCollecionDeValoresEsperadosDeMemoria = variablesLocales ! !


!SPlusPlus methodsFor: 'as yet unclassified' stamp: 'IF 10/26/2025 19:55:09'!
decrementarResultado
	ret := self decrementarValor: ret! !

!SPlusPlus methodsFor: 'as yet unclassified' stamp: 'IF 10/26/2025 19:54:58'!
decrementarValor: valor
	^ (valor - 1) max: 0! !

!SPlusPlus methodsFor: 'as yet unclassified' stamp: 'IF 10/26/2025 19:55:43'!
decrementarVariableLocalEnPos: unaPosicion
	variablesLocales at: unaPosicion put: (self decrementarValor: (variablesLocales at: unaPosicion)) "(( - 1) max: 0)"! !

!SPlusPlus methodsFor: 'as yet unclassified' stamp: 'IF 10/26/2025 20:04:01'!
decrementarVariableParametroEnPos: unaPosicion
	variablesParametros at: unaPosicion put: (self decrementarValor: (variablesParametros at: unaPosicion)).! !

!SPlusPlus methodsFor: 'as yet unclassified' stamp: 'IF 10/26/2025 20:04:32'!
incrementarResultado
	ret := self incrementarValor: ret! !

!SPlusPlus methodsFor: 'as yet unclassified' stamp: 'IF 10/26/2025 20:04:20'!
incrementarValor: valor
	^ valor + 1! !

!SPlusPlus methodsFor: 'as yet unclassified' stamp: 'IF 10/26/2025 20:05:06'!
incrementarVariableLocalEnPos: unaPosicion
	variablesLocales at: unaPosicion put: (self incrementarValor: (variablesLocales at: unaPosicion))! !

!SPlusPlus methodsFor: 'as yet unclassified' stamp: 'IF 10/26/2025 20:05:23'!
incrementarVariableParametroEnPos: unaPosicion
	variablesParametros at: unaPosicion put: (self incrementarValor: (variablesParametros at: unaPosicion))! !

!SPlusPlus methodsFor: 'as yet unclassified' stamp: 'IF 10/26/2025 19:20:39'!
modificarResultadoConInstrucicon: instruccionAAnalizar
	
	instruccionAAnalizar = 'Y++' ifTrue: [
		self incrementarResultado].
	
	instruccionAAnalizar = 'Y--' ifTrue: [
		self decrementarResultado].! !

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

!SPlusPlus methodsFor: 'as yet unclassified' stamp: 'IF 10/26/2025 18:49:40'!
modificarVariableParametroConInstrucicon: instruccionAAnalizar
	|a numeroDeVariableParametro|
	a := instruccionAAnalizar last: 2.
	a = '++' ifTrue: [
		numeroDeVariableParametro :=  instruccionAAnalizar allButFirst readStream upToAll: '++'.
		self incrementarVariableParametroEnPos: numeroDeVariableParametro asNumber + 1].
	
	a = '--' ifTrue: [
		numeroDeVariableParametro :=  instruccionAAnalizar allButFirst readStream upToAll: '--'.
		self decrementarVariableParametroEnPos: numeroDeVariableParametro asNumber + 1].! !

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

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'a 10/24/2025 15:46:55'!
test02
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('Y++').
	self assert: programa run = 1! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'a 10/24/2025 15:46:51'!
test03
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('Y++' 'Y++').
	self assert: programa run = 2! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'a 10/24/2025 15:46:45'!
test04
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('Y--').
	self assert: programa run = 0! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'a 10/24/2025 15:46:41'!
test05
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('Y++' 'Y--').
	self assert: programa run = 0! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'a 10/24/2025 15:46:35'!
test06
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('Y++' 'Z0--') conCantidadVariablesLocales: 1.
	self assert: programa run = 1! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'a 10/24/2025 15:46:32'!
test07
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('Y++' 'Z0--') conCantidadVariablesLocales: 1.
	programa run.
	self deny: (programa memoriaVariablesLocalesEsIgual: #(1)).! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'a 10/24/2025 15:46:28'!
test08
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('Y++' 'Z0++') conCantidadVariablesLocales: 1.
	programa run.
	self assert: (programa memoriaVariablesLocalesEsIgual: #(1)).! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'a 10/24/2025 15:46:14'!
test09
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('Y++' 'Z0++' 'Z1++') conCantidadVariablesLocales: 2.
	programa run.
	self assert: (programa memoriaVariablesLocalesEsIgual: #(1 1)).! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'a 10/24/2025 15:46:18'!
test10
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('Y++' 'Z0++' 'Z2++') conCantidadVariablesLocales: 3.
	programa run.
	self assert: (programa memoriaVariablesLocalesEsIgual: #(1 0 1)).! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'a 10/24/2025 16:16:16'!
test11
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('Y++' 'Z0' 'Z0--' 'Y--') conCantidadVariablesLocales: 1.
	programa run.
	self assert: (programa memoriaVariablesLocalesEsIgual: #(0)).! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'a 10/24/2025 15:05:53'!
test12
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('pass') conCantidadVariablesLocales: 0.
	self assert: programa run = 0.! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'a 10/24/2025 16:18:34'!
test13
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('Y++' #('Y' 'Y--')) conCantidadVariablesLocales: 1.
	self assert: programa run = 0.! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'a 10/24/2025 16:16:21'!
test14
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('Y++' #('Y' 'Y--' 'Z0++')) conCantidadVariablesLocales: 1.
	self assert: programa run = 0.
	self assert: (programa memoriaVariablesLocalesEsIgual: #(1)).! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'a 10/24/2025 16:16:28'!
test15
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('Y++' #('Y' 'Y--' 'Z0++' 'Z1++')) conCantidadVariablesLocales: 2.
	self assert: programa run = 0.
	self assert: (programa memoriaVariablesLocalesEsIgual: #(1 1)).! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'a 10/24/2025 16:24:37'!
test16
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('Y++'  'Y++'  #('Y' 'Y--' 'Z0++')) conCantidadVariablesLocales: 2.
	self assert: programa run = 0.
	self assert: (programa memoriaVariablesLocalesEsIgual: #(2 0)).! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'a 10/24/2025 16:28:40'!
test17
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('Z1++'  'Z1++'  #('Z1' 'Y++' 'Z1--')) conCantidadVariablesLocales: 2.
	self assert: programa run = 2.
	self assert: (programa memoriaVariablesLocalesEsIgual: #(0 0)).! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'IF 10/26/2025 18:29:12'!
test18
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #(#('X0' 'Y++' 'X0--')) conCantidadVariablesLocales: 0.
	self assert: (programa runConParametros: #(1)) = 1.
	self assert: (programa memoriaVariablesLocalesEsIgual: #()).
	self assert: (programa memoriaParametrosEsIgual: #(0)).! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'IF 10/26/2025 18:45:09'!
test19
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #(#('X0' 'Y++' 'X0--') 'X0++') conCantidadVariablesLocales: 0.
	self assert: (programa runConParametros: #(1)) = 1.
	self assert: (programa memoriaVariablesLocalesEsIgual: #()).
	self deny: (programa memoriaParametrosEsIgual: #(0)).! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'IF 10/26/2025 18:52:59'!
test20
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('X0--') conCantidadVariablesLocales: 0.
	self assert: (programa runConParametros: #(0)) = 0.
	self assert: (programa memoriaVariablesLocalesEsIgual: #()).
	self assert: (programa memoriaParametrosEsIgual: #(0)).! !

!TestRunSPlusPlus methodsFor: 'tests' stamp: 'IF 10/26/2025 18:53:53'!
test21
	|programa|
	programa := SPlusPlus crearNuevoProgramaConListaDePasos: #('X1++') conCantidadVariablesLocales: 0.
	self assert: (programa runConParametros: #(0 0)) = 0.
	self assert: (programa memoriaVariablesLocalesEsIgual: #()).
	self assert: (programa memoriaParametrosEsIgual: #(0 1)).! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(74 65 99 92 122 108 121 122 99 110 104 127 112 99 75 118 106 124 116 108 117 123 122 99 80 117 110 108 99 126 112 117 107 118 126 122 61 59 52 56 99 126 112 117 107 118 126 122 61 59 17 74 65 99 92 122 108 121 122 99 110 104 127 112 99 75 118 106 124 116 108 117 123 122 99 80 117 110 108 99 126 112 117 107 118 126 122 61 59 52 56 99 126 112 117 107 118 126 122 61 59 99 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 61 59 56 53 112 116 104 110 108 17 94 112 117 58 57 17 61 53 57 17 95 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 100 17 94 112 117 107 118 126 122 17 94 112 117 58 57 39 105 124 112 115 123 39 118 117 39 84 104 121 39 39 56 39 57 55 57 60 39 55 56 65 55 59 65 57 57 39 78 84 91 39 74 118 116 119 112 115 108 121 65 39 59 53 57 53 56 39 74 118 116 119 104 123 112 105 115 108 39 74 115 104 117 110 39 63 53 55 53 56 39 47 123 104 110 122 54 89 76 83 76 72 90 76 102 63 55 56 54 109 112 117 104 115 48 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 84 104 121 39 39 56 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 84 104 121 39 39 56 39 57 55 57 60 17 93 84 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 84 118 117 39 86 106 123 39 61 39 56 57 65 58 59 65 57 56 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 108 107 58 60 59 63 61 39 87 115 124 110 112 117 122 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 179 33 247 8 17 56 62 57 53 57 61 53 57 59 55 53 56 17 75 76 90 82 91 86 87 52 56 55 79 85 92 72 78 53 116 122 111 118 116 108 53 117 108 123 17 75 76 90 82 91 86 87 52 56 55 79 85 92 72 78 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 58 91 55 64 65 56 60 65 55 58 53 58 63 64 60 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 110 104 127 112 99 75 118 106 124 116 108 117 123 122 99 80 117 110 108 99 126 112 117 107 118 126 122 61 59 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 90 124 107 118 114 124 90 118 115 125 108 121 91 108 122 123 60 53 122 123 17 57 60 57 57 59 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 61 91 56 63 65 59 59 65 57 60 53 64 60 61 61 56 57 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 110 104 127 112 99 75 118 106 124 116 108 117 123 122 99 80 117 110 108 99 126 112 117 107 118 126 122 61 59 52 56 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 91 83 76 85 78 53 122 123 17 56 60 57 62 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 61 91 56 64 65 60 58 65 58 63 53 56 59 58 61 56 57 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 110 104 127 112 99 75 118 106 124 116 108 117 123 122 99 80 117 110 108 99 126 112 117 107 118 126 122 61 59 52 56 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 91 83 76 85 78 102 121 108 109 104 106 123 118 121 112 129 104 107 118 102 109 104 106 112 115 53 122 123 17 56 62 62 59 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 61 91 57 55 65 55 63 65 55 59 53 63 55 59 61 56 57 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 110 104 127 112 99 75 118 106 124 116 108 117 123 122 99 80 117 110 108 99 126 112 117 107 118 126 122 61 59 52 56 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 91 83 76 85 78 56 53 122 123 17 56 64 59 56 59 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 58 91 56 55 65 57 60 65 60 60 53 62 62 60 64 58 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 110 104 127 112 99 75 118 106 124 116 108 117 123 122 99 80 117 110 108 99 126 112 117 107 118 126 122 61 59 52 56 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 90 124 107 118 114 124 90 118 115 125 108 121 91 108 122 123 61 53 122 123 17 57 56 57 59 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 61 91 56 63 65 60 62 65 56 64 53 60 57 64 61 56 57 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 110 104 127 112 99 75 118 106 124 116 108 117 123 122 99 80 117 110 108 99 126 112 117 107 118 126 122 61 59 52 56 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 91 83 76 85 78 102 109 112 117 112 122 111 53 122 123 17 56 56 62 59 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 61 91 56 64 65 57 61 65 55 63 53 56 57 57 61 56 57 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 110 104 127 112 99 75 118 106 124 116 108 117 123 122 99 80 117 110 108 99 126 112 117 107 118 126 122 61 59 52 56 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 91 83 76 85 78 102 121 108 109 104 106 123 118 121 112 129 104 107 118 102 109 104 106 112 115 53 122 123 17 56 57 58 61 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 61 91 56 64 65 60 56 65 59 55 53 62 57 62 61 56 57 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 110 104 127 112 99 75 118 106 124 116 108 117 123 122 99 80 117 110 108 99 126 112 117 107 118 126 122 61 59 52 56 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 91 83 76 85 78 102 119 121 108 90 104 106 104 121 80 109 53 122 123 17 56 57 59 60 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 61 91 57 55 65 55 61 65 55 60 53 59 55 57 61 56 57 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 110 104 127 112 99 75 118 106 124 116 108 117 123 122 99 80 117 110 108 99 126 112 117 107 118 126 122 61 59 52 56 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 91 83 76 85 78 56 53 122 123 17 56 57 61 55 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 61 91 57 55 65 57 58 65 56 64 53 60 60 55 61 56 57 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 110 104 127 112 99 75 118 106 124 116 108 117 123 122 99 80 117 110 108 99 126 112 117 107 118 126 122 61 59 52 56 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 91 83 76 85 78 57 53 122 123 17 56 58 61 57 62 17 52 52 52 52 52 52 52 52 52 52 17 17))!