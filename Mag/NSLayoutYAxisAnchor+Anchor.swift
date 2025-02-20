#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

extension NSLayoutYAxisAnchor: LayoutAnchorProtocol {
    public func constraint(equalTo anchor: NSLayoutYAxisAnchor, constant: CGFloat, multiplier: CGFloat, priority: LayoutPriority) -> NSLayoutConstraint {
        constraint(equalTo: anchor, constant: constant).with(multiplier: multiplier, priority: priority)
    }

    public func constraint(greaterThanOrEqualTo anchor: NSLayoutYAxisAnchor, constant: CGFloat, multiplier: CGFloat, priority: LayoutPriority) -> NSLayoutConstraint {
        constraint(greaterThanOrEqualTo: anchor, constant: constant).with(multiplier: multiplier, priority: priority)
    }

    public func constraint(lessThanOrEqualTo anchor: NSLayoutYAxisAnchor, constant: CGFloat, multiplier: CGFloat, priority: LayoutPriority) -> NSLayoutConstraint {
        constraint(lessThanOrEqualTo: anchor, constant: constant).with(multiplier: multiplier, priority: priority)
    }
}

public extension NSLayoutYAxisAnchor {
    @discardableResult
    static func == (lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
        lhs.constraint(equalTo: rhs, constant: .zero, multiplier: 1, priority: .required)
    }
}
