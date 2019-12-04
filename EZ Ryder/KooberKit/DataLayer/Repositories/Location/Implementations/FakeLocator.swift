import Foundation
import PromiseKit

public class FakeLocator: Locator {

  // MARK: - Methods
  public init() {}

  public func getUsersCurrentLocation() -> Promise<Location> {
    return Promise { seal in
      DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 2) {
        let location = Location(id: "0", latitude: 10.828056, longitude: 72.178889)
        seal.fulfill(location)
      }
    }
  }
}
