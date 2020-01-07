#if os(iOS) || os(tvOS)
import UIKit

public typealias EdgeInsets = UIEdgeInsets
#else
import AppKit

public typealias EdgeInsets = NSEdgeInsets

extension NSEdgeInsets: Equatable {
    public static func == (lhs: NSEdgeInsets, rhs: NSEdgeInsets) -> Bool {
        lhs.top == rhs.top
            && lhs.bottom == rhs.bottom
            && lhs.right == rhs.right
            && lhs.left == rhs.left
    }

    public static var zero: NSEdgeInsets {
        NSEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
#endif
