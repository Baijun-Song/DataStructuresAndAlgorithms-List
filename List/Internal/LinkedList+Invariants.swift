extension LinkedList {
  func _checkInvariants() {
    assert(_tail?._next == nil)
  }
}
