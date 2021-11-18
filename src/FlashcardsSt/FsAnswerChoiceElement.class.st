Class {
	#name : #FsAnswerChoiceElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'model',
		'letter',
		'fontSize'
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
FsAnswerChoiceElement >> newLabelWithText: aStringOrText [
	^ BrLabel new 
		text: (aStringOrText asRopedText fontSize: self fontSize); 
		aptitude: BrGlamorousLabelAptitude new; 
		hMatchParent; 
		vFitContent; 
		yourself
]

{ #category : #accessing }
FsAnswerChoiceElement >> reset [
	| text container |
	self removeChildren.
	
	letter := (self newLabelWithText: self model letter asString, '. ') 
		layout: BlFrameLayout new;
		hFitContent; 
		yourself.
		
	text := self newLabelWithText: self model text.
	
	container := BrHorizontalPane new
		hMatchParent;
		vFitContent;
		margin: (BlInsets top: 0 right: 0 bottom: 0 left: self fontSize * 1.5);
		when: BlClickEvent 
		do: [ :anEvent | 
			self parent chooseAnswer: self.
			anEvent consumed: true ];
		addChild: letter;
		addChild: text;
		yourself.
			
	self addChild: container
]

{ #category : #accessing }
FsAnswerChoiceElement >> showAnalysis [

	| analysis |
	analysis := BrEditor new
		aptitude: BrGlamorousRegularEditorAptitude new;
		margin: (BlInsets top: 0 right: 0 bottom: 0 left: self fontSize * 1.5);
		text: (self model analysisText fontSize: self fontSize).
	self addChild: analysis
]