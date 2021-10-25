"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestFlashcardsSt,
	#superclass : #PackageManifest,
	#category : #'FlashcardsSt-Manifest'
}

{ #category : #'code-critics' }
ManifestFlashcardsSt class >> ruleRBRefersToClassRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#'FsFlashCard class' #testDeck #true)) #'2019-01-26T18:39:17.354982-05:00') )
]
