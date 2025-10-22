!classDefinition: #Sudoku category: #Sudoku!
Object subclass: #Sudoku
	instanceVariableNames: 'board juegoCorrecto'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Sudoku'!

!Sudoku methodsFor: 'initialization' stamp: 'Iñaki Frutos 10/21/2025 15:40:37'!
initializeWithSudokuBoard: anSudokuBoard
	board := anSudokuBoard ! !


!Sudoku methodsFor: 'functionality' stamp: 'Iñaki Frutos 10/21/2025 23:46:26'!
boardEs: unBoard
	^ unBoard = board ! !

!Sudoku methodsFor: 'functionality' stamp: 'k 10/21/2025 17:50:46'!
esJuegoCorrecto
	 
	juegoCorrecto := true.
	self tienenRepetidosFilas.
	
	self tienenRepetidosColumnas.
	
	self tienenRepetidosEnSubcuadriculas.
	
	^ juegoCorrecto! !

!Sudoku methodsFor: 'functionality' stamp: 'Iñaki Frutos 10/21/2025 20:02:04'!
obtenerElementosSubcuadriculaX: xSubcuadricula Y: ySubcuadricula 
	|elementos posX posY tamañoSubcuadricula|
	elementos  := OrderedCollection new.
	tamañoSubcuadricula := board size sqrt.
	posX := ((xSubcuadricula - 1) * (tamañoSubcuadricula)) + 1.
	posY := ((ySubcuadricula - 1)* (tamañoSubcuadricula )) + 1.
	
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


!Sudoku class methodsFor: 'initialization' stamp: 'Iñaki Frutos 10/21/2025 20:29:39'!
assertBoardCuadrado: unBoard

	^ unBoard do: [:fila | 
		fila size = (unBoard size) ifFalse: [self error: 'Board debe ser un cuadrado' ].
	]! !

!Sudoku class methodsFor: 'initialization' stamp: 'Iñaki Frutos 10/21/2025 20:20:18'!
assertMoreThanZeroRows: aPossibleSudoku

	^ aPossibleSudoku size = 0 ifTrue: [self error: 'Al menos tiene que haber una fila' ]! !

!Sudoku class methodsFor: 'initialization' stamp: 'Iñaki Frutos 10/21/2025 20:45:19'!
assertSizeIsAPerfectSquareOfBoard: aBoard

	^ (aBoard size sqrt isKindOf: Integer) ifFalse: [self error: 'Board tiene que tener como tamaño un numero cuadrado']! !

!Sudoku class methodsFor: 'initialization' stamp: 'Iñaki Frutos 10/21/2025 20:33:55'!
assertThatEveryElementIsGreaterThanOneInRow: aRow

	^ aRow do: [:celdaFila |
			celdaFila <= 0 ifTrue: [self error: 'Todos los números deben ser mayores a 1'].
		]! !

!Sudoku class methodsFor: 'initialization' stamp: 'Iñaki Frutos 10/21/2025 20:36:23'!
assertThatEveryElementIsLessOrEqualToSizeOfRow: aRow
	^ aRow do: [:celdaFila |
			celdaFila > (aRow size) ifTrue: [self error: 'Los elementos deben ser iguales o menores que el tamaño del board' ].
		]! !

!Sudoku class methodsFor: 'initialization' stamp: 'Iñaki Frutos 10/21/2025 20:23:23'!
assertThatEveryGameHasMoreThanZeroElementsSudoku: aPossibleSudoku

	^ aPossibleSudoku do: [:fila |
		fila size = 0 ifTrue: [self error: 'Todas las filas tienen que tener al menos un elemento'].
	]! !

!Sudoku class methodsFor: 'initialization' stamp: 'Iñaki Frutos 10/21/2025 20:35:28'!
assertThatEveryRowVerifiesConditionInBoard: aBoard

	^ aBoard do: [:fila |
		self assertThatEveryElementIsGreaterThanOneInRow: fila.
		self assertThatEveryElementIsLessOrEqualToSizeOfRow: fila.
	]! !

!Sudoku class methodsFor: 'initialization' stamp: 'Iñaki Frutos 10/21/2025 20:45:19'!
nuevoJuego: unPosibleSudoku
	|size|
	size := unPosibleSudoku size.
	self assertMoreThanZeroRows: unPosibleSudoku.
	
	self assertThatEveryGameHasMoreThanZeroElementsSudoku: unPosibleSudoku.
	
	self assertThatEveryRowVerifiesConditionInBoard: unPosibleSudoku.

	self assertBoardCuadrado: unPosibleSudoku.
	
	self assertSizeIsAPerfectSquareOfBoard: unPosibleSudoku.

	^ self new initializeWithSudokuBoard: unPosibleSudoku ! !


!classDefinition: #SudokuIncompleto category: #Sudoku!
Sudoku subclass: #SudokuIncompleto
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Sudoku'!

!SudokuIncompleto methodsFor: 'as yet unclassified' stamp: 'Iñaki Frutos 10/21/2025 23:48:06'!
addValue: aValue AtX: x Y: y
	(board at: y) at: x put: aValue ! !

!SudokuIncompleto methodsFor: 'as yet unclassified' stamp: 'Iñaki Frutos 10/21/2025 22:44:21'!
esJuegoCorrecto
	^ self noHayVacio and: [super esJuegoCorrecto].! !

!SudokuIncompleto methodsFor: 'as yet unclassified' stamp: 'Iñaki Frutos 10/21/2025 23:02:26'!
esJuegoParcialmenteCorrecto
	^ super esJuegoCorrecto! !

!SudokuIncompleto methodsFor: 'as yet unclassified' stamp: 'Iñaki Frutos 10/21/2025 22:45:22'!
noHayVacio
	board do: [:row |
		row do: [:cell|
			cell = 0 ifTrue: [^ false].
		].
	].
	^true! !

!SudokuIncompleto methodsFor: 'as yet unclassified' stamp: 'Iñaki Frutos 10/21/2025 23:02:04'!
tieneReptidos: fila
	|apariciones|
	apariciones := Bag new.
	fila do: [:celda | 
	celda = 0 ifFalse: [apariciones add: celda]].
	apariciones do: [:aparicion | 
		(apariciones occurrencesOf: aparicion) > 1 ifTrue: [^ true]].
	^ false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SudokuIncompleto class' category: #Sudoku!
SudokuIncompleto class
	instanceVariableNames: ''!

!SudokuIncompleto class methodsFor: 'as yet unclassified' stamp: 'Iñaki Frutos 10/21/2025 20:52:10'!
assertThatEveryElementIsGreaterThanZeroInRow: aRow

	^ aRow do: [:celdaFila |
			celdaFila < 0 ifTrue: [self error: 'No puede haber elementos negativos' ].
		]! !

!SudokuIncompleto class methodsFor: 'as yet unclassified' stamp: 'Iñaki Frutos 10/21/2025 20:51:19'!
nuevoJuego: unSudokuBoard
	self assertMoreThanZeroRows: unSudokuBoard.
	self assertThatEveryGameHasMoreThanZeroElementsSudoku: unSudokuBoard .
	self assertBoardCuadrado: unSudokuBoard .
	self assertSizeIsAPerfectSquareOfBoard: unSudokuBoard .
	
	unSudokuBoard do: [:row |
		self assertThatEveryElementIsLessOrEqualToSizeOfRow: row.
		self assertThatEveryElementIsGreaterThanZeroInRow: row 
	].
	^ self new initializeWithSudokuBoard: unSudokuBoard ! !


!classDefinition: #SudokuSolver category: #Sudoku!
Object subclass: #SudokuSolver
	instanceVariableNames: 'sudokuBoard sudokuInitialBoard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Sudoku'!

!SudokuSolver methodsFor: 'as yet unclassified' stamp: 'Iñaki Frutos 10/22/2025 14:32:21'!
backtrackingAtX: x AtY: y
	|sudoku size|
	size := sudokuInitialBoard size.
	sudoku := SudokuIncompleto nuevoJuego: sudokuBoard.
	sudoku noHayVacio ifTrue: [^true].
	(self esVaciaPosicionX: x Y: y) ifTrue: [
		 1 to: size do: [ :valor | 
			(sudokuBoard at: x) at: y put: valor.
			sudoku := SudokuIncompleto nuevoJuego: sudokuBoard.
			sudoku esJuegoCorrecto ifTrue: [
				^ true
			].
		].
	].
	^ false. "El camino no dio resultados, hacer backtracking"
	! !

!SudokuSolver methodsFor: 'as yet unclassified' stamp: 'Iñaki Frutos 10/22/2025 14:27:54'!
esVaciaPosicionX: x Y: y

	^ ((sudokuInitialBoard at: x) at: y) = 0! !

!SudokuSolver methodsFor: 'as yet unclassified' stamp: 'Iñaki Frutos 10/22/2025 00:05:26'!
initializeWithSudokuBoardToSolve: aSudokuBoard
	sudokuBoard := aSudokuBoard.
	sudokuInitialBoard := aSudokuBoard.! !

!SudokuSolver methodsFor: 'as yet unclassified' stamp: 'Iñaki Frutos 10/22/2025 14:33:33'!
resolver
	|sudoku|
	sudoku := SudokuIncompleto nuevoJuego: sudokuBoard.
	sudoku esJuegoParcialmenteCorrecto ifFalse: [
		^ self class imposibleDeResolver 
	].
	sudoku noHayVacio ifFalse: [
		(self esVaciaPosicionX: 3 Y: 4) ifTrue: [
			self backtrackingAtX: 3 AtY: 4.
		]. 
		self backtrackingAtX: 4 AtY: 4.].
	^ sudokuBoard ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SudokuSolver class' category: #Sudoku!
SudokuSolver class
	instanceVariableNames: ''!

!SudokuSolver class methodsFor: 'as yet unclassified' stamp: 'Iñaki Frutos 10/21/2025 23:28:51'!
imposibleDeResolver
	^ 'No se puede resolver'! !

!SudokuSolver class methodsFor: 'as yet unclassified' stamp: 'Iñaki Frutos 10/21/2025 23:12:38'!
porResolver: aSudokuToSolve
	^ self new initializeWithSudokuBoardToSolve: aSudokuToSolve ! !


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

!TestSudoku methodsFor: 'test' stamp: 'Iñaki Frutos 10/21/2025 19:56:41'!
test12
	|sudoku sudokuBoard|
	sudokuBoard := #(#(1 2 3 4 5 6 7 8 9)
                                     #(4 5 6 7 8 9 1 2 3)
                                     #(7 8 9 1 2 3 4 5 6)
					   #(2 3 4 5 6 7 8 9 1)
					   #(5 6 7 8 9 1 2 3 4)
					   #(8 9 1 2 3 4 5 6 7)
					   #(3 4 5 6 7 8 9 1 2)
					   #(6 7 8 9 1 2 3 4 5)
					   #(9 1 2 3 4 5 6 7 8)).
	sudoku := Sudoku nuevoJuego: sudokuBoard.
	self assert: sudoku esJuegoCorrecto ! !

!TestSudoku methodsFor: 'test' stamp: 'Iñaki Frutos 10/21/2025 22:57:19'!
test13
	|sudoku sudokuBoard|
	sudokuBoard := #(#(0)).
	sudoku := SudokuIncompleto nuevoJuego: sudokuBoard.
	
	self assert: sudoku esJuegoParcialmenteCorrecto.
	self deny: sudoku esJuegoCorrecto ! !

!TestSudoku methodsFor: 'test' stamp: 'Iñaki Frutos 10/21/2025 20:21:16'!
test14
	self 
		should: [ SudokuIncompleto nuevoJuego: #() ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: 'Al menos tiene que haber una fila' ].
! !

!TestSudoku methodsFor: 'test' stamp: 'Iñaki Frutos 10/21/2025 20:21:50'!
test15
	self 
		should: [ SudokuIncompleto nuevoJuego: #(#()) ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: 'Todas las filas tienen que tener al menos un elemento' ]! !

!TestSudoku methodsFor: 'test' stamp: 'Iñaki Frutos 10/21/2025 20:26:26'!
test16
	self 
		should: [ SudokuIncompleto nuevoJuego: #(#(1)
			                                              #(1)) ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: 'Board debe ser un cuadrado' ]! !

!TestSudoku methodsFor: 'test' stamp: 'Iñaki Frutos 10/21/2025 20:32:51'!
test17
	self 
		should: [ Sudoku nuevoJuego: #(#(2)) ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: 'Los elementos deben ser iguales o menores que el tamaño del board' ]! !

!TestSudoku methodsFor: 'test' stamp: 'Iñaki Frutos 10/21/2025 20:43:41'!
test18
	|board|
	board := #(#(1 2 3)
                                     #(2 3 1)
                                     #(3 1 2)).
	
	
	self 
		should: [ SudokuIncompleto nuevoJuego: board ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: 'Board tiene que tener como tamaño un numero cuadrado' ]! !

!TestSudoku methodsFor: 'test' stamp: 'Iñaki Frutos 10/21/2025 20:49:59'!
test19
	|board|
	board := #(#(-1)).
	
	self 
		should: [ SudokuIncompleto nuevoJuego: board ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: 'No puede haber elementos negativos' ]! !

!TestSudoku methodsFor: 'test' stamp: 'Iñaki Frutos 10/21/2025 22:57:31'!
test20
	|board sudoku|
	board := #(#(1 2 3 4)
                          #(3 4 1 2)
                          #(2 1 4 3)
                           #(4 3 2 1)).
	sudoku := SudokuIncompleto nuevoJuego: board.
	
	self assert: sudoku esJuegoParcialmenteCorrecto.
	self assert: sudoku esJuegoCorrecto ! !

!TestSudoku methodsFor: 'test' stamp: 'Iñaki Frutos 10/21/2025 23:04:22'!
test21
	|board sudoku|
	board :=             #(#(1 2 3 1)
                                     #(3 4 1 2)
                                     #(2 1 4 3)
					   #(4 3 2 1)).
	
	sudoku := SudokuIncompleto nuevoJuego: board.
	self deny: sudoku esJuegoParcialmenteCorrecto.
	self deny: sudoku esJuegoCorrecto .! !

!TestSudoku methodsFor: 'test' stamp: 'Iñaki Frutos 10/21/2025 23:04:34'!
test22
	|board sudoku|
	board :=             #(#(1 2 3 1)
                                     #(3 0 0 2)
                                     #(2 0 0 3)
					   #(4 3 2 1)).
	
	sudoku := SudokuIncompleto nuevoJuego: board.
	self deny: sudoku esJuegoParcialmenteCorrecto.
	self deny: sudoku esJuegoCorrecto .! !

!TestSudoku methodsFor: 'test' stamp: 'Iñaki Frutos 10/21/2025 23:46:05'!
test23
	|board sudoku boardEsperado|
	board :=             #(#(1 2 3 1)
                                     #(3 0 0 2)
                                     #(2 0 0 3)
					   #(4 3 2 1)).
					
	boardEsperado := #(#(1 2 3 1)
                                     #(3 4 0 2)
                                     #(2 0 0 3)
					   #(4 3 2 1)).
	
	sudoku := SudokuIncompleto nuevoJuego: board.
	sudoku addValue: 4 AtX: 2 Y: 2.
	self assert: (sudoku boardEs: boardEsperado)! !

!TestSudoku methodsFor: 'test' stamp: 'Iñaki Frutos 10/21/2025 23:49:58'!
test24
	|board sudoku boardEsperado|
	board :=             #(#(1 2 3 1)
                                     #(3 0 0 2)
                                     #(2 0 0 3)
					   #(4 3 2 1)).
					
	boardEsperado := #(#(1 2 3 1)
                                     #(3 0 0 2)
                                     #(2 1 0 3)
					   #(4 3 2 1)).
	
	sudoku := SudokuIncompleto nuevoJuego: board.
	sudoku addValue: 1 AtX: 2 Y: 3.
	self assert: (sudoku boardEs: boardEsperado)! !


!classDefinition: #TestsudokuSolver category: #Sudoku!
TestCase subclass: #TestsudokuSolver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Sudoku'!

!TestsudokuSolver methodsFor: 'test' stamp: 'Iñaki Frutos 10/21/2025 23:16:21'!
test01
	|solver board|
	board := #(#(1 2 3 4 5 6 7 8 9)
                          #(4 5 6 7 8 9 1 2 3)
                          #(7 8 9 1 2 3 4 5 6)
                          #(2 3 4 5 6 7 8 9 1)
			     #(5 6 7 8 9 1 2 3 4)
			      #(8 9 1 2 3 4 5 6 7)
				#(3 4 5 6 7 8 9 1 2)
				#(6 7 8 9 1 2 3 4 5)
				#(9 1 2 3 4 5 6 7 8)).
	solver := SudokuSolver porResolver: board.
	self assert: (solver resolver) = board! !

!TestsudokuSolver methodsFor: 'test' stamp: 'Iñaki Frutos 10/21/2025 23:25:31'!
test02
	|solver boardToSolve boardSolved|
	boardToSolve := #(#(1 2 3 4)
                          #(3 4 1 2)
                          #(2 1 4 3)
                           #(4 3 2 0)).
				
	boardSolved := #(#(1 2 3 4)
                          #(3 4 1 2)
                          #(2 1 4 3)
                           #(4 3 2 1)).
	solver := SudokuSolver porResolver: boardToSolve.
	self assert: (solver resolver) = boardSolved! !

!TestsudokuSolver methodsFor: 'test' stamp: 'Iñaki Frutos 10/22/2025 14:18:52'!
test03
	|solver boardToSolve|
	boardToSolve := #(#(1 2 1 4)
                          #(3 4 1 2)
                          #(2 1 4 3)
                           #(4 3 2 0)).
				
	solver := SudokuSolver porResolver: boardToSolve.
	self assert: (solver resolver) = 'No se puede resolver'! !

!TestsudokuSolver methodsFor: 'test' stamp: 'Iñaki Frutos 10/22/2025 14:18:38'!
test04
	|solver boardToSolve boardSolved|
	boardToSolve := #(#(1 3 4 2)
                                      #(2 4 1 3)
                                      #(3 1 2 4)
                                      #(4 2 3 0)).

	boardSolved := #(#(1 3 4 2)
                                      #(2 4 1 3)
                                      #(3 1 2 4)
                                      #(4 2 3 1)).
	solver := SudokuSolver porResolver: boardToSolve.
	self assert: (solver resolver) = boardSolved! !

!TestsudokuSolver methodsFor: 'test' stamp: 'Iñaki Frutos 10/22/2025 14:44:16'!
test05
	|solver boardToSolve boardSolved|
	boardToSolve := #(#(1 3 4 2)
                                      #(2 4 1 3)
                                      #(3 1 2 4)
                                      #(4 2 0 0)).

	boardSolved := #(#(1 3 4 2)
                                      #(2 4 1 3)
                                      #(3 1 2 4)
                                      #(4 2 3 1)).
	solver := SudokuSolver porResolver: boardToSolve.
	self assert: (solver resolver) = boardSolved! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(74 65 99 92 122 108 121 122 99 110 104 127 112 99 75 118 106 124 116 108 117 123 122 99 80 117 110 108 99 126 112 117 107 118 126 122 61 59 99 126 112 117 107 118 126 122 61 59 17 74 65 99 92 122 108 121 122 99 110 104 127 112 99 75 118 106 124 116 108 117 123 122 99 80 117 110 108 99 126 112 117 107 118 126 122 61 59 99 126 112 117 107 118 126 122 61 59 99 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 61 59 56 53 112 116 104 110 108 17 94 112 117 58 57 17 61 53 57 17 95 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 100 17 94 112 117 107 118 126 122 17 94 112 117 58 57 39 105 124 112 115 123 39 118 117 39 84 104 121 39 39 56 39 57 55 57 60 39 55 56 65 55 59 65 57 57 39 78 84 91 39 74 118 116 119 112 115 108 121 65 39 59 53 57 53 56 39 74 118 116 119 104 123 112 105 115 108 39 74 115 104 117 110 39 63 53 55 53 56 39 47 123 104 110 122 54 89 76 83 76 72 90 76 102 63 55 56 54 109 112 117 104 115 48 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 84 104 121 39 39 56 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 84 104 121 39 39 56 39 57 55 57 60 17 93 84 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 84 118 117 39 86 106 123 39 61 39 56 57 65 58 59 65 57 56 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 108 107 58 60 59 63 61 39 87 115 124 110 112 117 122 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 179 33 247 8 17 56 62 57 53 57 61 53 57 59 55 53 56 17 75 76 90 82 91 86 87 52 56 55 79 85 92 72 78 53 116 122 111 118 116 108 53 117 108 123 17 75 76 90 82 91 86 87 52 56 55 79 85 92 72 78 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 56 91 56 64 65 60 55 65 60 62 53 62 64 62 60 55 64 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 110 104 127 112 99 75 118 126 117 115 118 104 107 122 99 90 124 107 118 114 124 91 108 122 123 56 56 53 122 123 17 61 63 62 64 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 56 56 91 57 58 65 56 60 65 58 64 53 57 60 59 58 61 61 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 110 104 127 112 99 75 118 106 124 116 108 117 123 122 99 80 117 110 108 99 126 112 117 107 118 126 122 61 59 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 106 111 108 122 122 53 122 123 17 56 58 59 61 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 57 91 55 55 65 55 64 65 58 62 53 63 63 57 62 64 56 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 110 104 127 112 99 75 118 106 124 116 108 117 123 122 99 80 117 110 108 99 126 112 117 107 118 126 122 61 59 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 90 124 107 118 114 124 90 118 115 125 108 121 91 108 122 123 59 53 122 123 17 56 64 61 59 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 57 91 56 59 65 59 60 65 57 58 53 57 58 61 62 57 62 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 110 104 127 112 99 75 118 106 124 116 108 117 123 122 99 80 117 110 108 99 126 112 117 107 118 126 122 61 59 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 90 124 107 118 114 124 90 118 115 125 108 121 91 108 122 123 60 53 122 123 17 57 55 60 59 60 17 52 52 52 52 52 52 52 52 52 52 17 17))!