Class {
	#name : 'CTBPlusTreeInternalNode',
	#superclass : 'CTBPlusTreeNode',
	#instVars : [
		'children'
	],
	#category : 'Containers-BPlusTree',
	#package : 'Containers-BPlusTree'
}

{ #category : 'initialization' }
CTBPlusTreeInternalNode >> initialize [
    super initialize.
    children := OrderedCollection new.
]

{ #category : 'initialization' }
CTBPlusTreeInternalNode >> setKeys: aKeyCollection children: aChildCollection [
    keys := aKeyCollection.
    children := aChildCollection.
]
