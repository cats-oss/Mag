import CoreGraphics

public struct LayoutAnchorTarget<Anchor: LayoutAnchorProtocol> {
    var anchor: Anchor
    var constant: Anchor.Constant
    var multiplier: CGFloat
    var priority: LayoutPriority

    init(_ anchor: Anchor, constant: Anchor.Constant, multiplier: CGFloat, priority: LayoutPriority = .required) {
        self.anchor = anchor
        self.constant = constant
        self.multiplier = multiplier
        self.priority = priority
    }
}

public extension LayoutAnchorTarget {
    static func + (lhs: Self, rhs: Anchor.Constant) -> Self {
        LayoutAnchorTarget(lhs.anchor, constant: rhs, multiplier: lhs.multiplier, priority: lhs.priority)
    }

    static func - (lhs: Self, rhs: Anchor.Constant) -> Self {
        LayoutAnchorTarget(lhs.anchor, constant: -rhs, multiplier: lhs.multiplier, priority: lhs.priority)
    }

    static func * (lhs: Self, rhs: CGFloat) -> Self {
        LayoutAnchorTarget(lhs.anchor, constant: lhs.constant, multiplier: rhs, priority: lhs.priority)
    }

    static func ~ (lhs: Self, rhs: LayoutPriority) -> Self {
        LayoutAnchorTarget(lhs.anchor, constant: lhs.constant, multiplier: lhs.multiplier, priority: rhs)
    }

    static func ~ <T: BinaryFloatingPoint>(lhs: Self, rhs: T) -> Self {
        LayoutAnchorTarget(lhs.anchor, constant: lhs.constant, multiplier: lhs.multiplier, priority: .init(Float(rhs)))
    }
}
