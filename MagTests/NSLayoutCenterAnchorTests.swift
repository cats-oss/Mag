@testable import Mag
import XCTest

private final class NSLayoutCneterAnchorTests: XCTestCase {
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

    func testCenterAnchor() {
        XCTContext.runActivity(named: "Operator + (NSLayoutCenterAnchor, CGPoint)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.centerAnchor + CGPoint(x: 100, y: 100)
                expect(target.anchor.centerXAnchor) == view.centerXAnchor
                expect(target.anchor.centerYAnchor) == view.centerYAnchor
                expect(target.constant) == CGPoint(x: 100, y: 100)
                expect(target.multiplier) == 1
                expect(target.priority) == .required
            }
        }

        XCTContext.runActivity(named: "Operator + (NSLayoutCenterAnchor, LayoutPriorityValue)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.centerAnchor + (CGPoint(x: 100, y: 100) ~ .defaultHigh)
                expect(target.anchor.centerXAnchor) == view.centerXAnchor
                expect(target.anchor.centerYAnchor) == view.centerYAnchor
                expect(target.constant) == CGPoint(x: 100, y: 100)
                expect(target.multiplier) == 1
                expect(target.priority) == .defaultHigh
            }
        }

        XCTContext.runActivity(named: "Operator - (NSLayoutCenterAnchor, CGPoint)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.centerAnchor - CGPoint(x: 100, y: 100)
                expect(target.anchor.centerXAnchor) == view.centerXAnchor
                expect(target.anchor.centerYAnchor) == view.centerYAnchor
                expect(target.constant) == CGPoint(x: -100, y: -100)
                expect(target.multiplier) == 1
            }
        }

        XCTContext.runActivity(named: "Operator - (NSLayoutCenterAnchor, LayoutPriorityValue)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.centerAnchor - (CGPoint(x: 100, y: 100) ~ .defaultHigh)
                expect(target.anchor.centerXAnchor) == view.centerXAnchor
                expect(target.anchor.centerYAnchor) == view.centerYAnchor
                expect(target.constant) == CGPoint(x: -100, y: -100)
                expect(target.multiplier) == 1
                expect(target.priority) == .defaultHigh
            }
        }

        XCTContext.runActivity(named: "Operator * (NSLayoutCenterAnchor, CGSize)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.centerAnchor * 0.1
                expect(target.anchor.centerXAnchor) == view.centerXAnchor
                expect(target.anchor.centerYAnchor) == view.centerYAnchor
                expect(target.constant) == .zero
                expect(target.multiplier) == 0.1
                expect(target.priority) == .required
            }
        }

        XCTContext.runActivity(named: "Operator * (NSLayoutCenterAnchor, LayoutPriorityValue)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.centerAnchor * (0.2 ~ .defaultHigh)
                expect(target.anchor.centerXAnchor) == view.centerXAnchor
                expect(target.anchor.centerYAnchor) == view.centerYAnchor
                expect(target.constant) == .zero
                expect(target.multiplier) == 0.2
                expect(target.priority) == .defaultHigh
            }
        }

        XCTContext.runActivity(named: "Operator ~ (NSLayoutCenterAnchor, UILayoutPriority)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.centerAnchor ~ .defaultHigh
                expect(target.anchor.centerXAnchor) == view.centerXAnchor
                expect(target.anchor.centerYAnchor) == view.centerYAnchor
                expect(target.constant) == .zero
                expect(target.priority) == .defaultHigh
            }
        }

        XCTContext.runActivity(named: "Operator ~ (NSLayoutCenterAnchor, CGFloat)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.centerAnchor ~ 250
                expect(target.anchor.centerXAnchor) == view.centerXAnchor
                expect(target.anchor.centerYAnchor) == view.centerYAnchor
                expect(target.constant) == .zero
                expect(target.priority) == .init(250)
            }
        }

        XCTContext.runActivity(named: "Operator == (NSLayoutCenterAnchor, LayoutAnchorTarget)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let target = LayoutAnchorTarget(second.centerAnchor, constant: CGPoint(x: 100, y: 100), multiplier: 0.3, priority: .defaultHigh)
                let constraints = view.centerAnchor == target
                let constraintX = constraints[0]
                expect(constraintX.firstAnchor) == view.centerXAnchor
                expect(constraintX.secondAnchor) == second.centerXAnchor
                expect(constraintX.constant) == 100
                expect(floor(constraintX.multiplier * 100)) == 30
                expect(constraintX.priority) == .defaultHigh
                expect(constraintX.isActive) == false
                expect(constraintX.relation) == .equal
                let constraintY = constraints[1]
                expect(constraintY.firstAnchor) == view.centerYAnchor
                expect(constraintY.secondAnchor) == second.centerYAnchor
                expect(constraintY.constant) == 100
                expect(floor(constraintY.multiplier * 100)) == 30
                expect(constraintY.priority) == .defaultHigh
                expect(constraintY.isActive) == false
                expect(constraintY.relation) == .equal
            }
        }

        XCTContext.runActivity(named: "Operator == (NSLayoutCenterAnchor, NSLayoutCenterAnchor)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let constraints = view.centerAnchor == second.centerAnchor
                let constraintX = constraints[0]
                expect(constraintX.firstAnchor) == view.centerXAnchor
                expect(constraintX.secondAnchor) == second.centerXAnchor
                expect(constraintX.constant) == 0
                let constraintY = constraints[1]
                expect(constraintY.firstAnchor) == view.centerYAnchor
                expect(constraintY.secondAnchor) == second.centerYAnchor
                expect(constraintY.constant) == 0
            }
        }

        XCTContext.runActivity(named: "Operator >= (NSLayoutCenterAnchor, LayoutAnchorTarget)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let target = LayoutAnchorTarget(second.centerAnchor, constant: CGPoint(x: 100, y: 100), multiplier: 1, priority: .defaultHigh)
                let constraints = view.centerAnchor >= target
                let constraintX = constraints[0]
                expect(constraintX.firstAnchor) == view.centerXAnchor
                expect(constraintX.secondAnchor) == second.centerXAnchor
                expect(constraintX.constant) == 100
                expect(constraintX.multiplier) == 1
                expect(constraintX.priority) == .defaultHigh
                expect(constraintX.isActive) == false
                expect(constraintX.relation) == .greaterThanOrEqual
                let constraintY = constraints[1]
                expect(constraintY.firstAnchor) == view.centerYAnchor
                expect(constraintY.secondAnchor) == second.centerYAnchor
                expect(constraintY.constant) == 100
                expect(constraintY.multiplier) == 1
                expect(constraintY.priority) == .defaultHigh
                expect(constraintY.isActive) == false
                expect(constraintY.relation) == .greaterThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator >= (NSLayoutCenterAnchor, NSLayoutEdgeAnchor)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let constraints = view.centerAnchor >= second.centerAnchor
                let constraintX = constraints[0]
                expect(constraintX.firstAnchor) == view.centerXAnchor
                expect(constraintX.secondAnchor) == second.centerXAnchor
                expect(constraintX.constant) == 0
                expect(constraintX.multiplier) == 1
                expect(constraintX.priority) == .required
                expect(constraintX.isActive) == false
                expect(constraintX.relation) == .greaterThanOrEqual
                let constraintY = constraints[1]
                expect(constraintY.firstAnchor) == view.centerYAnchor
                expect(constraintY.secondAnchor) == second.centerYAnchor
                expect(constraintY.constant) == 0
                expect(constraintY.multiplier) == 1
                expect(constraintY.priority) == .required
                expect(constraintY.isActive) == false
                expect(constraintY.relation) == .greaterThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator <= (NSLayoutCenterAnchor, LayoutAnchorTarget)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let target = LayoutAnchorTarget(second.centerAnchor, constant: CGPoint(x: 100, y: 100), multiplier: 1, priority: .defaultHigh)
                let constraints = view.centerAnchor <= target
                let constraintX = constraints[0]
                expect(constraintX.firstAnchor) == view.centerXAnchor
                expect(constraintX.secondAnchor) == second.centerXAnchor
                expect(constraintX.constant) == 100
                expect(constraintX.multiplier) == 1
                expect(constraintX.priority) == .defaultHigh
                expect(constraintX.isActive) == false
                expect(constraintX.relation) == .lessThanOrEqual
                let constraintY = constraints[1]
                expect(constraintY.firstAnchor) == view.centerYAnchor
                expect(constraintY.secondAnchor) == second.centerYAnchor
                expect(constraintY.constant) == 100
                expect(constraintY.multiplier) == 1
                expect(constraintY.priority) == .defaultHigh
                expect(constraintY.isActive) == false
                expect(constraintY.relation) == .lessThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator <= (NSLayoutCenterAnchor, NSLayoutEdgeAnchor)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let constraints = view.centerAnchor <= second.centerAnchor
                let constraintX = constraints[0]
                expect(constraintX.firstAnchor) == view.centerXAnchor
                expect(constraintX.secondAnchor) == second.centerXAnchor
                expect(constraintX.constant) == 0
                expect(constraintX.multiplier) == 1
                expect(constraintX.priority) == .required
                expect(constraintX.isActive) == false
                expect(constraintX.relation) == .lessThanOrEqual
                let constraintY = constraints[1]
                expect(constraintY.firstAnchor) == view.centerYAnchor
                expect(constraintY.secondAnchor) == second.centerYAnchor
                expect(constraintY.constant) == 0
                expect(constraintY.multiplier) == 1
                expect(constraintY.priority) == .required
                expect(constraintY.isActive) == false
                expect(constraintY.relation) == .lessThanOrEqual
            }
        }
    }
}
