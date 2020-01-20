#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

public protocol NSLayoutEdgeAnchorProtocol {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
}

public struct NSLayoutEdgeAnchor: NSLayoutEdgeAnchorProtocol {
    var base: NSLayoutEdgeAnchorProtocol

    public var leadingAnchor: NSLayoutXAxisAnchor {
        base.leadingAnchor
    }

    public var trailingAnchor: NSLayoutXAxisAnchor {
        base.trailingAnchor
    }

    public var topAnchor: NSLayoutYAxisAnchor {
        base.topAnchor
    }

    public var bottomAnchor: NSLayoutYAxisAnchor {
        base.bottomAnchor
    }

    init(_ base: NSLayoutEdgeAnchorProtocol) {
        self.base = base
    }
}

extension NSLayoutEdgeAnchor: LayoutAnchorProtocol {
    public func constraint(equalTo anchor: NSLayoutEdgeAnchor, constant: EdgeInsets, multiplier: CGFloat, priority: LayoutPriority) -> [NSLayoutConstraint] {
        [
            topAnchor.constraint(equalTo: anchor.topAnchor, constant: constant.top, multiplier: multiplier, priority: priority),
            bottomAnchor.constraint(equalTo: anchor.bottomAnchor, constant: -constant.bottom, multiplier: multiplier, priority: priority),
            leadingAnchor.constraint(equalTo: anchor.leadingAnchor, constant: constant.left, multiplier: multiplier, priority: priority),
            trailingAnchor.constraint(equalTo: anchor.trailingAnchor, constant: -constant.right, multiplier: multiplier, priority: priority)
        ]
    }

    public func constraint(greaterThanOrEqualTo anchor: NSLayoutEdgeAnchor, constant: EdgeInsets, multiplier: CGFloat, priority: LayoutPriority) -> [NSLayoutConstraint] {
        [
            topAnchor.constraint(greaterThanOrEqualTo: anchor.topAnchor, constant: constant.top, multiplier: multiplier, priority: priority),
            bottomAnchor.constraint(greaterThanOrEqualTo: anchor.bottomAnchor, constant: -constant.bottom, multiplier: multiplier, priority: priority),
            leadingAnchor.constraint(greaterThanOrEqualTo: anchor.leadingAnchor, constant: constant.left, multiplier: multiplier, priority: priority),
            trailingAnchor.constraint(greaterThanOrEqualTo: anchor.trailingAnchor, constant: -constant.right, multiplier: multiplier, priority: priority)
        ]
    }

    public func constraint(lessThanOrEqualTo anchor: NSLayoutEdgeAnchor, constant: EdgeInsets, multiplier: CGFloat, priority: LayoutPriority) -> [NSLayoutConstraint] {
        [
            topAnchor.constraint(lessThanOrEqualTo: anchor.topAnchor, constant: constant.top, multiplier: multiplier, priority: priority),
            bottomAnchor.constraint(lessThanOrEqualTo: anchor.bottomAnchor, constant: -constant.bottom, multiplier: multiplier, priority: priority),
            leadingAnchor.constraint(lessThanOrEqualTo: anchor.leadingAnchor, constant: constant.left, multiplier: multiplier, priority: priority),
            trailingAnchor.constraint(lessThanOrEqualTo: anchor.trailingAnchor, constant: -constant.right, multiplier: multiplier, priority: priority)
        ]
    }
}

public protocol HasEdgeAnchor: NSLayoutEdgeAnchorProtocol {
    var edgeAnchor: NSLayoutEdgeAnchor { get }
}

public extension HasEdgeAnchor {
    var edgeAnchor: NSLayoutEdgeAnchor {
        NSLayoutEdgeAnchor(self)
    }
}

extension View: HasEdgeAnchor {}
extension LayoutGuide: HasEdgeAnchor {}
