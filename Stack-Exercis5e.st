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


!classDefinition: #Prefix category: #'Stack-Exercise'!
Object subclass: #Prefix
	instanceVariableNames: 'prefixText'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Prefix methodsFor: 'as yet unclassified' stamp: 'a 9/26/2025 15:26:44'!
initialize: aString
	prefixText := aString .! !

!Prefix methodsFor: 'as yet unclassified' stamp: 'a 9/26/2025 14:56:31'!
validate
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Prefix class' category: #'Stack-Exercise'!
Prefix class
	instanceVariableNames: 'prefixText'!

!Prefix class methodsFor: 'as yet unclassified' stamp: 'a 9/26/2025 15:27:05'!
accepts: aSentence
	! !

!Prefix class methodsFor: 'as yet unclassified' stamp: 'a 9/26/2025 15:50:15'!
canHandle: aPrefixText
	self subclassResponsibility 
	! !


!classDefinition: #ContainsSpaces category: #'Stack-Exercise'!
Prefix subclass: #ContainsSpaces
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ContainsSpaces methodsFor: 'as yet unclassified' stamp: 'a 9/26/2025 14:56:59'!
validate
	self error: SentenceFinderByPrefix invalidPrefixErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ContainsSpaces class' category: #'Stack-Exercise'!
ContainsSpaces class
	instanceVariableNames: ''!

!ContainsSpaces class methodsFor: 'as yet unclassified' stamp: 'a 9/26/2025 15:49:06'!
canHandle: aPrefixString
	aPrefixString includesSubString:  ' '! !


!classDefinition: #Empty category: #'Stack-Exercise'!
Prefix subclass: #Empty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Empty methodsFor: 'as yet unclassified' stamp: 'a 9/26/2025 14:56:52'!
validate
	self error: SentenceFinderByPrefix invalidPrefixErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Empty class' category: #'Stack-Exercise'!
Empty class
	instanceVariableNames: ''!

!Empty class methodsFor: 'as yet unclassified' stamp: 'a 9/26/2025 15:50:49'!
canHandle: aPrefixString
	aPrefixString isEmpty ! !


!classDefinition: #NotAString category: #'Stack-Exercise'!
Prefix subclass: #NotAString
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NotAString methodsFor: 'as yet unclassified' stamp: 'a 9/26/2025 15:00:13'!
validate
	self error: SentenceFinderByPrefix invalidPrefixErrorDescription ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NotAString class' category: #'Stack-Exercise'!
NotAString class
	instanceVariableNames: ''!

!NotAString class methodsFor: 'as yet unclassified' stamp: 'a 9/26/2025 15:51:40'!
canHandle: aPrefixString
	aPrefixString isKindOf: String
	! !


!classDefinition: #Valid category: #'Stack-Exercise'!
Prefix subclass: #Valid
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Valid methodsFor: 'as yet unclassified' stamp: 'a 9/26/2025 14:57:13'!
validate
	^ true.! !


!classDefinition: #Sentence category: #'Stack-Exercise'!
Object subclass: #Sentence
	instanceVariableNames: 'prefixText'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'sentences prefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'lh 9/24/2025 20:01:19'!
addSentence: aSentence
	sentences push: aSentence 
	
	! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'a 9/26/2025 15:15:06'!
drain: drainedStack forEach: aBlock
	|sentence|
	self whileIsNotEmpty: drainedStack do: [
		sentence := drainedStack pop.
		aBlock value: sentence.
		].! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'a 9/26/2025 15:18:29'!
drain: drainedStack forEach: aBlock into: fillingStack
	self drain: drainedStack forEach: [ : elem | fillingStack push: elem. aBlock value].! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'lh 9/24/2025 20:01:13'!
initialize
	sentences := OOStack new! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'a 9/26/2025 15:22:52'!
selectMatchingPrefixes: aPrefix

	| matches elementStorage |
	aPrefix validate.
	
	matches  := OrderedCollection new.
	elementStorage  := OOStack new.
	
	self drain: sentences forEach: [ : sentence | 
		(sentence beginsWith: aPrefix) ifTrue:  [
			matches add:sentence.
			]
		] into: elementStorage .
	
	self drain: elementStorage forEach: [:nothing|] into: sentences. 
	
	^matches! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'k 9/25/2025 23:58:23'!
whileIsNotEmpty: collection do: anAction

[collection isEmpty not] whileTrue: anAction.! !


!SentenceFinderByPrefix methodsFor: 'assertions' stamp: 'k 9/26/2025 01:03:05'!
assertThatAPrefixIsAString: aPrefix
    (aPrefix isKindOf: String) ifFalse: [ self error: self class invalidPrefixErrorDescription ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'nil' stamp: 'lh 9/24/2025 20:34:49'!
invalidPrefixErrorDescription
	^'Prefijo vacío, con espacios, o de tipo incorrecto'! !


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
	instanceVariableNames: 'zeroSentences oneSentence manySentences'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'nil' stamp: 'k 9/25/2025 15:15:09'!
setUp
	zeroSentences := SentenceFinderByPrefix new.
	oneSentence := SentenceFinderByPrefix new.
	manySentences := SentenceFinderByPrefix new.
	oneSentence addSentence: 'pEpe'.
	
	manySentences addSentence: 'pEpe'.
	manySentences addSentence: 'juan'.
	manySentences addSentence: 'Juan'.	
	manySentences addSentence: 'Jujeño'.	
	manySentences addSentence: 'Juan Pablo'.
	manySentences addSentence: 'pEpe'.
	manySentences addSentence: 'Gerónimo'.
	manySentences addSentence: ''.! !


!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'lh 9/24/2025 20:33:57'!
test00emptyPrefixFails
	self
		should: [ oneSentence selectMatchingPrefixes: '']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix invalidPrefixErrorDescription ]
	
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'k 9/25/2025 13:38:27'!
test01zeroSentencesReturnsEmptyCollection
	self assert: (zeroSentences selectMatchingPrefixes: 'cualqueir_cosa') isEmpty.
	
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'lh 9/24/2025 20:35:35'!
test02spaceContainingPrefixFails
	self
		should: [ manySentences selectMatchingPrefixes: 'Juan Pa']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix invalidPrefixErrorDescription ]
	
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'k 9/25/2025 14:05:14'!
test03nonStringPrefixFails
	self
		should: [ manySentences selectMatchingPrefixes: 65]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = (SentenceFinderByPrefix invalidPrefixErrorDescription) ]
	
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'k 9/25/2025 15:16:10'!
test04caseSensitive
	self assert: (manySentences selectMatchingPrefixes: 'jua') size = 1.
	
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'k 9/25/2025 15:16:37'!
test05findsSingleAppearenceOnce
	self assert: (manySentences selectMatchingPrefixes: 'Ger') size = 1.
	
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'k 9/25/2025 15:16:42'!
test06findsMultipleAppearences
	self assert: (manySentences selectMatchingPrefixes: 'pE') size = 2.
	
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'k 9/25/2025 15:17:01'!
test07findsMultipleMatchesWithSpace
	self assert: (manySentences selectMatchingPrefixes: 'Ju') size = 3.
	
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'k 9/26/2025 01:15:26'!
test08findDoesntChangeOrderStackEmpty
	self assert: (manySentences selectMatchingPrefixes: 'Ju') size = 3.
	
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'k 9/26/2025 01:15:46'!
test09findDoesntAddElementsToEmptyStack
	self assert: (manySentences selectMatchingPrefixes: 'Ju') size = 3.
	
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'k 9/26/2025 01:16:04'!
test10findDoesntChangeOrderStack
	self assert: (manySentences selectMatchingPrefixes: 'Ju') size = 3.
	
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'k 9/26/2025 01:16:26'!
test11findDoesntAddElementsToEmptyStack
	self assert: (manySentences selectMatchingPrefixes: 'Ju') size = 3.
	
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'k 9/26/2025 01:16:48'!
test12findDoesntChangeOrderStack
	self assert: (manySentences selectMatchingPrefixes: 'Ju') size = 3.
	
! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'k 9/26/2025 01:17:29'!
test13findDoesntRemoveElementsOrderStack
	self assert: (manySentences selectMatchingPrefixes: 'Ju') size = 3.
	
! !
