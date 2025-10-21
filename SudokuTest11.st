!classDefinition: #Sudoku category: #Sudoku!
Object subclass: #Sudoku
	instanceVariableNames: 'board juegoCorrecto'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Sudoku'!

!Sudoku methodsFor: 'initialization' stamp: 'Iñaki Frutos 10/21/2025 15:40:37'!
initializeWithSudokuBoard: anSudokuBoard
	board := anSudokuBoard ! !


!Sudoku methodsFor: 'functionality' stamp: 'k 10/21/2025 17:50:46'!
esJuegoCorrecto
	 
	juegoCorrecto := true.
	self tienenRepetidosFilas.
	
	self tienenRepetidosColumnas.
	
	self tienenRepetidosEnSubcuadriculas.
	
	^ juegoCorrecto! !

!Sudoku methodsFor: 'functionality' stamp: 'k 10/21/2025 18:35:49'!
obtenerElementosSubcuadriculaX: xSubcuadricula Y: ySubcuadricula 
	|elementos posX posY tamañoSubcuadricula|
	elementos  := OrderedCollection new.
	tamañoSubcuadricula := board size sqrt.
	posX := (xSubcuadricula * tamañoSubcuadricula) - 1.
	posY := (ySubcuadricula * tamañoSubcuadricula) - 1.
	
	(posX to: (posX + tamañoSubcuadricula - 1)) do: [:x |
		(posY to: (posY + tamañoSubcuadricula - 1)) do: [:y |
			elementos add: ((board at: x) at: y)
		].
	].
	^ elementos! !

!Sudoku methodsFor: 'functionality' stamp: 'k 10/21/2025 17:12:48'!
tieneReptidos: fila
	|apariciones|
	apariciones := Bag new.
	fila do: [:celda | apariciones add: celda].
	apariciones do: [:aparicion | 
		(apariciones occurrencesOf: aparicion) > 1 ifTrue: [^ true]].
	^ false! !

!Sudoku methodsFor: 'functionality' stamp: 'k 10/21/2025 17:46:07'!
tienenRepetidosColumnas
	|size columna|
	size := board size.
	
	1 to: size do: [ :x |
		columna := OrderedCollection new.
		1 to: size do: [ :y |
			columna add: ((board at: y) at: x).
		].
		self verificarRepetidosEnJuego: columna.
	].
! !

!Sudoku methodsFor: 'functionality' stamp: 'k 10/21/2025 18:29:35'!
tienenRepetidosEnSubcuadriculas
	|tamañoSubcuadricula subcuadricula|
	tamañoSubcuadricula := board size sqrt .
	
	1 to: tamañoSubcuadricula do: [:xSubcuadricula |
		1 to: tamañoSubcuadricula  do: [ :ySubcuadricula | 
			subcuadricula := self obtenerElementosSubcuadriculaX: xSubcuadricula Y: ySubcuadricula.
			self verificarRepetidosEnJuego: subcuadricula 
		]
	]! !

!Sudoku methodsFor: 'functionality' stamp: 'k 10/21/2025 17:46:29'!
tienenRepetidosFilas

	^ board do: [:fila |
		self verificarRepetidosEnJuego: fila.
	]! !

!Sudoku methodsFor: 'functionality' stamp: 'k 10/21/2025 17:46:07'!
verificarRepetidosEnJuego: aVerificar

	^ (self tieneReptidos: aVerificar) ifTrue: [juegoCorrecto := false]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sudoku class' category: #Sudoku!
Sudoku class
	instanceVariableNames: ''!

!Sudoku class methodsFor: 'as yet unclassified' stamp: 'k 10/21/2025 16:57:26'!
nuevoJuego: unPosibleSudoku
	|size|
	size := unPosibleSudoku size.
	size = 0 ifTrue: [self error: 'Al menos tiene que haber una fila' ].
	
	
	
	unPosibleSudoku do: [:fila |
		fila size = 0 ifTrue: [self error: 'Todas las filas tienen que tener al menos un elemento'].
		fila do: [:celdaFila |
			celdaFila <= 0 ifTrue: [self error: 'Todos los números deben ser mayores a 1'].
		].
	].

	unPosibleSudoku do: [:fila | 
		fila size = size ifFalse: [self error: 'Board debe ser un cuadrado' ].
	].
	
	(size sqrt isKindOf: Integer) ifFalse: [self error: 'Board tiene que tener como tamaño un numero cuadrado'].

	^ self new initializeWithSudokuBoard: unPosibleSudoku ! !


!classDefinition: #TestSudoku category: #Sudoku!
TestCase subclass: #TestSudoku
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Sudoku'!

!TestSudoku methodsFor: 'test' stamp: 'Iñaki Frutos 10/21/2025 15:38:47'!
test01
	|sudoku|
	sudoku := Sudoku nuevoJuego: #(#(1)).
	self assert: (sudoku esJuegoCorrecto).! !

!TestSudoku methodsFor: 'test' stamp: 'Iñaki Frutos 10/21/2025 15:52:44'!
test02
	self 
		should: [ Sudoku nuevoJuego: #(#(0)) ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: 'Todos los números deben ser mayores a 1' ]! !

!TestSudoku methodsFor: 'test' stamp: 'Iñaki Frutos 10/21/2025 16:01:10'!
test03
	self 
		should: [ Sudoku nuevoJuego: #(#(1 2)
			                                               #(2 0)) ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: 'Todos los números deben ser mayores a 1' ]! !

!TestSudoku methodsFor: 'test' stamp: 'Iñaki Frutos 10/21/2025 16:01:26'!
test04
	self 
		should: [ Sudoku nuevoJuego: #() ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: 'Al menos tiene que haber una fila' ]! !

!TestSudoku methodsFor: 'test' stamp: 'Iñaki Frutos 10/21/2025 16:05:04'!
test05
	self 
		should: [ Sudoku nuevoJuego: #(#()) ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: 'Todas las filas tienen que tener al menos un elemento' ]! !

!TestSudoku methodsFor: 'test' stamp: 'k 10/21/2025 16:44:29'!
test06
	self 
		should: [ Sudoku nuevoJuego: #(#(1)
			                                              #(1)) ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: 'Board debe ser un cuadrado' ]! !

!TestSudoku methodsFor: 'test' stamp: 'k 10/21/2025 16:49:33'!
test07
	|sudokuBoard|
	sudokuBoard := #(#(1 2 3)
                                     #(2 3 1)
                                     #(3 1 2)).
	
	
	self 
		should: [ Sudoku nuevoJuego: sudokuBoard ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: 'Board tiene que tener como tamaño un numero cuadrado' ]! !

!TestSudoku methodsFor: 'test' stamp: 'k 10/21/2025 17:04:02'!
test08
	|sudoku sudokuBoard|
	sudokuBoard := #(#(1 2 3 1)
                                     #(3 4 1 2)
                                     #(2 1 4 3)
					   #(4 3 2 1)).
	
	sudoku := Sudoku nuevoJuego: sudokuBoard.
	self deny: sudoku esJuegoCorrecto ! !

!TestSudoku methodsFor: 'test' stamp: 'k 10/21/2025 17:19:19'!
test09
	|sudoku sudokuBoard|
	sudokuBoard := #(#(1 2 3 4)
                                     #(1 4 1 2)
                                     #(2 1 4 3)
					   #(4 3 2 1)).
	
	sudoku := Sudoku nuevoJuego: sudokuBoard.
	self deny: sudoku esJuegoCorrecto ! !

!TestSudoku methodsFor: 'test' stamp: 'k 10/21/2025 17:23:52'!
test10
	|sudoku sudokuBoard|
	sudokuBoard := #(#(1 3 2 4)
                                     #(2 4 1 3)
                                     #(1 2 3 4)
					   #(4 3 1 2)).
					
		
	sudoku := Sudoku nuevoJuego: sudokuBoard.
	self deny: sudoku esJuegoCorrecto ! !

!TestSudoku methodsFor: 'test' stamp: 'k 10/21/2025 17:49:50'!
test11
	|sudoku sudokuBoard|
	sudokuBoard := #(#(1 2 3 4)
                                     #(2 1 4 3)
                                     #(3 4 1 2)
					   #(4 3 2 1)).
		
	sudoku := Sudoku nuevoJuego: sudokuBoard.
	self deny: sudoku esJuegoCorrecto ! !
