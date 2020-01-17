@testable import Mag
import XCTest

private final class NSLayoutXAxisAnchor_OperatorTests: XCTestCase {
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

    func testXAxisAnchorOperator() {
        XCTContext.runActivity(named: "Operator + (NSLayoutXAxisAnchor, CGFloat)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.leftAnchor + 100
                expect(target.constant) == 100
                expect(target.multiplier) == 1
                expect(target.priority) == .required
                expect(target.anchor) == view.leftAnchor
            }
        }

        XCTContext.runActivity(named: "Operator + (NSLayoutXAxisAnchor, LayoutPriorityValue)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.leftAnchor + LayoutPriorityValue(200, priority: .defaultHigh)
                expect(target.constant) == 200
                expect(target.multiplier) == 1
                expect(target.priority) == .defaultHigh
                expect(target.anchor) == view.leftAnchor
            }
        }

        XCTContext.runActivity(named: "Operator - (NSLayoutXAxisAnchor, CGFloat)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.leftAnchor - 100
                expect(target.constant) == -100
                expect(target.multiplier) == 1
                expect(target.priority) == .required
                expect(target.anchor) == view.leftAnchor
            }
        }

        XCTContext.runActivity(named: "Operator - (NSLayoutXAxisAnchor, LayoutPriorityValue)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.leftAnchor - LayoutPriorityValue(200, priority: .defaultHigh)
                expect(target.constant) == -200
                expect(target.multiplier) == 1
                expect(target.priority) == .defaultHigh
                expect(target.anchor) == view.leftAnchor
            }
        }

        XCTContext.runActivity(named: "Operator * (NSLayoutXAxisAnchor, CGFloat)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.heightAnchor * 0.1
                expect(target.constant) == 0
                expect(target.multiplier) == 0.1
                expect(target.priority) == .required
                expect(target.anchor) == view.heightAnchor
            }
        }

        XCTContext.runActivity(named: "Operator * (NSLayoutXAxisAnchor, LayoutPriorityValue)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.heightAnchor * LayoutPriorityValue(0.2, priority: .defaultHigh)
                expect(target.constant) == 0
                expect(target.multiplier) == 0.2
                expect(target.priority) == .defaultHigh
                expect(target.anchor) == view.heightAnchor
            }
        }

        XCTContext.runActivity(named: "Operator ~ (NSLayoutXAxisAnchor, UILayoutPriority)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.leftAnchor ~ .defaultHigh
                expect(target.constant) == 0
                expect(target.multiplier) == 1
                expect(target.priority) == .defaultHigh
                expect(target.anchor) == view.leftAnchor
            }
        }

        XCTContext.runActivity(named: "Operator ~ (NSLayoutXAxisAnchor, CGFloat)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.leftAnchor ~ 250
                expect(target.constant) == 0
                expect(target.multiplier) == 1
                expect(target.priority) == .init(250)
                expect(target.anchor) == view.leftAnchor
            }
        }

        XCTContext.runActivity(named: "Operator == (NSLayoutXAxisAnchor, NSLayoutXAxisAnchor)") { _ in
            XCTContext.runActivity(named: "returns NSLayoutConstraint") { _ in
                let constraint = view.leftAnchor == second.leftAnchor
                expect(constraint.secondAnchor) == second.leftAnchor
                expect(constraint.constant) == 0
                expect(constraint.multiplier) == 1
                expect(constraint.priority) == .required
                expect(constraint.isActive) == true
                expect(constraint.relation) == .equal
            }
        }

        XCTContext.runActivity(named: "Operator == (NSLayoutXAxisAnchor, LayoutAnchorTarget)") { _ in
            XCTContext.runActivity(named: "returns NSLayoutConstraint") { _ in
                let target = LayoutAnchorTarget(second.leftAnchor, constant: 300, multiplier: 0.3, priority: .defaultHigh)
                let constraint = view.leftAnchor == target
                expect(constraint.secondAnchor) == second.leftAnchor
                expect(constraint.constant) == 300
                expect(floor(constraint.multiplier * 100)) == 30
                expect(constraint.priority) == .defaultHigh
                expect(constraint.isActive) == true
                expect(constraint.relation) == .equal
            }
        }

        XCTContext.runActivity(named: "Operator >= (NSLayoutXAxisAnchor, NSLayoutXAxisAnchor)") { _ in
            XCTContext.runActivity(named: "returns NSLayoutConstraint") { _ in
                let constraint = view.leftAnchor >= second.leftAnchor
                expect(constraint.secondAnchor) == second.leftAnchor
                expect(constraint.constant) == 0
                expect(constraint.multiplier) == 1
                expect(constraint.priority) == .required
                expect(constraint.isActive) == true
                expect(constraint.relation) == .greaterThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator >= (NSLayoutXAxisAnchor, LayoutAnchorTarget)") { _ in
            XCTContext.runActivity(named: "returns NSLayoutConstraint") { _ in
                let target = LayoutAnchorTarget(second.leftAnchor, constant: 300, multiplier: 1, priority: .defaultHigh)
                let constraint = view.leftAnchor >= target
                expect(constraint.secondAnchor) == second.leftAnchor
                expect(constraint.constant) == 300
                expect(constraint.multiplier) == 1
                expect(constraint.priority) == .defaultHigh
                expect(constraint.isActive) == true
                expect(constraint.relation) == .greaterThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator <= (NSLayoutXAxisAnchor, NSLayoutXAxisAnchor)") { _ in
            XCTContext.runActivity(named: "returns NSLayoutConstraint") { _ in
                let constraint = view.leftAnchor <= second.leftAnchor
                expect(constraint.secondAnchor) == second.leftAnchor
                expect(constraint.constant) == 0
                expect(constraint.multiplier) == 1
                expect(constraint.priority) == .required
                expect(constraint.isActive) == true
                expect(constraint.relation) == .lessThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator <= (NSLayoutXAxisAnchor, LayoutAnchorTarget)") { _ in
            XCTContext.runActivity(named: "returns NSLayoutConstraint") { _ in
                let target = LayoutAnchorTarget(second.leftAnchor, constant: 300, multiplier: 1, priority: .defaultHigh)
                let constraint = view.leftAnchor <= target
                expect(constraint.secondAnchor) == second.leftAnchor
                expect(constraint.constant) == 300
                expect(constraint.multiplier) == 1
                expect(constraint.priority) == .defaultHigh
                expect(constraint.isActive) == true
                expect(constraint.relation) == .lessThanOrEqual
            }
        }
    }
}
