@testable import Mag
import XCTest

private final class LayoutConstraintTests: XCTestCase {
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

    func makeLayoutConstraint() -> LayoutConstraint {
        LayoutConstraint(
            item: view as Any,
            attribute: .left,
            relatedBy: .equal,
            toItem: second,
            attribute: .left,
            multiplier: 1,
            constant: 0
        )
    }

    func testLayoutConstraint() {
        XCTContext.runActivity(named: "hasActivated") { _ in
            XCTContext.runActivity(named: "when constraint has activated") { _ in
                XCTContext.runActivity(named: "returns true") { _ in
                    let constraint = makeLayoutConstraint()
                    expect(constraint.isActive) == false
                    expect(constraint.hasActivated) == false
                    constraint.isActive = true
                    expect(constraint.isActive) == true
                    expect(constraint.hasActivated) == true
                }

                XCTContext.runActivity(named: "when constraint deactivate") { _ in
                    XCTContext.runActivity(named: "returns true") { _ in
                        let constraint = makeLayoutConstraint()
                        expect(constraint.isActive) == false
                        expect(constraint.hasActivated) == false
                        constraint.isActive = true
                        expect(constraint.isActive) == true
                        expect(constraint.hasActivated) == true
                        constraint.isActive = false
                        expect(constraint.isActive) == false
                        expect(constraint.hasActivated) == true
                    }
                }
            }
        }
    }
}
