import Foundation
#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

public protocol NSLayoutVerticalAnchorProtocol {
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
}

public struct NSLayoutVerticalAnchor: NSLayoutVerticalAnchorProtocol {
    var base: NSLayoutVerticalAnchorProtocol

    public var topAnchor: NSLayoutYAxisAnchor {
        base.topAnchor
    }

    public var bottomAnchor: NSLayoutYAxisAnchor {
        base.bottomAnchor
    }

    init(_ base: NSLayoutVerticalAnchorProtocol) {
        self.base = base
    }
}

extension NSLayoutVerticalAnchor: LayoutAnchorProtocol {
    public func constraint(equalTo anchor: NSLayoutVerticalAnchor, constant: EdgeInsets, multiplier: CGFloat, priority: LayoutPriority) -> [NSLayoutConstraint] {
        [
            topAnchor.constraint(equalTo: anchor.topAnchor, constant: constant.top, multiplier: multiplier, priority: priority),
            bottomAnchor.constraint(equalTo: anchor.bottomAnchor, constant: -constant.bottom, multiplier: multiplier, priority: priority)
        ]
    }

    public func constraint(greaterThanOrEqualTo anchor: NSLayoutVerticalAnchor, constant: EdgeInsets, multiplier: CGFloat, priority: LayoutPriority) -> [NSLayoutConstraint] {
        [
            topAnchor.constraint(greaterThanOrEqualTo: anchor.topAnchor, constant: constant.top, multiplier: multiplier, priority: priority),
            bottomAnchor.constraint(greaterThanOrEqualTo: anchor.bottomAnchor, constant: -constant.bottom, multiplier: multiplier, priority: priority)
        ]
    }

    public func constraint(lessThanOrEqualTo anchor: NSLayoutVerticalAnchor, constant: EdgeInsets, multiplier: CGFloat, priority: LayoutPriority) -> [NSLayoutConstraint] {
        [
            topAnchor.constraint(lessThanOrEqualTo: anchor.topAnchor, constant: constant.top, multiplier: multiplier, priority: priority),
            bottomAnchor.constraint(lessThanOrEqualTo: anchor.bottomAnchor, constant: -constant.bottom, multiplier: multiplier, priority: priority)
        ]
    }
}

public protocol HasVerticalAnchor: NSLayoutVerticalAnchorProtocol {
    var verticalAnchor: NSLayoutVerticalAnchor { get }
}

public extension HasVerticalAnchor {
    var verticalAnchor: NSLayoutVerticalAnchor {
        NSLayoutVerticalAnchor(self)
    }
}

extension View: HasVerticalAnchor {}
extension LayoutGuide: HasVerticalAnchor {}
