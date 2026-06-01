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

{ #category : 'dispatching' }
CTBPlusTreeNode >> processUnderflowIn: anInternalNode index: childIndex order: maxOrder [
    "I am not underflowing, Tell the parent everything is fine"
    ^ anInternalNode
]
