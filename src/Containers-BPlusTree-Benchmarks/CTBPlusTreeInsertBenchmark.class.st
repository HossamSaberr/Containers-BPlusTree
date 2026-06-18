Class {
	#name : 'CTBPlusTreeInsertBenchmark',
	#superclass : 'CTTreeAbstractBenchmark',
	#instVars : [
		'tree',
		'elementsToInsert'
	],
	#category : 'Containers-BPlusTree-Benchmarks',
	#package : 'Containers-BPlusTree-Benchmarks'
}

{ #category : 'running' }
CTBPlusTreeInsertBenchmark >> run [
    elementsToInsert do: [ :each | tree at: each put: each ].
]

{ #category : 'running' }
CTBPlusTreeInsertBenchmark >> setUp [
    | random |
    
    tree := CTBPlusTree new order: order. 
    
    random := Random new.
    random seed: 42.
    
    elementsToInsert := (1 to: 1000000) collect: [ :i | random nextInteger: 10000000 ].
]
