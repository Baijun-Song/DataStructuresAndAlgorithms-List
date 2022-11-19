extension LinkedList {
  public struct UnsafeNode {
    var _storage: _Node
    
    init(_ node: _Node) {
      _storage = node
    }
    
    public var value: Element {
      _storage._value
    }
  }
}
