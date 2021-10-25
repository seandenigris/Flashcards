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

{ #category : #'accessing-magritte' }
FsResponse >> descriptionDuration [
	<magritteDescription>
	^ MADurationDescription new
		accessor: #duration;
		yourself
]

{ #category : #'accessing-magritte' }
FsResponse >> descriptionGrade [
	<magritteDescription>
	^ MAToOneRelationDescription new
		accessor: #grade;
		classes:(Set new add: FsAnswerGrade; yourself);
		yourself
]

{ #category : #'accessing-magritte' }
FsResponse >> descriptionQuestion [
	<magritteDescription>
	^ MAToOneRelationDescription new
		accessor: #question;
		classes: (Set new add: FsQuestion; yourself);
		yourself
]

{ #category : #'accessing-magritte' }
FsResponse >> descriptionTimestamp [
	<magritteDescription>
	^ MADateAndTimeDescription new
		accessor: #timestamp;
		yourself
]

{ #category : #accessing }
FsResponse >> duration [
	^ self maLazyFromDescriptionOf: #duration
]

{ #category : #accessing }
FsResponse >> duration: anObject [
	duration := anObject
]

{ #category : #accessing }
FsResponse >> grade [
	^ self maLazyFromDescriptionOf: #grade
]

{ #category : #accessing }
FsResponse >> grade: anObject [
	grade := anObject
]

{ #category : #accessing }
FsResponse >> question [
	^ question
]

{ #category : #accessing }
FsResponse >> question: anObject [
	question := anObject
]

{ #category : #accessing }
FsResponse >> timestamp [
	^ timestamp
]

{ #category : #accessing }
FsResponse >> timestamp: anObject [
	timestamp := anObject
]
