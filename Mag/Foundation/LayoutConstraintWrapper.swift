#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

final class LayoutConstraintWrapper: NSLayoutConstraint {
    deinit {
        if !hasActivated {
            origin.isActive = true
        }
    }

    let origin:  NSLayoutConstraint

    var hasActivated = false

    override var priority: LayoutPriority {
        get { origin.priority }
        set { origin.priority = newValue }
    }

    override var shouldBeArchived: Bool {
        get { origin.shouldBeArchived }
        set { origin.shouldBeArchived = newValue }
    }

    override var firstItem: AnyObject? {
        origin.firstItem
    }

    override var secondItem: AnyObject? {
        origin.secondItem
    }

    override var firstAttribute: NSLayoutConstraint.Attribute {
        origin.firstAttribute
    }

    override var secondAttribute: NSLayoutConstraint.Attribute {
        origin.secondAttribute
    }

    override var firstAnchor: NSLayoutAnchor<AnyObject> {
        origin.firstAnchor
    }

    override var secondAnchor: NSLayoutAnchor<AnyObject>? {
        origin.secondAnchor
    }

    override var relation: NSLayoutConstraint.Relation {
        origin.relation
    }

    override var multiplier: CGFloat {
        origin.multiplier
    }

    override var constant: CGFloat {
        get { origin.constant }
        set { origin.constant = newValue }
    }

    override var isActive: Bool {
        get { origin.isActive }
        set {
            hasActivated = hasActivated || newValue
            origin.isActive = newValue
        }
    }

    override var identifier: String? {
        get { origin.identifier }
        set { origin.identifier = newValue }
    }

    init(origin: NSLayoutConstraint) {
        self.origin = origin
    }
}
