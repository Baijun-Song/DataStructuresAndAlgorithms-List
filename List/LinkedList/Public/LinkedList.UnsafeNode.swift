extension LinkedList {
  public struct UnsafeNode {
    @usableFromInline
    var storage: InternalNode
    
    @inlinable @inline(__always)
    init(_ node: InternalNode) {
      storage = node
    }
    
    @inlinable @inline(__always)
    public var value: Element {
      storage.value
    }
  }
}
