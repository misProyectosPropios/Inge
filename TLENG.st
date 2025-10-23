!classDefinition: #SPlusPlus category: #TLENG!
Object subclass: #SPlusPlus
	instanceVariableNames: 'program'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TLENG'!

!SPlusPlus methodsFor: 'as yet unclassified' stamp: 'IF 10/23/2025 16:15:48'!
initializeWithInstrucctions: aListOfInstrucctions
	program := aListOfInstrucctions .! !

!SPlusPlus methodsFor: 'as yet unclassified' stamp: 'IF 10/23/2025 16:37:02'!
run 
	|ret|
	ret := 0.
	program do: [:instructions |
		instructions = 'y++' ifTrue: [ret := ret + 1].
		instructions = 'y--' ifTrue: [ret := (ret - 1) max: 0]
		"ifFalse: []."
	].
	^ ret! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SPlusPlus class' category: #TLENG!
SPlusPlus class
	instanceVariableNames: ''!

!SPlusPlus class methodsFor: 'as yet unclassified' stamp: 'IF 10/23/2025 16:15:38'!
nuevoProgramaConInstrucciones: unaListaDeInstrucciones
	^ self new initializeWithInstrucctions: unaListaDeInstrucciones! !


!classDefinition: #TestSPlusPlus category: #TLENG!
TestCase subclass: #TestSPlusPlus
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TLENG'!
!TestSPlusPlus commentStamp: 'IF 10/23/2025 16:05:26' prior: 0!
test01
	| programa |
	programa := SPlusPlus nuevoProgramaConInstrucciones: [].!


!TestSPlusPlus methodsFor: 'tests' stamp: 'IF 10/23/2025 16:17:16'!
test01
	| programa |
	programa := SPlusPlus nuevoProgramaConInstrucciones: #().
	self assert: (programa run = 0).! !

!TestSPlusPlus methodsFor: 'tests' stamp: 'IF 10/23/2025 16:17:53'!
test02
	| programa |
	programa := SPlusPlus nuevoProgramaConInstrucciones: #('y++').
	self assert: (programa run = 1).! !

!TestSPlusPlus methodsFor: 'tests' stamp: 'IF 10/23/2025 16:29:28'!
test03
	| programa |
	programa := SPlusPlus nuevoProgramaConInstrucciones: #('y++' 'y++').
	self assert: (programa run = 2).! !

!TestSPlusPlus methodsFor: 'tests' stamp: 'IF 10/23/2025 16:29:36'!
test04
	| programa |
	programa := SPlusPlus nuevoProgramaConInstrucciones: #('y++' 'y--').
	self assert: (programa run = 0).! !

!TestSPlusPlus methodsFor: 'tests' stamp: 'IF 10/23/2025 16:30:07'!
test05
	| programa |
	programa := SPlusPlus nuevoProgramaConInstrucciones: #('y--').
	self assert: (programa run = 0).! !

!TestSPlusPlus methodsFor: 'tests' stamp: 'IF 10/23/2025 16:39:46'!
test06
	| programa |
	programa := SPlusPlus nuevoProgramaConInstrucciones: #('z0++', 'y++').
	self assert: (programa run = 1).! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 17 54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 61 59 56 53 112 116 104 110 108 17 124 117 112 127 17 83 112 117 124 127 39 61 53 56 59 53 55 52 58 58 52 110 108 117 108 121 112 106 17 127 63 61 102 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 100 17 95 56 56 17 92 117 112 127 39 105 124 112 115 123 39 118 117 39 86 106 123 39 39 62 39 57 55 57 60 39 56 59 65 55 63 65 57 62 39 74 118 116 119 112 115 108 121 65 39 60 53 59 53 55 39 57 55 56 61 55 61 55 64 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 93 84 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 84 118 117 39 86 106 123 39 61 39 56 57 65 58 59 65 57 56 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 108 107 58 60 59 63 61 39 87 115 124 110 112 117 122 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 17 48 114 59 17 56 55 53 59 56 53 56 55 62 53 60 57 17 119 106 60 57 53 115 104 105 56 56 55 62 53 115 104 105 118 122 53 109 106 108 117 53 124 105 104 53 104 121 17 119 106 60 57 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 58 91 56 61 65 58 64 65 60 56 53 62 64 55 58 60 64 52 55 58 65 55 55 17 54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 91 83 76 85 78 53 122 123 17 57 59 61 59 17 52 52 52 52 52 52 52 52 52 52 17 17))!