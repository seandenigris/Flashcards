Class {
	#name : #FsMultipleChoiceQuestionParser,
	#superclass : #PP2CompositeNode,
	#instVars : [
		'choiceGrammar'
	],
	#category : #'FlashcardsSt-Core'
}

{ #category : #examples }
FsMultipleChoiceQuestionParser class >> example [
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
FsMultipleChoiceQuestionParser >> choice [
	^ self choiceGrammar==> [ :n | 
		FsAnswerChoice new
			order: n first asciiValue - $a asciiValue + 1;
			text: n second trimBoth withSeparatorsCompacted;
			yourself ].
]

{ #category : #accessing }
FsMultipleChoiceQuestionParser >> choiceGrammar [

	^ self choicePrefix, (self choicePrefix / self questionPrefix / (#startOfLine asPParser, #newline asPParser)) negate plus flatten
]

{ #category : #accessing }
FsMultipleChoiceQuestionParser >> choiceLetter [

	^ PP2PredicateObjectNode anyOf: 'abcdABCD'
]

{ #category : #accessing }
FsMultipleChoiceQuestionParser >> choicePrefix [
	| choiceLetter |
	choiceLetter := PP2PredicateObjectNode anyOf: 'abcdABCD'. "case is a common OCR error, so accept either"
	^ #startOfLine asPParser,  #space asPParser star, choiceLetter, 
		#space asPParser optional, "common OCR error"
			'.' asPParser, $) asPParser optional ==> [ :n | n third asLowercase ].
]

{ #category : #accessing }
FsMultipleChoiceQuestionParser >> newQuestionFromNumber: aNumber string: aString andChoices: aCollection [ 

	^ FsQuestion new
		number: aNumber;
		text: aString;
		answerChoices: aCollection;
		yourself
]

{ #category : #accessing }
FsMultipleChoiceQuestionParser >> questionPrefix [
	^ #startOfLine asPParser, #space asPParser star, #digit asPParser plus flatten, 
		#space asPParser optional, "common OCR error"
		'.' asPParser, $) asPParser optional ==> #third.
]

{ #category : #accessing }
FsMultipleChoiceQuestionParser >> start [
	| question |
	question := self questionPrefix optional, (self choicePrefix "/ self questionPrefix") negate plus flatten.
	^ question , self choice plus ==> [ :nodes | 
		| number |
		number := nodes first ifNotNil: [ :num | num asString asNumber ].
		self 
			newQuestionFromNumber: number
			string: nodes second trimBoth withSeparatorsCompacted
			andChoices: nodes third ].
]
