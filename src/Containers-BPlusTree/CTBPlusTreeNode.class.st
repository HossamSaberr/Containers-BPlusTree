Class {
	#name : 'CTBPlusTreeNode',
	#superclass : 'Object',
	#instVars : [
		'keys'
	],
	#category : 'Containers-BPlusTree',
	#package : 'Containers-BPlusTree'
}

{ #category : 'accessing' }
CTBPlusTreeNode >> keys [
    ^ keys
]

{ #category : 'accessing' }
CTBPlusTreeNode >> keys: anOrderedCollection [
    keys := anOrderedCollection
]
