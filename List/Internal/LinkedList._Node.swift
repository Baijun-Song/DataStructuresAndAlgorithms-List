extension LinkedList {
  final class _Node {
    var _value: Element
    var _next: _Node?
    
    init(value: Element, next: _Node? = nil) {
      self._value = value
      self._next = next
    }
  }
}
