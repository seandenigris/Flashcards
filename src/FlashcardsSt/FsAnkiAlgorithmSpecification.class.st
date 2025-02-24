Class {
	#name : #FsAnkiAlgorithmSpecification,
	#superclass : #BabyPhexample,
	#instVars : [
		'scorecard',
		'question',
		'algorithm'
	],
	#category : #'FlashcardsSt-Algorithm'
}

{ #category : #running }
FsAnkiAlgorithmSpecification >> setUp [
	scorecard := OrderedCollection new.
	question := FsQuestion new.
]

{ #category : #asserting }
FsAnkiAlgorithmSpecification >> shouldQuestionWithResponseButNotTodayBeReview [
	
	algorithm := self given: #shouldQuestionWithoutReviewsBeNew.
	
	algorithm scorecard add: (FsResponse new question: question; timestamp: (DateAndTime now - 1 day); yourself).
	
	(algorithm isNew: question) should beFalse.
	(algorithm isLearning: question) should beFalse.
	(algorithm isReview: question) should beTrue.
		
]

{ #category : #asserting }
FsAnkiAlgorithmSpecification >> shouldQuestionWithResponseTodayBeLearning [
	
	algorithm := self given: #shouldQuestionWithoutReviewsBeNew.
	
	algorithm scorecard add: (FsResponse new question: question; timestamp: DateAndTime now; yourself).
	
	(algorithm isNew: question) should beFalse.
	(algorithm isLearning: question) should beTrue.
	(algorithm isReview: question) should beFalse.
		
]

{ #category : #asserting }
FsAnkiAlgorithmSpecification >> shouldQuestionWithoutReviewsBeNew [

	algorithm := FsAnkiAlgorithm new
		scorecard: scorecard;
		yourself.
		
	(algorithm isNew: question) should beTrue.
	(algorithm isLearning: question) should beFalse.
	(algorithm isReview: question) should beFalse.
	
	^ algorithm
		
]
