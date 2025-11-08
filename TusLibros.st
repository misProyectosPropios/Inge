!classDefinition: #CarroDeComprasTest category: #TusLibros!
TestCase subclass: #CarroDeComprasTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CarroDeComprasTest methodsFor: 'as yet unclassified' stamp: 'IF 11/7/2025 21:27:50'!
test01iniacializarCarritoDeComprasLoCreaVacia
	|carroDeCompras |
	
	carroDeCompras  := CarroDeCompras new. 
	self assert: (carroDeCompras isEmpty).! !

!CarroDeComprasTest methodsFor: 'as yet unclassified' stamp: 'IF 11/7/2025 21:32:37'!
test02noSePuedeAgregarProductoAlCarritoFueraDeCatalogo
	|carroDeCompras libroFueraDeCatalogo|
	
	carroDeCompras  := CarroDeCompras new.
	libroFueraDeCatalogo := 'Un mundo feliz'.
	self should: [carroDeCompras add: libroFueraDeCatalogo] 
	       raise: Error-MessageNotUnderstood 
	       withExceptionDo: [:error | 
			"error messageText = CarroDeCompras intentoDeCompraFueraDeCatalogo."
			self assert: (carroDeCompras isEmpty).
		].
	
	! !

!CarroDeComprasTest methodsFor: 'as yet unclassified' stamp: 'IF 11/7/2025 21:54:07'!
test03sePuedeAgregarProductoAlCarritoEnElCatalogo
	|carroDeCompras libroFueraDeCatalogo unCatalogo libro|
	libro :=  'Un mundo feliz'.
	unCatalogo := OrderedCollection with: libro.
	carroDeCompras  := CarroDeCompras basadoEnCatalogo: unCatalogo.
	libroFueraDeCatalogo := libro.
	carroDeCompras add: libroFueraDeCatalogo.
	self assert: (carroDeCompras includes: libroFueraDeCatalogo ).
	self deny: (carroDeCompras isEmpty).! !

!CarroDeComprasTest methodsFor: 'as yet unclassified' stamp: 'IF 11/7/2025 21:55:35'!
test04sePuedenAgregarVariosProductosAlCarritoEnElCatalogo
	|carroDeCompras libroDeCatalogo libroDeCatalogo2|
	
	
	libroDeCatalogo := 'Un mundo feliz'.
	libroDeCatalogo2 := 'Un mundo feliz2'.
	carroDeCompras  := CarroDeCompras basadoEnCatalogo: (OrderedCollection with: libroDeCatalogo with: libroDeCatalogo2).
	carroDeCompras add: libroDeCatalogo.
	carroDeCompras add: libroDeCatalogo2.
	self assert: (carroDeCompras includes: libroDeCatalogo ).
	self assert: (carroDeCompras includes: libroDeCatalogo2 ).
	self deny: (carroDeCompras isEmpty).! !

!CarroDeComprasTest methodsFor: 'as yet unclassified' stamp: 'IF 11/7/2025 22:05:54'!
test05sePuedeAgregarVariosProductosDelMismoTipoAlCatalogo
	|carroDeCompras unCatalogo libro|
	libro :=  'Un mundo feliz'.
	unCatalogo := OrderedCollection with: libro.
	carroDeCompras  := CarroDeCompras basadoEnCatalogo: unCatalogo.
	libro := libro.
	carroDeCompras add: libro amount: 2.
	self assert: (carroDeCompras includes: libro ntimes:2 ).
	self deny: (carroDeCompras isEmpty).! !

!CarroDeComprasTest methodsFor: 'as yet unclassified' stamp: 'IF 11/7/2025 22:10:19'!
test06listarProductosDevuelveTodosProductosUnicos
	|carroDeCompras unCatalogo  libro libro2|
	libro :=  'Un mundo feliz'.
	libro2 :=  'Un mundo feliz2'.
	unCatalogo := OrderedCollection with: libro with: libro2.
	carroDeCompras  := CarroDeCompras basadoEnCatalogo: unCatalogo.
	carroDeCompras add: libro.
	carroDeCompras add: libro2.
	self assert: (carroDeCompras includes: libro ntimes:2 ).
	self deny: (carroDeCompras isEmpty).! !


!classDefinition: #CarroDeCompras category: #TusLibros!
Object subclass: #CarroDeCompras
	instanceVariableNames: 'catalogo productosDelCarrito'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CarroDeCompras methodsFor: 'as yet unclassified' stamp: 'IF 11/7/2025 21:37:32'!
add: aProduct
	(catalogo includes: aProduct) ifFalse: [self error: 'El producto no está en el catálogo'].
	productosDelCarrito add: aProduct .! !

!CarroDeCompras methodsFor: 'as yet unclassified' stamp: 'IF 11/7/2025 22:06:26'!
add: unProducto amount: unaCantidadDelProducto
	1 to: unaCantidadDelProducto do: [ :x |
		productosDelCarrito add: unProducto 
	].
	! !

!CarroDeCompras methodsFor: 'as yet unclassified' stamp: 'IF 11/7/2025 21:37:59'!
includes: aProduct
	^ true! !

!CarroDeCompras methodsFor: 'as yet unclassified' stamp: 'IF 11/7/2025 22:07:58'!
includes: aProduct ntimes: nTimes
	^(productosDelCarrito count: [:pr | pr = aProduct]) = nTimes
	! !

!CarroDeCompras methodsFor: 'as yet unclassified' stamp: 'IF 11/7/2025 21:37:40'!
initialize
	catalogo := OrderedCollection new.
	productosDelCarrito := OrderedCollection new.! !

!CarroDeCompras methodsFor: 'as yet unclassified' stamp: 'IF 11/7/2025 21:52:55'!
initializeWithCatalogo: unCatalogo
	self initialize .
	catalogo := unCatalogo ! !

!CarroDeCompras methodsFor: 'as yet unclassified' stamp: 'IF 11/7/2025 21:54:27'!
isEmpty
	^ productosDelCarrito isEmpty ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CarroDeCompras class' category: #TusLibros!
CarroDeCompras class
	instanceVariableNames: ''!

!CarroDeCompras class methodsFor: 'as yet unclassified' stamp: 'IF 11/7/2025 21:52:27'!
basadoEnCatalogo: unCatalogo
	^ self new initializeWithCatalogo: unCatalogo.! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 47 56 48 54 115 112 117 124 127 61 59 17 54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 47 56 48 54 115 112 117 124 127 61 59 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 61 59 56 53 112 116 104 110 108 17 124 117 112 127 17 83 112 117 124 127 39 61 53 56 59 53 55 52 58 59 52 110 108 117 108 121 112 106 17 127 63 61 102 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 100 17 95 56 56 17 92 117 112 127 39 105 124 112 115 123 39 118 117 39 86 106 123 39 39 62 39 57 55 57 60 39 56 59 65 55 63 65 57 62 39 74 118 116 119 112 115 108 121 65 39 60 53 59 53 55 39 57 55 56 61 55 61 55 64 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 93 84 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 84 118 117 39 86 106 123 39 61 39 56 57 65 58 59 65 57 56 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 108 107 58 60 59 63 61 39 87 115 124 110 112 117 122 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 17 48 111 49 17 56 55 53 59 56 53 56 55 59 53 59 57 17 119 106 59 57 53 115 104 105 56 56 55 59 53 115 104 105 118 122 53 109 106 108 117 53 124 105 104 53 104 121 17 119 106 59 57 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 56 52 55 62 91 57 57 65 56 55 65 60 55 53 55 61 59 63 62 58 52 55 58 65 55 55 17 54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 47 56 48 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 91 124 122 83 112 105 121 118 122 53 122 123 17 59 63 63 57 17 52 52 52 52 52 52 52 52 52 52 17 17))!