Class {
	#name : 'CTBPlusTreeInternalNode',
	#superclass : 'CTBPlusTreeNode',
	#instVars : [
		'children'
	],
	#category : 'Containers-BPlusTree',
	#package : 'Containers-BPlusTree'
}

{ #category : 'private' }
CTBPlusTreeInternalNode >> addFirstChild: aNode [
    children add: aNode.
]

{ #category : 'private' }
CTBPlusTreeInternalNode >> childForKey: aKey [
    | index |
    index := keys findFirst: [ :k | aKey < k ].
    index = 0 ifTrue: [ ^ children last ].
    ^ children at: index.
]

{ #category : 'initialization' }
CTBPlusTreeInternalNode >> initialize [
    super initialize.
    children := OrderedCollection new.
]

{ #category : 'private' }
CTBPlusTreeInternalNode >> insertPromotedKey: aKey child: aNode [
    keys add: aKey.
    children add: aNode.
]

{ #category : 'accessing' }
CTBPlusTreeInternalNode >> searchKey: aKey ifAbsent: errorBlock [
    ^ (self childForKey: aKey) searchKey: aKey ifAbsent: errorBlock
]

{ #category : 'initialization' }
CTBPlusTreeInternalNode >> setKeys: aKeyCollection children: aChildCollection [
    keys := aKeyCollection.
    children := aChildCollection.
]
