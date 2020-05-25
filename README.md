# 🧲 Mag

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Build Status](https://travis-ci.org/cats-oss/Mag.svg?branch=master)](https://travis-ci.org/cats-oss/Mag)
[![codecov](https://codecov.io/gh/cats-oss/Mag/branch/master/graph/badge.svg)](https://codecov.io/gh/cats-oss/Mag)
[![Version](https://img.shields.io/cocoapods/v/Mag.svg?style=flat)](http://cocoadocs.org/docsets/Mag)
[![License](https://img.shields.io/cocoapods/l/Mag.svg?style=flat)](http://cocoadocs.org/docsets/Mag)
[![Platform](https://img.shields.io/cocoapods/p/Mag.svg?style=flat)](http://cocoadocs.org/docsets/Mag)

Mag is Framework which wraps `NSLayoutAnchor`.

## Installation

#### CocoaPods

Add the following to your `Podfile`:

```Ruby
pod "Mag"
```

#### Carthage

Add the following to your `Cartfile`:

```Ruby
github "cats-oss/Mag"
```

## Example

```swift
let redView = UIView(frame: .zero)
redView.backgroundColor = .red
view.addSubview(redView)
redView.sizeAnchor == CGSize(width: 100, height: 100)
redView.leadingAnchor == view.leadingAnchor + 100
redView.topAnchor == (view.bottomAnchor - 100) * 0.5 ~ 999

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
```

<img alt="Example" src="https://user-images.githubusercontent.com/5707132/72708416-ff793e80-3ba5-11ea-88f3-541ba1a5005a.png" width="414">

## Usage

### Alignment

```swift
redView.leadingAnchor == view.leadingAnchor + 10
// redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)

redView.topAnchor >= view.bottomAnchor
// redView.topAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: 0)

redView.centerYAnchor <= view.centerYAnchor - 20
// redView.centerYAnchor.constraint(lessThanOrEqualTo: view.centerYAnchor, constant: -20)

blueView.centerAnchor == redView.centerAnchor + CGPoint(x: 100, y: -100)
// blueView.centerXAnchor.constraint(equalTo: redView.centerXAnchor, constant: 100)
// blueView.centerYAnchor.constraint(equalTo: redView.centerYAnchor, constant: -100)

label.edgeAnchor == redView.edgeAnchor + UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
// label.topAnchor.constraint(equalTo: redView.topAnchor, constant: 5),
// label.bottomAnchor.constraint(equalTo: redView.bottomAnchor, constant: -5)
// label.leadingAnchor.constraint(equalTo: redView.leadingAnchor, constant: 10)
// label.trailingAnchor.constraint(equalTo: redView.trailingAnchor, constant: -10)

redView.topAnchor == view.bottomAnchor * 0.5
// redView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
// multiplying 0.5
```

### Size

```swift
redView.widthAnchor == 100
// redView.widthAnchor.constraint(equalToConstant: 100)

redView.heightAnchor >= 200
// redView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200)

redView.widthAnchor <= 200
// redView.widthAnchor.constraint(lessThanOrEqualToConstant: 200)

redView.sizeAnchor == CGSize(width: 100, height: 200)
// redView.widthAnchor.constraint(equalToConstant: 100)
// redView.heightAnchor.constraint(equalToConstant: 200)

blueView.sizeAnchor <= redView.sizeAnchor + CGSize(width: 20, height: 0)
// blueView.widthAnchor.constraint(lessThanOrEqualTo: redView.widthAnchor, constant: 20)
// blueView.heightAnchor.constraint(lessThanOrEqualTo: redView.heightAnchor, constant: 0)

redView.sizeAnchor == view.sizeAnchor * 0.5
// redView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5, constant: 0)
// redView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5, constant: 0)
```

### Priority

```swift
redView.topAnchor == view.topAnchor ~ .defaultHigh
// constraint.priority = .defaultHigh

redView.centerAnchor == view.centerAnchor ~ 900
// constraint.priority = UILayoutPriority(Float(900)) (or NSLayoutConstraint.Priority)
```

### Constraints

Comparison operators return `NSLayoutConstraint`.

```swift
let constraint = redView.leadingAnchor == view.leadingAnchor
// returns NSLayoutConstraint
constraint.isActive = true
```

If target anchors are composite anchors, returns multiple `NSLayoutConstraint`. (e.g. `[NSLayoutConstraint]`)

```swift
let constraints = redView.centerAnchor == view.centerAnchor
// returns [NSLayoutConstraint]
NSLayoutConstraint.activate(constraints)
```

If `firstItem` in `NSLayoutConstraint` is `UIView` (or `NSView`), `translatesAutoresizingMaskIntoConstraints` is set to `false`.

### Activation

Comparison operators return `NSLayoutConstraint` which has never activated.

If the constraint deinits without being activated, it activates automatically.

```swift
_ = redView.leadingAnchor == view.leadingAnchor
// NSLayoutConstraint activates automatically
```

If you want to activate manually, set `true` to `isActivate` or executes activate methods.

#### Singular Constraint

```swift
var constraint: NSLayoutConstraint? {
    didSet {
        oldValue?.isActivate = false
        constraint?.isActivate = true
    }
}

constraint = redView.leadingAnchor == view.leadingAnchor
```

#### Multiple Constraints

`Mag` extends `NSLayoutConstraint` deactivate and activate method.

```swift
var constraints: [NSLayoutConstraint] = [] {
    didSet {
        NSLayoutConstraint.deactivate(oldValue, beforeActivate: constraints)
    }
}

constraints = redView.centerAnchor == view.centerAnchor
```

The following process is the same.

```swift
var constraints: [NSLayoutConstraint] = []
constraints.replaceActivatedConstraints(redView.centerAnchor == view.centerAnchor)
```

## LICENSE
Under the MIT license. See LICENSE file for details.
