#if os(iOS) || os(tvOS)
import UIKit

public typealias LayoutPriority = UILayoutPriority
#else
import AppKit

public typealias LayoutPriority = NSLayoutConstraint.Priority
#endif
