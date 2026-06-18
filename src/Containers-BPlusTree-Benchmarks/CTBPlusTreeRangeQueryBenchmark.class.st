Class {
	#name : 'CTBPlusTreeRangeQueryBenchmark',
	#superclass : 'CTTreeAbstractBenchmark',
	#instVars : [
		'tree'
	],
	#category : 'Containers-BPlusTree-Benchmarks',
	#package : 'Containers-BPlusTree-Benchmarks'
}

{ #category : 'running' }
CTBPlusTreeRangeQueryBenchmark >> run [
    | count currentLeaf |
    count := 0.
    
    currentLeaf := tree findLeafContaining: 50000. 
    
    [ currentLeaf notNil and: [ count < 1000 ] ] whileTrue: [
        currentLeaf keysDo: [ :k |
            (k between: 50000 and: 51000) ifTrue: [ count := count + 1 ]
        ].
        currentLeaf := currentLeaf nextLeaf.
    ].
    
    ^ count
]

{ #category : 'running' }
CTBPlusTreeRangeQueryBenchmark >> setUp [
	| dataSize |
	dataSize := 1000000.
	tree := CTBPlusTree new order: 4.
	1 to: dataSize do: [ :i | tree at: i put: 'Pharo' ].
]
