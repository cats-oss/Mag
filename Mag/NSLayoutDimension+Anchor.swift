#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

extension NSLayoutDimension: LayoutAnchorProtocol {
    public func constraint(equalTo anchor: NSLayoutDimension, constant: CGFloat, multiplier: CGFloat, priority: LayoutPriority) -> NSLayoutConstraint {
        constraint(equalTo: anchor, constant: constant).with(multiplier: multiplier, priority: priority)
    }

    public func constraint(greaterThanOrEqualTo anchor: NSLayoutDimension, constant: CGFloat, multiplier: CGFloat, priority: LayoutPriority) -> NSLayoutConstraint {
        constraint(greaterThanOrEqualTo: anchor, constant: constant).with(multiplier: multiplier, priority: priority)
    }

    public func constraint(lessThanOrEqualTo anchor: NSLayoutDimension, constant: CGFloat, multiplier: CGFloat, priority: LayoutPriority) -> NSLayoutConstraint {
        constraint(lessThanOrEqualTo: anchor, constant: constant).with(multiplier: multiplier, priority: priority)
    }
}

extension NSLayoutDimension: LayoutDimensionAnchorProtocol {
    public func constraint(equalToConstant constant: CGFloat, multiplier: CGFloat, priority: LayoutPriority) -> NSLayoutConstraint {
        constraint(equalToConstant: constant).with(multiplier: multiplier, priority: priority)
    }

    public func constraint(greaterThanOrEqualToConstant constant: CGFloat, multiplier: CGFloat, priority: LayoutPriority) -> NSLayoutConstraint {
        constraint(greaterThanOrEqualToConstant: constant).with(multiplier: multiplier, priority: priority)
    }

    public func constraint(lessThanOrEqualToConstant constant: CGFloat, multiplier: CGFloat, priority: LayoutPriority) -> NSLayoutConstraint {
        constraint(lessThanOrEqualToConstant: constant).with(multiplier: multiplier, priority: priority)
    }
}

public extension NSLayoutDimension {
    @discardableResult
    static func == (lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
        lhs.constraint(equalTo: rhs, constant: .zero, multiplier: 1, priority: .required)
    }
}
