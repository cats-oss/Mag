@testable import Mag
import XCTest

private final class NSLayoutSizeAnchorTests: XCTestCase {
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

    func testSizeAnchor() {
        XCTContext.runActivity(named: "Operator + (NSLayoutSizeAnchor, CGPoint)") { _ in
            XCTContext.runActivity(named: "returns (NSLayoutSizeAnchor, CGPoint)") { _ in
                let target = view.sizeAnchor + CGSize(width: 100, height: 200)
                expect(target.anchor.widthAnchor) == view.widthAnchor
                expect(target.anchor.heightAnchor) == view.heightAnchor
                expect(target.constant.value) == CGSize(width: 100, height: 200)
                expect(target.constant.multiplier) == 1
                expect(target.priority) == .required
            }
        }

        XCTContext.runActivity(named: "Operator + (NSLayoutSizeAnchor, LayoutPriorityValue)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.sizeAnchor + LayoutPriorityValue(CGSize(width: 100, height: 200), priority: .defaultHigh)
                expect(target.anchor.widthAnchor) == view.widthAnchor
                expect(target.anchor.heightAnchor) == view.heightAnchor
                expect(target.constant.value) == CGSize(width: 100, height: 200)
                expect(target.constant.multiplier) == 1
                expect(target.priority) == .defaultHigh
            }
        }

        XCTContext.runActivity(named: "Operator - (NSLayoutSizeAnchor, CGPoint)") { _ in
            XCTContext.runActivity(named: "returns (NSLayoutSizeAnchor, CGPoint)") { _ in
                let target = view.sizeAnchor - CGSize(width: 100, height: 200)
                expect(target.anchor.widthAnchor) == view.widthAnchor
                expect(target.anchor.heightAnchor) == view.heightAnchor
                expect(target.constant.value) == CGSize(width: -100, height: -200)
                expect(target.constant.multiplier) == 1
            }
        }

        XCTContext.runActivity(named: "Operator - (NSLayoutSizeAnchor, LayoutPriorityValue)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.sizeAnchor - LayoutPriorityValue(CGSize(width: 100, height: 200), priority: .defaultHigh)
                expect(target.anchor.widthAnchor) == view.widthAnchor
                expect(target.anchor.heightAnchor) == view.heightAnchor
                expect(target.constant.value) == CGSize(width: -100, height: -200)
                expect(target.constant.multiplier) == 1
                expect(target.priority) == .defaultHigh
            }
        }

        XCTContext.runActivity(named: "Operator * (NSLayoutSizeAnchor, CGSize)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.sizeAnchor * 0.1
                expect(target.anchor.widthAnchor) == view.widthAnchor
                expect(target.anchor.heightAnchor) == view.heightAnchor
                expect(target.constant.value) == .zero
                expect(target.constant.multiplier) == 0.1
                expect(target.priority) == .required
            }
        }

        XCTContext.runActivity(named: "Operator * (NSLayoutSizeAnchor, LayoutPriorityValue)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.sizeAnchor * LayoutPriorityValue(0.2, priority: .defaultHigh)
                expect(target.anchor.widthAnchor) == view.widthAnchor
                expect(target.anchor.heightAnchor) == view.heightAnchor
                expect(target.constant.value) == .zero
                expect(target.constant.multiplier) == 0.2
                expect(target.priority) == .defaultHigh
            }
        }

        XCTContext.runActivity(named: "Operator ~ (NSLayoutSizeAnchor, UILayoutPriority)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.sizeAnchor ~ .defaultHigh
                expect(target.anchor.widthAnchor) == view.widthAnchor
                expect(target.anchor.heightAnchor) == view.heightAnchor
                expect(target.constant.value) == .zero
                expect(target.constant.multiplier) == 1
                expect(target.priority) == .defaultHigh
            }
        }

        XCTContext.runActivity(named: "Operator ~ (NSLayoutSizeAnchor, CGFloat)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.sizeAnchor ~ 250
                expect(target.anchor.widthAnchor) == view.widthAnchor
                expect(target.anchor.heightAnchor) == view.heightAnchor
                expect(target.constant.value) == .zero
                expect(target.constant.multiplier) == 1
                expect(target.priority) == .init(250)
            }
        }

        XCTContext.runActivity(named: "Operator == (NSLayoutSizeAnchor, LayoutAnchorTarget)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let constant = LayoutConstant(CGSize(width: 100, height: 200), multiplier: 0.3)
                let target = LayoutAnchorTarget(second.sizeAnchor, constant: constant, priority: .defaultHigh)
                let constraints = view.sizeAnchor == target
                let constraintWidth = constraints[0]
                expect(constraintWidth.firstAnchor) == view.widthAnchor
                expect(constraintWidth.secondAnchor) == second.widthAnchor
                expect(constraintWidth.constant) == 100
                expect(floor(constraintWidth.multiplier * 100)) == 30
                expect(constraintWidth.priority) == .defaultHigh
                expect(constraintWidth.isActive) == true
                expect(constraintWidth.relation) == .equal
                let constraintHeight = constraints[1]
                expect(constraintHeight.firstAnchor) == view.heightAnchor
                expect(constraintHeight.secondAnchor) == second.heightAnchor
                expect(constraintHeight.constant) == 200
                expect(floor(constraintHeight.multiplier * 100)) == 30
                expect(constraintHeight.priority) == .defaultHigh
                expect(constraintHeight.isActive) == true
                expect(constraintHeight.relation) == .equal
            }
        }

        XCTContext.runActivity(named: "Operator == (NSLayoutSizeAnchor, NSLayoutSizeAnchor)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let constraints = view.sizeAnchor == second.sizeAnchor
                let constraintWidth = constraints[0]
                expect(constraintWidth.firstAnchor) == view.widthAnchor
                expect(constraintWidth.secondAnchor) == second.widthAnchor
                expect(constraintWidth.constant) == 0
                let constraintHeight = constraints[1]
                expect(constraintHeight.firstAnchor) == view.heightAnchor
                expect(constraintHeight.secondAnchor) == second.heightAnchor
                expect(constraintHeight.constant) == 0
            }
        }

        XCTContext.runActivity(named: "Operator == (NSLayoutSizeAnchor, LayoutPriorityValue)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let constraints = view.sizeAnchor == LayoutPriorityValue(CGSize(width: 100, height: 200), priority: .defaultHigh)
                let constraintWidth = constraints[0]
                expect(constraintWidth.firstAnchor) == view.widthAnchor
                expect(constraintWidth.secondAnchor) == nil
                expect(constraintWidth.constant) == 100
                expect(constraintWidth.priority) == .defaultHigh
                let constraintHeight = constraints[1]
                expect(constraintHeight.firstAnchor) == view.heightAnchor
                expect(constraintHeight.secondAnchor) == nil
                expect(constraintHeight.constant) == 200
                expect(constraintHeight.priority) == .defaultHigh
            }
        }

        XCTContext.runActivity(named: "Operator == (NSLayoutSizeAnchor, CGSize)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let constraints = view.sizeAnchor == CGSize(width: 100, height: 200)
                let constraintWidth = constraints[0]
                expect(constraintWidth.firstAnchor) == view.widthAnchor
                expect(constraintWidth.secondAnchor) == nil
                expect(constraintWidth.constant) == 100
                let constraintHeight = constraints[1]
                expect(constraintHeight.firstAnchor) == view.heightAnchor
                expect(constraintHeight.secondAnchor) == nil
                expect(constraintHeight.constant) == 200
            }
        }

        XCTContext.runActivity(named: "Operator >= (NSLayoutSizeAnchor, LayoutAnchorTarget)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let constant = LayoutConstant(CGSize(width: 100, height: 200), multiplier: 0.3)
                let target = LayoutAnchorTarget(second.sizeAnchor, constant: constant, priority: .defaultHigh)
                let constraints = view.sizeAnchor >= target
                let constraintWidth = constraints[0]
                expect(constraintWidth.firstAnchor) == view.widthAnchor
                expect(constraintWidth.secondAnchor) == second.widthAnchor
                expect(constraintWidth.constant) == 100
                expect(floor(constraintWidth.multiplier * 100)) == 30
                expect(constraintWidth.priority) == .defaultHigh
                expect(constraintWidth.isActive) == true
                expect(constraintWidth.relation) == .greaterThanOrEqual
                let constraintHeight = constraints[1]
                expect(constraintHeight.firstAnchor) == view.heightAnchor
                expect(constraintHeight.secondAnchor) == second.heightAnchor
                expect(constraintHeight.constant) == 200
                expect(floor(constraintHeight.multiplier * 100)) == 30
                expect(constraintHeight.priority) == .defaultHigh
                expect(constraintHeight.isActive) == true
                expect(constraintHeight.relation) == .greaterThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator >= (NSLayoutSizeAnchor, NSLayoutEdgeAnchor)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let constraints = view.sizeAnchor >= second.sizeAnchor
                let constraintWidth = constraints[0]
                expect(constraintWidth.firstAnchor) == view.widthAnchor
                expect(constraintWidth.secondAnchor) == second.widthAnchor
                expect(constraintWidth.constant) == 0
                expect(constraintWidth.multiplier) == 1
                expect(constraintWidth.priority) == .required
                expect(constraintWidth.isActive) == true
                expect(constraintWidth.relation) == .greaterThanOrEqual
                let constraintHeight = constraints[1]
                expect(constraintHeight.firstAnchor) == view.heightAnchor
                expect(constraintHeight.secondAnchor) == second.heightAnchor
                expect(constraintHeight.constant) == 0
                expect(constraintHeight.multiplier) == 1
                expect(constraintHeight.priority) == .required
                expect(constraintHeight.isActive) == true
                expect(constraintHeight.relation) == .greaterThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator >= (NSLayoutSizeAnchor, LayoutPriorityValue)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let constraints = view.sizeAnchor >= LayoutPriorityValue(CGSize(width: 100, height: 200), priority: .defaultHigh)
                let constraintWidth = constraints[0]
                expect(constraintWidth.firstAnchor) == view.widthAnchor
                expect(constraintWidth.secondAnchor) == nil
                expect(constraintWidth.constant) == 100
                expect(constraintWidth.multiplier) == 1
                expect(constraintWidth.priority) == .defaultHigh
                expect(constraintWidth.isActive) == true
                expect(constraintWidth.relation) == .greaterThanOrEqual
                let constraintHeight = constraints[1]
                expect(constraintHeight.firstAnchor) == view.heightAnchor
                expect(constraintHeight.secondAnchor) == nil
                expect(constraintHeight.constant) == 200
                expect(constraintHeight.multiplier) == 1
                expect(constraintHeight.priority) == .defaultHigh
                expect(constraintHeight.isActive) == true
                expect(constraintHeight.relation) == .greaterThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator >= (NSLayoutSizeAnchor, CGSize)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let constraints = view.sizeAnchor >= CGSize(width: 100, height: 200)
                let constraintWidth = constraints[0]
                expect(constraintWidth.firstAnchor) == view.widthAnchor
                expect(constraintWidth.secondAnchor) == nil
                expect(constraintWidth.constant) == 100
                expect(constraintWidth.multiplier) == 1
                expect(constraintWidth.priority) == .required
                expect(constraintWidth.isActive) == true
                expect(constraintWidth.relation) == .greaterThanOrEqual
                let constraintHeight = constraints[1]
                expect(constraintHeight.firstAnchor) == view.heightAnchor
                expect(constraintHeight.secondAnchor) == nil
                expect(constraintHeight.constant) == 200
                expect(constraintHeight.multiplier) == 1
                expect(constraintHeight.priority) == .required
                expect(constraintHeight.isActive) == true
                expect(constraintHeight.relation) == .greaterThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator <= (NSLayoutSizeAnchor, LayoutAnchorTarget)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let constant = LayoutConstant(CGSize(width: 100, height: 200), multiplier: 0.3)
                let target = LayoutAnchorTarget(second.sizeAnchor, constant: constant, priority: .defaultHigh)
                let constraints = view.sizeAnchor <= target
                let constraintWidth = constraints[0]
                expect(constraintWidth.firstAnchor) == view.widthAnchor
                expect(constraintWidth.secondAnchor) == second.widthAnchor
                expect(constraintWidth.constant) == 100
                expect(floor(constraintWidth.multiplier * 100)) == 30
                expect(constraintWidth.priority) == .defaultHigh
                expect(constraintWidth.isActive) == true
                expect(constraintWidth.relation) == .lessThanOrEqual
                let constraintHeight = constraints[1]
                expect(constraintHeight.firstAnchor) == view.heightAnchor
                expect(constraintHeight.secondAnchor) == second.heightAnchor
                expect(constraintHeight.constant) == 200
                expect(floor(constraintHeight.multiplier * 100)) == 30
                expect(constraintHeight.priority) == .defaultHigh
                expect(constraintHeight.isActive) == true
                expect(constraintHeight.relation) == .lessThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator <= (NSLayoutSizeAnchor, NSLayoutEdgeAnchor)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let constraints = view.sizeAnchor <= second.sizeAnchor
                let constraintWidth = constraints[0]
                expect(constraintWidth.firstAnchor) == view.widthAnchor
                expect(constraintWidth.secondAnchor) == second.widthAnchor
                expect(constraintWidth.constant) == 0
                expect(constraintWidth.multiplier) == 1
                expect(constraintWidth.priority) == .required
                expect(constraintWidth.isActive) == true
                expect(constraintWidth.relation) == .lessThanOrEqual
                let constraintHeight = constraints[1]
                expect(constraintHeight.firstAnchor) == view.heightAnchor
                expect(constraintHeight.secondAnchor) == second.heightAnchor
                expect(constraintHeight.constant) == 0
                expect(constraintHeight.multiplier) == 1
                expect(constraintHeight.priority) == .required
                expect(constraintHeight.isActive) == true
                expect(constraintHeight.relation) == .lessThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator <= (NSLayoutSizeAnchor, LayoutPriorityValue)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let constraints = view.sizeAnchor <= LayoutPriorityValue(CGSize(width: 100, height: 200), priority: .defaultHigh)
                let constraintWidth = constraints[0]
                expect(constraintWidth.firstAnchor) == view.widthAnchor
                expect(constraintWidth.secondAnchor) == nil
                expect(constraintWidth.constant) == 100
                expect(constraintWidth.multiplier) == 1
                expect(constraintWidth.priority) == .defaultHigh
                expect(constraintWidth.isActive) == true
                expect(constraintWidth.relation) == .lessThanOrEqual
                let constraintHeight = constraints[1]
                expect(constraintHeight.firstAnchor) == view.heightAnchor
                expect(constraintHeight.secondAnchor) == nil
                expect(constraintHeight.constant) == 200
                expect(constraintHeight.multiplier) == 1
                expect(constraintHeight.priority) == .defaultHigh
                expect(constraintHeight.isActive) == true
                expect(constraintHeight.relation) == .lessThanOrEqual
            }
        }

        XCTContext.runActivity(named: "Operator <= (NSLayoutSizeAnchor, CGSize)") { _ in
            XCTContext.runActivity(named: "returns [NSLayoutConstraint]") { _ in
                let constraints = view.sizeAnchor <= CGSize(width: 100, height: 200)
                let constraintWidth = constraints[0]
                expect(constraintWidth.firstAnchor) == view.widthAnchor
                expect(constraintWidth.secondAnchor) == nil
                expect(constraintWidth.constant) == 100
                expect(constraintWidth.multiplier) == 1
                expect(constraintWidth.priority) == .required
                expect(constraintWidth.isActive) == true
                expect(constraintWidth.relation) == .lessThanOrEqual
                let constraintHeight = constraints[1]
                expect(constraintHeight.firstAnchor) == view.heightAnchor
                expect(constraintHeight.secondAnchor) == nil
                expect(constraintHeight.constant) == 200
                expect(constraintHeight.multiplier) == 1
                expect(constraintHeight.priority) == .required
                expect(constraintHeight.isActive) == true
                expect(constraintHeight.relation) == .lessThanOrEqual
            }
        }
    }
}
