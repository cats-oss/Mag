#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

public protocol NSLayoutHorizontalAnchorProtocol {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
}

public struct NSLayoutHorizontalAnchor: NSLayoutHorizontalAnchorProtocol {
    var base: NSLayoutHorizontalAnchorProtocol

    public var leadingAnchor: NSLayoutXAxisAnchor {
        base.leadingAnchor
    }

    public var trailingAnchor: NSLayoutXAxisAnchor {
        base.trailingAnchor
    }

    init(_ base: NSLayoutHorizontalAnchorProtocol) {
        self.base = base
    }
}

extension NSLayoutHorizontalAnchor: LayoutAnchorProtocol {
    public func constraint(equalTo anchor: NSLayoutHorizontalAnchor, constant: EdgeInsets, multiplier: CGFloat, priority: LayoutPriority) -> [NSLayoutConstraint] {
        [
            leadingAnchor.constraint(equalTo: anchor.leadingAnchor, constant: constant.left, multiplier: multiplier, priority: priority),
            trailingAnchor.constraint(equalTo: anchor.trailingAnchor, constant: -constant.right, multiplier: multiplier, priority: priority)
        ]
    }

    public func constraint(greaterThanOrEqualTo anchor: NSLayoutHorizontalAnchor, constant: EdgeInsets, multiplier: CGFloat, priority: LayoutPriority) -> [NSLayoutConstraint] {
        [
            leadingAnchor.constraint(greaterThanOrEqualTo: anchor.leadingAnchor, constant: constant.left, multiplier: multiplier, priority: priority),
            trailingAnchor.constraint(greaterThanOrEqualTo: anchor.trailingAnchor, constant: -constant.right, multiplier: multiplier, priority: priority)
        ]
    }

    public func constraint(lessThanOrEqualTo anchor: NSLayoutHorizontalAnchor, constant: EdgeInsets, multiplier: CGFloat, priority: LayoutPriority) -> [NSLayoutConstraint] {
        [
            leadingAnchor.constraint(lessThanOrEqualTo: anchor.leadingAnchor, constant: constant.left, multiplier: multiplier, priority: priority),
            trailingAnchor.constraint(lessThanOrEqualTo: anchor.trailingAnchor, constant: -constant.right, multiplier: multiplier, priority: priority)
        ]
    }
}

public protocol HasHorizontalAnchor: NSLayoutHorizontalAnchorProtocol {
    var horizontalAnchor: NSLayoutHorizontalAnchor { get }
}

public extension HasHorizontalAnchor {
    var horizontalAnchor: NSLayoutHorizontalAnchor {
        NSLayoutHorizontalAnchor(self)
    }
}

extension View: HasHorizontalAnchor {}
extension LayoutGuide: HasHorizontalAnchor {}
