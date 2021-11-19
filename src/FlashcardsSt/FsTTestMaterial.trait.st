Trait {
	#name : #FsTTestMaterial,
	#category : #'FlashcardsSt-Core'
}

{ #category : #accessing }
FsTTestMaterial >> keywordsDoWithIndex: aBlock [
	#('always' 'best' 'except' 'most' 'not') do: [ :keyword |
		| index |
		index := 0.
		[ 
			index := self text findString: keyword startingAt: index + 1 caseSensitive: false.
			index = 0 
		] whileFalse: [ aBlock value: keyword value: index ] ]
]
