Class {
	#name : 'CTBPlusTreeSearchBenchmark',
	#superclass : 'CTTreeAbstractBenchmark',
	#instVars : [
		'tree',
		'keysToSearch'
	],
	#category : 'Containers-BPlusTree-Benchmarks',
	#package : 'Containers-BPlusTree-Benchmarks'
}

{ #category : 'running' }
CTBPlusTreeSearchBenchmark >> run [
    keysToSearch do: [ :each | tree at: each ].
]

{ #category : 'running' }
CTBPlusTreeSearchBenchmark >> setUp [
    | random allKeys |
    
    tree := CTBPlusTree new order: order. 
    
    random := Random new.
    random seed: 42.
    
    allKeys := (1 to: 1000000) collect: [ :i | random nextInteger: 10000000 ].
    
    allKeys do: [ :each | tree at: each put: each ].
    
    keysToSearch := (allKeys shuffledBy: random) first: 100000.
]
