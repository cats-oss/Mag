#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

final class LayoutConstraint: NSLayoutConstraint {
    deinit {
        if !hasActivated {
            safeActivate()
        }
    }

    var hasActivated = false

    override var isActive: Bool {
        get {
            super.isActive
        }
        set {
            hasActivated = hasActivated || newValue
            super.isActive = newValue
        }
    }

    func safeActivate() {
        with(multiplier: multiplier, priority: priority).isActive = true
    }
}
