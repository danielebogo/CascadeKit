import Foundation


/// Attribute struct to decorate an attribute string
public struct Attribute {
    public var key: NSAttributedStringKey
    public var value: Any
    public var range: CountableClosedRange<Int>
}
