extension DoublyLinkedList {
  @usableFromInline
  final class InternalNode {
    @usableFromInline
    var value: Element
    
    @usableFromInline
    var next: InternalNode?
    
    @usableFromInline
    weak var prev: InternalNode?
    
    @inlinable @inline(__always)
    init(
      value: Element,
      next: InternalNode? = nil,
      prev: InternalNode? = nil
    ) {
      self.value = value
      self.next = next
      self.prev = prev
    }
  }
}
