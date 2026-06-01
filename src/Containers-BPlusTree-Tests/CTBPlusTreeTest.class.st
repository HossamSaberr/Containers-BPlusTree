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
CTBPlusTreeTest >> testCustomOrderSplits [
    tree order: 3. 
    1 to: 50 do: [ :i | tree at: i put: i ].
    self assert: tree size equals: 50.
    1 to: 50 do: [ :i | self assert: (tree at: i) equals: i ].
]

{ #category : 'tests' }
CTBPlusTreeTest >> testEmptyTree [
    self assert: tree size equals: 0.
    self should: [ tree at: 1 ] raise: Error.
]

{ #category : 'tests' }
CTBPlusTreeTest >> testInsertUntilFirstSplit [
    "order 4 means it splits when inserting the 4th element"
    1 to: 4 do: [ :i | tree at: i put: i asString ].
    self assert: tree size equals: 4.
    1 to: 4 do: [ :i | self assert: (tree at: i) equals: i asString ].
]

{ #category : 'tests' }
CTBPlusTreeTest >> testInsertUntilRootSplits [
    "forces internal nodes to split and bubble a new root up"
    1 to: 20 do: [ :i | tree at: i put: i ].
    self assert: tree size equals: 20.
    1 to: 20 do: [ :i | self assert: (tree at: i) equals: i ].
]

{ #category : 'tests' }
CTBPlusTreeTest >> testLeafBorrowFromRight [
    "insert 1..5, Splits into Left [1, 2] and Right [3, 4, 5]"
    1 to: 5 do: [ :i | tree at: i put: i ].
    
    "delete 1, Left drops to [2], Right has 3, so it LENDS the 3"
    "left becomes [2, 3], Right becomes [4, 5], Root key updates"
    tree removeKey: 1.
    
    self assert: tree size equals: 4.
    self assert: (tree at: 2) equals: 2.
    self assert: (tree at: 5) equals: 5.
    self should: [ tree at: 1 ] raise: Error.
]

{ #category : 'tests' }
CTBPlusTreeTest >> testLeafMergeAndRootCollapse [
    "insert 1..4, Splits into Left [1, 2] and Right [3, 4] with Root having 1 key"
    1 to: 4 do: [ :i | tree at: i put: i ].
    
    "delete 1, Left drops to [2], Right only has [3, 4], so it CANNOT lend"
    "they MERGE into [2, 3, 4], The Root loses its key and collapses"
    tree removeKey: 1.
    
    self assert: tree size equals: 3.
    self assert: (tree at: 2) equals: 2.
    self assert: (tree at: 3) equals: 3.
    self assert: (tree at: 4) equals: 4.
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
CTBPlusTreeTest >> testSequentialLeafLinksAscending [
    | currentLeaf count |
    1 to: 50 do: [ :i | tree at: i put: i ].
    
    currentLeaf := tree firstLeaf.
    count := 0.
    [ currentLeaf notNil ] whileTrue: [
        count := count + currentLeaf keys size.
        currentLeaf := currentLeaf nextLeaf.
    ].
    
    self assert: count equals: 50.
]

{ #category : 'tests' }
CTBPlusTreeTest >> testSequentialLeafLinksDescending [
    | currentLeaf count |
    50 to: 1 by: -1 do: [ :i | tree at: i put: i ].
    
    currentLeaf := tree firstLeaf.
    count := 0.
    [ currentLeaf notNil ] whileTrue: [
        count := count + currentLeaf keys size.
        currentLeaf := currentLeaf nextLeaf.
    ].
    
    self assert: count equals: 50.
]

{ #category : 'tests' }
CTBPlusTreeTest >> testSequentialLinksAfterMassiveDeletions [
    | currentLeaf count |
    "Build a large tree"
    1 to: 1000 do: [ :i | tree at: i put: i ].
    
    "Punch holes throughout the entire tree to force dozens of merges"
    1 to: 1000 by: 2 do: [ :i | tree removeKey: i ].
    
    self assert: tree size equals: 500.
    
    "Traverse the surviving linked list to ensure no pointers point to dead memory"
    currentLeaf := tree firstLeaf.
    count := 0.
    [ currentLeaf notNil ] whileTrue: [
        count := count + currentLeaf keys size.
        currentLeaf := currentLeaf nextLeaf.
    ].
    
    self assert: count equals: 500.
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
