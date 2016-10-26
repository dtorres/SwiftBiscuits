import UIKit

@objc protocol OptionalText {
    @objc var text: String? { get set }
}

extension OptionalText {
    var isEmpty: Bool {
        if let text = self.text {
            return text.isEmpty
        }
        return true
    }
}

extension UILabel: OptionalText {}
extension UITextField: OptionalText {}

