import CoreGraphics

public protocol LayoutAnchorProtocol {
    associatedtype Constant: LayoutConstantProtocol
    associatedtype Constraint: Activatable

    func constraint(equalTo anchor: Self, constant: Constant, multiplier: CGFloat, priority: LayoutPriority) -> Constraint
    func constraint(greaterThanOrEqualTo anchor: Self, constant: Constant, multiplier: CGFloat, priority: LayoutPriority) -> Constraint
    func constraint(lessThanOrEqualTo anchor: Self, constant: Constant, multiplier: CGFloat, priority: LayoutPriority) -> Constraint
}

public extension LayoutAnchorProtocol {
    @discardableResult
    static func == (lhs: Self, rhs: Self) -> Constraint {
        lhs.constraint(equalTo: rhs, constant: .zero, multiplier: 1, priority: .required).activated()
    }

    @discardableResult
    static func == (lhs: Self, rhs: LayoutAnchorTarget<Self>) -> Constraint {
        lhs.constraint(equalTo: rhs.anchor, constant: rhs.constant, multiplier: rhs.multiplier, priority: rhs.priority).activated()
    }

    @discardableResult
    static func >= (lhs: Self, rhs: Self) -> Constraint {
        lhs.constraint(greaterThanOrEqualTo: rhs, constant: .zero, multiplier: 1, priority: .required).activated()
    }

    @discardableResult
    static func >= (lhs: Self, rhs: LayoutAnchorTarget<Self>) -> Constraint {
        lhs.constraint(greaterThanOrEqualTo: rhs.anchor, constant: rhs.constant, multiplier: rhs.multiplier, priority: rhs.priority).activated()
    }

    @discardableResult
    static func <= (lhs: Self, rhs: Self) -> Constraint {
        lhs.constraint(lessThanOrEqualTo: rhs, constant: .zero, multiplier: 1, priority: .required).activated()
    }

    @discardableResult
    static func <= (lhs: Self, rhs: LayoutAnchorTarget<Self>) -> Constraint {
        lhs.constraint(lessThanOrEqualTo: rhs.anchor, constant: rhs.constant, multiplier: rhs.multiplier, priority: rhs.priority).activated()
    }
}

public extension LayoutAnchorProtocol {
    static func + (lhs: Self, rhs: Constant) -> LayoutAnchorTarget<Self> {
        LayoutAnchorTarget(lhs, constant: rhs, multiplier: 1)
    }

    static func + (lhs: Self, rhs: LayoutPriorityValue<Constant>) -> LayoutAnchorTarget<Self> {
        LayoutAnchorTarget(lhs, constant: rhs.value, multiplier: 1, priority: rhs.priority)
    }

    static func - (lhs: Self, rhs: Constant) -> LayoutAnchorTarget<Self> {
        LayoutAnchorTarget(lhs, constant: -rhs, multiplier: 1)
    }

    static func - (lhs: Self, rhs: LayoutPriorityValue<Constant>) -> LayoutAnchorTarget<Self> {
        LayoutAnchorTarget(lhs, constant: -rhs.value, multiplier: 1, priority: rhs.priority)
    }

    static func * (lhs: Self, rhs: CGFloat) -> LayoutAnchorTarget<Self> {
        LayoutAnchorTarget(lhs, constant: .zero, multiplier: rhs)
    }

    static func * (lhs: Self, rhs: LayoutPriorityValue<CGFloat>) -> LayoutAnchorTarget<Self> {
        LayoutAnchorTarget(lhs, constant: .zero, multiplier: rhs.value, priority: rhs.priority)
    }

    static func ~ (lhs: Self, rhs: LayoutPriority) -> LayoutAnchorTarget<Self> {
        LayoutAnchorTarget(lhs, constant: .zero, multiplier: 1, priority: rhs)
    }

    static func ~ <T: BinaryFloatingPoint>(lhs: Self, rhs: T) -> LayoutAnchorTarget<Self> {
        LayoutAnchorTarget(lhs, constant: .zero, multiplier: 1, priority: .init(Float(rhs)))
    }
}
