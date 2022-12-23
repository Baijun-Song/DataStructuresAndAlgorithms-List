extension LinkedList {
  @usableFromInline
  final class InternalNode {
    @usableFromInline
    var value: Element
    
    @usableFromInline
    var next: InternalNode?
    
    @inlinable @inline(__always)
    init(value: Element, next: InternalNode? = nil) {
      self.value = value
      self.next = next
    }
  }
}
