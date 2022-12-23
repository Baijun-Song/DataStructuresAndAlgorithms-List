extension LinkedList {
  public struct Node {
    @usableFromInline
    weak var _storage: InternalNode?
    
    @inlinable @inline(__always)
    init(_ node: InternalNode) {
      _storage = node
    }
    
    @inlinable @inline(__always)
    var storage: InternalNode {
      guard let storage = _storage else {
        preconditionFailure()
      }
      return storage
    }
    
    @inlinable @inline(__always)
    public var next: Node? {
      if let next = storage.next {
        return Node(next)
      } else {
        return nil
      }
    }
    
    @inlinable @inline(__always)
    public var value: Element {
      get { storage.value }
      set { storage.value = newValue }
    }
  }
}
