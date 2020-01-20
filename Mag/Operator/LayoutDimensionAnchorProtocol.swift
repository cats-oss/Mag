import CoreGraphics

public protocol LayoutDimensionAnchorProtocol: LayoutAnchorProtocol {
    func constraint(equalToConstant constant: Constant, multiplier: CGFloat, priority: LayoutPriority) -> Constraint
    func constraint(greaterThanOrEqualToConstant constant: Constant, multiplier: CGFloat, priority: LayoutPriority) -> Constraint
    func constraint(lessThanOrEqualToConstant constant: Constant, multiplier: CGFloat, priority: LayoutPriority) -> Constraint
}

public extension LayoutDimensionAnchorProtocol {
    @discardableResult
    static func == (lhs: Self, rhs: Constant) -> Constraint {
        lhs.constraint(equalToConstant: rhs, multiplier: 1, priority: .required).activated()
    }

    @discardableResult
    static func == (lhs: Self, rhs: LayoutPriorityValue<Constant>) -> Constraint {
        lhs.constraint(equalToConstant: rhs.value, multiplier: 1, priority: rhs.priority).activated()
    }

    @discardableResult
    static func >= (lhs: Self, rhs: Constant) -> Constraint {
        lhs.constraint(greaterThanOrEqualToConstant: rhs, multiplier: 1, priority: .required).activated()
    }

    @discardableResult
    static func >= (lhs: Self, rhs: LayoutPriorityValue<Constant>) -> Constraint {
        lhs.constraint(greaterThanOrEqualToConstant: rhs.value, multiplier: 1, priority: rhs.priority).activated()
    }

    @discardableResult
    static func <= (lhs: Self, rhs: Constant) -> Constraint {
        lhs.constraint(lessThanOrEqualToConstant: rhs, multiplier: 1, priority: .required).activated()
    }

    @discardableResult
    static func <= (lhs: Self, rhs: LayoutPriorityValue<Constant>) -> Constraint {
        lhs.constraint(lessThanOrEqualToConstant: rhs.value, multiplier: 1, priority: rhs.priority).activated()
    }
}
