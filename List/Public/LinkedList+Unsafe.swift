extension LinkedList {
  public mutating func breakIntoUnsafeNodes() -> [UnsafeNode] {
    _update()
    var result: [UnsafeNode] = []
    var currentNode = _head
    while let node = currentNode {
      result.append(UnsafeNode(node))
      currentNode = node._next
      node._next = nil
    }
    _head = nil
    _tail = nil
    _checkInvariants()
    return result
  }
  
  public init(unsafeNodes: [UnsafeNode]) {
    guard !unsafeNodes.isEmpty else {
      return
    }
    _head = unsafeNodes[0]._storage
    var currentNode = _head!
    for unsafeNode in unsafeNodes[1...] {
      currentNode._next = unsafeNode._storage
      currentNode = currentNode._next!
    }
    _tail = currentNode
    _checkInvariants()
  }
}
