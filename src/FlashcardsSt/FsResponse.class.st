Class {
	#name : #FsResponse,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'question',
		'duration',
		'grade'
	],
	#category : #'FlashcardsSt-Core'
}

{ #category : #accessing }
FsResponse >> duration [
	^ self maLazyFromDescriptionOf: #duration
]

{ #category : #accessing }
FsResponse >> duration: anObject [
	duration := anObject
]

{ #category : #'accessing-magritte' }
FsResponse >> durationDescription [
	<magritteDescription>
	^ MADurationDescription new
		accessor: #duration;
		yourself
]

{ #category : #accessing }
FsResponse >> grade [
	^ self maLazyFromDescriptionOf: #grade
]

{ #category : #accessing }
FsResponse >> grade: anObject [
	grade := anObject
]

{ #category : #'accessing-magritte' }
FsResponse >> gradeDescription [
	<magritteDescription>
	^ MAToOneRelationDescription new
		accessor: #grade;
		classes:(Set new add: FsAnswerGrade; yourself);
		yourself
]

{ #category : #accessing }
FsResponse >> question [
	^ question
]

{ #category : #accessing }
FsResponse >> question: anObject [
	question := anObject
]

{ #category : #'accessing-magritte' }
FsResponse >> questionDescription [
	<magritteDescription>
	^ MAToOneRelationDescription new
		accessor: #question;
		classes: (Set new add: FsQuestion; yourself);
		yourself
]

{ #category : #accessing }
FsResponse >> timestamp [
	^ timestamp
]

{ #category : #accessing }
FsResponse >> timestamp: anObject [
	timestamp := anObject
]

{ #category : #'accessing-magritte' }
FsResponse >> timestampDescription [
	<magritteDescription>
	^ MADateAndTimeDescription new
		accessor: #timestamp;
		yourself
]
