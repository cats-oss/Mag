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

Comparison operators return `NSLayoutConstraint` which has already activated. If target anchors are composite anchors, returns multiple `NSLayoutConstraint`. (e.g. `[NSLayoutConstraint]`)

```swift
let constraint = redView.leadingAnchor == view.leadingAnchor
// returns NSLayoutConstraint
constraint.isActive = false

let constraints = redView.centerAnchor == view.centerAnchor
// returns [NSLayoutConstraint]
NSLayoutConstraint.deactivate(constraints)
```

If `firstItem` in `NSLayoutConstraint` is `UIView` (or `NSView`), `translatesAutoresizingMaskIntoConstraints` is set to `false`.

## LICENSE
Under the MIT license. See LICENSE file for details.