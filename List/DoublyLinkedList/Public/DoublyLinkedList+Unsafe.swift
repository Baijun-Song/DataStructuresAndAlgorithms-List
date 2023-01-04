extension DoublyLinkedList {
  @inlinable
  public mutating func breakIntoUnsafeNodes() -> [UnsafeNode] {
    update()
    var result: [UnsafeNode] = []
    var currentNode = head
    while let node = currentNode {
      result.append(UnsafeNode(node))
      currentNode = node.next
      node.next = nil
      currentNode?.prev = nil
    }
    head = nil
    tail = nil
    checkInvariants()
    return result
  }
  
  @inlinable
  public init(unsafeNodes: [UnsafeNode]) {
    guard let firstUnsafeNode = unsafeNodes.first else {
      return
    }
    head = firstUnsafeNode.storage
    var currentNode = firstUnsafeNode.storage
    for unsafeNode in unsafeNodes.dropFirst() {
      currentNode.next = unsafeNode.storage
      currentNode = unsafeNode.storage
    }
    tail = currentNode
    checkInvariants()
  }
}
