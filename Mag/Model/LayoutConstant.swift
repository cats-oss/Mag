import CoreGraphics

public struct LayoutConstant<Value: LayoutConstantProtocol> {
    public var value: Value
    public var multiplier: CGFloat

    public init(_ value: Value, multiplier: CGFloat) {
        self.value = value
        self.multiplier = multiplier
    }
}

public extension LayoutConstant {
    init(_ value: Value) {
        self.init(value, multiplier: 1)
    }

    static prefix func - (rhs: Self) -> Self {
        Self(-rhs.value, multiplier: rhs.multiplier)
    }

    static var zero: Self {
        Self(.zero)
    }
}

extension LayoutConstant: Equatable where Value: Equatable {
    public static func == (lhs: LayoutConstant<Value>, rhs: LayoutConstant<Value>) -> Bool {
        lhs.value == rhs.value && lhs.multiplier == rhs.multiplier
    }
}
