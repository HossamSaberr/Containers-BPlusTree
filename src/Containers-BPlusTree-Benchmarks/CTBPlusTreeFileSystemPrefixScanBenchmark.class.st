Class {
	#name : 'CTBPlusTreeFileSystemPrefixScanBenchmark',
	#superclass : 'CTTreeAbstractBenchmark',
	#instVars : [
		'tree'
	],
	#category : 'Containers-BPlusTree-Benchmarks',
	#package : 'Containers-BPlusTree-Benchmarks'
}

{ #category : 'running' }
CTBPlusTreeFileSystemPrefixScanBenchmark >> run [
	| count currentLeaf |
	count := 0.
	currentLeaf := tree findLeafContaining: 'A'.
	[ currentLeaf notNil ] whileTrue: [
		currentLeaf keysDo: [ :k |
			(k beginsWith: 'A') ifTrue: [ count := count + 1 ]
		].
		currentLeaf := currentLeaf nextLeaf.
	].
	^ count
]

{ #category : 'running' }
CTBPlusTreeFileSystemPrefixScanBenchmark >> setUp [
	| dataSize |
	dataSize := 1000000.
	tree := CTBPlusTree new order: 4.
	1 to: dataSize do: [ :i | 
		tree at: ('A_File_', i asString) put: 'Metadata';
			at: ('Z_File_', i asString) put: 'Metadata' ].
]
