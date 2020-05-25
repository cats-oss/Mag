@testable import Mag
import XCTest

private final class NSLayoutDimension_OperatorTests: XCTestCase {
    let superView = View()
    var view: View!
    var second: View!

    override func setUp() {
        super.setUp()
        view = View()
        superView.addSubview(view)
        second = View()
        superView.addSubview(second)
    }

    override func tearDown() {
        super.tearDown()
        second.removeFromSuperview()
        view.removeFromSuperview()
    }

    func testDimensionOperator() {
        XCTContext.runActivity(named: "Operator + (NSLayoutDimension, CGFloat)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.heightAnchor + 100
                expect(target.constant) == 100
                expect(target.multiplier) == 1
                expect(target.priority) == .required
                expect(target.anchor) == view.heightAnchor
            }
        }

        XCTContext.runActivity(named: "Operator + (NSLayoutDimension, LayoutPriorityValue)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.heightAnchor + (200 ~ .defaultHigh)
                expect(target.constant) == 200
                expect(target.multiplier) == 1
                expect(target.priority) == .defaultHigh
                expect(target.anchor) == view.heightAnchor
            }
        }

        XCTContext.runActivity(named: "Operator - (NSLayoutDimension, CGFloat)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.heightAnchor - 100
                expect(target.constant) == -100
                expect(target.multiplier) == 1
                expect(target.priority) == .required
                expect(target.anchor) == view.heightAnchor
            }
        }

        XCTContext.runActivity(named: "Operator - (NSLayoutDimension, LayoutPriorityValue)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.heightAnchor - (200 ~ .defaultHigh)
                expect(target.constant) == -200
                expect(target.multiplier) == 1
                expect(target.priority) == .defaultHigh
                expect(target.anchor) == view.heightAnchor
            }
        }

        XCTContext.runActivity(named: "Operator * (NSLayoutDimension, CGFloat)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.heightAnchor * 0.1
                expect(target.constant) == 0
                expect(target.multiplier) == 0.1
                expect(target.priority) == .required
                expect(target.anchor) == view.heightAnchor
            }
        }

        XCTContext.runActivity(named: "Operator * (NSLayoutDimension, LayoutPriorityValue)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.heightAnchor * (0.2 ~ .defaultHigh)
                expect(target.constant) == 0
                expect(target.multiplier) == 0.2
                expect(target.priority) == .defaultHigh
                expect(target.anchor) == view.heightAnchor
            }
        }

        XCTContext.runActivity(named: "Operator ~ (NSLayoutDimension, UILayoutPriority)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.heightAnchor ~ .defaultHigh
                expect(target.constant) == 0
                expect(target.multiplier) == 1
                expect(target.priority) == .defaultHigh
                expect(target.anchor) == view.heightAnchor
            }
        }

        XCTContext.runActivity(named: "Operator ~ (NSLayoutDimension, CGFloat)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.heightAnchor ~ 250
                expect(target.constant) == 0
                expect(target.multiplier) == 1
                expect(target.priority) == .init(250)
                expect(target.anchor) == view.heightAnchor
            }
        }

        XCTContext.runActivity(named: "Operator == (NSLayoutDimension, NSLayoutDimension)") { _ in
            XCTContext.runActivity(named: "returns NSLayoutConstraint") { _ in
                let constraint = view.heightAnchor == second.heightAnchor
                expect(constraint.firstItem as? UIView) == view
                expect(constraint.secondItem as? UIView) == second
                expect(constraint.secondAnchor) == second.heightAnchor
                expect(constraint.constant) == 0
                expect(constraint.multiplier) == 1
                expect(constraint.priority) == .required
                expect(constraint.isActive) == false
                expect(constraint.relation) == .equal
            }
        }

        XCTContext.runActivity(named: "Operator == (NSLayoutDimension, LayoutAnchorTarget)") { _ in
            XCTContext.runActivity(named: "returns NSLayoutConstraint") { _ in
                let target = LayoutAnchorTarget(second.heightAnchor, constant: 300, multiplier: 0.3, priority: .defaultHigh)
                let constraint = view.heightAnchor == target
                expect(constraint.firstItem as? UIView) == view
                expect(constraint.secondItem as? UIView) == second
                expect(constraint.secondAnchor) == second.heightAnchor
                expect(constraint.constant) == 300
                expect(floor(constraint.multiplier * 100)) == 30
                expect(constraint.priority) == .defaultHigh
                expect(constraint.isActive) == false
                expect(constraint.relation) == .equal
            }
        }

        XCTContext.runActivity(named: "Operator == (NSLayoutDimension, LayoutPriorityValue)") { _ in
            XCTContext.runActivity(named: "returns NSLayoutConstraint") { _ in
                let constraint = view.heightAnchor == (200 ~ .defaultHigh)
                expect(constraint.firstItem as? UIView) == view
                expect(constraint.secondItem as? UIView) == nil
                expect(constraint.secondAnchor) == nil
                expect(constraint.constant) == 200
                expect(constraint.multiplier) == 1
                expect(constraint.priority) == .defaultHigh
                expect(constraint.isActive) == false
                expect(constraint.relation) == .equal
            }
        }

        XCTContext.runActivity(named: "Operator == (NSLayoutDimension, CGFloat)") { _ in
            XCTContext.runActivity(named: "returns NSLayoutConstraint") { _ in
                let constraint = view.heightAnchor == 200
                expect(constraint.firstItem as? UIView) == view
                expect(constraint.secondItem as? UIView) == nil
                expect(constraint.secondAnchor) == nil
                expect(constraint.constant) == 200
                expect(constraint.multiplier) == 1
                expect(constraint.priority) == .required
                expect(constraint.isActive) == false
                expect(constraint.relation) == .equal
            }
        }

        XCTContext.runActivity(named: "Operator >= (NSLayoutDimension, NSLayoutDimension)") { _ in
            XCTContext.runActivity(named: "returns NSLayoutConstraint") { _ in
                let constraint = view.heightAnchor >= second.heightAnchor
                expect(constraint.firstItem as? UIView) == view
                expect(constraint.secondItem as? UIView) == second
                expect(constraint.secondAnchor) == second.heightAnchor
                expect(constraint.constant) == 0
                expect(constraint.multiplier) == 1
                expect(constraint.priority) == .required
                expect(constraint.isActive) == false
                expect(constraint.relation) == .greaterThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator >= (NSLayoutDimension, LayoutAnchorTarget)") { _ in
            XCTContext.runActivity(named: "returns NSLayoutConstraint") { _ in
                let target = LayoutAnchorTarget(second.heightAnchor, constant: 300, multiplier: 0.3, priority: .defaultHigh)
                let constraint = view.heightAnchor >= target
                expect(constraint.firstItem as? UIView) == view
                expect(constraint.secondItem as? UIView) == second
                expect(constraint.secondAnchor) == second.heightAnchor
                expect(constraint.constant) == 300
                expect(floor(constraint.multiplier * 100)) == 30
                expect(constraint.priority) == .defaultHigh
                expect(constraint.isActive) == false
                expect(constraint.relation) == .greaterThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator >= (NSLayoutDimension, LayoutPriorityValue)") { _ in
            XCTContext.runActivity(named: "returns NSLayoutConstraint") { _ in
                let constraint = view.heightAnchor >= (200 ~ .defaultHigh)
                expect(constraint.firstItem as? UIView) == view
                expect(constraint.secondItem as? UIView) == nil
                expect(constraint.secondAnchor) == nil
                expect(constraint.constant) == 200
                expect(constraint.multiplier) == 1
                expect(constraint.priority) == .defaultHigh
                expect(constraint.isActive) == false
                expect(constraint.relation) == .greaterThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator >= (NSLayoutDimension, CGFloat)") { _ in
            XCTContext.runActivity(named: "returns NSLayoutConstraint") { _ in
                let constraint = view.heightAnchor >= 200
                expect(constraint.firstItem as? UIView) == view
                expect(constraint.secondItem as? UIView) == nil
                expect(constraint.secondAnchor) == nil
                expect(constraint.constant) == 200
                expect(constraint.multiplier) == 1
                expect(constraint.priority) == .required
                expect(constraint.isActive) == false
                expect(constraint.relation) == .greaterThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator <= (NSLayoutDimension, NSLayoutDimension)") { _ in
            XCTContext.runActivity(named: "returns NSLayoutConstraint") { _ in
                let constraint = view.heightAnchor <= second.heightAnchor
                expect(constraint.firstItem as? UIView) == view
                expect(constraint.secondItem as? UIView) == second
                expect(constraint.secondAnchor) == second.heightAnchor
                expect(constraint.constant) == 0
                expect(constraint.multiplier) == 1
                expect(constraint.priority) == .required
                expect(constraint.isActive) == false
                expect(constraint.relation) == .lessThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator <= (NSLayoutDimension, LayoutAnchorTarget)") { _ in
            XCTContext.runActivity(named: "returns NSLayoutConstraint") { _ in
                let target = LayoutAnchorTarget(second.heightAnchor, constant: 300, multiplier: 0.3, priority: .defaultHigh)
                let constraint = view.heightAnchor <= target
                expect(constraint.firstItem as? UIView) == view
                expect(constraint.secondItem as? UIView) == second
                expect(constraint.secondAnchor) == second.heightAnchor
                expect(constraint.constant) == 300
                expect(floor(constraint.multiplier * 100)) == 30
                expect(constraint.priority) == .defaultHigh
                expect(constraint.isActive) == false
                expect(constraint.relation) == .lessThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator <= (NSLayoutDimension, LayoutPriorityValue)") { _ in
            XCTContext.runActivity(named: "returns NSLayoutConstraint") { _ in
                let constraint = view.heightAnchor <= (200 ~ .defaultHigh)
                expect(constraint.firstItem as? UIView) == view
                expect(constraint.secondItem as? UIView) == nil
                expect(constraint.secondAnchor) == nil
                expect(constraint.constant) == 200
                expect(constraint.multiplier) == 1
                expect(constraint.priority) == .defaultHigh
                expect(constraint.isActive) == false
                expect(constraint.relation) == .lessThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator <= (NSLayoutDimension, CGFloat)") { _ in
            XCTContext.runActivity(named: "returns NSLayoutConstraint") { _ in
                let constraint = view.heightAnchor <= 200
                expect(constraint.firstItem as? UIView) == view
                expect(constraint.secondItem as? UIView) == nil
                expect(constraint.secondAnchor) == nil
                expect(constraint.constant) == 200
                expect(constraint.multiplier) == 1
                expect(constraint.priority) == .required
                expect(constraint.isActive) == false
                expect(constraint.relation) == .lessThanOrEqual
            }
        }
    }
}
