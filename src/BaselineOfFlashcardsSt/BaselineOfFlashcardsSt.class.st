Class {
	#name : #BaselineOfFlashcardsSt,
	#superclass : #BaselineOf,
	#category : #BaselineOfFlashcardsSt
}

{ #category : #testing }
BaselineOfFlashcardsSt class >> isDynabook [
	^ true
]

{ #category : #baseline }
BaselineOfFlashcardsSt >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'Magritte' with: [ spec repository: 'github://seandenigris/Magritte' ];
			baseline: 'QuoteMe' with: [ spec repository: 'github://seandenigris/Quote-Me' ];
			baseline: 'SimplePersistence' with: [ spec repository: 'github://seandenigris/Simple-Persistence' ].
		spec package: #FlashcardsSt with: [ spec requires: #(#'Magritte' #QuoteMe #'SimplePersistence') ] ]
]
