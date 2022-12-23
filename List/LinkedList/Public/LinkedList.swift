public struct LinkedList<Element> {
  @usableFromInline
  var head: InternalNode?
  
  @usableFromInline
  weak var tail: InternalNode? 
  
  @inlinable @inline(__always)
  public init() {}
  
  @inlinable @inline(__always)
  public init<S>(
    _ elements: S
  ) where S: Sequence, S.Element == Element {
    for element in elements {
      append(element)
    }
  }
}

extension LinkedList {
  @inlinable @inline(__always)
  public var firstNode: Node? {
    if let head = head {
      return Node(head)
    } else {
      return nil
    } 
  }
  
  @inlinable @inline(__always)
  public var lastNode: Node? {
    if let tail = tail {
      return Node(tail)
    } else {
      return nil
    }
  }
  
  @inlinable @inline(__always)
  public var isEmpty: Bool {
    head == nil
  }
  
  @inlinable
  public var count: Int {
    var count = 0
    var currentNode = head
    while let node = currentNode {
      count += 1
      currentNode = node.next
    }
    return count
  }
  
  @inlinable
  @discardableResult
  public mutating func prepend(
    _ newElement: Element
  ) -> Node {
    update()
    head = InternalNode(value: newElement, next: head)
    if tail == nil {
      tail = head
    }
    checkInvariants()
    return Node(head!)
  }
  
  @inlinable
  @discardableResult
  public mutating func append(
    _ newElement: Element
  ) -> Node {
    update()
    guard let tailNode = tail else {
      return prepend(newElement)
    }
    tailNode.next = InternalNode(value: newElement)
    tail = tailNode.next
    checkInvariants()
    return Node(tail!)
  }
  
  @inlinable
  @discardableResult
  public mutating func insert(
    _ newElement: Element,
    after node: Node
  ) -> Node {
    let nodeCopy = update(withNode: node) ?? node
    let validNode = nodeCopy.storage
    if validNode === tail {
      return append(newElement)
    } else {
      validNode.next = InternalNode(value: newElement, next: validNode.next)
      checkInvariants()
      return Node(validNode.next!)
    }
  }
  
  @inlinable
  public mutating func popFirst() -> Element? {
    update()
    guard let headNode = head else {
      return nil
    }
    let result = headNode.value
    head = headNode.next
    if head == nil {
      tail = nil
    }
    checkInvariants()
    return result
  }
  
  @inlinable @inline(__always)
  @discardableResult
  public mutating func removeFirst() -> Element {
    if let removedElement = popFirst() {
      return removedElement
    } else {
      preconditionFailure()
    }
  }
  
  @inlinable
  @discardableResult
  public mutating func removeLast() -> Element {
    update()
    guard let head = head, head.next != nil else {
      return removeFirst()
    }
    var previousNode = head
    var currentNode = head
    while let nextNode = currentNode.next {
      previousNode = currentNode
      currentNode = nextNode
    }
    previousNode.next = nil
    tail = previousNode
    checkInvariants()
    return currentNode.value
  }
  
  @inlinable
  @discardableResult
  public mutating func remove(
    after node: Node
  ) -> Element {
    let nodeCopy = update(withNode: node) ?? node
    let validNode = nodeCopy.storage
    guard let nextNode = validNode.next else {
      preconditionFailure()
    }
    let removedElement = nextNode.value
    if nextNode === tail {
      tail = validNode
    }
    validNode.next = nextNode.next
    checkInvariants()
    return removedElement
  }
  
  @inlinable
  public mutating func reverse() {
    update()
    tail = head
    var previousNode = head
    var currentNode = head?.next
    previousNode?.next = nil
    while currentNode != nil {
      let next = currentNode?.next
      currentNode?.next = previousNode
      previousNode = currentNode
      currentNode = next
    }
    head = previousNode
    checkInvariants()
  }
  
  @inlinable @inline(__always)
  public func reversed() -> Self {
    var reversed = self
    reversed.reverse()
    return reversed
  }
}
