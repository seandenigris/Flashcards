Class {
	#name : #FsFlashCard,
	#superclass : #Object,
	#instVars : [
		'question'
	],
	#classInstVars : [
		'deck'
	],
	#category : #'FlashcardsSt-Core'
}

{ #category : #accessing }
FsFlashCard class >> deck [
	^ deck ifNil: [ deck := FsCardDeck new ]
]

{ #category : #accessing }
FsFlashCard class >> deck: anObject [
	deck := anObject
]

{ #category : #persistence }
FsFlashCard class >> restoreFrom: anObject [

	deck := anObject.
]

{ #category : #persistence }
FsFlashCard class >> spData [

	^ deck
]

{ #category : #accessing }
FsFlashCard class >> testDeck [
	<sampleInstance>
	^ OrderedCollection newFrom: { 
			FsFlashCard new
				question: '1 + 1';
				answer: '2';
				yourself.
			FsFlashCard new
				question: '2 + 2';
				answer: '4';
				yourself. }
]

{ #category : #converting }
FsFlashCard >> asMorph [
	^ FsFlashCardMorph new card: self; yourself
]

{ #category : #accessing }
FsFlashCard >> back [
	^ self question bestAnswer text
]

{ #category : #accessing }
FsFlashCard >> front [
	^ self question text
]

{ #category : #printing }
FsFlashCard >> printOn: aStream [
	aStream
		nextPutAll: 'Q: ';
		print: self question
]

{ #category : #accessing }
FsFlashCard >> question [
	^ question
]

{ #category : #accessing }
FsFlashCard >> question: anObject [
	question := anObject
]
