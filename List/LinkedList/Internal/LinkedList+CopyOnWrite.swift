extension LinkedList {
  @inlinable @inline(__always)
  mutating func update() {
    _update(withIndex: nil)
  }
  
  @inlinable @inline(__always)
  mutating func update(
    withIndex index: Index
  ) -> Index {
    _update(withIndex: index)!
  }
  
  @usableFromInline
  @discardableResult
  mutating func _update(
    withIndex index: Index?
  ) -> Index? {
    guard
      !isKnownUniquelyReferenced(&head),
      var currentOldNode = head
    else {
      return index
    }
    var currentNewNode = Node(value: currentOldNode.value)
    head = currentNewNode
    var updatedIndex = index
    if currentOldNode === index?.node {
      updatedIndex = Index(node: currentNewNode)
    }
    
    while let nextOldNode = currentOldNode.next {
      let newNode = Node(value: nextOldNode.value)
      currentNewNode.next = newNode
      currentOldNode = nextOldNode
      currentNewNode = newNode
      if currentOldNode === index?.node {
        updatedIndex = Index(node: currentNewNode)
      }
    }
    tail = currentNewNode
    return updatedIndex
  }
}
