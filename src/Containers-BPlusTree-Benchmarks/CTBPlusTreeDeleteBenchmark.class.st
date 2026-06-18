Class {
	#name : 'CTBPlusTreeDeleteBenchmark',
	#superclass : 'CTTreeAbstractBenchmark',
	#instVars : [
		'tree',
		'keysToDelete'
	],
	#category : 'Containers-BPlusTree-Benchmarks',
	#package : 'Containers-BPlusTree-Benchmarks'
}

{ #category : 'running' }
CTBPlusTreeDeleteBenchmark >> run [
    keysToDelete do: [ :each | tree removeKey: each ].
]

{ #category : 'running' }
CTBPlusTreeDeleteBenchmark >> setUp [
    | random allKeys uniqueKeys |

    tree := CTBPlusTree new order: order.

    random := Random new.
    random seed: 42.

    allKeys := (1 to: 1000000) collect: [ :i | random nextInteger: 10000000 ].
    allKeys do: [ :each | tree at: each put: each ].

    uniqueKeys := allKeys asSet asArray.
    keysToDelete := (uniqueKeys shuffledBy: random) first: 100000.
]
