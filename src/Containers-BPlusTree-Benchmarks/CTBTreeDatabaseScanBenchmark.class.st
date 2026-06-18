Class {
	#name : 'CTBTreeDatabaseScanBenchmark',
	#superclass : 'CTTreeAbstractBenchmark',
	#instVars : [
		'tree'
	],
	#category : 'Containers-BPlusTree-Benchmarks',
	#package : 'Containers-BPlusTree-Benchmarks'
}

{ #category : 'running' }
CTBTreeDatabaseScanBenchmark >> run [
	| count |
	count := 0.
	1 to: 100000 do: [ :i | tree at: i ].
	^ count
]

{ #category : 'running' }
CTBTreeDatabaseScanBenchmark >> setUp [
	| dataSize |
	dataSize := 1000000.
	tree := CTBTree new.
	1 to: dataSize do: [ :i | tree at: i put: 'User' ].
]
