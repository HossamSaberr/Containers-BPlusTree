Class {
	#name : 'CTBPlusTreeDatabaseScanBenchmark',
	#superclass : 'CTTreeAbstractBenchmark',
	#instVars : [
		'tree'
	],
	#category : 'Containers-BPlusTree-Benchmarks',
	#package : 'Containers-BPlusTree-Benchmarks'
}

{ #category : 'running' }
CTBPlusTreeDatabaseScanBenchmark >> run [
	| count currentLeaf |
	count := 0.
	currentLeaf := tree firstLeaf.
	[ currentLeaf notNil ] whileTrue: [
		currentLeaf keysDo: [ :k | count := count + 1 ].
		currentLeaf := currentLeaf nextLeaf.
	].
	^ count
]

{ #category : 'running' }
CTBPlusTreeDatabaseScanBenchmark >> setUp [
	| dataSize |
	dataSize := 1000000.
	tree := CTBPlusTree new order: 4.
	1 to: dataSize do: [ :i | tree at: i put: 'User' ].
]
