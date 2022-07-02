Class {
	#name : #FsFlashCardBrowser,
	#superclass : #SpPresenter,
	#instVars : [
		'deck',
		'flashcardWidget',
		'showAnswerButton',
		'againButton',
		'goodButton',
		'easyButton'
	],
	#category : #'FlashcardsSt-UI'
}

{ #category : #specs }
FsFlashCardBrowser class >> defaultSpec [
	<spec>
	^ SpecLayout composed
		newColumn: [ :column1 | 
			column1
				"newColumn: [ :column2 | column2 add: #changesTree ];
				addSplitter;"
				add: #flashcardWidget;
				add: #showAnswerButton height: 35 ]
]

{ #category : #specs }
FsFlashCardBrowser class >> showAnswerSpec [
	<spec>
	^ SpecLayout composed
		newColumn: [ :column1 | 
			column1
				"newColumn: [ :column2 | column2 add: #changesTree ];
				addSplitter;"
				add: #flashcardWidget;
				newRow: [ :aRow |
					aRow
						add: #againButton;
						add: #goodButton;
						add: #easyButton ] height: 35 ]
]

{ #category : #accessing }
FsFlashCardBrowser >> againButton [
	^ againButton
]

{ #category : #accessing }
FsFlashCardBrowser >> deck [
	^ deck ifNil: [ deck := FsFlashCard testDeck ]
]

{ #category : #accessing }
FsFlashCardBrowser >> deck: anObject [
	deck := anObject.
	self flashcardWidget morph card: deck first
]

{ #category : #accessing }
FsFlashCardBrowser >> easyButton [
	^ easyButton
]

{ #category : #accessing }
FsFlashCardBrowser >> flashcardWidget [
	^ flashcardWidget
]

{ #category : #accessing }
FsFlashCardBrowser >> goodButton [
	^ goodButton
]

{ #category : #initialization }
FsFlashCardBrowser >> initializeWidgets [
	
	flashcardWidget := FsFlashCardMorph new 
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		asSpecAdapter.
	showAnswerButton := self newButton
		label: 'Show Answer';
		whenActionPerformedDo: [ 
			self needFullRebuild: false.
			flashcardWidget morph flip.
			self buildWithSpecLayout: self class showAnswerSpec ].
	againButton := self newButton label: 'Again'.
	goodButton := self newButton label: 'Good'.
	easyButton := self newButton label: 'Easy'.
]

{ #category : #accessing }
FsFlashCardBrowser >> showAnswerButton [
	^ showAnswerButton
]
