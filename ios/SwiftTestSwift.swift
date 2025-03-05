import Foundation

@objc(SwiftTestSwift)
public class SwiftTestSwift: NSObject {
  @objc
  public static func multiply(_ a: Double, b: Double) -> NSNumber {
    return NSNumber(value: a * b)
  }
}
