Class {
	#name : 'CTBTreeRangeQueryBenchmark',
	#superclass : 'CTTreeAbstractBenchmark',
	#instVars : [
		'tree'
	],
	#category : 'Containers-BPlusTree-Benchmarks',
	#package : 'Containers-BPlusTree-Benchmarks'
}

{ #category : 'running' }
CTBTreeRangeQueryBenchmark >> run [
	| count |
	count := 0.
	50000 to: 51000 do: [ :i |
		(tree at: i ifAbsent: [ nil ]) ifNotNil: [ count := count + 1 ]
	].
	^ count
]

{ #category : 'running' }
CTBTreeRangeQueryBenchmark >> setUp [
	| dataSize |
	dataSize := 1000000.
	tree := CTBTree new.
	1 to: dataSize do: [ :i | tree at: i put: 'Pharo' ].
]
