Class {
	#name : 'CTBPlusTreeLeafNode',
	#superclass : 'CTBPlusTreeNode',
	#instVars : [
		'values',
		'nextLeaf'
	],
	#category : 'Containers-BPlusTree',
	#package : 'Containers-BPlusTree'
}

{ #category : 'initialization' }
CTBPlusTreeLeafNode >> initialize [
    super initialize.
    values := OrderedCollection new.
]

{ #category : 'initialization' }
CTBPlusTreeLeafNode >> setKeys: aKeyCollection values: aValueCollection nextLeaf: aNode [
    keys := aKeyCollection.
    values := aValueCollection.
    nextLeaf := aNode.
]
