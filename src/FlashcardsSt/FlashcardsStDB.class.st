Class {
	#name : #FlashcardsStDB,
	#superclass : #SpFileDatabase,
	#category : #'FlashcardsSt-Persistence'
}

{ #category : #accessing }
FlashcardsStDB class >> backupDirectoryParent [
	"Re-write this if you'd like your backups to be saved in a location other than the image folder"
	^ FileLocator dynabookData
]

{ #category : #accessing }
FlashcardsStDB class >> schema [
	^ { 
		FsFlashCard.
		QuoteMeDB 
	}.
]
