Class {
	#name : #FsCardDeck,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'FlashcardsSt-Core'
}

{ #category : #accessing }
FsCardDeck >> cards [
	^ cards ifNil: [ cards := OrderedCollection new ]
]
