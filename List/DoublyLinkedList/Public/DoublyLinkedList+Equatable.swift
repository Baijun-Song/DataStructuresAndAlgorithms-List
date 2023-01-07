extension DoublyLinkedList: Equatable where Element: Equatable {
  @inlinable
  public static func == (lhs: Self, rhs: Self) -> Bool {
    var currentLeftNode = lhs.head
    var currentRightNode = rhs.head
    while true {
      switch (currentLeftNode, currentRightNode) {
      case let (leftNode?, rightNode?):
        if leftNode.value != rightNode.value {
          return false
        }
        currentLeftNode = leftNode.next
        currentRightNode = rightNode.next
      case (nil, nil):
        return true
      default:
        return false
      }
    }
  }
}
