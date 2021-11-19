Class {
	#name : #FsAnswerChoiceElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'model',
		'letter',
		'fontSize',
		'textElement'
	],
	#category : #'FlashcardsSt-UI'
}

{ #category : #accessing }
FsAnswerChoiceElement class >> on: answerChoice [
	^ self new
		model: answerChoice;
		yourself
]

{ #category : #accessing }
FsAnswerChoiceElement >> fontSize [
	^ fontSize ifNil: [ 14 ]
]

{ #category : #accessing }
FsAnswerChoiceElement >> fontSize: anInteger [
	fontSize := anInteger.
	self reset
]

{ #category : #accessing }
FsAnswerChoiceElement >> highlightKeywords [

	self model keywordsDoWithIndex: [ :kw :i |
		(textElement text from: i to: i + kw size) bold ]
]

{ #category : #accessing }
FsAnswerChoiceElement >> initialize [
	super initialize.
	
	"Adapted from GtRefactoringsElement"
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical fitContent ].
]

{ #category : #accessing }
FsAnswerChoiceElement >> markChosen [
	
	| answerMark overlay |
	answerMark := BlElement new
		geometry: BlCircleGeometry new;
		size: self fontSize asPoint;
		border: (BlBorder paint: (Color gray alpha: 0.8) width: 3);
		yourself.
	letter addChild: answerMark
]

{ #category : #accessing }
FsAnswerChoiceElement >> model [
	
	^ model
]

{ #category : #accessing }
FsAnswerChoiceElement >> model: anAnswerChoice [
	
	model := anAnswerChoice.
	self reset.
]

{ #category : #accessing }
FsAnswerChoiceElement >> new: anElementClass withText: aStringOrText andAptitude: anAptitudeClass [
	^ anElementClass new 
		text: (aStringOrText asRopedText fontSize: self fontSize); 
		aptitude: anAptitudeClass new; 
		hMatchParent; 
		vFitContent; 
		yourself
]

{ #category : #accessing }
FsAnswerChoiceElement >> reset [
	| container |
	self removeChildren.
	
	letter := (self 
		new: BrLabel 
		withText: self model letter asString, '. ' 
		andAptitude: BrGlamorousLabelAptitude) 
		layout: BlFrameLayout new;
		hFitContent; 
		yourself.
		
	textElement := self 
		new: BrEditor 
		withText: self model text
		andAptitude: BrGlamorousEditorAptitude.
	
	container := BrHorizontalPane new
		hMatchParent;
		vFitContent;
		margin: (BlInsets top: 0 right: 0 bottom: 0 left: self fontSize * 1.5);
		when: BlClickEvent 
		do: [ :anEvent | 
			self parent chooseAnswer: self.
			anEvent consumed: true ];
		addChild: letter;
		addChild: textElement;
		yourself.
			
	self addChild: container
]

{ #category : #accessing }
FsAnswerChoiceElement >> showAnalysis [

	| analysis text |
	self highlightKeywords.
	
	text := self model analysisText.
	text ifEmpty: [ ^ self ].
	
	analysis := BrEditor new
		aptitude: BrGlamorousRegularEditorAptitude new;
		margin: (BlInsets top: 0 right: 0 bottom: 0 left: self fontSize * 1.5);
		text: (text fontSize: self fontSize).
	self addChild: analysis
]
