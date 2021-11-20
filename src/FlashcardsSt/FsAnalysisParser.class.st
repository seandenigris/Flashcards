Class {
	#name : #FsAnalysisParser,
	#superclass : #FsMultipleChoiceQuestionParser,
	#category : #'FlashcardsSt-Core'
}

{ #category : #examples }
FsAnalysisParser class >> answerInput: aString shouldHaveAnalysis: text order: order andGrade: grade [
	
	^ self 
		given: []
		when: [ self parse: '1. Question?
', aString ]
		then: [ :result | 
			result number should equal: 1.
			result text should equal: 'Question?'.
			result answerChoices should haveSize: 1.
			result answerChoices first order should equal: order.
			result answerChoices first grade should equal: grade.
			result answerChoices first analysis should equal: text ]
]

{ #category : #examples }
FsAnalysisParser class >> example [
	<gtExample>
	^ self 
		answerInput: 'a. +2 Choice 1' 
		shouldHaveAnalysis: 'Choice 1' 
		order: 1 
		andGrade: 2
]

{ #category : #examples }
FsAnalysisParser class >> exampleErrantSpaceInGrade [
	"Sometimes happens with OCR"
	<gtExample>
	
	^ self 
		answerInput: 'a. + 2 Choice 1' 
		shouldHaveAnalysis: 'Choice 1' 
		order: 1 
		andGrade: 2
]

{ #category : #accessing }
FsAnalysisParser >> choice [
	^ self choiceGrammar==> [ :n | 
		FsAnswerChoice new
			order: n first asciiValue - $a asciiValue + 1;
			grade: n third;
			analysis: n fifth trimBoth withSeparatorsCompacted;
			yourself ].
]

{ #category : #accessing }
FsAnalysisParser >> choiceGrammar [
	| grade |
	grade := (($+ asPParser / $- asPParser) optional, #space asPParser optional, #digit asPParser plus) flatten ==> [ :n | 
		(n select: [ :c | '1234567890-' includes: c ] ) asNumber ].
	^ self choicePrefix, #space asPParser optional, grade, #space asPParser optional, (self choicePrefix / self questionPrefix) negate plus flatten
]

{ #category : #accessing }
FsAnalysisParser >> newQuestionFromNumber: aNumber string: aString andChoices: aCollection [ 

	^ FsQuestion new
		number: aNumber;
		analysis: aString;
		answerChoices: aCollection;
		yourself
]
