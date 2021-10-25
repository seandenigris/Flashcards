"
self new
"
Class {
	#name : #FsScorecard,
	#superclass : #Object,
	#instVars : [
		'material',
		'resultMap'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'FlashcardsSt-Core'
}

{ #category : #'as yet unclassified' }
FsScorecard class >> uniqueInstance [

	^ uniqueInstance ifNil: [ uniqueInstance := self new ]
]

{ #category : #accessing }
FsScorecard >> material [

	^ material ifNil: [ material := OrderedCollection new ].
]

{ #category : #private }
FsScorecard >> resultMap [

	resultMap ifNotNil: [ ^ resultMap ].
	resultMap := Dictionary new.
	self material do: [ :e | resultMap at: e put: OrderedCollection new ].
	^ resultMap
]

{ #category : #'as yet unclassified' }
FsScorecard >> unmasteredQuestions [
	
	| unmasteredQuestions |
	unmasteredQuestions := self resultMap select: [ :col | (col size < 2) or: [ 
			| lastTwo |
			lastTwo := col last: 2.
			lastTwo anySatisfy: [ :result | result wasCorrect not ] ] ].
	^ unmasteredQuestions keys atRandom
]
