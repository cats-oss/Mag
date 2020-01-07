import Mag
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let redView = UIView(frame: .zero)
        redView.backgroundColor = .red
        view.addSubview(redView)
        redView.sizeAnchor == CGSize(width: 100, height: 100)
        redView.leadingAnchor == view.leadingAnchor + 100
        redView.topAnchor == view.topAnchor ~ .defaultHigh
        redView.centerAnchor == view.centerAnchor ~ 900
        redView.topAnchor == view.bottomAnchor * 0.5

        let label = UILabel(frame: .zero)
        label.text = "Example"
        label.textAlignment = .center
        redView.addSubview(label)
        label.edgeAnchor == redView.edgeAnchor

        let blueView = UIView(frame: .zero)
        blueView.backgroundColor = .blue
        view.addSubview(blueView)
        blueView.sizeAnchor == redView.sizeAnchor
        blueView.centerAnchor == redView.centerAnchor + CGPoint(x: 100, y: -100)
    }
}
