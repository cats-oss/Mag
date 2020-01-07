import CoreGraphics

public protocol LayoutAnchorProtocol {
    associatedtype Constant: LayoutConstantProtocol
    associatedtype Constraint: Activatable

    func constraint(equalTo anchor: Self, constant: LayoutConstant<Constant>, priority: LayoutPriority) -> Constraint
    func constraint(greaterThanOrEqualTo anchor: Self, constant: LayoutConstant<Constant>, priority: LayoutPriority) -> Constraint
    func constraint(lessThanOrEqualTo anchor: Self, constant: LayoutConstant<Constant>, priority: LayoutPriority) -> Constraint
}

public extension LayoutAnchorProtocol {
    @discardableResult
    static func == (lhs: Self, rhs: Self) -> Constraint {
        lhs.constraint(equalTo: rhs, constant: .zero, priority: .required).activated()
    }

    @discardableResult
    static func == (lhs: Self, rhs: LayoutAnchorTarget<Self>) -> Constraint {
        lhs.constraint(equalTo: rhs.anchor, constant: rhs.constant, priority: rhs.priority).activated()
    }

    @discardableResult
    static func >= (lhs: Self, rhs: Self) -> Constraint {
        lhs.constraint(greaterThanOrEqualTo: rhs, constant: .zero, priority: .required).activated()
    }

    @discardableResult
    static func >= (lhs: Self, rhs: LayoutAnchorTarget<Self>) -> Constraint {
        lhs.constraint(greaterThanOrEqualTo: rhs.anchor, constant: rhs.constant, priority: rhs.priority).activated()
    }

    @discardableResult
    static func <= (lhs: Self, rhs: Self) -> Constraint {
        lhs.constraint(lessThanOrEqualTo: rhs, constant: .zero, priority: .required).activated()
    }

    @discardableResult
    static func <= (lhs: Self, rhs: LayoutAnchorTarget<Self>) -> Constraint {
        lhs.constraint(lessThanOrEqualTo: rhs.anchor, constant: rhs.constant, priority: rhs.priority).activated()
    }
}

public extension LayoutAnchorProtocol {
    static func + (lhs: Self, rhs: Constant) -> LayoutAnchorTarget<Self> {
        LayoutAnchorTarget(lhs, constant: LayoutConstant(rhs))
    }

    static func + (lhs: Self, rhs: LayoutPriorityValue<Constant>) -> LayoutAnchorTarget<Self> {
        LayoutAnchorTarget(lhs, constant: LayoutConstant(rhs.value), priority: rhs.priority)
    }

    static func - (lhs: Self, rhs: Constant) -> LayoutAnchorTarget<Self> {
        LayoutAnchorTarget(lhs, constant: -LayoutConstant(rhs))
    }

    static func - (lhs: Self, rhs: LayoutPriorityValue<Constant>) -> LayoutAnchorTarget<Self> {
        LayoutAnchorTarget(lhs, constant: -LayoutConstant(rhs.value), priority: rhs.priority)
    }

    static func * (lhs: Self, rhs: CGFloat) -> LayoutAnchorTarget<Self> {
        LayoutAnchorTarget(lhs, constant: LayoutConstant(.zero, multiplier: rhs))
    }

    static func * (lhs: Self, rhs: LayoutPriorityValue<CGFloat>) -> LayoutAnchorTarget<Self> {
        LayoutAnchorTarget(lhs, constant: LayoutConstant(.zero, multiplier: rhs.value), priority: rhs.priority)
    }

    static func ~ (lhs: Self, rhs: LayoutPriority) -> LayoutAnchorTarget<Self> {
        LayoutAnchorTarget(lhs, constant: .zero, priority: rhs)
    }

    static func ~ <T: BinaryFloatingPoint>(lhs: Self, rhs: T) -> LayoutAnchorTarget<Self> {
        LayoutAnchorTarget(lhs, constant: .zero, priority: .init(Float(rhs)))
    }
}
