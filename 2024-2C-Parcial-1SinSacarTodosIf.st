!classDefinition: #Aventurero category: #'2024-2C-Parcial-1'!
Object subclass: #Aventurero
	instanceVariableNames: 'fuerza vida defensa itemsDeAtaque'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Aventurero methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 21:18:04'!
atacadoConPV: PVMonstruo
	vida := vida - (0 max: (PVMonstruo - defensa)).! !

!Aventurero methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 21:16:33'!
atacarA: unMonstruo con: unItemDeAtaque
	self subclassResponsibility ! !

!Aventurero methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 21:48:44'!
equiparItemDeAtaque: elItemDeAtaqueAEquipar
	itemsDeAtaque add: elItemDeAtaqueAEquipar .! !

!Aventurero methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 20:55:01'!
equiparItemDeDefensa: anItemDeDefensa
	defensa := defensa + anItemDeDefensa proteccionOtorgada.! !

!Aventurero methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 21:24:44'!
initialize
	defensa := 0 * pv.
	itemsDeAtaque := Set new.! !

!Aventurero methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 22:18:18'!
perderTodosLosPuntosDeVida
	vida := 0! !

!Aventurero methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 20:41:28'!
tienePuntosDeVida: puntosDeVida
	^ puntosDeVida = vida.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Aventurero class' category: #'2024-2C-Parcial-1'!
Aventurero class
	instanceVariableNames: ''!

!Aventurero class methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 20:20:50'!
crearGuerrero
	^ Guerrero new initialize! !

!Aventurero class methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 20:20:59'!
crearMago
	^ Mago new initialize! !


!classDefinition: #Guerrero category: #'2024-2C-Parcial-1'!
Aventurero subclass: #Guerrero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Guerrero methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 21:18:34'!
atacadoConPV: PVMonstruo
	super atacadoConPV: PVMonstruo.
	! !

!Guerrero methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 22:36:34'!
atacarA: unMonstruo con: unItemDeAtaque
	(itemsDeAtaque includes: unItemDeAtaque) 
	ifFalse: [self error: self itemNoDisponibleMensajeDeError ].
	
	(unItemDeAtaque class = Espada
	and: [unItemDeAtaque monstruoObjetivo = unMonstruo])
	ifTrue: [unMonstruo  dañadoConPuntosVida: fuerza ].

	
	(unItemDeAtaque class = Espada
	and: [unItemDeAtaque monstruoObjetivo !!= unMonstruo])
	ifTrue: [].
	
	(unItemDeAtaque class = Báculo
	and: [unMonstruo class = Goblin])
	ifTrue: [unMonstruo duplicarVida ].
	
	(unItemDeAtaque class = Báculo
	and: [unMonstruo class !!= Goblin])
	ifTrue: [unMonstruo dañadoConPuntosVida: fuerza].	
	! !

!Guerrero methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 21:01:51'!
equiparItemDeDefensa: anItemDeDefensa
	super equiparItemDeDefensa: anItemDeDefensa .! !

!Guerrero methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 21:01:29'!
initialize
	vida :=  10 * pv.
	fuerza := 4 * pv.
	super initialize.! !

!Guerrero methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 21:24:01'!
itemNoDisponibleMensajeDeError
	^ 'El aventurero no tiene este item de ataque'! !

!Guerrero methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 22:18:28'!
perderTodosLosPuntosDeVida
	super perderTodosLosPuntosDeVida
	! !


!classDefinition: #Mago category: #'2024-2C-Parcial-1'!
Aventurero subclass: #Mago
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Mago methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 21:18:40'!
atacadoConPV: PVMonstruo
	super atacadoConPV: PVMonstruo.! !

!Mago methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 22:27:51'!
atacarA: unMonstruo con: unItemDeAtaque
	(unItemDeAtaque class = Espada
	and: [unItemDeAtaque monstruoObjetivo = unMonstruo])
	ifTrue: [self perderTodosLosPuntosDeVida ].
	
	(unItemDeAtaque class = Báculo
	and: [unMonstruo class = Goblin])
	ifTrue: [unMonstruo perderTodosLosPuntosDeVida ].
	
	(unItemDeAtaque class = Báculo
	and: [unMonstruo class !!= Goblin])
	ifTrue: [unMonstruo dañadoConPuntosVida: fuerza].! !

!Mago methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 21:02:02'!
equiparItemDeDefensa: anItemDeDefensa
	super equiparItemDeDefensa: anItemDeDefensa .! !

!Mago methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 21:01:38'!
initialize
	vida :=  15 * pv.
	fuerza := 2 * pv.
	super initialize.! !

!Mago methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 22:18:24'!
perderTodosLosPuntosDeVida
	super perderTodosLosPuntosDeVida
	! !


!classDefinition: #ItemsDelJuego category: #'2024-2C-Parcial-1'!
Object subclass: #ItemsDelJuego
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!


!classDefinition: #ItemsDeAtaque category: #'2024-2C-Parcial-1'!
ItemsDelJuego subclass: #ItemsDeAtaque
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ItemsDeAtaque class' category: #'2024-2C-Parcial-1'!
ItemsDeAtaque class
	instanceVariableNames: ''!

!ItemsDeAtaque class methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 20:52:12'!
crearBaculo
	^ Báculo new initialize.! !

!ItemsDeAtaque class methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 21:32:56'!
crearEspadaPara: elMonstruoDestinado
	^ Espada new initializeFor: elMonstruoDestinado.! !


!classDefinition: #Báculo category: #'2024-2C-Parcial-1'!
ItemsDeAtaque subclass: #Báculo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Báculo methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 20:52:41'!
initialize
	! !


!classDefinition: #Espada category: #'2024-2C-Parcial-1'!
ItemsDeAtaque subclass: #Espada
	instanceVariableNames: 'monstruoDestinada'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Espada methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 22:39:17'!
initializeFor: elMonstruoDestinado
	
	(elMonstruoDestinado altura < (100 * centimeter) ) 
	ifTrue: [self error: Espada noSePuedeAtacarAMonstruoMenorAUnMetroDeAlturaMensajeDeError ]. 

	monstruoDestinada := elMonstruoDestinado.! !

!Espada methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 22:12:01'!
monstruoObjetivo
	^ monstruoDestinada.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Espada class' category: #'2024-2C-Parcial-1'!
Espada class
	instanceVariableNames: ''!

!Espada class methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 22:32:32'!
noSePuedeAtacarAMonstruoMenorAUnMetroDeAlturaMensajeDeError
	^ 'La espada no puede atacar a monstruos de menos de un metro de altura'.! !


!classDefinition: #ItemsDeDefensa category: #'2024-2C-Parcial-1'!
ItemsDelJuego subclass: #ItemsDeDefensa
	instanceVariableNames: 'proteccionDeDefensa'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!ItemsDeDefensa methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 20:52:56'!
initialize
	self subclassResponsibility ! !

!ItemsDeDefensa methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 20:54:50'!
proteccionOtorgada
	^ proteccionDeDefensa .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ItemsDeDefensa class' category: #'2024-2C-Parcial-1'!
ItemsDeDefensa class
	instanceVariableNames: ''!

!ItemsDeDefensa class methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 20:51:42'!
crearArmadura
	^ Armadura new initialize.! !

!ItemsDeDefensa class methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 20:51:54'!
crearEscudoMagico
	^ EscudoMagico new initialize.! !


!classDefinition: #Armadura category: #'2024-2C-Parcial-1'!
ItemsDeDefensa subclass: #Armadura
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Armadura methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 20:51:16'!
initialize
	proteccionDeDefensa := 5 * pv. ! !

!Armadura methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 21:08:38'!
proteccionOtorgada
	^super proteccionOtorgada ! !


!classDefinition: #EscudoMagico category: #'2024-2C-Parcial-1'!
ItemsDeDefensa subclass: #EscudoMagico
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!EscudoMagico methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 20:53:07'!
initialize
	proteccionDeDefensa := 3 * pv. ! !

!EscudoMagico methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 21:08:32'!
proteccionOtorgada
	^super proteccionOtorgada ! !


!classDefinition: #Monstruo category: #'2024-2C-Parcial-1'!
Object subclass: #Monstruo
	instanceVariableNames: 'altura PV'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Monstruo methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 22:33:24'!
altura
	^ altura ! !

!Monstruo methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 21:09:34'!
atacarA: aventurero
	aventurero atacadoConPV: PV ! !

!Monstruo methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 22:04:27'!
dañadoConPuntosVida: puntosVida
	PV := PV - puntosVida .! !

!Monstruo methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 22:29:19'!
duplicarVida
	PV := PV * 2.! !

!Monstruo methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 22:23:29'!
perderTodosLosPuntosDeVida
	PV := 0.! !

!Monstruo methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 21:35:27'!
tienePuntosDeVida: puntosDeVidaEsperado
	^ puntosDeVidaEsperado = PV.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Monstruo class' category: #'2024-2C-Parcial-1'!
Monstruo class
	instanceVariableNames: ''!

!Monstruo class methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 20:20:16'!
crearGoblin
	^ Goblin new initialize! !

!Monstruo class methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 20:20:35'!
crearOgro
	^ Ogro new initialize! !


!classDefinition: #Goblin category: #'2024-2C-Parcial-1'!
Monstruo subclass: #Goblin
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Goblin methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 22:33:33'!
altura
	^  super altura ! !

!Goblin methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 21:09:54'!
atacarA: aventurero
	super atacarA: aventurero ! !

!Goblin methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 22:04:42'!
dañadoConPuntosVida: puntosVida
	super dañadoConPuntosVida: puntosVida! !

!Goblin methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 22:29:42'!
duplicarVida 
	super duplicarVida ! !

!Goblin methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 20:40:58'!
initialize
	altura := 90 * centimeter .
	PV := 5 * pv.! !

!Goblin methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 22:26:43'!
perderTodosLosPuntosDeVida
	super perderTodosLosPuntosDeVida
	! !

!Goblin methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 21:35:50'!
tienePuntosDeVida: puntosDeVidaEsperado
	^ super tienePuntosDeVida: puntosDeVidaEsperado.! !


!classDefinition: #Ogro category: #'2024-2C-Parcial-1'!
Monstruo subclass: #Ogro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Ogro methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 22:33:36'!
altura
	^  super altura ! !

!Ogro methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 21:10:00'!
atacarA: aventurero
	super atacarA: aventurero ! !

!Ogro methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 22:04:46'!
dañadoConPuntosVida: puntosVida
	super dañadoConPuntosVida: puntosVida! !

!Ogro methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 22:29:45'!
duplicarVida 
	super duplicarVida ! !

!Ogro methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 20:41:02'!
initialize
	altura := 220 * centimeter .
	PV := 15  * pv.! !

!Ogro methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 22:26:48'!
perderTodosLosPuntosDeVida
	super perderTodosLosPuntosDeVida
	! !

!Ogro methodsFor: 'as yet unclassified' stamp: 'k 9/28/2025 21:35:53'!
tienePuntosDeVida: puntosDeVidaEsperado
	^ super tienePuntosDeVida: puntosDeVidaEsperado.! !


!classDefinition: #TestMyA category: #'2024-2C-Parcial-1'!
TestCase subclass: #TestMyA
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!TestMyA methodsFor: 'tests' stamp: 'k 9/28/2025 20:41:33'!
test01UnMonstruoAtacaAUnAventureroUsandoSusPVs

	| guerrero |
	
	guerrero := self crearGuerrero.
	
	self crearGoblin atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 10 * pv - (5 * pv))! !

!TestMyA methodsFor: 'tests' stamp: 'k 9/28/2025 20:53:11'!
test02UnAventureroPuedeUsarItemsDeDefensaParaProtegerse

	| guerrero |
	
	guerrero := self crearGuerrero.
	guerrero equiparItemDeDefensa: self crearEscudoMagico.
	guerrero equiparItemDeDefensa: self crearArmadura.
	
	self crearOgro atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 10 * pv - (15 * pv - (5 * pv) - (3 * pv)))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:35'!
test03LosItemsDeDefensaNoPuedenAumentarLosPuntosDeVidaDelAventurero

	| guerrero |
	
	guerrero := self crearGuerrero.
	guerrero equiparItemDeDefensa: self crearArmadura.
	guerrero equiparItemDeDefensa: self crearArmadura.
	
	self crearGoblin atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 10 * pv)! !

!TestMyA methodsFor: 'tests' stamp: 'k 9/28/2025 21:28:48'!
test04UnAventureroNoPuedeAtacarSinItemsEquipados

	| guerrero ogro espada |
	
	guerrero := self crearGuerrero.
	ogro := self crearOgro.
	espada := self crearEspadaPara: ogro.
	
	self should: [ guerrero atacarA: ogro con: (espada) ] 
		raise: Error-MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: guerrero itemNoDisponibleMensajeDeError.
			self assert: (ogro tienePuntosDeVida: 15 * pv)
	]
	! !

!TestMyA methodsFor: 'tests' stamp: 'k 9/28/2025 21:48:54'!
test05UnGuerreroConEspadaProvocaDañoSegunSuFuerza

	| guerrero ogro itemDeAtaque otroItemDeAtaque otroOgro |
	
	guerrero := self crearGuerrero.
	ogro := self crearOgro.
	itemDeAtaque := self crearEspadaPara: ogro.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	otroOgro := self crearOgro.
	otroItemDeAtaque := self crearEspadaPara: otroOgro.
	guerrero equiparItemDeAtaque: otroItemDeAtaque.
	
	guerrero atacarA: ogro con: itemDeAtaque.
	guerrero atacarA: otroOgro con: otroItemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv - (4 * pv)).
	self assert: (otroOgro tienePuntosDeVida: 15 * pv - (4 * pv)).
	self assert: (guerrero tienePuntosDeVida: 10 * pv)! !

!TestMyA methodsFor: 'tests' stamp: 'HAW 9/27/2024 09:46:06'!
test06UnGuerreroConEspadaNoProvocaDañoAOtroMonstruoQueNoSeaElDeLaEspada

	| guerrero ogroNoObjetivoDeAtaque itemDeAtaque ogroObjetivoDeAtaque |
	
	guerrero := self crearGuerrero.
	ogroObjetivoDeAtaque := self crearOgro.
	itemDeAtaque := self crearEspadaPara: ogroObjetivoDeAtaque.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	ogroNoObjetivoDeAtaque := self crearOgro.
	
	guerrero atacarA: ogroNoObjetivoDeAtaque con: itemDeAtaque.
	
	self assert: (ogroNoObjetivoDeAtaque tienePuntosDeVida: 15 * pv)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:52'!
test07UnAventureroNoGuerreroPierdeTodosSusPuntosDeVidaSiUsaLaEspada

	| ogro mago itemDeAtaque |
	
	mago := self crearMago.
	ogro := self crearOgro.
	itemDeAtaque := self crearEspadaPara: ogro.
	mago equiparItemDeAtaque: itemDeAtaque.
	
	mago atacarA: ogro con: itemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv).
	self assert: (mago tienePuntosDeVida: 0)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:49'!
test08ElMagoUsandoElBaculoMataAlGoblin

	| mago goblin itemDeAtaque |
	
	mago := self crearMago.
	itemDeAtaque := self crearBaculo.
	mago equiparItemDeAtaque: itemDeAtaque.
	goblin :=  self crearGoblin.
	
	mago atacarA: goblin con: itemDeAtaque.
	
	self assert: (goblin tienePuntosDeVida: 0)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:42:13'!
test09ElMagoUsandoElBaculoDañaAOtrosMonstruosSegunSuFuerza

	| mago ogro itemDeAtaque |
	
	mago := self crearMago.
	itemDeAtaque := self crearBaculo.
	mago equiparItemDeAtaque: itemDeAtaque.
	ogro := self crearOgro.
	
	mago atacarA: ogro con: itemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv - (2 * pv))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:45'!
test10UnAventureroNoMagoEsPenalizadoAlUsarElBaculoDuplicandoPVDeGoblins

	| guerrero goblin itemDeAtaque |
	
	guerrero := self crearGuerrero.
	itemDeAtaque := self crearBaculo.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	goblin := self crearGoblin.
	
	guerrero atacarA: goblin con: itemDeAtaque.
	
	self assert: (goblin tienePuntosDeVida: 5 * pv * 2)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:38'!
test11UnAventureroNoMagoUsandoElBaculoDañaSegunSuFuerzaAOtrosMonstruos

	| guerrero ogro itemDeAtaque |
	
	guerrero := self crearGuerrero.
	itemDeAtaque := self crearBaculo.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	ogro := self crearOgro.
	
	guerrero atacarA: ogro con: itemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv - (4 * pv))! !

!TestMyA methodsFor: 'tests' stamp: 'k 9/28/2025 22:39:28'!
test12UnaEspadaNuncaPuedeSerUsadaEnMonstruosDeMenosDeUnMetro

	| goblin |
	
	goblin := self crearGoblin.
	
	self should: [
		self crearEspadaPara: goblin ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
		self assert: anException messageText equals: Espada noSePuedeAtacarAMonstruoMenorAUnMetroDeAlturaMensajeDeError
	]
	! !


!TestMyA methodsFor: 'crear items' stamp: 'k 9/28/2025 21:04:27'!
crearArmadura

	^ ItemsDeDefensa crearArmadura ! !

!TestMyA methodsFor: 'crear items' stamp: 'k 9/28/2025 21:04:42'!
crearBaculo
	
	^ ItemsDeAtaque crearBaculo ! !

!TestMyA methodsFor: 'crear items' stamp: 'k 9/28/2025 21:04:10'!
crearEscudoMagico

	^ ItemsDeDefensa crearEscudoMagico 
! !

!TestMyA methodsFor: 'crear items' stamp: 'k 9/28/2025 21:33:39'!
crearEspadaPara: monstruo
	^ ItemsDeAtaque crearEspadaPara: monstruo
! !


!TestMyA methodsFor: 'crear combatientes' stamp: 'k 9/28/2025 20:27:04'!
crearGoblin
	^Monstruo crearGoblin.! !

!TestMyA methodsFor: 'crear combatientes' stamp: 'k 9/28/2025 20:26:43'!
crearGuerrero
	^ Aventurero crearGuerrero.! !

!TestMyA methodsFor: 'crear combatientes' stamp: 'k 9/28/2025 20:29:09'!
crearMago
	^ Aventurero crearMago. 
! !

!TestMyA methodsFor: 'crear combatientes' stamp: 'k 9/28/2025 20:29:24'!
crearOgro
	^ Monstruo crearOgro.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TestMyA class' category: #'2024-2C-Parcial-1'!
TestMyA class
	instanceVariableNames: ''!

!TestMyA class methodsFor: 'initialization' stamp: 'LL 9/26/2024 20:21:50'!
initialize

	Smalltalk at: #pv put: (BaseUnit named: 'pv' sign: 'pv')! !

TestMyA initialize!