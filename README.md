# Containers-BPlusTree

A dynamically balanced **B+ Tree** index providing guaranteed $O(\log N)$ search, insertion, and deletion alongside $O(1)$ lateral sequential leaf access. Engineered to eliminate linear scanning and sorting bottlenecks during large-scale range queries, enabling high-performance database indexing and storage engine simulations.

![Pharo 14+](https://img.shields.io/badge/Pharo-14%2B-blue.svg)
![License MIT](https://img.shields.io/badge/license-MIT-green.svg)

## What is a B+ Tree?

Traditional binary search trees and standard B-Trees are excellent for localized point lookups. However, if you need to execute a range query (e.g., extracting all sorted keys between $X$ and $Y$), traditional tree structures force you to execute continuous, back-and-forth vertical traversals across parents and subtrees, resulting in heavy CPU cache misses and an $O(K \log N)$ operational wall.

Our **B+ Tree** solves this bottleneck by completely separating the routing layer from the actual data storage layer. Internal nodes (`CTBPlusTreeInternalNode`) store strictly routing-key separators to direct search trajectories down the tree, while *all* actual key-value payloads reside exclusively inside terminal leaf nodes (`CTBPlusTreeLeafNode`). 

Furthermore, it guarantees **$O(1)$ Lateral Sequential Scans**. Every leaf node is horizontally woven into a continuous, single-linked list via a sequential `nextLeaf` pointer. When reading a block of sequential data, the engine performs a single $O(\log N)$ point lookup to discover the starting boundary leaf, then instantly shifts into an ultra-fast lateral walk across contiguous leaf blocks, executing range lookups in strict linear time without ever returning to the root.

## Loading

To install `Containers-BPlusTree`, open the Playground (`Ctrl + O + W`) in your Pharo image and execute the following Metacello script:

```smalltalk
Metacello new
    baseline: 'ContainersBPlusTree';
    repository: 'github://pharo-containers/Containers-BPlusTree/src';
    load.
```
## Why use Containers-BPlusTree?

`CTBPlusTree` pays a minor structural maintenance tax on mutations to keep its depth shallow, but in return, it completely vitalizes massive sequential workflows, guaranteeing flat algorithmic complexities across intense transactional volumes.

| Operation | CTBPlusTree (Indexed Order $M$) |
| :--- | :--- |
| **Insert Key** | $O(\log_M N)$ structural split |
| **Point Lookup** | $O(\log_M N)$ direct routing path |
| **Range Scan ($K$ elements)** | **$O(\log_M N) + O(K)$ linear leaf walk** |
| **Delete Key** | $O(\log_M N)$ balanced borrow/merge |
| **Memory Locality** | **Contiguous key-value blocks** |

## Key Benefits

- **$O(\log N)$ Balanced Depth Invariants:** Structural mutations bubble up via single-responsibility `CTBPlusTreePromotion` and `CTBPlusTreeUnderflow` messengers, keeping the tree uniformly shallow even under adversarial workloads.

## Basic Usage

```smalltalk
"Create a new B+ Tree with an industrial branching factor of 100"
tree := CTBPlusTree new.
tree order: 100.

"Insert elements with associative payloads"
tree at: 10 put: 'User_Profile_A'.
tree at: 50 put: 'User_Profile_B'.
tree at: 20 put: 'User_Profile_C'.

"Point lookups operate in strict logarithmic time"
tree at: 50. "=> 'User_Profile_B'"

"Safe functional fallback lookup"
tree at: 999 ifAbsent: [ 'Guest_Profile' ].

"Dynamically remove a key. Sibling nodes automatically borrow or merge to balance memory"
tree removeKey: 20.
```

---

## Contributing

This library is part of the [Pharo Containers](https://github.com/pharo-containers) project. Contributions are welcome, whether implementing additional functional combinators, improving test coverage, or enhancing documentation. Please open an issue or pull request on GitHub.
