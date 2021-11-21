"
#Analysis
See implementors of `#fsExportAnalysisTo:`. Test prep sources present analysis in two common ways:
1. Some structure the analysis to mirror the question i.e. general analysis, followed by analysis for each choice starting with the choice's letter. In that case, we can parse the analysis itself as a question and import from there. 
2. Some have a free-form paragraph explanation. In this case, it's generally easiest to rework the information into a paragraph, where the first optional line is general analysis of the question and the remaining lines each explain one answer choice.
"
Class {
	#name : #FsQuestion,
	#superclass : #Object,
	#traits : 'FsTTestMaterial',
	#classTraits : 'FsTTestMaterial classTrait',
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
	^ self parser new plus parse: aString
]

{ #category : #'instance creation' }
FsQuestion class >> bank [
	^ Bank ifNil: [ Bank := Bag new ]
]

{ #category : #examples }
FsQuestion class >> example [
	<gtExample>
	^ self
		given: []
		when: [ 
			self new
				number: 1;
				text: 'Question?';
				analysis: 'This question is straighforward. Don''t ready into it!';
				answerChoices: { 
					FsAnswerChoice exampleBestA.
					FsAnswerChoice exampleWorstB.
					FsAnswerChoice exampleNeutralC.
					FsAnswerChoice exampleGoodD };
				yourself ]
		then: [ :result |
			result bestAnswer should equal: result answerChoices first ]
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
	^ FsMultipleChoiceQuestionParser
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
		default: '';
		yourself
]

{ #category : #accessing }
FsQuestion >> analysisText [
	^ self analysis asRopedText italic
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
	^ self answerChoices detectMax: [ :e | e grade "score" ]
]

{ #category : #accessing }
FsQuestion >> fsExportAnalysisTo: aQuestion [

	self number ~= aQuestion number ifTrue: [ self error: 'Question number mismatch' ].
	aQuestion analysis: self analysis.
	self answerChoices doWithIndex: [ :ans :i |
		| target |
		target := aQuestion answerChoices at: i.
		target grade: ans grade.
		target analysis: ans analysis ]
]

{ #category : #accessing }
FsQuestion >> gtElementViewFor: aView [
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

{ #category : #'as yet unclassified' }
FsQuestion >> gtInspectorTextIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite text
		title: 'Question';
		display: [ self ]
]

{ #category : #accessing }
FsQuestion >> importAnalysisFrom: aQuestionOrString [
	aQuestionOrString fsExportAnalysisTo: self
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
FsQuestion >> rightAnswerIndex: aNumber [
	self answerChoices doWithIndex: [ :ans :i |
		i = aNumber
			ifTrue: [ ans grade: 2 ]
			ifFalse: [ ans grade: -2 ] ]
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
	^ MAMemoDescription new
		accessor: #text;
		yourself
]
