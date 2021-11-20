Extension { #name : #String }

{ #category : #'*FlashcardsSt' }
String >> fsExportAnalysisTo: anFsQuestion [
	| lines |
	lines := self lines reject: [ :l | l trimBoth isEmpty ].
	lines readStreamDo: [ :str |
		lines size > anFsQuestion answerChoices size ifTrue: [ anFsQuestion analysis: str next trimBoth capitalized ].
		anFsQuestion answerChoices do: [ :ans | ans analysis: str next trimBoth capitalized ] ]
]
