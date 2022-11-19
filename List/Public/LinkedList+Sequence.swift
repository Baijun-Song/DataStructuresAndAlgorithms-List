extension LinkedList: Sequence {
  public func makeIterator() -> some IteratorProtocol {
    var currentNode = head
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
