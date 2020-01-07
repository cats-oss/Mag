#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

extension NSLayoutDimension: LayoutAnchorProtocol {
    public func constraint(equalTo anchor: NSLayoutDimension, constant: LayoutConstant<CGFloat>, priority: LayoutPriority) -> NSLayoutConstraint {
        constraint(equalTo: anchor, constant: constant.value).with(multiplier: constant.multiplier, priority: priority)
    }

    public func constraint(greaterThanOrEqualTo anchor: NSLayoutDimension, constant: LayoutConstant<CGFloat>, priority: LayoutPriority) -> NSLayoutConstraint {
        constraint(greaterThanOrEqualTo: anchor, constant: constant.value).with(multiplier: constant.multiplier, priority: priority)
    }

    public func constraint(lessThanOrEqualTo anchor: NSLayoutDimension, constant: LayoutConstant<CGFloat>, priority: LayoutPriority) -> NSLayoutConstraint {
        constraint(lessThanOrEqualTo: anchor, constant: constant.value).with(multiplier: constant.multiplier, priority: priority)
    }
}

extension NSLayoutDimension: LayoutDimensionAnchorProtocol {
    public func constraint(equalToConstant constant: LayoutConstant<Constant>, priority: LayoutPriority) -> NSLayoutConstraint {
        constraint(equalToConstant: constant.value).with(multiplier: constant.multiplier, priority: priority)
    }

    public func constraint(greaterThanOrEqualToConstant constant: LayoutConstant<Constant>, priority: LayoutPriority) -> NSLayoutConstraint {
        constraint(greaterThanOrEqualToConstant: constant.value).with(multiplier: constant.multiplier, priority: priority)
    }

    public func constraint(lessThanOrEqualToConstant constant: LayoutConstant<Constant>, priority: LayoutPriority) -> NSLayoutConstraint {
        constraint(lessThanOrEqualToConstant: constant.value).with(multiplier: constant.multiplier, priority: priority)
    }
}

public extension NSLayoutDimension {
    @discardableResult
    static func == (lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
        rhs.constraint(equalTo: rhs).activated()
    }
}
