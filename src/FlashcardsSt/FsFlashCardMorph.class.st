Class {
	#name : #FsFlashCardMorph,
	#superclass : #Morph,
	#instVars : [
		'card',
		'isFlipped'
	],
	#category : #'FlashcardsSt-UI'
}

{ #category : #examples }
FsFlashCardMorph class >> example1 [
	<gtExample>
	^ self new openInWindow.
]

{ #category : #private }
FsFlashCardMorph >> card [
	^ card
]

{ #category : #private }
FsFlashCardMorph >> card: flashCard [
	card := flashCard.
	self reset.
]

{ #category : #private }
FsFlashCardMorph >> flip [
	self isShowingBack
		ifFalse: [ self showBack ]
		ifTrue: [ self reset ]
]

{ #category : #initialization }
FsFlashCardMorph >> initialize [
	super initialize.
	self 
		color: Color white;
		changeTableLayout;
		listCentering: #center;
		listDirection: #topToBottom;
		wrapCentering: #center;
		cellInset: 10;
		layoutInset: 25.
]

{ #category : #private }
FsFlashCardMorph >> isShowingBack [
	^ self submorphs size > 1
]

{ #category : #private }
FsFlashCardMorph >> reset [
	self removeAllMorphs.
	self addMorphBack: (self card front asMorph color: Color black; yourself).
]

{ #category : #private }
FsFlashCardMorph >> showBack [
	self addMorphBack: ((LineMorph from: 0@0 to: 100@0 color: Color black width: 2) hResizing: #spaceFill).
	self addMorphBack: (self card back asMorph color: Color black; yourself)
]
