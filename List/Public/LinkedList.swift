public struct LinkedList<Element> {
  var _head: _Node?
  weak var _tail: _Node? 
  
  public init() {}
  
  public init<S>(
    _ elements: S
  ) where S: Sequence, S.Element == Element {
    for element in elements {
      append(element)
    }
  }
}

extension LinkedList {
  public var head: Node? {
    if let _head = _head {
      return Node(_head)
    } else {
      return nil
    }
  }
  
  public var tail: Node? {
    if let _tail = _tail {
      return Node(_tail)
    } else {
      return nil
    }
  }
  
  public var isEmpty: Bool {
    _head == nil
  }
  
  public var count: Int {
    var count = 0
    var currentNode = _head
    while let node = currentNode {
      count += 1
      currentNode = node._next
    }
    return count
  }
  
  @discardableResult
  public mutating func prepend(
    _ newElement: Element
  ) -> Node {
    _update()
    _head = _Node(value: newElement, next: _head)
    if _tail == nil {
      _tail = _head
    }
    _checkInvariants()
    return Node(_head!)
  }
  
  @discardableResult
  public mutating func append(
    _ newElement: Element
  ) -> Node {
    _update()
    guard let tailNode = _tail else {
      return prepend(newElement)
    }
    tailNode._next = _Node(value: newElement)
    _tail = tailNode._next
    _checkInvariants()
    return Node(_tail!)
  }
  
  @discardableResult
  public mutating func insert(
    _ newElement: Element,
    after node: Node
  ) -> Node {
    let nodeCopy = _update(withNode: node) ?? node
    let validNode = nodeCopy._storage
    if validNode === _tail {
      return append(newElement)
    } else {
      validNode._next = _Node(value: newElement, next: validNode._next)
      _checkInvariants()
      return Node(validNode._next!)
    }
  }
  
  public mutating func popFirst() -> Element? {
    _update()
    guard let node = _head else {
      return nil
    }
    let result = node._value
    _head = node._next
    if _head == nil {
      _tail = nil
    }
    _checkInvariants()
    return result
  }
  
  @discardableResult
  public mutating func removeFirst() -> Element {
    if let removedElement = popFirst() {
      return removedElement
    } else {
      preconditionFailure()
    }
  }
  
  @discardableResult
  public mutating func removeLast() -> Element {
    _update()
    guard let head = _head, head._next != nil else {
      return removeFirst()
    }
    var previousNode = head
    var currentNode = head
    while let nextNode = currentNode._next {
      previousNode = currentNode
      currentNode = nextNode
    }
    previousNode._next = nil
    _tail = previousNode
    _checkInvariants()
    return currentNode._value
  }
  
  @discardableResult
  public mutating func remove(
    after node: Node
  ) -> Element {
    let nodeCopy = _update(withNode: node) ?? node
    let validNode = nodeCopy._storage
    guard let nextNode = validNode._next else {
      preconditionFailure()
    }
    let removedElement = nextNode._value
    if nextNode === _tail {
      _tail = validNode
    }
    validNode._next = nextNode._next
    _checkInvariants()
    return removedElement
  }
  
  public mutating func reverse() {
    _update()
    _tail = _head
    var previousNode = _head
    var currentNode = _head?._next
    previousNode?._next = nil
    while currentNode != nil {
      let next = currentNode?._next
      currentNode?._next = previousNode
      previousNode = currentNode
      currentNode = next
    }
    _head = previousNode
    _checkInvariants()
  }
  
  public func reversed() -> Self {
    var reversed = self
    reversed.reverse()
    return reversed
  }
}
