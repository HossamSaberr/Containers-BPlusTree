Class {
	#name : 'CTBPlusTreeBenchmarker',
	#superclass : 'Object',
	#instVars : [
		'block'
	],
	#category : 'Containers-BPlusTree-Benchmarks',
	#package : 'Containers-BPlusTree-Benchmarks'
}

{ #category : 'as yet unclassified' }
CTBPlusTreeBenchmarker >> benchmark [
    | executionTime fullGCTime incrementalGCTime |
    
    fullGCTime := Smalltalk vm totalFullGCTime.
    incrementalGCTime := Smalltalk vm totalIncrementalGCTime.
    executionTime := Time primUTCMicrosecondsClock.

    block value.
    
    executionTime := Time primUTCMicrosecondsClock - executionTime.
    "Multiply by 1000 to convert millisecond GC time into microseconds"
    fullGCTime := (Smalltalk vm totalFullGCTime - fullGCTime) * 1000.
    incrementalGCTime := (Smalltalk vm totalIncrementalGCTime - incrementalGCTime) * 1000.

    ^ CTBPlusTreeBenchmarkerResult new
          executionTime: executionTime;
          fullGCTime: fullGCTime;
          incrementalGCTime: incrementalGCTime;
          yourself
]

{ #category : 'as yet unclassified' }
CTBPlusTreeBenchmarker >> blockToExecute: aBlock [
    block := aBlock
]
