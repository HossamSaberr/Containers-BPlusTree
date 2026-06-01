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

{ #category : 'adding' }
CTBPlusTreeLeafNode >> insertKey: aKey value: aValue order: maxOrder [
    | index |
    index := keys findFirst: [ :k | aKey <= k ].
    
    index = 0 ifTrue: [
        "Key is larger than all others, safely append"
        keys addLast: aKey.
        values addLast: aValue.
    ] ifFalse: [
        "Update if exact match"
        (keys at: index) = aKey ifTrue: [ 
            values at: index put: aValue. 
            ^ self 
        ].
        "Otherwise insert at the exact sorted position"
        keys add: aKey beforeIndex: index.
        values add: aValue beforeIndex: index.
    ].
    
    ^ keys size < maxOrder 
        ifTrue: [ self ]
        ifFalse: [ self splitLeaf ]
]

{ #category : 'accessing' }
CTBPlusTreeLeafNode >> nextLeaf [
    ^ nextLeaf
]

{ #category : 'accessing' }
CTBPlusTreeLeafNode >> nextLeaf: aNode [
    nextLeaf := aNode
]

{ #category : 'removing' }
CTBPlusTreeLeafNode >> removeKey: aKey ifAbsent: errorBlock order: maxOrder [
    | index minSize |
    index := keys indexOf: aKey.
    index = 0 ifTrue: [ ^ errorBlock value ].
    
    "remove the key and value"
    keys removeAt: index.
    values removeAt: index.
    
    "B+ Trees require nodes to be at least half full (except the root)"
    minSize := maxOrder // 2.
    
    ^ keys size < minSize 
        ifTrue: [ CTBPlusTreeUnderflow node: self ]
        ifFalse: [ self ]
]

{ #category : 'accessing' }
CTBPlusTreeLeafNode >> searchKey: aKey ifAbsent: errorBlock [
    | index |
    index := keys indexOf: aKey.
    index = 0 ifTrue: [ ^ errorBlock value ].
    ^ values at: index.
]

{ #category : 'initialization' }
CTBPlusTreeLeafNode >> setKeys: aKeyCollection values: aValueCollection nextLeaf: aNode [
    keys := aKeyCollection.
    values := aValueCollection.
    nextLeaf := aNode.
]

{ #category : 'private' }
CTBPlusTreeLeafNode >> splitLeaf [
    | splitIndex middleKey newSibling newKeys newValues |
    splitIndex := (keys size // 2) + 1.
    
    newKeys := OrderedCollection new.
    newValues := OrderedCollection new.
    
    splitIndex to: keys size do: [ :i |
        newKeys addLast: (keys at: i).
        newValues addLast: (values at: i).
    ].
    
    (keys size - splitIndex + 1) timesRepeat: [
        keys removeLast.
        values removeLast.
    ].
    
    newSibling := self class new.
    newSibling keys: newKeys.
    newSibling values: newValues.
    newSibling nextLeaf: self nextLeaf.
    
    self nextLeaf: newSibling.
    middleKey := newKeys first.
    
    ^ CTBPlusTreePromotion key: middleKey left: self right: newSibling
]

{ #category : 'accessing' }
CTBPlusTreeLeafNode >> values [
    ^ values
]

{ #category : 'accessing' }
CTBPlusTreeLeafNode >> values: anOrderedCollection [
    values := anOrderedCollection
]
