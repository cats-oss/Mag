#if os(iOS) || os(tvOS)
import UIKit

public typealias View = UIView
public typealias LayoutGuide = UILayoutGuide
#else
import AppKit

public typealias View = NSView
public typealias LayoutGuide = NSLayoutGuide
#endif
