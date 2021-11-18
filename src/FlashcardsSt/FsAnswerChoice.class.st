Class {
	#name : #FsAnswerChoice,
	#superclass : #Object,
	#instVars : [
		'order',
		'text',
		'grade',
		'analysis'
	],
	#category : #'FlashcardsSt-Core'
}

{ #category : #accessing }
FsAnswerChoice >> analysis [

	^ analysis
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
	^ self gradeText, ' ' asRopedText, self analysis asRopedText italic
]

{ #category : #'accessing-magritte' }
FsAnswerChoice >> descriptionGrade [
	<magritteDescription>
	^ MAOptionDescription new
		accessor: #grade;
		optionsTextual: 'Right Wrong -2 -1 0 1 2';
		yourself
]

{ #category : #'accessing-magritte' }
FsAnswerChoice >> descriptionOrder [
	<magritteDescription>
	^ MANumberDescription new
		accessor: #order;
		yourself
]

{ #category : #'accessing-magritte' }
FsAnswerChoice >> descriptionText [
	<magritteDescription>
	^ MAMemoDescription new
		accessor: #text;
		yourself
]

{ #category : #accessing }
FsAnswerChoice >> grade [
	^ self maLazyFrom: self descriptionGrade
]

{ #category : #accessing }
FsAnswerChoice >> grade: anObject [
	grade := anObject
]

{ #category : #predicates }
FsAnswerChoice >> letter [
	^ Character value: $a asciiValue + self order - 1
]

{ #category : #accessing }
FsAnswerChoice >> order [
	^ self maLazyFrom: self descriptionOrder
]

{ #category : #accessing }
FsAnswerChoice >> order: anObject [
	order := anObject
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
	^ self maLazyFrom: self descriptionText
]

{ #category : #accessing }
FsAnswerChoice >> text: anObject [
	text := anObject
]
