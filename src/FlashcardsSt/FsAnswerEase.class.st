Class {
	#name : #FsAnswerEase,
	#superclass : #Object,
	#instVars : [
		'description'
	],
	#category : #'FlashcardsSt-Algorithm'
}

{ #category : #'instance creation' }
FsAnswerEase class >> again [
	^ self new
		description: 'Again';
		yourself
]

{ #category : #'instance creation' }
FsAnswerEase class >> easy [
	^ self new
		description: 'Easy';
		yourself
]

{ #category : #'instance creation' }
FsAnswerEase class >> good [
	^ self new
		description: 'Good';
		yourself
]

{ #category : #accessing }
FsAnswerEase >> description [
	^ description
]

{ #category : #accessing }
FsAnswerEase >> description: anObject [
	description := anObject
]

{ #category : #printing }
FsAnswerEase >> printOn: aStream [

	aStream nextPutAll: description
]
