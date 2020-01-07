import CoreGraphics

public protocol LayoutDimensionAnchorProtocol: LayoutAnchorProtocol {
    func constraint(equalToConstant constant: LayoutConstant<Constant>, priority: LayoutPriority) -> Constraint
    func constraint(greaterThanOrEqualToConstant constant: LayoutConstant<Constant>, priority: LayoutPriority) -> Constraint
    func constraint(lessThanOrEqualToConstant constant: LayoutConstant<Constant>, priority: LayoutPriority) -> Constraint
}

public extension LayoutDimensionAnchorProtocol {
    @discardableResult
    static func == (lhs: Self, rhs: Constant) -> Constraint {
        lhs.constraint(equalToConstant: LayoutConstant(rhs), priority: .required).activated()
    }

    @discardableResult
    static func == (lhs: Self, rhs: LayoutPriorityValue<Constant>) -> Constraint {
        lhs.constraint(equalToConstant: LayoutConstant(rhs.value), priority: rhs.priority).activated()
    }

    @discardableResult
    static func >= (lhs: Self, rhs: Constant) -> Constraint {
        lhs.constraint(greaterThanOrEqualToConstant: LayoutConstant(rhs), priority: .required).activated()
    }

    @discardableResult
    static func >= (lhs: Self, rhs: LayoutPriorityValue<Constant>) -> Constraint {
        lhs.constraint(greaterThanOrEqualToConstant: LayoutConstant(rhs.value), priority: rhs.priority).activated()
    }

    @discardableResult
    static func <= (lhs: Self, rhs: Constant) -> Constraint {
        lhs.constraint(lessThanOrEqualToConstant: LayoutConstant(rhs), priority: .required).activated()
    }

    @discardableResult
    static func <= (lhs: Self, rhs: LayoutPriorityValue<Constant>) -> Constraint {
        lhs.constraint(lessThanOrEqualToConstant: LayoutConstant(rhs.value), priority: rhs.priority).activated()
    }
}
