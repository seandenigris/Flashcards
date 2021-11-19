Trait {
	#name : #FsTTestMaterial,
	#category : #'FlashcardsSt-Core'
}

{ #category : #accessing }
FsTTestMaterial >> keywordsDoWithIndex: aBlock [
	#('every' 'must' 'only'
	'all' 'always' 'never' 'whenever' "absolutes; be suspicious"
	'best' 'except' 'no' 'none' 'not' "Can flip what is actually asked"
	'most' 'some' 'usually' "non-absolutes; more likely to be right") do: [ :keyword |
		| index |
		index := 0.
		[ 
			index := self text findString: keyword startingAt: index + 1 caseSensitive: false.
			index = 0 
		] whileFalse: [ aBlock value: keyword value: index ] ]
]

{ #category : #accessing }
FsTTestMaterial >> text [
	self subclassResponsibility
]
