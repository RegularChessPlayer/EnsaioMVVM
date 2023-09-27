import UIKit

extension UIView {
    func addSubViews(_ subviews: UIView...) {
        subviews.forEach(addSubview(_:))
    }
}

extension UIStackView {
    public func addArrangedSubviews(_ views: UIView...) {
        views.forEach(addArrangedSubview(_:))
    }
}
