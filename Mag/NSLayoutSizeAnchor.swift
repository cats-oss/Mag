#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

public protocol NSLayoutSizeAnchorProtocol {
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
}

public struct NSLayoutSizeAnchor: NSLayoutSizeAnchorProtocol {
    var base: NSLayoutSizeAnchorProtocol

    public var widthAnchor: NSLayoutDimension {
        base.widthAnchor
    }

    public var heightAnchor: NSLayoutDimension {
        base.heightAnchor
    }

    init(_ base: NSLayoutSizeAnchorProtocol) {
        self.base = base
    }
}

extension NSLayoutSizeAnchor: LayoutAnchorProtocol {
    public func constraint(equalTo anchor: NSLayoutSizeAnchor, constant: CGSize, multiplier: CGFloat, priority: LayoutPriority) -> [NSLayoutConstraint] {
        [
            widthAnchor.constraint(equalTo: anchor.widthAnchor, constant: constant.width, multiplier: multiplier, priority: priority),
            heightAnchor.constraint(equalTo: anchor.heightAnchor, constant: constant.height, multiplier: multiplier, priority: priority)
        ]
    }

    public func constraint(greaterThanOrEqualTo anchor: NSLayoutSizeAnchor, constant: CGSize, multiplier: CGFloat, priority: LayoutPriority) -> [NSLayoutConstraint] {
        [
            widthAnchor.constraint(greaterThanOrEqualTo: anchor.widthAnchor, constant: constant.width, multiplier: multiplier, priority: priority),
            heightAnchor.constraint(greaterThanOrEqualTo: anchor.heightAnchor, constant: constant.height, multiplier: multiplier, priority: priority)
        ]
    }

    public func constraint(lessThanOrEqualTo anchor: NSLayoutSizeAnchor, constant: CGSize, multiplier: CGFloat, priority: LayoutPriority) -> [NSLayoutConstraint] {
        [
            widthAnchor.constraint(lessThanOrEqualTo: anchor.widthAnchor, constant: constant.width, multiplier: multiplier, priority: priority),
            heightAnchor.constraint(lessThanOrEqualTo: anchor.heightAnchor, constant: constant.height, multiplier: multiplier, priority: priority)
        ]
    }
}

extension NSLayoutSizeAnchor: LayoutDimensionAnchorProtocol {
    public func constraint(equalToConstant constant: CGSize, multiplier: CGFloat, priority: LayoutPriority) -> [NSLayoutConstraint] {
        [
            widthAnchor.constraint(equalToConstant: constant.width, multiplier: multiplier, priority: priority),
            heightAnchor.constraint(equalToConstant: constant.height, multiplier: multiplier, priority: priority)
        ]
    }

    public func constraint(greaterThanOrEqualToConstant constant: CGSize, multiplier: CGFloat, priority: LayoutPriority) -> [NSLayoutConstraint] {
        [
            widthAnchor.constraint(greaterThanOrEqualToConstant: constant.width, multiplier: multiplier, priority: priority),
            heightAnchor.constraint(greaterThanOrEqualToConstant: constant.height, multiplier: multiplier, priority: priority)
        ]
    }

    public func constraint(lessThanOrEqualToConstant constant: CGSize, multiplier: CGFloat, priority: LayoutPriority) -> [NSLayoutConstraint] {
        [
            widthAnchor.constraint(lessThanOrEqualToConstant: constant.width, multiplier: multiplier, priority: priority),
            heightAnchor.constraint(lessThanOrEqualToConstant: constant.height, multiplier: multiplier, priority: priority)
        ]
    }
}

public protocol HasSizeAnchor: NSLayoutSizeAnchorProtocol {
    var sizeAnchor: NSLayoutSizeAnchor { get }
}

public extension HasSizeAnchor {
    var sizeAnchor: NSLayoutSizeAnchor {
        NSLayoutSizeAnchor(self)
    }
}

extension View: HasSizeAnchor {}
extension LayoutGuide: HasSizeAnchor {}
