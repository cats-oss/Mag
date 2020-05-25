#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

public extension NSLayoutConstraint {
    static func deactivate(_ constraints: [NSLayoutConstraint], beforeActivate nextConstraints: [NSLayoutConstraint]) {
        NSLayoutConstraint.deactivate(constraints)
        NSLayoutConstraint.activate(nextConstraints)
    }
}

public extension Array where Element: NSLayoutConstraint {
    mutating func replaceActivatedConstraints(_ constraints: [Element]) {
        NSLayoutConstraint.deactivate(self, beforeActivate: constraints)
        self = constraints
    }
}
