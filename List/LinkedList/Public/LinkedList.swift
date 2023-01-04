public struct LinkedList<Element> {
  @usableFromInline
  var head: Node?
  
  @usableFromInline
  weak var tail: Node? 
  
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
  public var isEmpty: Bool {
    head == nil
  }

  @inlinable
  public var count: Int {
    var result = 0
    var currentNode = head
    while let node = currentNode {
      result += 1
      currentNode = node.next
    }
    return result
  }

  @inlinable
  public mutating func prepend(_ newElement: Element) {
    update()
    let newNode = Node(value: newElement, next: head)
    head = newNode
    if tail == nil {
      tail = newNode
    }
    checkInvariants()
  }

  @inlinable
  public mutating func append(_ newElement: Element) {
    update()
    guard let tail = tail else {
      prepend(newElement)
      return
    }
    let newNode = Node(value: newElement)
    tail.next = newNode
    self.tail = newNode
    checkInvariants()
  }

  @inlinable
  public mutating func insert(
    _ newElement: Element,
    after index: Index
  ) {
    guard let node = update(withIndex: index).node else {
      preconditionFailure()
    }
    if node === tail {
      return append(newElement)
    } else {
      let newNode = Node(value: newElement, next: node.next)
      node.next = newNode
      checkInvariants()
    }
  }

  @inlinable
  public mutating func popFirst() -> Element? {
    update()
    guard let head = head else {
      return nil
    }
    let removedElement = head.value
    self.head = head.next
    if self.head == nil {
      tail = nil
    }
    checkInvariants()
    return removedElement
  }

  @inlinable
  @discardableResult
  public mutating func remove(
    after index: Index
  ) -> Element {
    guard
      let node = update(withIndex: index).node,
      let nextNode = node.next
    else {
      preconditionFailure()
    }
    let removedElement = nextNode.value
    if nextNode === tail {
      tail = node
    }
    node.next = nextNode.next
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
      let nextNode = currentNode?.next
      currentNode?.next = previousNode
      previousNode = currentNode
      currentNode = nextNode
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
