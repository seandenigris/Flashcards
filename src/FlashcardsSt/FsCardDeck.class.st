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
FsCardDeck >> gtGtSpotterFullFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		priority: 5;
		title: 'Full Search';
		allCandidates: [ self cards ];
		filter: GtFilterSubstrings;
		candidatesLimit: 7;
		itemName: #fullDisplayString
]

{ #category : #accessing }
FsCardDeck >> gtGtSpotterTitlesFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		priority: 5;
		title: 'Titles';
		allCandidates: [ self cards ];
		filter: GtFilterSubstrings;
		candidatesLimit: 7;
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
		actionUpdateButtonTooltip: 'Update'.
]
