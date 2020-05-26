@testable import Mag
import XCTest

private final class LayoutConstraintWrapperTests: XCTestCase {
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

    func testLayoutConstraint() {
        XCTContext.runActivity(named: "hasActivated") { _ in
            XCTContext.runActivity(named: "when constraint has activated") { _ in
                XCTContext.runActivity(named: "returns true") { _ in
                    let constraint = makeLayoutConstraint()
                    let wrapper = LayoutConstraintWrapper(origin: constraint)
                    expect(constraint.isActive) == false
                    expect(wrapper.hasActivated) == false
                    wrapper.isActive = true
                    expect(constraint.isActive) == true
                    expect(wrapper.hasActivated) == true
                }

                XCTContext.runActivity(named: "when constraint deactivate") { _ in
                    XCTContext.runActivity(named: "returns true") { _ in
                        let constraint = makeLayoutConstraint()
                        let wrapper = LayoutConstraintWrapper(origin: constraint)
                        expect(constraint.isActive) == false
                        expect(wrapper.hasActivated) == false
                        wrapper.isActive = true
                        expect(constraint.isActive) == true
                        expect(wrapper.hasActivated) == true
                        wrapper.isActive = false
                        expect(constraint.isActive) == false
                        expect(wrapper.hasActivated) == true
                    }
                }
            }
        }

        XCTContext.runActivity(named: "isActive") { _ in
            XCTContext.runActivity(named: "when constraint deinits without activate") { _ in
                XCTContext.runActivity(named: "returns true") { _ in
                    let constraint = makeLayoutConstraint()
                    var wrapper: NSLayoutConstraint? = LayoutConstraintWrapper(origin: constraint)
                    expect(wrapper?.isActive) == false
                    expect(constraint.isActive) == false
                    wrapper = nil
                    expect(constraint.isActive) == true
                }
            }

            XCTContext.runActivity(named: "when constraint has activated and then deinit") { _ in
                XCTContext.runActivity(named: "returns false") { _ in
                    let constraint = makeLayoutConstraint()
                    var wrapper: NSLayoutConstraint? = LayoutConstraintWrapper(origin: constraint)
                    wrapper?.isActive = true
                    expect(wrapper?.isActive) == true
                    expect(constraint.isActive) == true
                    wrapper?.isActive = false
                    expect(wrapper?.isActive) == false
                    expect(constraint.isActive) == false
                    wrapper = nil
                    expect(constraint.isActive) == false
                }
            }
        }


        XCTContext.runActivity(named: "properties") { _ in
            let constraint = makeLayoutConstraint()
            let wrapper: NSLayoutConstraint = LayoutConstraintWrapper(origin: constraint)
            expect(wrapper.priority) == .required
            wrapper.priority = .defaultLow
            expect(wrapper.priority) == .defaultLow
            expect(wrapper.shouldBeArchived) == false
            wrapper.shouldBeArchived = true
            expect(wrapper.shouldBeArchived) == true
            expect(wrapper.firstItem as? View) == view
            expect(wrapper.secondItem as? View) == second
            expect(wrapper.firstAttribute) == .left
            expect(wrapper.secondAttribute) == .left
            expect(wrapper.firstAnchor) == view.leftAnchor
            expect(wrapper.secondAnchor) == second.leftAnchor
            expect(wrapper.relation) == .equal
            expect(wrapper.multiplier) == 1
            expect(wrapper.constant) == 0
            wrapper.constant = 10
            expect(wrapper.constant) == 10
            expect(wrapper.isActive) == false
            wrapper.isActive = true
            expect(wrapper.isActive) == true
            expect(wrapper.identifier) == nil
            wrapper.identifier = "TestConstraint"
            expect(wrapper.identifier) == "TestConstraint"
        }
    }
}
