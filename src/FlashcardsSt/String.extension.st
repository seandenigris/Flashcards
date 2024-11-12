Extension { #name : #String }

{ #category : #'*FlashcardsSt' }
String >> fsExportAnalysisTo: anFsQuestion [

	| lines isFillInTheBlank |
	isFillInTheBlank := anFsQuestion answerChoices isEmpty.
	
	isFillInTheBlank ifTrue: [
		| onlyChoice |
		onlyChoice := FsAnswerChoice new
			text: 'Click to show answer';
			analysis: self;
			yourself.
		anFsQuestion answerChoicesAdd: onlyChoice.
		^ self ].
		
	lines := self lines reject: [ :l | l trimBoth isEmpty ].
	lines readStreamDo: [ :str |
		lines size > anFsQuestion answerChoices size ifTrue: [ anFsQuestion analysis: str next trimBoth capitalized ].
		anFsQuestion answerChoices do: [ :ans | 
			ans importAnalysisFrom: str next trimBoth capitalized ] ]
]
