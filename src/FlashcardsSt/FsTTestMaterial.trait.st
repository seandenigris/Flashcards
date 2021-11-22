Trait {
	#name : #FsTTestMaterial,
	#category : #'FlashcardsSt-Core'
}

{ #category : #accessing }
FsTTestMaterial >> keywordsDoWithIndex: aBlock [
	#('every' 'must' 'only'
	'all' 'always' 'never' 'whenever' "absolutes; be suspicious"
	'best' 'except' 'first' 'no' 'none' 'not' "Can flip what is actually asked"
	'least' 'may' 'most' 'often' 'some' 'usually' "non-absolutes; more likely to be right") do: [ :keyword |
		| index |
		index := 0.
		[ 
			index := self text findString: keyword startingAt: index + 1 caseSensitive: false.
			index = 0 
		] whileFalse: [ 
			| isWordStart isWordEnd indexAfter |
			isWordStart := index = 1 or: [ (self text at: index - 1) isLetter not ].
			indexAfter := index + keyword size.
			isWordEnd := indexAfter > self text size or: [ (self text at: indexAfter) isLetter not ].
			isWordStart & isWordEnd ifTrue: [ aBlock value: keyword value: index ] ] ]
]

{ #category : #accessing }
FsTTestMaterial >> text [
	self subclassResponsibility
]
