Class {
	#name : 'CTTreeAbstractBenchmark',
	#superclass : 'Object',
	#instVars : [
		'order'
	],
	#category : 'Containers-BPlusTree-Benchmarks',
	#package : 'Containers-BPlusTree-Benchmarks'
}

{ #category : 'accessing' }
CTTreeAbstractBenchmark >> order: asInteger [
order := asInteger 
]

{ #category : 'running' }
CTTreeAbstractBenchmark >> run [
	self subclassResponsibility
]
