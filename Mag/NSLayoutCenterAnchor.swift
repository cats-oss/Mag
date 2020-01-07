#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

public protocol NSLayoutCenterAnchorProtocol {
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
}

public struct NSLayoutCenterAnchor: NSLayoutCenterAnchorProtocol {
    var base: NSLayoutCenterAnchorProtocol

    public var centerXAnchor: NSLayoutXAxisAnchor {
        base.centerXAnchor
    }

    public var centerYAnchor: NSLayoutYAxisAnchor {
        base.centerYAnchor
    }

    init(_ base: NSLayoutCenterAnchorProtocol) {
        self.base = base
    }
}

extension NSLayoutCenterAnchor: LayoutAnchorProtocol {
    public func constraint(equalTo anchor: NSLayoutCenterAnchor, constant: LayoutConstant<CGPoint>, priority: LayoutPriority) -> [NSLayoutConstraint] {
        [
            centerXAnchor.constraint(equalTo: anchor.centerXAnchor, constant: .init(constant.value.x, multiplier: constant.multiplier), priority: priority),
            centerYAnchor.constraint(equalTo: anchor.centerYAnchor, constant: .init(constant.value.y, multiplier: constant.multiplier), priority: priority)
        ]
    }

    public func constraint(greaterThanOrEqualTo anchor: NSLayoutCenterAnchor, constant: LayoutConstant<CGPoint>, priority: LayoutPriority) -> [NSLayoutConstraint] {
        [
            centerXAnchor.constraint(greaterThanOrEqualTo: anchor.centerXAnchor, constant: .init(constant.value.x, multiplier: constant.multiplier), priority: priority),
            centerYAnchor.constraint(greaterThanOrEqualTo: anchor.centerYAnchor, constant: .init(constant.value.y, multiplier: constant.multiplier), priority: priority)
        ]
    }

    public func constraint(lessThanOrEqualTo anchor: NSLayoutCenterAnchor, constant: LayoutConstant<CGPoint>, priority: LayoutPriority) -> [NSLayoutConstraint] {
        [
            centerXAnchor.constraint(lessThanOrEqualTo: anchor.centerXAnchor, constant: .init(constant.value.x, multiplier: constant.multiplier), priority: priority),
            centerYAnchor.constraint(lessThanOrEqualTo: anchor.centerYAnchor, constant: .init(constant.value.y, multiplier: constant.multiplier), priority: priority)
        ]
    }
}

public protocol HasCenterAnchor: NSLayoutCenterAnchorProtocol {
    var centerAnchor: NSLayoutCenterAnchor { get }
}

public extension HasCenterAnchor {
    var centerAnchor: NSLayoutCenterAnchor {
        NSLayoutCenterAnchor(self)
    }
}

extension View: HasCenterAnchor {}
extension LayoutGuide: HasCenterAnchor {}
