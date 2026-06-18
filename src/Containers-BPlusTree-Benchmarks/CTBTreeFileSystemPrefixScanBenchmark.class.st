Class {
	#name : 'CTBTreeFileSystemPrefixScanBenchmark',
	#superclass : 'CTTreeAbstractBenchmark',
	#instVars : [
		'tree'
	],
	#category : 'Containers-BPlusTree-Benchmarks',
	#package : 'Containers-BPlusTree-Benchmarks'
}

{ #category : 'running' }
CTBTreeFileSystemPrefixScanBenchmark >> run [
	| count |
	count := 0.
	tree from: 'A' to: 'B' keysAndValuesDo: [ :k :v |
		(k beginsWith: 'A') ifTrue: [ count := count + 1 ] ].
	^ count
]

{ #category : 'running' }
CTBTreeFileSystemPrefixScanBenchmark >> setUp [
	| dataSize |
	dataSize := 1000000.
	tree := CTBTree new.
	1 to: dataSize do: [ :i | 
		tree at: ('A_File_', i asString) put: 'Metadata';
			at: ('Z_File_', i asString) put: 'Metadata' ].
]
