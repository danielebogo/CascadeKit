import Foundation


public extension NSMutableAttributedString {
    typealias FallBackHandler = (Fallback) -> [Attribute]
    /// Modify the attribute handling the Fallback attributes
    ///
    /// - Parameters:
    ///   - alphabets: A collection of Alphabet
    ///   - block: Returns the Attributes for the current fallback

    /// - Returns: A mutable attribute string
    @discardableResult
    public func addAttributes(for alphabets: [Alphabet], _ block: @escaping FallBackHandler) -> NSMutableAttributedString {
        string.mapCascade(for: alphabets) { [weak self] (fallback) in
            let attributes = block(fallback)

            attributes.forEach {
                self?.addAttribute($0.key, value: $0.value, range: $0.range)
            }
        }

        return self
    }

    /// Add an attribute to a NSMutableAttributedString passing a CountableClosedRange<Int>
    ///
    /// - Parameters:
    ///   - name: NSAttributedStringKey key value
    ///   - value: A value for the attribute
    ///   - range: A valid CountableClosedRange<Int>
    public func addAttribute(_ name: NSAttributedStringKey, value: Any, range: CountableClosedRange<Int>) {
        guard let start = Array(range).first, let last = Array(range).last else {
            return
        }

        addAttribute(name, value: value, range: NSRange(location: start, length: last - start + 1))
    }
}
