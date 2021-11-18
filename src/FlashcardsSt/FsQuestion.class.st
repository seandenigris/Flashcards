Class {
	#name : #FsQuestion,
	#superclass : #Object,
	#instVars : [
		'number',
		'text',
		'answerChoices',
		'sources',
		'analysis'
	],
	#classVars : [
		'Bank'
	],
	#category : #'FlashcardsSt-Core'
}

{ #category : #'instance creation' }
FsQuestion class >> allFrom: aString [
	^ self parser plus parse: aString
]

{ #category : #'instance creation' }
FsQuestion class >> bank [
	^ Bank ifNil: [ Bank := Bag new ]
]

{ #category : #'instance creation' }
FsQuestion class >> exportAsCSV [
	<script>
	| nonScenarios fileBase |
	nonScenarios := self bank select: [ :e | e questions size = 1 ].
	fileBase := 'fs-export-', DateAndTime now asString.
	FileLocator imageDirectory / fileBase, 'csv' writeStreamDo: [ :s | 
		(NeoCSVWriter on: s)
			addField: #text;
			addField: [ :e | e bestAnswer text ];
			nextPutAll: nonScenarios ]
]

{ #category : #'instance creation' }
FsQuestion class >> from: aString [
	^ self parser parse: aString
]

{ #category : #'instance creation' }
FsQuestion class >> parser [
	| choiceLetter choicePrefix choice question questionPrefix |
	questionPrefix := #startOfLine asPParser, #digit asPParser plus flatten, '. ' asPParser ==> #second.
	choiceLetter := $a asPParser / $b asPParser / $c asPParser
		/ $d asPParser.
	choicePrefix := #startOfLine asPParser, choiceLetter , '. ' asPParser ==> #second.
	choice := choicePrefix, (choicePrefix / questionPrefix) negate plus flatten
		==> [ :n | 
			FsAnswerChoice new
				order: n first asciiValue - $a asciiValue + 1;
				text: n second trimRight withSeparatorsCompacted;
				yourself ].
	question := questionPrefix optional, (choicePrefix / questionPrefix) negate plus flatten.
	^ question , choice star
		==> [ :n | 
			self new
				number: n first asString asNumber;
				text: n second trimRight withSeparatorsCompacted;
				answerChoices: n third;
				yourself ].
]

{ #category : #accessing }
FsQuestion >> addAnalysis: aQuestion [
	self number ~= aQuestion number ifTrue: [ self error: 'Question number mismatch' ].
	self analysis: aQuestion analysis.
	aQuestion answerChoices doWithIndex: [ :ans :i |
		| target |
		target := self answerChoices at: i.
		target grade: ans grade.
		target analysis: ans analysis ]
]

{ #category : #accessing }
FsQuestion >> analysis [

	^ self maLazyInstVarUsing: self analysisDescription
]

{ #category : #accessing }
FsQuestion >> analysis: aString [
	analysis := aString
]

{ #category : #'accessing-magritte' }
FsQuestion >> analysisDescription [
	<magritteDescription>
	^ MAMemoDescription new
		accessor: #analysis;
		yourself
]

{ #category : #accessing }
FsQuestion >> answerChoices [

	^ self maLazyInstVarUsing: self answerChoicesDescription
]

{ #category : #accessing }
FsQuestion >> answerChoices: anObject [
	answerChoices := anObject
]

{ #category : #'accessing-magritte' }
FsQuestion >> answerChoicesDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		accessor: #answerChoices;
		classes: { FsAnswerChoice };
		default: OrderedCollection new;
		yourself
]

{ #category : #accessing }
FsQuestion >> asElement [
	^ FsQuestionElement on: self.
]

{ #category : #converting }
FsQuestion >> asFlashCard [
	^ FsFlashCard new
			question: self;
			yourself
]

{ #category : #accessing }
FsQuestion >> bestAnswer [
	^ self answerChoices detectMax: [ :e | e grade score ]
]

{ #category : #accessing }
FsQuestion >> gtElementViewFor: aView [
	<gtView>
	^ aView explicit
		title: 'Element';
		priority: 25;
		stencil: [ self asElement ]
]

{ #category : #'as yet unclassified' }
FsQuestion >> gtInspectorTextIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite text
		title: 'Question';
		display: [ self ]
]

{ #category : #accessing }
FsQuestion >> number [

	^ self maLazyInstVarUsing: self numberDescription
]

{ #category : #accessing }
FsQuestion >> number: anObject [
	number := anObject
]

{ #category : #'accessing-magritte' }
FsQuestion >> numberDescription [
	<magritteDescription>
	^ MANumberDescription new
		accessor: #number;
		yourself
]

{ #category : #printing }
FsQuestion >> printOn: aStream [
	aStream
		nextPutAll: self text;
		cr.
	self answerChoices
		do: [ :ac | aStream tab; print: ac ]
		separatedBy: [ aStream cr ]
]

{ #category : #'scenario compatibility' }
FsQuestion >> questions [
	^ { self }
]

{ #category : #accessing }
FsQuestion >> sources [

	^ self maLazyInstVarUsing: self sourcesDescription
]

{ #category : #accessing }
FsQuestion >> sources: anObject [
	sources := anObject
]

{ #category : #'accessing-magritte' }
FsQuestion >> sourcesDescription [
	<magritteDescription>
	^ MAToManyRelationDescription new
		accessor: #sources;
		classes: QuCitation subclasses;
		default: Bag new;
		yourself
]

{ #category : #accessing }
FsQuestion >> text [

	^ self maLazyInstVarUsing: self textDescription
]

{ #category : #accessing }
FsQuestion >> text: anObject [
	text := anObject
]

{ #category : #'accessing-magritte' }
FsQuestion >> textDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #text;
		yourself
]
