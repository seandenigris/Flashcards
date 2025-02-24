Class {
	#name : #FsAnswerChoice,
	#superclass : #Object,
	#traits : 'FsTTestMaterial',
	#classTraits : 'FsTTestMaterial classTrait',
	#instVars : [
		'order',
		'text',
		'grade',
		'analysis'
	],
	#category : #'FlashcardsSt-Core'
}

{ #category : #accessing }
FsAnswerChoice class >> exampleBestA [
	<gtExample>
	^ self
		given: []
		when: [ 
			self new
				order: 1;
				text: 'Best choice';
				grade: 2;
				analysis: 'This choice is better than the others';
				yourself ]
		then: [ :result | 
			result letter should equal: $a. ]
]

{ #category : #accessing }
FsAnswerChoice class >> exampleGoodD [
	<gtExample>
	^ self
		given: []
		when: [ 
			self new
				order: 4;
				text: 'Good choice';
				grade: 1;
				analysis: 'This choice is good, but not the best';
				yourself ]
		then: [ :result | 
			result letter should equal: $d. ]
]

{ #category : #examples }
FsAnswerChoice class >> exampleImportAnalysis [
	<gtExample>
	^ self
		given: [ self new order: 2; yourself ]
		when: [ :inst |
			inst importAnalysisFrom: 'b. +1 This choice is good, but not the best' ]
		then: [ :result | 
			result grade should equal: 1.
			result analysis should equal: 'This choice is good, but not the best'. ]
]

{ #category : #accessing }
FsAnswerChoice class >> exampleNeutralC [
	<gtExample>
	^ self
		given: []
		when: [ 
			self new
				order: 3;
				text: 'Neutral choice';
				grade: 2;
				analysis: 'This choice is average compared to the others';
				yourself ]
		then: [ :result | 
			result letter should equal: $c. ]
]

{ #category : #accessing }
FsAnswerChoice class >> exampleWorstB [
	<gtExample>
	^ self
		given: []
		when: [ 
			self new
				order: 2;
				text: 'Worst choice';
				grade: -2;
				analysis: 'This choice is worse than the others';
				yourself ]
		then: [ :result | 
			result letter should equal: $b. ]
]

{ #category : #accessing }
FsAnswerChoice >> analysis [

	^ analysis ifNil: [ '' ]
]

{ #category : #accessing }
FsAnswerChoice >> analysis: anObject [

	analysis := anObject
]

{ #category : #'accessing-magritte' }
FsAnswerChoice >> analysisDescription [
	<magritteDescription>
	^ MAMemoDescription new
		accessor: #analysis;
		default: '';
		yourself
]

{ #category : #accessing }
FsAnswerChoice >> analysisText [
	| hasNothingToShow |
	hasNothingToShow := self gradeText isEmpty and: [ self analysis isEmpty ].
	hasNothingToShow ifTrue: [ ^ '' asRopedText ].
	^ self gradeText, ' ' asRopedText, self analysis asRopedText italic
]

{ #category : #accessing }
FsAnswerChoice >> asElement [
	^ FsAnswerChoiceElement on: self
]

{ #category : #accessing }
FsAnswerChoice >> elementGtViewFor: aView [
	<gtView>
	^ aView explicit
		title: 'Element';
		priority: 25;
		stencil: [ 
			BlScrollableElement new 
				constraintsDo: [ :c |
					c horizontal matchParent.
					c vertical matchParent ];
				addChild: self asElement;
				yourself ]
]

{ #category : #accessing }
FsAnswerChoice >> grade [

	^ self maLazyInstVarUsing: self gradeDescription
]

{ #category : #accessing }
FsAnswerChoice >> grade: anObject [
	grade := anObject
]

{ #category : #'accessing-magritte' }
FsAnswerChoice >> gradeDescription [
	<magritteDescription>
	^ MAOptionDescription new
		accessor: #grade;
		optionsTextual: 'Right Wrong -2 -1 0 1 2';
		yourself
]

{ #category : #accessing }
FsAnswerChoice >> gradeText [
	| result |
	self grade 
		ifNotNil: [ :g | result := g asRopedText ]
		ifNil: [ ^ '' asRopedText ].
		
	self grade = 2 ifTrue: [ ^ result foreground: Color green ].
	self grade = 1 ifTrue: [ ^ result foreground: Color yellow darker darker ].
	self grade = -1 ifTrue: [ ^ result foreground: Color orange ].
	self grade = -2 ifTrue: [ ^ result foreground: Color red ].
	^ result
]

{ #category : #importing }
FsAnswerChoice >> importAnalysisFrom: aString [
	"aString - format is '{choice name}\.? \+?{grade} {analysis}' e.g. 'a. +2 this is the right answer because it is the best'"

	^ aString
		readStreamDo: [ :str | 
			| gradeString listMarker anOrder |
			listMarker := str next.
			anOrder := listMarker isDigit
				ifTrue: [ listMarker asNumber ]
				ifFalse: [ listMarker asUppercase asciiValue - $A asciiValue + 1 ].
			anOrder = self order ifFalse: [ self error: 'this doesn''t seem to be an analysis of this particular choice' ].
			str upTo: Character space.
			gradeString := str upTo: Character space.
			self
				order: anOrder;
				grade: gradeString squeezeOutNumber;
				analysis: str upToEnd ]
]

{ #category : #predicates }
FsAnswerChoice >> letter [
	^ Character value: $a asciiValue + self order - 1
]

{ #category : #accessing }
FsAnswerChoice >> order [

	^ self maLazyInstVarUsing: self orderDescription
]

{ #category : #accessing }
FsAnswerChoice >> order: anObject [
	order := anObject
]

{ #category : #'accessing-magritte' }
FsAnswerChoice >> orderDescription [
	<magritteDescription>
	^ MANumberDescription new
		accessor: #order;
		default: 1;
		yourself
]

{ #category : #printing }
FsAnswerChoice >> printOn: aStream [
	"If we wanted to show whether the answer was correct or not:
			self grade = #Right ifTrue: [ aStream nextPut: $* ]."
	aStream
		nextPutAll: self letter asString;
		nextPutAll: '. ';
		nextPutAll: self text
]

{ #category : #accessing }
FsAnswerChoice >> text [

	^ self maLazyInstVarUsing: self textDescription
]

{ #category : #accessing }
FsAnswerChoice >> text: anObject [
	text := anObject
]

{ #category : #'accessing-magritte' }
FsAnswerChoice >> textDescription [
	<magritteDescription>
	^ MAMemoDescription new
		accessor: #text;
		default: '';
		yourself
]
