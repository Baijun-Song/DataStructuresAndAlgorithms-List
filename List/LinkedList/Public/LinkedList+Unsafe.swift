extension LinkedList {
  @inlinable
  public mutating func breakIntoUnsafeNodes() -> [UnsafeNode] {
    update()
    var result: [UnsafeNode] = []
    var currentNode = head
    while let node = currentNode {
      result.append(UnsafeNode(node))
      currentNode = node.next
      node.next = nil
    }
    head = nil
    tail = nil
    checkInvariants()
    return result
  }
  
  @inlinable
  public init(unsafeNodes: [UnsafeNode]) {
    guard !unsafeNodes.isEmpty else {
      return
    }
    head = unsafeNodes[0].storage
    var currentNode = head!
    for unsafeNode in unsafeNodes[1...] {
      currentNode.next = unsafeNode.storage
      currentNode = currentNode.next!
    }
    tail = currentNode
    checkInvariants()
  }
}
