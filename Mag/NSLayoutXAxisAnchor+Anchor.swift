#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

extension NSLayoutXAxisAnchor: LayoutAnchorProtocol {
    public func constraint(equalTo anchor: NSLayoutXAxisAnchor, constant: LayoutConstant<CGFloat>, priority: LayoutPriority) -> NSLayoutConstraint {
        constraint(equalTo: anchor, constant: constant.value).with(multiplier: constant.multiplier, priority: priority)
    }

    public func constraint(greaterThanOrEqualTo anchor: NSLayoutXAxisAnchor, constant: LayoutConstant<CGFloat>, priority: LayoutPriority) -> NSLayoutConstraint {
        constraint(greaterThanOrEqualTo: anchor, constant: constant.value).with(multiplier: constant.multiplier, priority: priority)
    }

    public func constraint(lessThanOrEqualTo anchor: NSLayoutXAxisAnchor, constant: LayoutConstant<CGFloat>, priority: LayoutPriority) -> NSLayoutConstraint {
        constraint(lessThanOrEqualTo: anchor, constant: constant.value).with(multiplier: constant.multiplier, priority: priority)
    }
}

public extension NSLayoutXAxisAnchor {
    @discardableResult
    static func == (lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
        lhs.constraint(equalTo: rhs).activated()
    }
}
