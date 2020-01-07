public struct LayoutPriorityValue<Value> {
    var value: Value
    var priority: LayoutPriority

    init(_ value: Value, priority: LayoutPriority) {
        self.value = value
        self.priority = priority
    }
}
