@testable import Mag
import XCTest

private final class LayoutAnchorTargetTests: XCTestCase {
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

    func testLayoutAnchorTarget() {
        XCTContext.runActivity(named: "Operator + (LayoutAnchorTarget, CGFloat)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = LayoutAnchorTarget(view.heightAnchor, constant: 300, multiplier: 0.3, priority: .defaultHigh) + 100
                expect(target.anchor) == view.heightAnchor
                expect(target.constant) == 100
                expect(target.multiplier) == 0.3
                expect(target.priority) == .defaultHigh
            }
        }

        XCTContext.runActivity(named: "Operator - (LayoutAnchorTarget, CGFloat)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = LayoutAnchorTarget(view.heightAnchor, constant: 300, multiplier: 0.3, priority: .defaultHigh) - 100
                expect(target.anchor) == view.heightAnchor
                expect(target.constant) == -100
                expect(target.multiplier) == 0.3
                expect(target.priority) == .defaultHigh
            }
        }

        XCTContext.runActivity(named: "Operator * (LayoutAnchorTarget, CGFloat)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = LayoutAnchorTarget(view.heightAnchor, constant: 300, multiplier: 0.3, priority: .defaultHigh) * 0.5
                expect(target.anchor) == view.heightAnchor
                expect(target.constant) == 300
                expect(target.multiplier) == 0.5
                expect(target.priority) == .defaultHigh
            }
        }

        XCTContext.runActivity(named: "Operator ~ (LayoutAnchorTarget, LayoutPriority)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = LayoutAnchorTarget(view.heightAnchor, constant: 300, multiplier: 0.3, priority: .defaultHigh) ~ .required
                expect(target.anchor) == view.heightAnchor
                expect(target.constant) == 300
                expect(target.multiplier) == 0.3
                expect(target.priority) == .required
            }
        }

        XCTContext.runActivity(named: "Operator ~ (LayoutAnchorTarget, CGFloat)") { _ in
            XCTContext.runActivity(named: "returns LayoutAnchorTarget") { _ in
                let target = LayoutAnchorTarget(view.heightAnchor, constant: 300, multiplier: 0.3, priority: .defaultHigh) ~ 250
                expect(target.anchor) == view.heightAnchor
                expect(target.constant) == 300
                expect(target.multiplier) == 0.3
                expect(target.priority) == .init(250)
            }
        }
    }
}
