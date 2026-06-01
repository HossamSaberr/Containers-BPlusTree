Class {
	#name : 'CTBPlusTree',
	#superclass : 'Object',
	#instVars : [
		'root',
		'order',
		'size',
		'firstLeaf'
	],
	#category : 'Containers-BPlusTree',
	#package : 'Containers-BPlusTree'
}

{ #category : 'accessing' }
CTBPlusTree >> at: aKey [
    ^ self at: aKey ifAbsent: [ self error: 'Key not found' ]
]

{ #category : 'accessing' }
CTBPlusTree >> at: aKey ifAbsent: errorBlock [
    ^ root searchKey: aKey ifAbsent: errorBlock
]

{ #category : 'adding' }
CTBPlusTree >> at: aKey put: aValue [
    | result isNew |
    isNew := false.
    self at: aKey ifAbsent: [ isNew := true ].
    
    result := root insertKey: aKey value: aValue order: order.
    
    "Double dispatch handles the case where the root itself splits"
    result processRootUpdateFor: self.
    
    isNew ifTrue: [ size := size + 1 ].
    ^ aValue
]

{ #category : 'initialization' }
CTBPlusTree >> clear [
    "Starting with a LeafNode avoids explicit nil checks on the first insertion"
    root := CTBPlusTreeLeafNode new.
    firstLeaf := root.
    size := 0.
]

{ #category : 'accessing' }
CTBPlusTree >> firstLeaf [
    ^ firstLeaf
]

{ #category : 'initialization' }
CTBPlusTree >> initialize [
    super initialize.
    order := 4. "Default branching factor"
    self clear.
]

{ #category : 'accessing' }
CTBPlusTree >> order: anInteger [
    order := anInteger max: 3.
]

{ #category : 'private' }
CTBPlusTree >> root: aNode [
    root := aNode
]

{ #category : 'accessing' }
CTBPlusTree >> size [
    ^ size
]
