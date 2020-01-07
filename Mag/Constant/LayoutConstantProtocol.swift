import CoreGraphics

public protocol LayoutConstantProtocol {
    static prefix func - (rhs: Self) -> Self
    static var zero: Self { get }
}

extension EdgeInsets: LayoutConstantProtocol {
    public static prefix func - (rhs: EdgeInsets) -> EdgeInsets {
        EdgeInsets(top: -rhs.top, left: -rhs.left, bottom: -rhs.bottom, right: -rhs.right)
    }
}

extension CGSize: LayoutConstantProtocol {
    public static prefix func - (rhs: CGSize) -> CGSize {
        CGSize(width: -rhs.width, height: -rhs.height)
    }
}

extension CGPoint: LayoutConstantProtocol {
    public static prefix func - (rhs: CGPoint) -> CGPoint {
        CGPoint(x: -rhs.x, y: -rhs.y)
    }
}

extension CGFloat: LayoutConstantProtocol {}
