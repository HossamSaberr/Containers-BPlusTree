Class {
	#name : 'CTBPlusTreeBenchmarkerResult',
	#superclass : 'Object',
	#instVars : [
		'executionTime',
		'fullGCTime',
		'incrementalGCTime'
	],
	#category : 'Containers-BPlusTree-Benchmarks',
	#package : 'Containers-BPlusTree-Benchmarks'
}

{ #category : 'accessing' }
CTBPlusTreeBenchmarkerResult >> executionTime [
    ^ executionTime
]

{ #category : 'accessing' }
CTBPlusTreeBenchmarkerResult >> executionTime: anInteger [
    executionTime := anInteger
]

{ #category : 'accessing' }
CTBPlusTreeBenchmarkerResult >> fullGCTime [
    ^ fullGCTime
]

{ #category : 'accessing' }
CTBPlusTreeBenchmarkerResult >> fullGCTime: anInteger [
    fullGCTime := anInteger
]

{ #category : 'accessing' }
CTBPlusTreeBenchmarkerResult >> incrementalGCTime [
    ^ incrementalGCTime
]

{ #category : 'accessing' }
CTBPlusTreeBenchmarkerResult >> incrementalGCTime: anInteger [
    incrementalGCTime := anInteger
]

{ #category : 'accessing' }
CTBPlusTreeBenchmarkerResult >> relativeGCTime [
    "Prevent ZeroDivide if the code executes in under 1 microsecond"
    executionTime = 0 ifTrue: [ ^ '0.00 %' ].
    
    ^ (((fullGCTime + incrementalGCTime) / executionTime * 100) asFloat
           printShowingDecimalPlaces: 2) , ' %'
]
