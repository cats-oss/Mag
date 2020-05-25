@testable import Mag
import XCTest

private final class NSLayoutConstraint_ActivationTests: XCTestCase {
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

    func makeLayoutConstraint() -> NSLayoutConstraint {
        NSLayoutConstraint(
            item: view as Any,
            attribute: .left,
            relatedBy: .equal,
            toItem: second,
            attribute: .left,
            multiplier: 1,
            constant: 0
        )
    }

    func testLayoutConstraintActivation() {
        XCTContext.runActivity(named: "deactivate(_:beforeActivate)") { _ in
            let constraint1 = makeLayoutConstraint()
            let constraint2 = makeLayoutConstraint()
            constraint1.isActive = true
            constraint2.isActive = false
            NSLayoutConstraint.deactivate([constraint1], beforeActivate: [constraint2])
            expect(constraint1.isActive) == false
            expect(constraint2.isActive) == true
        }

        XCTContext.runActivity(named: "replaceActivatedConstraints(_)") { _ in
            let constraint1 = makeLayoutConstraint()
            let constraint2 = makeLayoutConstraint()
            var constraints = [constraint1]
            constraint1.isActive = true
            constraint2.isActive = false
            constraints.replaceActivatedConstraints([constraint2])
            expect(constraint1.isActive) == false
            expect(constraint2.isActive) == true
        }
    }
}
