@testable import Mag
import XCTest

private final class NSLayoutVerticalAnchorTests: XCTestCase {
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

    func testEdgeAnchor() {
        XCTContext.runActivity(named: "Operator + (NSLayoutVerticalAnchor, EdgeInsets)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.verticalAnchor + EdgeInsets(top: 100, left: 100, bottom: 100, right: 100)
                expect(target.anchor.topAnchor) == view.topAnchor
                expect(target.anchor.bottomAnchor) == view.bottomAnchor
                expect(target.constant) == EdgeInsets(top: 100, left: 100, bottom: 100, right: 100)
                expect(target.multiplier) == 1
                expect(target.priority) == .required
            }
        }

        XCTContext.runActivity(named: "Operator + (NSLayoutVerticalAnchor, LayoutPriorityValue)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.verticalAnchor + (EdgeInsets(top: 100, left: 100, bottom: 100, right: 100) ~ .defaultHigh)
                expect(target.anchor.topAnchor) == view.topAnchor
                expect(target.anchor.bottomAnchor) == view.bottomAnchor
                expect(target.constant) == EdgeInsets(top: 100, left: 100, bottom: 100, right: 100)
                expect(target.multiplier) == 1
                expect(target.priority) == .defaultHigh
            }
        }

        XCTContext.runActivity(named: "Operator - (NSLayoutVerticalAnchor, EdgeInsets)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.verticalAnchor - EdgeInsets(top: 100, left: 100, bottom: 100, right: 100)
                expect(target.anchor.topAnchor) == view.topAnchor
                expect(target.anchor.bottomAnchor) == view.bottomAnchor
                expect(target.constant) == EdgeInsets(top: -100, left: -100, bottom: -100, right: -100)
                expect(target.multiplier) == 1
                expect(target.priority) == .required
            }
        }

        XCTContext.runActivity(named: "Operator - (NSLayoutVerticalAnchor, EdgeInsets)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.verticalAnchor - (EdgeInsets(top: 100, left: 100, bottom: 100, right: 100) ~ .defaultHigh)
                expect(target.anchor.topAnchor) == view.topAnchor
                expect(target.anchor.bottomAnchor) == view.bottomAnchor
                expect(target.constant) == EdgeInsets(top: -100, left: -100, bottom: -100, right: -100)
                expect(target.multiplier) == 1
                expect(target.priority) == .defaultHigh
            }
        }

        XCTContext.runActivity(named: "Operator * (NSLayoutVerticalAnchor, CGSize)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.verticalAnchor * 0.1
                expect(target.anchor.topAnchor) == view.topAnchor
                expect(target.anchor.bottomAnchor) == view.bottomAnchor
                expect(target.constant) == .zero
                expect(target.multiplier) == 0.1
                expect(target.priority) == .required
            }
        }

        XCTContext.runActivity(named: "Operator * (NSLayoutVerticalAnchor, LayoutPriorityValue)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.verticalAnchor * (0.2 ~ .defaultHigh)
                expect(target.anchor.topAnchor) == view.topAnchor
                expect(target.anchor.bottomAnchor) == view.bottomAnchor
                expect(target.constant) == .zero
                expect(target.multiplier) == 0.2
                expect(target.priority) == .defaultHigh
            }
        }

        XCTContext.runActivity(named: "Operator ~ (NSLayoutVerticalAnchor, UILayoutPriority)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.verticalAnchor ~ .defaultHigh
                expect(target.anchor.topAnchor) == view.topAnchor
                expect(target.anchor.bottomAnchor) == view.bottomAnchor
                expect(target.constant) == .zero
                expect(target.priority) == .defaultHigh
            }
        }

        XCTContext.runActivity(named: "Operator ~ (NSLayoutVerticalAnchor, CGFloat)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.verticalAnchor ~ 250
                expect(target.anchor.topAnchor) == view.topAnchor
                expect(target.anchor.bottomAnchor) == view.bottomAnchor
                expect(target.constant) == .zero
                expect(target.priority) == .init(250)
            }
        }

        XCTContext.runActivity(named: "Operator == (NSLayoutVerticalAnchor, LayoutAnchorTarget)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let target = LayoutAnchorTarget(second.verticalAnchor, constant: EdgeInsets(top: 100, left: 100, bottom: 100, right: 100), multiplier: 0.3, priority: .defaultHigh)
                let constraints = view.verticalAnchor == target
                let constraintTop = constraints[0]
                expect(constraintTop.firstAnchor) == view.topAnchor
                expect(constraintTop.secondAnchor) == second.topAnchor
                expect(constraintTop.constant) == 100
                expect(floor(constraintTop.multiplier * 100)) == 30
                expect(constraintTop.priority) == .defaultHigh
                expect(constraintTop.isActive) == false
                expect(constraintTop.relation) == .equal
                let constraintBottom = constraints[1]
                expect(constraintBottom.firstAnchor) == view.bottomAnchor
                expect(constraintBottom.secondAnchor) == second.bottomAnchor
                expect(constraintBottom.constant) == -100
                expect(floor(constraintBottom.multiplier * 100)) == 30
                expect(constraintBottom.priority) == .defaultHigh
                expect(constraintBottom.isActive) == false
                expect(constraintBottom.relation) == .equal
            }
        }

        XCTContext.runActivity(named: "Operator == (NSLayoutVerticalAnchor, NSLayoutVerticalAnchor)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let constraints = view.verticalAnchor == second.verticalAnchor
                let constraintTop = constraints[0]
                expect(constraintTop.firstAnchor) == view.topAnchor
                expect(constraintTop.secondAnchor) == second.topAnchor
                expect(constraintTop.constant) == 0
                expect(constraintTop.multiplier) == 1
                expect(constraintTop.priority) == .required
                expect(constraintTop.isActive) == false
                expect(constraintTop.relation) == .equal
                let constraintBottom = constraints[1]
                expect(constraintBottom.firstAnchor) == view.bottomAnchor
                expect(constraintBottom.secondAnchor) == second.bottomAnchor
                expect(constraintBottom.constant) == 0
                expect(constraintBottom.multiplier) == 1
                expect(constraintBottom.priority) == .required
                expect(constraintBottom.isActive) == false
                expect(constraintBottom.relation) == .equal
            }
        }

        XCTContext.runActivity(named: "Operator >= (NSLayoutVerticalAnchor, LayoutAnchorTarget)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let target = LayoutAnchorTarget(
                    second.verticalAnchor,
                    constant: EdgeInsets(top: 100, left: 100, bottom: 100, right: 100),
                    multiplier: 1,
                    priority: .defaultHigh
                )
                let constraints = view.verticalAnchor >= target
                let constraintTop = constraints[0]
                expect(constraintTop.firstAnchor) == view.topAnchor
                expect(constraintTop.secondAnchor) == second.topAnchor
                expect(constraintTop.constant) == 100
                expect(constraintTop.multiplier) == 1
                expect(constraintTop.priority) == .defaultHigh
                expect(constraintTop.isActive) == false
                expect(constraintTop.relation) == .greaterThanOrEqual
                let constraintBottom = constraints[1]
                expect(constraintBottom.firstAnchor) == view.bottomAnchor
                expect(constraintBottom.secondAnchor) == second.bottomAnchor
                expect(constraintBottom.constant) == -100
                expect(constraintBottom.multiplier) == 1
                expect(constraintBottom.priority) == .defaultHigh
                expect(constraintBottom.isActive) == false
                expect(constraintBottom.relation) == .greaterThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator >= (NSLayoutVerticalAnchor, NSLayoutVerticalAnchor)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let constraints = view.verticalAnchor >= second.verticalAnchor
                let constraintTop = constraints[0]
                expect(constraintTop.firstAnchor) == view.topAnchor
                expect(constraintTop.secondAnchor) == second.topAnchor
                expect(constraintTop.constant) == 0
                expect(constraintTop.multiplier) == 1
                expect(constraintTop.priority) == .required
                expect(constraintTop.isActive) == false
                expect(constraintTop.relation) == .greaterThanOrEqual
                let constraintBottom = constraints[1]
                expect(constraintBottom.firstAnchor) == view.bottomAnchor
                expect(constraintBottom.secondAnchor) == second.bottomAnchor
                expect(constraintBottom.constant) == 0
                expect(constraintBottom.multiplier) == 1
                expect(constraintBottom.priority) == .required
                expect(constraintBottom.isActive) == false
                expect(constraintBottom.relation) == .greaterThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator <= (NSLayoutVerticalAnchor, LayoutAnchorTarget)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let target = LayoutAnchorTarget(
                    second.verticalAnchor,
                    constant: EdgeInsets(top: 100, left: 100, bottom: 100, right: 100),
                    multiplier: 1,
                    priority: .defaultHigh
                )
                let constraints = view.verticalAnchor <= target
                let constraintTop = constraints[0]
                expect(constraintTop.firstAnchor) == view.topAnchor
                expect(constraintTop.secondAnchor) == second.topAnchor
                expect(constraintTop.constant) == 100
                expect(constraintTop.multiplier) == 1
                expect(constraintTop.priority) == .defaultHigh
                expect(constraintTop.isActive) == false
                expect(constraintTop.relation) == .lessThanOrEqual
                let constraintBottom = constraints[1]
                expect(constraintBottom.firstAnchor) == view.bottomAnchor
                expect(constraintBottom.secondAnchor) == second.bottomAnchor
                expect(constraintBottom.constant) == -100
                expect(constraintBottom.multiplier) == 1
                expect(constraintBottom.priority) == .defaultHigh
                expect(constraintBottom.isActive) == false
                expect(constraintBottom.relation) == .lessThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator <= (NSLayoutVerticalAnchor, NSLayoutVerticalAnchor)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let constraints = view.verticalAnchor <= second.verticalAnchor
                let constraintTop = constraints[0]
                expect(constraintTop.firstAnchor) == view.topAnchor
                expect(constraintTop.secondAnchor) == second.topAnchor
                expect(constraintTop.constant) == 0
                expect(constraintTop.multiplier) == 1
                expect(constraintTop.priority) == .required
                expect(constraintTop.isActive) == false
                expect(constraintTop.relation) == .lessThanOrEqual
                let constraintBottom = constraints[1]
                expect(constraintBottom.firstAnchor) == view.bottomAnchor
                expect(constraintBottom.secondAnchor) == second.bottomAnchor
                expect(constraintBottom.constant) == 0
                expect(constraintBottom.multiplier) == 1
                expect(constraintBottom.priority) == .required
                expect(constraintBottom.isActive) == false
                expect(constraintBottom.relation) == .lessThanOrEqual
            }
        }
    }
}
