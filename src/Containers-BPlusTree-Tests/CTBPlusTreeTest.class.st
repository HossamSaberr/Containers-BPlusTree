Class {
	#name : 'CTBPlusTreeTest',
	#superclass : 'TestCase',
	#instVars : [
		'tree'
	],
	#category : 'Containers-BPlusTree-Tests',
	#package : 'Containers-BPlusTree-Tests'
}

{ #category : 'running' }
CTBPlusTreeTest >> setUp [
    super setUp.
    tree := CTBPlusTree new.
    tree order: 4. "Defaulting to a small order to force early splits"
]

{ #category : 'tests' }
CTBPlusTreeTest >> testBasicDeletion [
    tree at: 10 put: 'A'.
    tree at: 20 put: 'B'.
    tree at: 30 put: 'C'.
    
    tree removeKey: 20.
    
    self assert: tree size equals: 2.
    self assert: (tree at: 10) equals: 'A'.
    self assert: (tree at: 30) equals: 'C'.
    self should: [ tree at: 20 ] raise: Error.
]

{ #category : 'tests' }
CTBPlusTreeTest >> testEmptyTree [
    self assert: tree size equals: 0.
    self should: [ tree at: 1 ] raise: Error.
]

{ #category : 'tests' }
CTBPlusTreeTest >> testMissingKeyIfAbsent [
    | result |
    result := tree at: 99 ifAbsent: [ 'NotFound' ].
    self assert: result equals: 'NotFound'.
]

{ #category : 'tests' }
CTBPlusTreeTest >> testMissingKeyThrowsError [
    tree at: 1 put: 'A'.
    self should: [ tree at: 99 ] raise: Error.
]

{ #category : 'tests' }
CTBPlusTreeTest >> testSingleInsertion [
    tree at: 10 put: 'A'.
    self assert: tree size equals: 1.
    self assert: (tree at: 10) equals: 'A'.
]

{ #category : 'tests' }
CTBPlusTreeTest >> testUpdateExistingKey [
    tree at: 10 put: 'A'.
    tree at: 10 put: 'B'.
    self assert: tree size equals: 1.
    self assert: (tree at: 10) equals: 'B'.
]
