#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

extension NSLayoutConstraint {
    func with(multiplier: CGFloat, priority: LayoutPriority) -> NSLayoutConstraint {
        guard let item = firstItem else {
            fatalError("First item in constraint is nil.")
        }

        (item as? View)?.translatesAutoresizingMaskIntoConstraints = false
        let constraint = LayoutConstraint(
            item: item,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant
        )
        constraint.priority = priority
        constraint.shouldBeArchived = shouldBeArchived
        constraint.identifier = identifier
        return constraint
    }
}
