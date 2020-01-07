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
    public func constraint(equalTo anchor: NSLayoutSizeAnchor, constant: LayoutConstant<CGSize>, priority: LayoutPriority) -> [NSLayoutConstraint] {
        [
            widthAnchor.constraint(equalTo: anchor.widthAnchor, constant: .init(constant.value.width, multiplier: constant.multiplier), priority: priority),
            heightAnchor.constraint(equalTo: anchor.heightAnchor, constant: .init(constant.value.height, multiplier: constant.multiplier), priority: priority)
        ]
    }

    public func constraint(greaterThanOrEqualTo anchor: NSLayoutSizeAnchor, constant: LayoutConstant<CGSize>, priority: LayoutPriority) -> [NSLayoutConstraint] {
        [
            widthAnchor.constraint(greaterThanOrEqualTo: anchor.widthAnchor, constant: .init(constant.value.width, multiplier: constant.multiplier), priority: priority),
            heightAnchor.constraint(greaterThanOrEqualTo: anchor.heightAnchor, constant: .init(constant.value.height, multiplier: constant.multiplier), priority: priority)
        ]
    }

    public func constraint(lessThanOrEqualTo anchor: NSLayoutSizeAnchor, constant: LayoutConstant<CGSize>, priority: LayoutPriority) -> [NSLayoutConstraint] {
        [
            widthAnchor.constraint(lessThanOrEqualTo: anchor.widthAnchor, constant: .init(constant.value.width, multiplier: constant.multiplier), priority: priority),
            heightAnchor.constraint(lessThanOrEqualTo: anchor.heightAnchor, constant: .init(constant.value.height, multiplier: constant.multiplier), priority: priority)
        ]
    }
}

extension NSLayoutSizeAnchor: LayoutDimensionAnchorProtocol {
    public func constraint(equalToConstant constant: LayoutConstant<CGSize>, priority: LayoutPriority) -> [NSLayoutConstraint] {
        [
            widthAnchor.constraint(equalToConstant: .init(constant.value.width, multiplier: constant.multiplier), priority: priority),
            heightAnchor.constraint(equalToConstant: .init(constant.value.height, multiplier: constant.multiplier), priority: priority)
        ]
    }

    public func constraint(greaterThanOrEqualToConstant constant: LayoutConstant<CGSize>, priority: LayoutPriority) -> [NSLayoutConstraint] {
        [
            widthAnchor.constraint(greaterThanOrEqualToConstant: .init(constant.value.width, multiplier: constant.multiplier), priority: priority),
            heightAnchor.constraint(greaterThanOrEqualToConstant: .init(constant.value.height, multiplier: constant.multiplier), priority: priority)
        ]
    }

    public func constraint(lessThanOrEqualToConstant constant: LayoutConstant<CGSize>, priority: LayoutPriority) -> [NSLayoutConstraint] {
        [
            widthAnchor.constraint(lessThanOrEqualToConstant: .init(constant.value.width, multiplier: constant.multiplier), priority: priority),
            heightAnchor.constraint(lessThanOrEqualToConstant: .init(constant.value.height, multiplier: constant.multiplier), priority: priority)
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
