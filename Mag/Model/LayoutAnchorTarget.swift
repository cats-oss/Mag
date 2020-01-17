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
