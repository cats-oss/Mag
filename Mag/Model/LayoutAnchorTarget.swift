public struct LayoutAnchorTarget<Anchor: LayoutAnchorProtocol> {
    var anchor: Anchor
    var constant: LayoutConstant<Anchor.Constant>
    var priority: LayoutPriority

    init(_ anchor: Anchor, constant: LayoutConstant<Anchor.Constant>, priority: LayoutPriority = .required) {
        self.anchor = anchor
        self.constant = constant
        self.priority = priority
    }
}
