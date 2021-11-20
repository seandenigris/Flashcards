Class {
	#name : #FsQuestionParser,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'choiceGrammar'
	],
	#category : #'FlashcardsSt-Core'
}

{ #category : #examples }
FsQuestionParser class >> example [
	<gtExample>
	^ self 
		given: []
		when: [ self parse: '1. Question?
a. Choice 1
b. Choice 2
c. Choice 3
d. Choice 4' ]
		then: [ :result | 
			result number should equal: 1.
			result text should equal: 'Question?'.
			result answerChoices should haveSize: 4.
			result answerChoices first order should equal: 1.
			result answerChoices first text should equal: 'Choice 1'. ]
]

{ #category : #accessing }
FsQuestionParser >> choice [
	^ self choiceGrammar==> [ :n | 
		FsAnswerChoice new
			order: n first asciiValue - $a asciiValue + 1;
			text: n second trimBoth withSeparatorsCompacted;
			yourself ].
]

{ #category : #accessing }
FsQuestionParser >> choiceGrammar [

	^ self choicePrefix, (self choicePrefix / self questionPrefix) negate plus flatten
]

{ #category : #accessing }
FsQuestionParser >> choiceLetter [

	^ PP2PredicateObjectNode anyOf: 'abcdABCD'
]

{ #category : #accessing }
FsQuestionParser >> choicePrefix [
	| choiceLetter |
	choiceLetter := PP2PredicateObjectNode anyOf: 'abcdABCD'. "case is a common OCR error, so accept either"
	^ #startOfLine asPParser, 
		choiceLetter, 
			#space asPParser optional, "common OCR error"
				'.' asPParser ==> [ :n | n second asLowercase ].
]

{ #category : #accessing }
FsQuestionParser >> newQuestionFromNumber: aNumber string: aString andChoices: aCollection [ 

	^ FsQuestion new
		number: aNumber;
		text: aString;
		answerChoices: aCollection;
		yourself
]

{ #category : #accessing }
FsQuestionParser >> questionPrefix [
	^ #startOfLine asPParser, #digit asPParser plus flatten, 
		#space asPParser optional, "common OCR error"
		'.' asPParser ==> #second.
]

{ #category : #accessing }
FsQuestionParser >> start [
	| question |
	question := self questionPrefix optional, (self choicePrefix "/ self questionPrefix") negate plus flatten.
	^ question , self choice plus ==> [ :n | 
		self 
			newQuestionFromNumber: n first asString asNumber
			string: n second trimBoth withSeparatorsCompacted
			andChoices: n third ].
]
