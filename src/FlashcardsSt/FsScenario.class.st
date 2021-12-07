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

{ #category : #accessing }
FsScenario >> contents [
	^ self lepiterPage
]

{ #category : #'accessing-magritte' }
FsScenario >> descriptionName [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #name;
		yourself
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
FsScenario >> gtViewContentsOn: aView [
	<gtView>
	
	^ aView forward
		title: 'Contents';
		priority: 10;
		object: [ self contents ];
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

	^ self maLazyInstVarUsing: self descriptionName
]

{ #category : #accessing }
FsScenario >> name: anObject [
	name := anObject
]

{ #category : #accessing }
FsScenario >> printOn: aStream [
	name
		ifNotNil: [ 
			aStream
				nextPut: $";
				nextPutAll: self name;
				nextPut: $";
				nextPutAll: ' Scenario' ]
		ifNil: [ super printOn: aStream ]
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
