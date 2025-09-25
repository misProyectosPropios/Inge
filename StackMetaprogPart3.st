'From Cuis7.3 [latest update: #7158] on 25 September 2025 at 3:21:09 pm'!
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

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'k 9/25/2025 15:20:06'!
test08findDoesntChangeOrderStack
	self assert: (manySentences selectMatchingPrefixes: 'Ju') size = 3.
	
! !
