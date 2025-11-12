!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'IF 11/11/2025 20:55:11'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'IF 11/11/2025 20:55:00'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'IF 11/11/2025 20:55:00'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'IF 11/11/2025 20:55:00'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'IF 11/11/2025 20:55:00'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'IF 11/11/2025 20:55:00'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'IF 11/11/2025 20:55:00'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'IF 11/11/2025 20:55:00'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !

!CartTest methodsFor: 'tests' stamp: 'IF 11/11/2025 20:55:00'!
test09EmptyCartHasPrice0

	| cart |
	
	cart := self createCart.

	self assert: (cart precio ) = 0! !

!CartTest methodsFor: 'tests' stamp: 'IF 11/11/2025 20:55:00'!
test10NonEmptyCartHasItemPrice

	| cart |
	
	cart := self createCart.
	cart add: self  itemSellByTheStore.
	self assert: (cart precio ) = 4.! !

!CartTest methodsFor: 'tests' stamp: 'IF 11/11/2025 20:55:00'!
test11SeveralItemCartHasItemPrices

	| cart |
	
	cart := self createCart.
	cart add: self  itemSellByTheStore.
		cart add: self  itemSellByTheStore.

	self assert: (cart precio ) = 8.! !


!CartTest methodsFor: 'support' stamp: 'IF 11/11/2025 20:55:00'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'IF 11/11/2025 20:11:10'!
defaultCatalog
	
	^ Dictionary with: (self itemSellByTheStore -> 4)! !

!CartTest methodsFor: 'support' stamp: 'IF 11/11/2025 20:12:42'!
extendCatalog: cata withItem: item ofPrice: price
	cata at: item set: price.! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'as yet unclassified' stamp: 'IF 11/11/2025 19:37:42'!
test01checkoutCartWithoutElementsFails
	|carrito cashier|
	cashier := Cashier new.
	carrito := Cart acceptingItemsOf: OrderedCollection new.
	self should: [cashier checkout: carrito] raise: Error - MessageNotUnderstood 
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'IF 11/11/2025 19:51:10'!
test02checkoutConCarritoNoVacio
	|carrito cashier cuentaBanco|
	
	cuentaBanco := AccountBankSimulation new.
	carrito := Cart acceptingItemsOf: (OrderedCollection with: 'Pepsi cola').
	cashier := Cashier paraCarrito: carrito pagarCon: cuentaBanco.
	
	carrito add: 'Pepsi cola'.
	cashier checkout: carrito.
	! !


!classDefinition: #HttpInterfaceTest category: #TusLibros!
TestCase subclass: #HttpInterfaceTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!


!classDefinition: #AccountBankSimulation category: #TusLibros!
Object subclass: #AccountBankSimulation
	instanceVariableNames: 'savings'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!AccountBankSimulation methodsFor: 'as yet unclassified' stamp: 'IF 11/11/2025 20:19:56'!
initializeWithMoney: money
	savings := money.! !

!AccountBankSimulation methodsFor: 'as yet unclassified' stamp: 'IF 11/11/2025 20:22:57'!
withdraw: anAmount
	anAmount > savings ifTrue: [self error: self class brokeAssError].
	savings := savings - anAmount! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountBankSimulation class' category: #TusLibros!
AccountBankSimulation class
	instanceVariableNames: ''!

!AccountBankSimulation class methodsFor: 'as yet unclassified' stamp: 'IF 11/11/2025 20:21:21'!
brokeAssError
	^ 'No alcanza el dinero para la extracción'! !

!AccountBankSimulation class methodsFor: 'as yet unclassified' stamp: 'IF 11/11/2025 20:18:43'!
createWithSavings: money
	^self new initializeWithMoney: money ! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'IF 11/11/2025 20:04:44'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'IF 11/11/2025 20:00:24'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'IF 11/11/2025 20:08:08'!
precio
	 ^ items sum:  [:aProduct | catalog at: aProduct ] ifEmpty: [0].! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'carrito cuenta'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'IF 11/11/2025 20:26:21'!
checkout: aCart
	(cuenta withdraw: (aCart precio)) on: Error - MessageNotUnderstood do: [self error: 'Me querés cagar plata cliente?'].

	! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'IF 11/11/2025 19:52:25'!
initializeWith: aCarrito APagarCon: unaCuentaBanco
	carrito := aCarrito .
	cuenta := unaCuentaBanco .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'IF 11/11/2025 19:51:40'!
paraCarrito: carrito pagarCon: cuentaBanco.
	^ self new initializeWith: carrito APagarCon: cuentaBanco! !


!classDefinition: #HttpInterface category: #TusLibros!
Object subclass: #HttpInterface
	instanceVariableNames: 'cartsToMoveLater'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!HttpInterface methodsFor: 'as yet unclassified' stamp: 'IF 11/11/2025 20:59:25'!
add:amount of:item cartID: cartid
	(cartsToMoveLater at:cartid) add:amount of:item! !

!HttpInterface methodsFor: 'as yet unclassified' stamp: 'IF 11/11/2025 20:56:22'!
createCart: user authenticated: authenticated 
	cartsToMoveLater add: (Cart  acceptingItemsOf: self shopCatalog).
	^ cartsToMoveLater length ! !

!HttpInterface methodsFor: 'as yet unclassified' stamp: 'IF 11/11/2025 20:53:16'!
initialize
	cartsToMoveLater := OrderedCollection new.! !

!HttpInterface methodsFor: 'as yet unclassified' stamp: 'IF 11/11/2025 20:39:40'!
shopCatalog
	^ObjectFactory new getCatalog 
	 ! !


!classDefinition: #ObjectFactory category: #TusLibros!
Object subclass: #ObjectFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ObjectFactory methodsFor: 'as yet unclassified' stamp: 'IF 11/11/2025 20:39:02'!
getCatalog
	^ Dictionary with: 'validBook'->1 with: 'calidBook'->2  with: 'pallidBook'->3 ! !
