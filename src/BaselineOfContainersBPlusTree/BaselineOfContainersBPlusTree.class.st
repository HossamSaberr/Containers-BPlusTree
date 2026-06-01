Class {
	#name : 'BaselineOfContainersBPlusTree',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfContainersBPlusTree',
	#package : 'BaselineOfContainersBPlusTree'
}

{ #category : 'baselines' }
BaselineOfContainersBPlusTree >> baseline: spec [
	<baseline>

	spec for: #common do: [
		spec package: 'Containers-BPlusTree'.

		spec package: 'Containers-BPlusTree-Tests' with: [
			spec requires: #('Containers-BPlusTree')
		].
		
		spec package: 'Containers-BPlusTree-Benchmarks' with: [
			spec requires: #('Containers-BPlusTree')
		].

		spec group: 'Core' with: #('Containers-BPlusTree').
		spec group: 'Tests' with: #('Containers-BPlusTree-Tests').
		spec group: 'Benchmarks' with: #('Containers-BPlusTree-Benchmarks').
		spec group: 'default' with: #('Core' 'Tests' 'Benchmarks').
	]
]
