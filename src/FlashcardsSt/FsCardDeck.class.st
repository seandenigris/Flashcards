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

{ #category : #accessing }
FsCardDeck >> gtGtSpotterFullFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 5;
		title: 'Full Search';
		items: [ self cards ];
		matchSubstrings;
		itemName: #fullDisplayString
]

{ #category : #accessing }
FsCardDeck >> gtGtSpotterTitlesFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 5;
		title: 'Titles';
		items: [ self cards ];
		matchSubstrings;
		itemName: #title
]

{ #category : #accessing }
FsCardDeck >> gtViewCardsOn: aView [
	<gtView>

	(self cards isEmpty) ifTrue: [ ^ aView empty ].
	^ aView tree
		title: 'Cards' translated;
		priority: 25;
		items: [ self cards ];
		children: [ :each | 
			(each isKindOf: FsScenario)
				ifTrue: [ each questions ]
				ifFalse: [ #() ] ];
		itemText: #title;
		actionUpdateButton
]
