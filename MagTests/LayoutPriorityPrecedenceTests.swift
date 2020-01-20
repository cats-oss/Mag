@testable import Mag
import XCTest

private final class LayoutPriorityPrecedenceTests: XCTestCase {
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

    func testLayoutPriorityOperator() {
        XCTContext.runActivity(named: "Operator ~ (T, UILayoutPriority)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.heightAnchor + (100 ~ .defaultHigh)
                expect(target.constant) == 100
                expect(target.priority) == .defaultHigh
                expect(target.anchor) == view.heightAnchor
            }
        }

        XCTContext.runActivity(named: "Operator ~ (T, CGFloat)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = view.heightAnchor + (100 ~ 250)
                expect(target.constant) == 100
                expect(target.priority) == .init(250)
                expect(target.anchor) == view.heightAnchor
            }
        }
    }
}
