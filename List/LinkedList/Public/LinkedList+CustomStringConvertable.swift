extension LinkedList: CustomStringConvertible {
  public var description: String {
    guard !isEmpty else {
      return "Empty Linked List"
    }
    let s1 = "Linked List: head-> "
    let s2 = map { "\($0)" }.joined(separator: "---")
    let s3 = " <-tail"
    return s1 + s2 + s3
  }
}
