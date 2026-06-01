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

{ #category : 'accessing' }
CTBPlusTree >> size [
    ^ size
]
