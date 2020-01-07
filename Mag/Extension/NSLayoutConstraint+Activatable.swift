#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

public protocol Activatable {
    func activated() -> Self
}

extension NSLayoutConstraint: Activatable {
    public func activated() -> Self {
        (firstItem as? View)?.translatesAutoresizingMaskIntoConstraints = false
        isActive = true
        return self
    }
}

extension Array: Activatable where Element: Activatable {
    public func activated() -> Self {
        map { $0.activated() }
    }
}
