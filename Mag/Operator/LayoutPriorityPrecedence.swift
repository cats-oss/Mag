precedencegroup LayoutPriorityPrecedence {
    higherThan: RangeFormationPrecedence
    lowerThan: AdditionPrecedence
}

infix operator ~: LayoutPriorityPrecedence

public extension BinaryFloatingPoint {
    static func ~ <T>(lhs: T, rhs: Self) -> LayoutPriorityValue<T> {
        LayoutPriorityValue(lhs, priority: .init(Float(rhs)))
    }
}

public extension LayoutPriority {
    static func ~ <T>(lhs: T, rhs: LayoutPriority) -> LayoutPriorityValue<T> {
        LayoutPriorityValue(lhs, priority: rhs)
    }
}
