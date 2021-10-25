Class {
	#name : #FsAnswerGrade,
	#superclass : #Object,
	#traits : 'TComparable',
	#classTraits : 'TComparable classTrait',
	#instVars : [
		'description',
		'score'
	],
	#category : #'FlashcardsSt-Core'
}

{ #category : #accessing }
FsAnswerGrade class >> all [
	| data generated |
	data := #(
		(2)
		(1)
		(0)
		(-1)
		(-2)).
	generated := data collect: [ :e |
		self new
			score: e last;
			yourself ].
		
	^ { self right. self wrong }, generated.
]

{ #category : #accessing }
FsAnswerGrade class >> right [
	^ self new
			description: #Right;
			score: 3;
			yourself.
]

{ #category : #accessing }
FsAnswerGrade class >> wrong [
	^ self new
			description: #Wrong;
			score: -3;
			yourself.
]

{ #category : #comparing }
FsAnswerGrade >> < rhs [
	^ self score < rhs score
]

{ #category : #comparing }
FsAnswerGrade >> = rhs [
	^ self score = rhs score
]

{ #category : #accessing }
FsAnswerGrade >> description [
	^ self maLazyFromDescriptionOf: #description
]

{ #category : #accessing }
FsAnswerGrade >> description: anObject [
	description := anObject
]

{ #category : #'accessing-magritte' }
FsAnswerGrade >> descriptionDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #description;
		yourself
]

{ #category : #'accessing-magritte' }
FsAnswerGrade >> descriptionScore [
	<magritteDescription>
	^ MANumberDescription new
		accessor: #score;
		required: true;
		yourself
]

{ #category : #comparing }
FsAnswerGrade >> hash [
	^ self score hash
]

{ #category : #printing }
FsAnswerGrade >> printOn: aStream [
	description 
		ifNotNil: [ aStream nextPutAll: description ]
		ifNil: [ aStream print: score ].
]

{ #category : #accessing }
FsAnswerGrade >> score [
	^ self maLazyFrom: self descriptionScore
]

{ #category : #accessing }
FsAnswerGrade >> score: anObject [
	score := anObject
]
