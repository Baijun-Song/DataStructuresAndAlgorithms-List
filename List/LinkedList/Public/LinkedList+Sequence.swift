extension LinkedList: Sequence {
  @inlinable
  public func makeIterator() -> some IteratorProtocol {
    var currentNode = firstNode
    let iterator = AnyIterator {
      if let node = currentNode {
        currentNode = node.next
        return node.value
      } else {
        return nil
      }
    }
    return iterator
  }
}
