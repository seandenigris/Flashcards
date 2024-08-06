Class {
	#name : #FsScenario,
	#superclass : #Object,
	#instVars : [
		'questions',
		'source',
		'name',
		'lepiterPage',
		'lepiterDatabase'
	],
	#classVars : [
		'LepiterDatabase'
	],
	#category : #'FlashcardsSt-Core'
}

{ #category : #examples }
FsScenario class >> exampleEmpty [
	<gtExample>
	^ self new
		lepiterDatabase: LeDatabase new;
		yourself
]

{ #category : #accessing }
FsScenario class >> lepiterDatabase [
	LepiterDatabase ifNotNil: [ ^ LepiterDatabase ].
	
	^ LepiterDatabase := LeDatabase new
]

{ #category : #accessing }
FsScenario >> answerChoices [
	^ self questions flatCollect: #answerChoices
]

{ #category : #'accessing-magritte' }
FsScenario >> descriptionQuestions [
	<magritteDescription>
	^ MAToManyRelationDescription new
		accessor: #questions;
		default: OrderedCollection new;
		yourself
]

{ #category : #'accessing-magritte' }
FsScenario >> descriptionSource [
	<magritteDescription>
	^ MAToOneRelationDescription new
		accessor: #source;
		yourself
]

{ #category : #accessing }
FsScenario >> displayStringOn: aStream [
	name ifNil: [ ^ super printOn: aStream ].
	aStream
		nextPut: $";
		nextPutAll: self name;
		nextPut: $";
		nextPutAll: ' Scenario';
		crlf; crlf;
		print: self text asMarkdownString;
		crlf; crlf.
		
	self questions
		do: [ :q | aStream print: q ]
		separatedBy: [ aStream crlf; crlf ]
]

{ #category : #accessing }
FsScenario >> gtViewFullTextOn: aView [
	<gtView>
	
	^ aView text
		title: 'Text (Full)';
		priority: 20;
		text: [ self fullDisplayString ]
]

{ #category : #accessing }
FsScenario >> gtViewTextOn: aView [
	<gtView>
	
	^ aView forward
		title: 'Text';
		priority: 10;
		object: [ self text ];
		view: #gtLiveFor:
]

{ #category : #accessing }
FsScenario >> lepiterDatabase [
	^ lepiterDatabase ifNil: [ self class lepiterDatabase ]
]

{ #category : #accessing }
FsScenario >> lepiterDatabase: anLeDatabase [
	lepiterDatabase := anLeDatabase
]

{ #category : #accessing }
FsScenario >> lepiterPage [
	lepiterPage ifNotNil: [ ^ lepiterPage ].
	
	lepiterPage := LePage unnamedPageWithDefaultTitle: ''.
	^ self lepiterDatabase addPage: lepiterPage 
		"addSnippet: LeTextSnippet empty; from IdMind, not sure if applies here
		yourself"
]

{ #category : #accessing }
FsScenario >> name [

	^ self maLazyInstVarUsing: self nameDescription
]

{ #category : #accessing }
FsScenario >> name: anObject [
	name := anObject
]

{ #category : #'accessing-magritte' }
FsScenario >> nameDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #name;
		yourself
]

{ #category : #accessing }
FsScenario >> printOn: aStream [
	name ifNil: [ ^ super printOn: aStream ].
	aStream
		nextPut: $";
		nextPutAll: self name;
		nextPut: $";
		nextPutAll: ' Scenario'.
]

{ #category : #accessing }
FsScenario >> questions [

	^ self maLazyInstVarUsing: self descriptionQuestions
]

{ #category : #accessing }
FsScenario >> questions: anObject [
	questions := anObject
]

{ #category : #accessing }
FsScenario >> source [

	^ self maLazyInstVarUsing: self descriptionSource
]

{ #category : #accessing }
FsScenario >> source: anObject [
	source := anObject
]

{ #category : #accessing }
FsScenario >> sources [
	^ { self source }
]

{ #category : #accessing }
FsScenario >> text [
	^ self lepiterPage
]

{ #category : #accessing }
FsScenario >> title [
	^ self name
]
