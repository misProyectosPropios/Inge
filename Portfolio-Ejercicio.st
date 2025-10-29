!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'lh 10/24/2025 21:26:51'!
affectBalance: account

	self subclassResponsibility! !

!AccountTransaction methodsFor: 'value' stamp: 'lh 10/24/2025 21:02:11'!
balanceImpact

	self subclassResponsibility! !

!AccountTransaction methodsFor: 'value' stamp: 'lh 10/24/2025 21:29:35'!
value

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'lh 10/24/2025 21:27:09'!
affectBalance: account

	account changeBalanceBy: value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'lh 10/24/2025 21:27:25'!
affectBalance: account

	account changeBalanceBy: value negated ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'balance portfolio acc'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'as yet unclassified' stamp: 'aa 10/28/2025 21:59:54'!
addAccount: anAccount
	acc add: anAccount.
	balance := balance + anAccount balance .! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'aa 10/28/2025 21:47:18'!
addPortfolio: anPortfolio
	balance := balance + anPortfolio value.
	"portfolio add: anPortfolio."! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'aa 10/28/2025 22:00:24'!
hasRegistered: aTransaction
	^ acc anySatisfy: [:account | account hasRegistered: aTransaction]. ! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'aa 10/28/2025 21:59:36'!
initialize
	balance := 0.
	portfolio := OrderedCollection new.
	acc := OrderedCollection new.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'aa 10/28/2025 21:45:50'!
value
	^ balance 
"^accounts sum: [:account | account balance]. "! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions balance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'lh 10/24/2025 21:28:22'!
initialize

	transactions := OrderedCollection new.
	balance := 0.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'lh 10/24/2025 21:28:49'!
changeBalanceBy: amount
	balance := balance + amount! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'lh 10/24/2025 21:26:14'!
register: aTransaction

	transactions add: aTransaction.
	aTransaction affectBalance: self. 
	
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'aa 10/28/2025 21:55:54'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'lh 10/24/2025 21:28:10'!
balance

	^balance! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'lh 10/24/2025 21:55:59'!
test00EmptyPortfolioHasZeroBalance
	|portfolio cuenta|
	
	portfolio := Portfolio new.
	
	cuenta := ReceptiveAccount  new.
		
	self assert: portfolio value = 0.! !

!PortfolioTest methodsFor: 'tests' stamp: 'lh 10/24/2025 21:57:37'!
test01AddNonEmptyAccountChangesBalance
	|portfolio cuenta|
	
	portfolio := Portfolio new.
	
	cuenta := ReceptiveAccount  new.
	Deposit register: 100 on: cuenta.
	
	portfolio addAccount: cuenta.
	
	self assert: portfolio value = cuenta balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'lh 10/24/2025 21:57:41'!
test02AddSeveralNonEmptyAccountsChangesBalance
	|portfolio cuenta1 cuenta2|
	
	portfolio := Portfolio new.
	
	cuenta1 := ReceptiveAccount  new.
	Deposit register: 100 on: cuenta1.
	cuenta2 := ReceptiveAccount  new.
	Deposit register: 50 on: cuenta1.
	
	
	portfolio addAccount: cuenta1.	
	portfolio addAccount: cuenta2.
	
	self assert: portfolio value = (cuenta1 balance + cuenta2 balance).! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/28/2025 21:30:50'!
test03addPortfolioEmptyToPorfolio
	|portfolio portfolioToAdd |
	
	portfolio := Portfolio new.
	portfolioToAdd := Portfolio new.
	portfolio addPortfolio: portfolioToAdd.	
	self assert: portfolio value = (0).! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/28/2025 21:34:57'!
test04addPortfolioNonEmptyToPorfolio
	|portfolio portfolioToAdd cuenta|
	
	portfolio := Portfolio new.
	portfolioToAdd := Portfolio new.
	
	cuenta := ReceptiveAccount new.
	Deposit register: 100 on: cuenta.
	
	portfolioToAdd addAccount: cuenta.	
	portfolio addPortfolio: portfolioToAdd .
	self assert: portfolio value = (cuenta balance).! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/28/2025 21:40:28'!
test05addSeveralNonEmptyPortfolio
	|portfolio portfolioToAdd1 portfolioToAdd2 cuenta1 cuenta2|
	
	portfolio := Portfolio new.
	portfolioToAdd1 := Portfolio new.
	portfolioToAdd2 := Portfolio new.
	
	cuenta1 := ReceptiveAccount new.
	Deposit register: 100 on: cuenta1.
	
	portfolioToAdd1 addAccount: cuenta1.	
	portfolio addPortfolio: portfolioToAdd1.
	
	cuenta2 := ReceptiveAccount new.
	Deposit register: 50 on: cuenta2.
	
	portfolioToAdd2 addAccount: cuenta2.	
	portfolio addPortfolio: portfolioToAdd2.
	
	self assert: portfolio value = (cuenta1 balance + cuenta2 balance).! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/28/2025 21:49:33'!
test06hasRegisteredWorksForOneAccountSingleTransaction
	|portfolio portfolioToAdd1  cuenta1 variable|
	
	portfolio := Portfolio new.
	portfolioToAdd1 := Portfolio new.
	
	cuenta1 := ReceptiveAccount new.
	variable := Deposit register: 100 on: cuenta1.
	
	portfolio addAccount: cuenta1.	
	
	self assert: (portfolio hasRegistered: variable)! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/28/2025 21:52:19'!
test07hasRegisteredWorksForOneAccountSingleTransaction
	|portfolio portfolioToAdd1  cuenta1 cuenta2 deposit |
	
	portfolio := Portfolio new.
	portfolioToAdd1 := Portfolio new.
	
	cuenta1 := ReceptiveAccount new.
	cuenta2 := ReceptiveAccount new.
	deposit := Deposit register: 100 on: cuenta2.

	portfolio addAccount: cuenta1.	
	self deny: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/28/2025 21:59:06'!
test08hasRegisteredWorksForManyAccountManyTransaction
	|portfolio portfolioToAdd1  cuenta1 cuenta2 deposit deposit1 deposit2 deposit3|
	
	portfolio := Portfolio new.
	portfolioToAdd1 := Portfolio new.
	
	cuenta1 := ReceptiveAccount new.
	cuenta2 := ReceptiveAccount new.
	deposit := Deposit register: 100 on: cuenta1.
	deposit1 := Deposit register: 100 on: cuenta1.
	deposit2 := Deposit register: 100 on: cuenta2.
	deposit3 := Deposit register: 100 on: cuenta2.
	portfolio addAccount: cuenta1.	
	portfolio addAccount: cuenta2.
	self assert: (portfolio hasRegistered: deposit ).
	self assert: (portfolio hasRegistered: deposit1).
	self assert: (portfolio hasRegistered: deposit2).
	self assert: (portfolio hasRegistered: deposit3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/28/2025 22:02:42'!
test09hasRegisteredWorksForZeroAccountZeroTransaction
	|portfolio portfolioToAdd1  cuenta1 cuenta2 deposit |
	
	portfolio := Portfolio new.
	portfolioToAdd1 := Portfolio new.
	cuenta2 := ReceptiveAccount new.
	cuenta1 := ReceptiveAccount new.
	deposit := Deposit register: 100 on: cuenta1.
	
	
	portfolio addAccount: cuenta2.	
	self deny: (portfolio hasRegistered: deposit ).! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/28/2025 22:04:11'!
test10hasRegisteredWorksForPortfolioWithOneAccount
	|portfolio portfolioToAdd1  cuenta1 cuenta2 deposit |
	
	portfolio := Portfolio new.
	portfolioToAdd1 := Portfolio new.
	cuenta2 := ReceptiveAccount new.
	cuenta1 := ReceptiveAccount new.
	deposit := Deposit register: 100 on: cuenta1.
	portfolioToAdd1 addAccount: deposit.
	portfolio addPortfolio: portfolioToAdd1.
	
	self deny: (portfolio hasRegistered: deposit ).! !

!PortfolioTest methodsFor: 'tests' stamp: 'aa 10/28/2025 21:47:32'!
testXXaddEmptyPortfolioThenTransactionToAccount
	"|portfolio portfolioToAdd  cuenta|
	
	portfolio := Portfolio new.
	portfolioToAdd := Portfolio new.
	cuenta := ReceptiveAccount new.
	
	portfolioToAdd addAccount: cuenta.	
	portfolio addPortfolio: portfolioToAdd.
	
	Deposit register: 100 on: cuenta.
	
	
	
	self assert: portfolio value = (cuenta balance)."! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 17 54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 61 59 56 53 112 116 104 110 108 17 124 117 112 127 17 83 112 117 124 127 39 61 53 56 59 53 55 52 58 58 52 110 108 117 108 121 112 106 17 127 63 61 102 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 100 17 95 56 56 17 92 117 112 127 39 105 124 112 115 123 39 118 117 39 86 106 123 39 39 62 39 57 55 57 60 39 56 59 65 55 63 65 57 62 39 74 118 116 119 112 115 108 121 65 39 60 53 59 53 55 39 57 55 56 61 55 61 55 64 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 61 61 57 39 124 124 112 107 65 39 57 61 104 55 55 106 105 106 52 58 56 60 107 52 59 106 108 107 52 104 108 60 105 52 61 60 55 58 60 56 56 61 58 106 58 62 39 86 106 123 39 39 62 39 57 55 57 60 17 93 84 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 84 118 117 39 86 106 123 39 61 39 56 57 65 58 59 65 57 56 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 108 107 58 60 59 63 61 39 87 115 124 110 112 117 122 65 39 57 55 57 60 56 55 55 61 56 64 58 59 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 17 48 112 29 17 56 55 53 59 56 53 56 55 60 53 57 57 17 119 106 57 57 53 115 104 105 56 56 55 60 53 115 104 105 118 122 53 109 106 108 117 53 124 105 104 53 104 121 17 119 106 57 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 63 91 57 56 65 57 57 65 55 61 53 56 61 59 59 57 63 52 55 58 65 55 55 17 54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 107 108 122 106 104 121 110 104 53 122 123 17 62 63 63 57 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 57 63 91 57 57 65 55 59 65 58 62 53 63 56 59 58 55 58 52 55 58 65 55 55 17 54 111 118 116 108 54 76 122 123 124 107 112 104 117 123 108 54 75 108 122 106 104 121 110 104 122 54 115 112 117 124 127 61 59 54 115 112 117 124 127 61 59 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 87 118 121 123 109 118 115 112 118 52 76 113 108 121 106 112 106 112 118 53 122 123 17 56 57 61 59 60 17 52 52 52 52 52 52 52 52 52 52 17 17))!