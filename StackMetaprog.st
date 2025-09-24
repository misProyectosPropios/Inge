!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'lista state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'k 9/24/2025 09:57:16'!
initialize
	"comment stating purpose of message"

	
	lista := OrderedCollection  new.
	state := OOStackState.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'k 9/20/2025 00:20:14'!
isEmpty
	"comment stating purpose of message"	
	^ lista isEmpty
! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'k 9/23/2025 23:39:01'!
pop
	|top|
	top := self top.
	lista removeLast.
	^ top.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'k 9/20/2025 00:18:58'!
push: anObject

	lista add: anObject.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'k 9/20/2025 00:19:41'!
size
	
	^ lista size.
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'k 9/24/2025 10:26:29'!
top
	|subclass|
	subclass := state canHandle: self.
	subclass := subclass new for: self.
	^subclass top.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'k 9/24/2025 10:10:37'!
topWhenEmpty
	self error: self class stackEmptyErrorDescription ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'k 9/24/2025 10:10:12'!
topWhenNotEmpty
	^ lista at: self size! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/14/2023 08:12:21'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackState category: #'Stack-Exercise'!
Object subclass: #OOStackState
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackState methodsFor: 'as yet unclassified' stamp: 'k 9/24/2025 10:22:10'!
for: aStack
	stack  := aStack .! !

!OOStackState methodsFor: 'as yet unclassified' stamp: 'k 9/24/2025 10:06:22'!
top
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackState class' category: #'Stack-Exercise'!
OOStackState class
	instanceVariableNames: 'stack'!

!OOStackState class methodsFor: 'as yet unclassified' stamp: 'k 9/24/2025 09:51:57'!
canHandle: aStack
	^ self subclasses detect: [:subclass | subclass canHandle: aStack ].! !


!classDefinition: #StateIsEmpty category: #'Stack-Exercise'!
OOStackState subclass: #StateIsEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StateIsEmpty methodsFor: 'as yet unclassified' stamp: 'k 9/24/2025 10:17:17'!
top
	stack topWhenEmpty! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StateIsEmpty class' category: #'Stack-Exercise'!
StateIsEmpty class
	instanceVariableNames: ''!

!StateIsEmpty class methodsFor: 'as yet unclassified' stamp: 'k 9/24/2025 09:58:46'!
canHandle: aStack
	^aStack isEmpty! !


!classDefinition: #StateIsNotEmpty category: #'Stack-Exercise'!
OOStackState subclass: #StateIsNotEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StateIsNotEmpty methodsFor: 'as yet unclassified' stamp: 'k 9/24/2025 10:26:19'!
top
	^stack topWhenNotEmpty! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StateIsNotEmpty class' category: #'Stack-Exercise'!
StateIsNotEmpty class
	instanceVariableNames: ''!

!StateIsNotEmpty class methodsFor: 'as yet unclassified' stamp: 'k 9/24/2025 09:58:41'!
canHandle: aStack
	^aStack isEmpty not! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'k 9/24/2025 10:26:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
