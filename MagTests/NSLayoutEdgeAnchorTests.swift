@testable import Mag
import XCTest

private final class NSLayoutEdgeAnchorTests: XCTestCase {
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
        XCTContext.runActivity(named: "Operator + (NSLayoutEdgeAnchor, EdgeInsets)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.edgeAnchor + EdgeInsets(top: 100, left: 100, bottom: 100, right: 100)
                expect(target.anchor.topAnchor) == view.topAnchor
                expect(target.anchor.leadingAnchor) == view.leadingAnchor
                expect(target.anchor.trailingAnchor) == view.trailingAnchor
                expect(target.anchor.bottomAnchor) == view.bottomAnchor
                expect(target.constant) == EdgeInsets(top: 100, left: 100, bottom: 100, right: 100)
                expect(target.multiplier) == 1
                expect(target.priority) == .required
            }
        }

        XCTContext.runActivity(named: "Operator + (NSLayoutEdgeAnchor, LayoutPriorityValue)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.edgeAnchor + (EdgeInsets(top: 100, left: 100, bottom: 100, right: 100) ~ .defaultHigh)
                expect(target.anchor.topAnchor) == view.topAnchor
                expect(target.anchor.leadingAnchor) == view.leadingAnchor
                expect(target.anchor.trailingAnchor) == view.trailingAnchor
                expect(target.anchor.bottomAnchor) == view.bottomAnchor
                expect(target.constant) == EdgeInsets(top: 100, left: 100, bottom: 100, right: 100)
                expect(target.multiplier) == 1
                expect(target.priority) == .defaultHigh
            }
        }

        XCTContext.runActivity(named: "Operator - (NSLayoutEdgeAnchor, EdgeInsets)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.edgeAnchor - EdgeInsets(top: 100, left: 100, bottom: 100, right: 100)
                expect(target.anchor.topAnchor) == view.topAnchor
                expect(target.anchor.leadingAnchor) == view.leadingAnchor
                expect(target.anchor.trailingAnchor) == view.trailingAnchor
                expect(target.anchor.bottomAnchor) == view.bottomAnchor
                expect(target.constant) == EdgeInsets(top: -100, left: -100, bottom: -100, right: -100)
                expect(target.multiplier) == 1
                expect(target.priority) == .required
            }
        }

        XCTContext.runActivity(named: "Operator - (NSLayoutEdgeAnchor, EdgeInsets)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.edgeAnchor - (EdgeInsets(top: 100, left: 100, bottom: 100, right: 100) ~ .defaultHigh)
                expect(target.anchor.topAnchor) == view.topAnchor
                expect(target.anchor.leadingAnchor) == view.leadingAnchor
                expect(target.anchor.trailingAnchor) == view.trailingAnchor
                expect(target.anchor.bottomAnchor) == view.bottomAnchor
                expect(target.constant) == EdgeInsets(top: -100, left: -100, bottom: -100, right: -100)
                expect(target.multiplier) == 1
                expect(target.priority) == .defaultHigh
            }
        }

        XCTContext.runActivity(named: "Operator * (NSLayoutEdgeAnchor, CGSize)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.edgeAnchor * 0.1
                expect(target.anchor.topAnchor) == view.topAnchor
                expect(target.anchor.leadingAnchor) == view.leadingAnchor
                expect(target.anchor.trailingAnchor) == view.trailingAnchor
                expect(target.anchor.bottomAnchor) == view.bottomAnchor
                expect(target.constant) == .zero
                expect(target.multiplier) == 0.1
                expect(target.priority) == .required
            }
        }

        XCTContext.runActivity(named: "Operator * (NSLayoutEdgeAnchor, LayoutPriorityValue)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.edgeAnchor * (0.2 ~ .defaultHigh)
                expect(target.anchor.topAnchor) == view.topAnchor
                expect(target.anchor.leadingAnchor) == view.leadingAnchor
                expect(target.anchor.trailingAnchor) == view.trailingAnchor
                expect(target.anchor.bottomAnchor) == view.bottomAnchor
                expect(target.constant) == .zero
                expect(target.multiplier) == 0.2
                expect(target.priority) == .defaultHigh
            }
        }

        XCTContext.runActivity(named: "Operator ~ (NSLayoutEdgeAnchor, UILayoutPriority)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.edgeAnchor ~ .defaultHigh
                expect(target.anchor.topAnchor) == view.topAnchor
                expect(target.anchor.leadingAnchor) == view.leadingAnchor
                expect(target.anchor.trailingAnchor) == view.trailingAnchor
                expect(target.anchor.bottomAnchor) == view.bottomAnchor
                expect(target.constant) == .zero
                expect(target.priority) == .defaultHigh
            }
        }

        XCTContext.runActivity(named: "Operator ~ (NSLayoutEdgeAnchor, CGFloat)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.edgeAnchor ~ 250
                expect(target.anchor.topAnchor) == view.topAnchor
                expect(target.anchor.leadingAnchor) == view.leadingAnchor
                expect(target.anchor.trailingAnchor) == view.trailingAnchor
                expect(target.anchor.bottomAnchor) == view.bottomAnchor
                expect(target.constant) == .zero
                expect(target.priority) == .init(250)
            }
        }

        XCTContext.runActivity(named: "Operator == (NSLayoutEdgeAnchor, LayoutAnchorTarget)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let target = LayoutAnchorTarget(second.edgeAnchor, constant: EdgeInsets(top: 100, left: 100, bottom: 100, right: 100), multiplier: 0.3, priority: .defaultHigh)
                let constraints = view.edgeAnchor == target
                let constraintTop = constraints[0]
                expect(constraintTop.firstAnchor) == view.topAnchor
                expect(constraintTop.secondAnchor) == second.topAnchor
                expect(constraintTop.constant) == 100
                expect(floor(constraintTop.multiplier * 100)) == 30
                expect(constraintTop.priority) == .defaultHigh
                expect(constraintTop.isActive) == true
                expect(constraintTop.relation) == .equal
                let constraintBottom = constraints[1]
                expect(constraintBottom.firstAnchor) == view.bottomAnchor
                expect(constraintBottom.secondAnchor) == second.bottomAnchor
                expect(constraintBottom.constant) == -100
                expect(floor(constraintBottom.multiplier * 100)) == 30
                expect(constraintBottom.priority) == .defaultHigh
                expect(constraintBottom.isActive) == true
                expect(constraintBottom.relation) == .equal
                let constraintLeft = constraints[2]
                expect(constraintLeft.firstAnchor) == view.leadingAnchor
                expect(constraintLeft.secondAnchor) == second.leadingAnchor
                expect(constraintLeft.constant) == 100
                expect(floor(constraintLeft.multiplier * 100)) == 30
                expect(constraintLeft.priority) == .defaultHigh
                expect(constraintLeft.isActive) == true
                expect(constraintLeft.relation) == .equal
                let constraintRight = constraints[3]
                expect(constraintRight.firstAnchor) == view.trailingAnchor
                expect(constraintRight.secondAnchor) == second.trailingAnchor
                expect(constraintRight.constant) == -100
                expect(floor(constraintRight.multiplier * 100)) == 30
                expect(constraintRight.priority) == .defaultHigh
                expect(constraintRight.isActive) == true
                expect(constraintRight.relation) == .equal
            }
        }

        XCTContext.runActivity(named: "Operator == (NSLayoutEdgeAnchor, NSLayoutEdgeAnchor)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let constraints = view.edgeAnchor == second.edgeAnchor
                let constraintTop = constraints[0]
                expect(constraintTop.firstAnchor) == view.topAnchor
                expect(constraintTop.secondAnchor) == second.topAnchor
                expect(constraintTop.constant) == 0
                expect(constraintTop.multiplier) == 1
                expect(constraintTop.priority) == .required
                expect(constraintTop.isActive) == true
                expect(constraintTop.relation) == .equal
                let constraintBottom = constraints[1]
                expect(constraintBottom.firstAnchor) == view.bottomAnchor
                expect(constraintBottom.secondAnchor) == second.bottomAnchor
                expect(constraintBottom.constant) == 0
                expect(constraintBottom.multiplier) == 1
                expect(constraintBottom.priority) == .required
                expect(constraintBottom.isActive) == true
                expect(constraintBottom.relation) == .equal
                let constraintLeft = constraints[2]
                expect(constraintLeft.firstAnchor) == view.leadingAnchor
                expect(constraintLeft.secondAnchor) == second.leadingAnchor
                expect(constraintLeft.constant) == 0
                expect(constraintLeft.multiplier) == 1
                expect(constraintLeft.priority) == .required
                expect(constraintLeft.isActive) == true
                expect(constraintLeft.relation) == .equal
                let constraintRight = constraints[3]
                expect(constraintRight.firstAnchor) == view.trailingAnchor
                expect(constraintRight.secondAnchor) == second.trailingAnchor
                expect(constraintRight.constant) == 0
                expect(constraintRight.multiplier) == 1
                expect(constraintRight.priority) == .required
                expect(constraintRight.isActive) == true
                expect(constraintRight.relation) == .equal
            }
        }

        XCTContext.runActivity(named: "Operator >= (NSLayoutEdgeAnchor, LayoutAnchorTarget)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let target = LayoutAnchorTarget(
                    second.edgeAnchor,
                    constant: EdgeInsets(top: 100, left: 100, bottom: 100, right: 100),
                    multiplier: 1,
                    priority: .defaultHigh
                )
                let constraints = view.edgeAnchor >= target
                let constraintTop = constraints[0]
                expect(constraintTop.firstAnchor) == view.topAnchor
                expect(constraintTop.secondAnchor) == second.topAnchor
                expect(constraintTop.constant) == 100
                expect(constraintTop.multiplier) == 1
                expect(constraintTop.priority) == .defaultHigh
                expect(constraintTop.isActive) == true
                expect(constraintTop.relation) == .greaterThanOrEqual
                let constraintBottom = constraints[1]
                expect(constraintBottom.firstAnchor) == view.bottomAnchor
                expect(constraintBottom.secondAnchor) == second.bottomAnchor
                expect(constraintBottom.constant) == -100
                expect(constraintBottom.multiplier) == 1
                expect(constraintBottom.priority) == .defaultHigh
                expect(constraintBottom.isActive) == true
                expect(constraintBottom.relation) == .greaterThanOrEqual
                let constraintLeft = constraints[2]
                expect(constraintLeft.firstAnchor) == view.leadingAnchor
                expect(constraintLeft.secondAnchor) == second.leadingAnchor
                expect(constraintLeft.constant) == 100
                expect(constraintLeft.multiplier) == 1
                expect(constraintLeft.priority) == .defaultHigh
                expect(constraintLeft.isActive) == true
                expect(constraintLeft.relation) == .greaterThanOrEqual
                let constraintRight = constraints[3]
                expect(constraintRight.firstAnchor) == view.trailingAnchor
                expect(constraintRight.secondAnchor) == second.trailingAnchor
                expect(constraintRight.constant) == -100
                expect(constraintRight.multiplier) == 1
                expect(constraintRight.priority) == .defaultHigh
                expect(constraintRight.isActive) == true
                expect(constraintRight.relation) == .greaterThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator >= (NSLayoutEdgeAnchor, NSLayoutEdgeAnchor)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let constraints = view.edgeAnchor >= second.edgeAnchor
                let constraintTop = constraints[0]
                expect(constraintTop.firstAnchor) == view.topAnchor
                expect(constraintTop.secondAnchor) == second.topAnchor
                expect(constraintTop.constant) == 0
                expect(constraintTop.multiplier) == 1
                expect(constraintTop.priority) == .required
                expect(constraintTop.isActive) == true
                expect(constraintTop.relation) == .greaterThanOrEqual
                let constraintBottom = constraints[1]
                expect(constraintBottom.firstAnchor) == view.bottomAnchor
                expect(constraintBottom.secondAnchor) == second.bottomAnchor
                expect(constraintBottom.constant) == 0
                expect(constraintBottom.multiplier) == 1
                expect(constraintBottom.priority) == .required
                expect(constraintBottom.isActive) == true
                expect(constraintBottom.relation) == .greaterThanOrEqual
                let constraintLeft = constraints[2]
                expect(constraintLeft.firstAnchor) == view.leadingAnchor
                expect(constraintLeft.secondAnchor) == second.leadingAnchor
                expect(constraintLeft.constant) == 0
                expect(constraintLeft.multiplier) == 1
                expect(constraintLeft.priority) == .required
                expect(constraintLeft.isActive) == true
                expect(constraintLeft.relation) == .greaterThanOrEqual
                let constraintRight = constraints[3]
                expect(constraintRight.firstAnchor) == view.trailingAnchor
                expect(constraintRight.secondAnchor) == second.trailingAnchor
                expect(constraintRight.constant) == 0
                expect(constraintRight.multiplier) == 1
                expect(constraintRight.priority) == .required
                expect(constraintRight.isActive) == true
                expect(constraintRight.relation) == .greaterThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator <= (NSLayoutEdgeAnchor, LayoutAnchorTarget)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let target = LayoutAnchorTarget(
                    second.edgeAnchor,
                    constant: EdgeInsets(top: 100, left: 100, bottom: 100, right: 100),
                    multiplier: 1,
                    priority: .defaultHigh
                )
                let constraints = view.edgeAnchor <= target
                let constraintTop = constraints[0]
                expect(constraintTop.firstAnchor) == view.topAnchor
                expect(constraintTop.secondAnchor) == second.topAnchor
                expect(constraintTop.constant) == 100
                expect(constraintTop.multiplier) == 1
                expect(constraintTop.priority) == .defaultHigh
                expect(constraintTop.isActive) == true
                expect(constraintTop.relation) == .lessThanOrEqual
                let constraintBottom = constraints[1]
                expect(constraintBottom.firstAnchor) == view.bottomAnchor
                expect(constraintBottom.secondAnchor) == second.bottomAnchor
                expect(constraintBottom.constant) == -100
                expect(constraintBottom.multiplier) == 1
                expect(constraintBottom.priority) == .defaultHigh
                expect(constraintBottom.isActive) == true
                expect(constraintBottom.relation) == .lessThanOrEqual
                let constraintLeft = constraints[2]
                expect(constraintLeft.firstAnchor) == view.leadingAnchor
                expect(constraintLeft.secondAnchor) == second.leadingAnchor
                expect(constraintLeft.constant) == 100
                expect(constraintLeft.multiplier) == 1
                expect(constraintLeft.priority) == .defaultHigh
                expect(constraintLeft.isActive) == true
                expect(constraintLeft.relation) == .lessThanOrEqual
                let constraintRight = constraints[3]
                expect(constraintRight.firstAnchor) == view.trailingAnchor
                expect(constraintRight.secondAnchor) == second.trailingAnchor
                expect(constraintRight.constant) == -100
                expect(constraintRight.multiplier) == 1
                expect(constraintRight.priority) == .defaultHigh
                expect(constraintRight.isActive) == true
                expect(constraintRight.relation) == .lessThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator <= (NSLayoutEdgeAnchor, NSLayoutEdgeAnchor)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let constraints = view.edgeAnchor <= second.edgeAnchor
                let constraintTop = constraints[0]
                expect(constraintTop.firstAnchor) == view.topAnchor
                expect(constraintTop.secondAnchor) == second.topAnchor
                expect(constraintTop.constant) == 0
                expect(constraintTop.multiplier) == 1
                expect(constraintTop.priority) == .required
                expect(constraintTop.isActive) == true
                expect(constraintTop.relation) == .lessThanOrEqual
                let constraintBottom = constraints[1]
                expect(constraintBottom.firstAnchor) == view.bottomAnchor
                expect(constraintBottom.secondAnchor) == second.bottomAnchor
                expect(constraintBottom.constant) == 0
                expect(constraintBottom.multiplier) == 1
                expect(constraintBottom.priority) == .required
                expect(constraintBottom.isActive) == true
                expect(constraintBottom.relation) == .lessThanOrEqual
                let constraintLeft = constraints[2]
                expect(constraintLeft.firstAnchor) == view.leadingAnchor
                expect(constraintLeft.secondAnchor) == second.leadingAnchor
                expect(constraintLeft.constant) == 0
                expect(constraintLeft.multiplier) == 1
                expect(constraintLeft.priority) == .required
                expect(constraintLeft.isActive) == true
                expect(constraintLeft.relation) == .lessThanOrEqual
                let constraintRight = constraints[3]
                expect(constraintRight.firstAnchor) == view.trailingAnchor
                expect(constraintRight.secondAnchor) == second.trailingAnchor
                expect(constraintRight.constant) == 0
                expect(constraintRight.multiplier) == 1
                expect(constraintRight.priority) == .required
                expect(constraintRight.isActive) == true
                expect(constraintRight.relation) == .lessThanOrEqual
            }
        }
    }
}
