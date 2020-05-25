@testable import Mag
import XCTest

private final class NSLayoutConstraint_PropertiesTests: XCTestCase {
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

    func testLayoutConstraintProperties() {
        XCTContext.runActivity(named: "with(multiplier:priority:)") { _ in
            XCTContext.runActivity(named: "translatesAutoresizingMaskIntoConstraints equals false") { _ in
                expect(self.view.translatesAutoresizingMaskIntoConstraints) == true
                _ = makeLayoutConstraint().with(multiplier: 1, priority: .required)
                expect(self.view.translatesAutoresizingMaskIntoConstraints) == false
            }

            XCTContext.runActivity(named: "set properties") { _ in
                let constraint = makeLayoutConstraint()
                constraint.identifier = "Test"
                constraint.shouldBeArchived = true
                expect(constraint.priority) == .required
                expect(constraint.multiplier) == 1
                expect(constraint.identifier) == "Test"
                expect(constraint.shouldBeArchived) == true
                let new = constraint.with(multiplier: 0.5, priority: .defaultLow)
                expect(new.priority) == .defaultLow
                expect(new.multiplier) == 0.5
                expect(new.identifier) == "Test"
                expect(new.shouldBeArchived) == true
            }
        }
    }
}
