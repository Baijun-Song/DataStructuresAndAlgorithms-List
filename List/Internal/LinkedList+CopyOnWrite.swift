extension LinkedList {
  @discardableResult
  mutating func _update(
    withNode node: Node? = nil
  ) -> Node? {
    guard
      !isKnownUniquelyReferenced(&_head),
      var oldNode = _head
    else {
      return nil
    }
    _head = _Node(value: oldNode._value)
    var newNode = _head!
    var nodeCopy: Node?
    if oldNode === node?._storage {
      nodeCopy = Node(newNode)
    }
    
    while let nextOldNode = oldNode._next {
      newNode._next = _Node(value: nextOldNode._value)
      oldNode = nextOldNode
      newNode = newNode._next!
      if oldNode === node?._storage {
        nodeCopy = Node(newNode)
      }
    }
    _tail = newNode
    return nodeCopy
  }
}
