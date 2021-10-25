Class {
	#name : #FsScenario,
	#superclass : #Object,
	#instVars : [
		'questions',
		'source',
		'name'
	],
	#category : #'FlashcardsSt-Core'
}

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
FsScenario >> name [
	^ self maLazyFrom: self descriptionName
]

{ #category : #accessing }
FsScenario >> name: anObject [
	name := anObject
]

{ #category : #accessing }
FsScenario >> questions [
	^ self maLazyFrom: self descriptionQuestions
]

{ #category : #accessing }
FsScenario >> questions: anObject [
	questions := anObject
]

{ #category : #accessing }
FsScenario >> source [
	^ self maLazyFrom: self descriptionSource
]

{ #category : #accessing }
FsScenario >> source: anObject [
	source := anObject
]
