Class {
	#name : #FsAnkiAlgorithm,
	#superclass : #Object,
	#instVars : [
		'scorecard'
	],
	#category : #'FlashcardsSt-Algorithm'
}

{ #category : #testing }
FsAnkiAlgorithm >> isLearning: aFsQuestion [ 
	^ scorecard anySatisfy: [ :e | e question = aFsQuestion and: [ e timestamp asDate = Date today ] ]
]

{ #category : #testing }
FsAnkiAlgorithm >> isNew: aFsQuestion [ 
	^ scorecard noneSatisfy: [ :e | e question = aFsQuestion ]
]

{ #category : #testing }
FsAnkiAlgorithm >> isReview: aFsQuestion [ 
	scorecard 
		select: [ :e | e question = aFsQuestion ]
		thenDo: [ :e | e timestamp asDate = Date today ifTrue: [ ^ false ] ]
		ifNone: [ ^ false ].
	^ true
		
]

{ #category : #'as yet unclassified' }
FsAnkiAlgorithm >> scorecard [
	^ scorecard
]

{ #category : #accessing }
FsAnkiAlgorithm >> scorecard: aCollection [ 
	scorecard := aCollection
]
