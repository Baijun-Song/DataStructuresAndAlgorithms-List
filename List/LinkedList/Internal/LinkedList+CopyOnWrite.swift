extension LinkedList {
  @usableFromInline
  @discardableResult
  mutating func update(
    withNode node: Node? = nil
  ) -> Node? {
    guard
      !isKnownUniquelyReferenced(&head),
      var oldNode = head
    else {
      return nil
    }
    head = InternalNode(value: oldNode.value)
    var newNode = head!
    var nodeCopy: Node?
    if oldNode === node?.storage {
      nodeCopy = Node(newNode)
    }
    
    while let nextOldNode = oldNode.next {
      newNode.next = InternalNode(value: nextOldNode.value)
      oldNode = nextOldNode
      newNode = newNode.next!
      if oldNode === node?.storage {
        nodeCopy = Node(newNode)
      }
    }
    tail = newNode
    return nodeCopy
  }
}
