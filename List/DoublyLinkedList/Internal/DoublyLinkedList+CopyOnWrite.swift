extension DoublyLinkedList {
  @inlinable @inline(__always)
  mutating func update() {
    _update(withFirstIndex: nil, withSecondIndex: nil)
  }
  
  @inlinable @inline(__always)
  mutating func update(
    withIndex index: Index
  ) -> Index {
    _update(withFirstIndex: index, withSecondIndex: nil).firstIndex!
  }
  
  @inlinable @inline(__always)
  mutating func update(
    withRange range: Range<Index>
  ) -> Range<Index> {
    let (lowerBound, upperBound) = _update(
      withFirstIndex: range.lowerBound,
      withSecondIndex: range.upperBound
    )
    return lowerBound!..<upperBound!
  }
  
  @usableFromInline
  @discardableResult
  mutating func _update(
    withFirstIndex firstIndex: Index?,
    withSecondIndex secondIndex: Index?
  ) -> (firstIndex: Index?, secondIndex: Index?) {
    guard
      !isKnownUniquelyReferenced(&head),
      var currentOldNode = head
    else {
      return (firstIndex, secondIndex)
    }
    var currentNewNode = Node(value: currentOldNode.value)
    head = currentNewNode
    var firstUpdatedIndex = firstIndex
    var secondUpdatedIndex = secondIndex
    if currentOldNode === firstIndex?.node {
      firstUpdatedIndex = Index(node: currentNewNode)
    }
    if currentOldNode === secondIndex?.node {
      secondUpdatedIndex = Index(node: currentNewNode)
    }
    
    while let nextOldNode = currentOldNode.next {
      let newNode = Node(
        value: nextOldNode.value,
        prev: currentNewNode
      )
      currentNewNode.next = newNode
      currentOldNode = nextOldNode
      currentNewNode = newNode
      if currentOldNode === firstIndex?.node {
        firstUpdatedIndex = Index(node: currentNewNode)
      }
      if currentOldNode === secondIndex?.node {
        secondUpdatedIndex = Index(node: currentNewNode)
      }
    }
    tail = currentNewNode
    return (firstUpdatedIndex, secondUpdatedIndex)
  }
}
