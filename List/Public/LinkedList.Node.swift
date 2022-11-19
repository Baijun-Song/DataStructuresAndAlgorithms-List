extension LinkedList {
  public struct Node {
    private weak var __weakNodeReference: _Node?
    
    init(_ node: _Node) {
      __weakNodeReference = node
    }
    
    var _storage: _Node {
      guard let validNode = __weakNodeReference else {
        preconditionFailure()
      }
      return validNode
    }
    
    public var next: Node? {
      if let next = _storage._next {
        return Node(next)
      } else {
        return nil
      }
    }
    
    public var value: Element {
      get { _storage._value }
      set { _storage._value = newValue }
    }
  }
}
