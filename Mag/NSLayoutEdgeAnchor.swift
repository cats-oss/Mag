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
    public func constraint(equalTo anchor: NSLayoutEdgeAnchor, constant: LayoutConstant<EdgeInsets>, priority: LayoutPriority) -> [NSLayoutConstraint] {
        [
            topAnchor.constraint(equalTo: anchor.topAnchor, constant: .init(constant.value.top, multiplier: constant.multiplier), priority: priority),
            bottomAnchor.constraint(equalTo: anchor.bottomAnchor, constant: -.init(constant.value.bottom, multiplier: constant.multiplier), priority: priority),
            leadingAnchor.constraint(equalTo: anchor.leadingAnchor, constant: .init(constant.value.left, multiplier: constant.multiplier), priority: priority),
            trailingAnchor.constraint(equalTo: anchor.trailingAnchor, constant: -.init(constant.value.right, multiplier: constant.multiplier), priority: priority)
        ]
    }

    public func constraint(greaterThanOrEqualTo anchor: NSLayoutEdgeAnchor, constant: LayoutConstant<EdgeInsets>, priority: LayoutPriority) -> [NSLayoutConstraint] {
        [
            topAnchor.constraint(greaterThanOrEqualTo: anchor.topAnchor, constant: .init(constant.value.top, multiplier: constant.multiplier), priority: priority),
            bottomAnchor.constraint(greaterThanOrEqualTo: anchor.bottomAnchor, constant: -.init(constant.value.bottom, multiplier: constant.multiplier), priority: priority),
            leadingAnchor.constraint(greaterThanOrEqualTo: anchor.leadingAnchor, constant: .init(constant.value.left, multiplier: constant.multiplier), priority: priority),
            trailingAnchor.constraint(greaterThanOrEqualTo: anchor.trailingAnchor, constant: -.init(constant.value.right, multiplier: constant.multiplier), priority: priority)
        ]
    }

    public func constraint(lessThanOrEqualTo anchor: NSLayoutEdgeAnchor, constant: LayoutConstant<EdgeInsets>, priority: LayoutPriority) -> [NSLayoutConstraint] {
        [
            topAnchor.constraint(lessThanOrEqualTo: anchor.topAnchor, constant: .init(constant.value.top, multiplier: constant.multiplier), priority: priority),
            bottomAnchor.constraint(lessThanOrEqualTo: anchor.bottomAnchor, constant: -.init(constant.value.bottom, multiplier: constant.multiplier), priority: priority),
            leadingAnchor.constraint(lessThanOrEqualTo: anchor.leadingAnchor, constant: .init(constant.value.left, multiplier: constant.multiplier), priority: priority),
            trailingAnchor.constraint(lessThanOrEqualTo: anchor.trailingAnchor, constant: -.init(constant.value.right, multiplier: constant.multiplier), priority: priority)
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
