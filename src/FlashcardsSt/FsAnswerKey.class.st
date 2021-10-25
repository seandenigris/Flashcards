Class {
	#name : #FsAnswerKey,
	#superclass : #Object,
	#instVars : [
		'answers'
	],
	#category : #'FlashcardsSt-Core'
}

{ #category : #'instance creation' }
FsAnswerKey class >> from: aString [
	| answer |
	answer := (#digit asPParser plus , '.' asPParser
		, #space asPParser optional , #letter asPParser) ==> #fourth.
	^ (answer separatedBy: #newline asPParser ==> [ :n | nil ])
		==> [ :n | FsAnswerKey new answers: (n reject: #isNil) ]
		parse: aString
]

{ #category : #convenience }
FsAnswerKey class >> import: inputString applyingTo: questionCollection [
	"
	inputString - of the form 1.C\cr2.B...
	questionCollection - should be in same order as answers"
	
	| key |
	key := self from: inputString.
	key applyTo: questionCollection
]

{ #category : #accessing }
FsAnswerKey >> answers [
	^ self maLazyFrom: self descriptionAnswers
]

{ #category : #accessing }
FsAnswerKey >> answers: anObject [
	answers := anObject
]

{ #category : #'as yet unclassified' }
FsAnswerKey >> applyTo: aCollection [ 
	aCollection doWithIndex: [ :e :i | 
		| correctLetter correctChoice |
		correctLetter := (self answers at: i) lowercase.
		correctChoice := e answerChoices detect: [ :ac | ac letter = correctLetter ].
		correctChoice grade: #Right ].
]

{ #category : #'accessing-magritte' }
FsAnswerKey >> descriptionAnswers [
	<magritteDescription>
	^ MAToManyRelationDescription new
		accessor: #answers;
		yourself
]
