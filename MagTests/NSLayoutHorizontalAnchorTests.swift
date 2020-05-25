@testable import Mag
import XCTest

private final class NSLayoutHorizontalAnchorTests: XCTestCase {
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
        XCTContext.runActivity(named: "Operator + (NSLayoutHorizontalAnchor, EdgeInsets)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.horizontalAnchor + EdgeInsets(top: 100, left: 100, bottom: 100, right: 100)
                expect(target.anchor.leadingAnchor) == view.leadingAnchor
                expect(target.anchor.trailingAnchor) == view.trailingAnchor
                expect(target.constant) == EdgeInsets(top: 100, left: 100, bottom: 100, right: 100)
                expect(target.multiplier) == 1
                expect(target.priority) == .required
            }
        }

        XCTContext.runActivity(named: "Operator + (NSLayoutHorizontalAnchor, LayoutPriorityValue)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.horizontalAnchor + (EdgeInsets(top: 100, left: 100, bottom: 100, right: 100) ~ .defaultHigh)
                expect(target.anchor.leadingAnchor) == view.leadingAnchor
                expect(target.anchor.trailingAnchor) == view.trailingAnchor
                expect(target.constant) == EdgeInsets(top: 100, left: 100, bottom: 100, right: 100)
                expect(target.multiplier) == 1
                expect(target.priority) == .defaultHigh
            }
        }

        XCTContext.runActivity(named: "Operator - (NSLayoutHorizontalAnchor, EdgeInsets)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.horizontalAnchor - EdgeInsets(top: 100, left: 100, bottom: 100, right: 100)
                expect(target.anchor.leadingAnchor) == view.leadingAnchor
                expect(target.anchor.trailingAnchor) == view.trailingAnchor
                expect(target.constant) == EdgeInsets(top: -100, left: -100, bottom: -100, right: -100)
                expect(target.multiplier) == 1
                expect(target.priority) == .required
            }
        }

        XCTContext.runActivity(named: "Operator - (NSLayoutHorizontalAnchor, EdgeInsets)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.horizontalAnchor - (EdgeInsets(top: 100, left: 100, bottom: 100, right: 100) ~ .defaultHigh)
                expect(target.anchor.leadingAnchor) == view.leadingAnchor
                expect(target.anchor.trailingAnchor) == view.trailingAnchor
                expect(target.constant) == EdgeInsets(top: -100, left: -100, bottom: -100, right: -100)
                expect(target.multiplier) == 1
                expect(target.priority) == .defaultHigh
            }
        }

        XCTContext.runActivity(named: "Operator * (NSLayoutHorizontalAnchor, CGSize)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.horizontalAnchor * 0.1
                expect(target.anchor.leadingAnchor) == view.leadingAnchor
                expect(target.anchor.trailingAnchor) == view.trailingAnchor
                expect(target.constant) == .zero
                expect(target.multiplier) == 0.1
                expect(target.priority) == .required
            }
        }

        XCTContext.runActivity(named: "Operator * (NSLayoutHorizontalAnchor, LayoutPriorityValue)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.horizontalAnchor * (0.2 ~ .defaultHigh)
                expect(target.anchor.leadingAnchor) == view.leadingAnchor
                expect(target.anchor.trailingAnchor) == view.trailingAnchor
                expect(target.constant) == .zero
                expect(target.multiplier) == 0.2
                expect(target.priority) == .defaultHigh
            }
        }

        XCTContext.runActivity(named: "Operator ~ (NSLayoutHorizontalAnchor, UILayoutPriority)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.horizontalAnchor ~ .defaultHigh
                expect(target.anchor.leadingAnchor) == view.leadingAnchor
                expect(target.anchor.trailingAnchor) == view.trailingAnchor
                expect(target.constant) == .zero
                expect(target.priority) == .defaultHigh
            }
        }

        XCTContext.runActivity(named: "Operator ~ (NSLayoutHorizontalAnchor, CGFloat)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.horizontalAnchor ~ 250
                expect(target.anchor.leadingAnchor) == view.leadingAnchor
                expect(target.anchor.trailingAnchor) == view.trailingAnchor
                expect(target.constant) == .zero
                expect(target.priority) == .init(250)
            }
        }

        XCTContext.runActivity(named: "Operator == (NSLayoutHorizontalAnchor, LayoutAnchorTarget)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let target = LayoutAnchorTarget(second.horizontalAnchor, constant: EdgeInsets(top: 100, left: 100, bottom: 100, right: 100), multiplier: 0.3, priority: .defaultHigh)
                let constraints = view.horizontalAnchor == target
                let constraintLeft = constraints[0]
                expect(constraintLeft.firstAnchor) == view.leadingAnchor
                expect(constraintLeft.secondAnchor) == second.leadingAnchor
                expect(constraintLeft.constant) == 100
                expect(floor(constraintLeft.multiplier * 100)) == 30
                expect(constraintLeft.priority) == .defaultHigh
                expect(constraintLeft.isActive) == false
                expect(constraintLeft.relation) == .equal
                let constraintRight = constraints[1]
                expect(constraintRight.firstAnchor) == view.trailingAnchor
                expect(constraintRight.secondAnchor) == second.trailingAnchor
                expect(constraintRight.constant) == -100
                expect(floor(constraintRight.multiplier * 100)) == 30
                expect(constraintRight.priority) == .defaultHigh
                expect(constraintRight.isActive) == false
                expect(constraintRight.relation) == .equal
            }
        }

        XCTContext.runActivity(named: "Operator == (NSLayoutHorizontalAnchor, NSLayoutHorizontalAnchor)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let constraints = view.horizontalAnchor == second.horizontalAnchor
                let constraintLeft = constraints[0]
                expect(constraintLeft.firstAnchor) == view.leadingAnchor
                expect(constraintLeft.secondAnchor) == second.leadingAnchor
                expect(constraintLeft.constant) == 0
                expect(constraintLeft.multiplier) == 1
                expect(constraintLeft.priority) == .required
                expect(constraintLeft.isActive) == false
                expect(constraintLeft.relation) == .equal
                let constraintRight = constraints[1]
                expect(constraintRight.firstAnchor) == view.trailingAnchor
                expect(constraintRight.secondAnchor) == second.trailingAnchor
                expect(constraintRight.constant) == 0
                expect(constraintRight.multiplier) == 1
                expect(constraintRight.priority) == .required
                expect(constraintRight.isActive) == false
                expect(constraintRight.relation) == .equal
            }
        }

        XCTContext.runActivity(named: "Operator >= (NSLayoutHorizontalAnchor, LayoutAnchorTarget)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let target = LayoutAnchorTarget(
                    second.horizontalAnchor,
                    constant: EdgeInsets(top: 100, left: 100, bottom: 100, right: 100),
                    multiplier: 1,
                    priority: .defaultHigh
                )
                let constraints = view.horizontalAnchor >= target
                let constraintLeft = constraints[0]
                expect(constraintLeft.firstAnchor) == view.leadingAnchor
                expect(constraintLeft.secondAnchor) == second.leadingAnchor
                expect(constraintLeft.constant) == 100
                expect(constraintLeft.multiplier) == 1
                expect(constraintLeft.priority) == .defaultHigh
                expect(constraintLeft.isActive) == false
                expect(constraintLeft.relation) == .greaterThanOrEqual
                let constraintRight = constraints[1]
                expect(constraintRight.firstAnchor) == view.trailingAnchor
                expect(constraintRight.secondAnchor) == second.trailingAnchor
                expect(constraintRight.constant) == -100
                expect(constraintRight.multiplier) == 1
                expect(constraintRight.priority) == .defaultHigh
                expect(constraintRight.isActive) == false
                expect(constraintRight.relation) == .greaterThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator >= (NSLayoutHorizontalAnchor, NSLayoutHorizontalAnchor)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let constraints = view.horizontalAnchor >= second.horizontalAnchor
                let constraintLeft = constraints[0]
                expect(constraintLeft.firstAnchor) == view.leadingAnchor
                expect(constraintLeft.secondAnchor) == second.leadingAnchor
                expect(constraintLeft.constant) == 0
                expect(constraintLeft.multiplier) == 1
                expect(constraintLeft.priority) == .required
                expect(constraintLeft.isActive) == false
                expect(constraintLeft.relation) == .greaterThanOrEqual
                let constraintRight = constraints[1]
                expect(constraintRight.firstAnchor) == view.trailingAnchor
                expect(constraintRight.secondAnchor) == second.trailingAnchor
                expect(constraintRight.constant) == 0
                expect(constraintRight.multiplier) == 1
                expect(constraintRight.priority) == .required
                expect(constraintRight.isActive) == false
                expect(constraintRight.relation) == .greaterThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator <= (NSLayoutHorizontalAnchor, LayoutAnchorTarget)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let target = LayoutAnchorTarget(
                    second.horizontalAnchor,
                    constant: EdgeInsets(top: 100, left: 100, bottom: 100, right: 100),
                    multiplier: 1,
                    priority: .defaultHigh
                )
                let constraints = view.horizontalAnchor <= target
                let constraintLeft = constraints[0]
                expect(constraintLeft.firstAnchor) == view.leadingAnchor
                expect(constraintLeft.secondAnchor) == second.leadingAnchor
                expect(constraintLeft.constant) == 100
                expect(constraintLeft.multiplier) == 1
                expect(constraintLeft.priority) == .defaultHigh
                expect(constraintLeft.isActive) == false
                expect(constraintLeft.relation) == .lessThanOrEqual
                let constraintRight = constraints[1]
                expect(constraintRight.firstAnchor) == view.trailingAnchor
                expect(constraintRight.secondAnchor) == second.trailingAnchor
                expect(constraintRight.constant) == -100
                expect(constraintRight.multiplier) == 1
                expect(constraintRight.priority) == .defaultHigh
                expect(constraintRight.isActive) == false
                expect(constraintRight.relation) == .lessThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator <= (NSLayoutHorizontalAnchor, NSLayoutHorizontalAnchor)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let constraints = view.horizontalAnchor <= second.horizontalAnchor
                let constraintLeft = constraints[0]
                expect(constraintLeft.firstAnchor) == view.leadingAnchor
                expect(constraintLeft.secondAnchor) == second.leadingAnchor
                expect(constraintLeft.constant) == 0
                expect(constraintLeft.multiplier) == 1
                expect(constraintLeft.priority) == .required
                expect(constraintLeft.isActive) == false
                expect(constraintLeft.relation) == .lessThanOrEqual
                let constraintRight = constraints[1]
                expect(constraintRight.firstAnchor) == view.trailingAnchor
                expect(constraintRight.secondAnchor) == second.trailingAnchor
                expect(constraintRight.constant) == 0
                expect(constraintRight.multiplier) == 1
                expect(constraintRight.priority) == .required
                expect(constraintRight.isActive) == false
                expect(constraintRight.relation) == .lessThanOrEqual
            }
        }
    }
}
