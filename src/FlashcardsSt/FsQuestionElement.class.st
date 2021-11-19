Class {
	#name : #FsQuestionElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'model',
		'chosenAnswer'
	],
	#category : #'FlashcardsSt-UI'
}

{ #category : #'instance creation' }
FsQuestionElement class >> on: aQuestion [
	^ self new
		model: aQuestion;
		yourself
]

{ #category : #accessing }
FsQuestionElement >> chooseAnswer: anElement [

	chosenAnswer ifNotNil: [ ^ self ].
	chosenAnswer := anElement model.
	anElement markChosen.
	self gradeAnswer.
	self showAnalysis.
]

{ #category : #accessing }
FsQuestionElement >> fontSize [
	^ 20
]

{ #category : #accessing }
FsQuestionElement >> gradeAnswer [
	| text |
	text := chosenAnswer = self model bestAnswer
		ifTrue: [ 
			(Character value: 16r2713) asRopedText
				foreground: Color green;
				bold ]
		ifFalse: [ 'X' asRopedText foreground: Color red ].
	self addChild: (BrLabel new
		text: (text fontSize: self fontSize * 2);
		aptitude: BrGlamorousLabelAptitude new;
		constraintsDo: [ :c | c ignoreByLayout ];
		yourself)
]

{ #category : #accessing }
FsQuestionElement >> initialize [
	super initialize.
	
	"Adapted from GtRefactoringsElement"
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].
		
	self cellSpacing: 10
]

{ #category : #accessing }
FsQuestionElement >> markAnswer: anElement [

	| answerMark |
	answerMark := BlElement new
		geometry: BlCircleGeometry new;
		size: 20 @ 20;
		border: (BlBorder paint: (Color gray alpha: 0.8) width: 3);
		yourself.
	anElement addChild: answerMark
]

{ #category : #accessing }
FsQuestionElement >> model [

	^ model
]

{ #category : #accessing }
FsQuestionElement >> model: anObject [

	| text |
	
	model := anObject.
	self removeChildren.
	
	text := self newElementWithText: self model text.
	self addChild: text.
	
	self model answerChoices do: [ :ans | self addChild: (ans asElement fontSize: self fontSize) ]
]

{ #category : #accessing }
FsQuestionElement >> newElementWithText: aStringOrText [
	^ BrEditor new 
		text: (aStringOrText asRopedText fontSize: self fontSize); 
		aptitude: BrGlamorousEditorAptitude new; 
		hMatchParent; 
		vFitContent; 
		yourself
]

{ #category : #accessing }
FsQuestionElement >> showAnalysis [

	self showGeneralAnalysis.
	
	self children 
		select: [ :e | e isKindOf: FsAnswerChoiceElement ]
		thenDo: [ :e | e showAnalysis ]
]

{ #category : #accessing }
FsQuestionElement >> showGeneralAnalysis [
	
	| analysis text |
	text := self model analysisText.
	text ifEmpty: [ ^ self ].
	
	analysis := (self newElementWithText: text)
		margin: (BlInsets top: 0 right: 0 bottom: 0 left: self fontSize * 1.5);
		yourself.
	self addChild: analysis at: 2.

]
