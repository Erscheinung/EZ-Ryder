
import Foundation
import PromiseKit

public class FakeNewRideRemoteAPI: NewRideRemoteAPI {

  // MARK: - Methods
  public init() {}

  public func getRideOptions(pickupLocation: Location) -> Promise<[RideOption]> {
    let ri1 = RemoteImage(rideOptionName: "wallabee", selected: true)
    let ri2 = RemoteImage(rideOptionName: "wallabee", selected: false)
    let ri3 = RemoteImage(rideOptionName: "wallabe")
    let ro1 = RideOption(id: "A1EE7F09-4F87-4CA7-99D4-AD95226E08A4",
                         name: "EZFlow",
                         buttonRemoteImages: (selected:ri1, unselected: ri2),
                         availableMapMarkerRemoteImage: ri3)

//    let ri4 = RemoteImage(rideOptionName: "wallaroo", selected: true)
//    let ri5 = RemoteImage(rideOptionName: "wallaroo", selected: false)
//    let ri6 = RemoteImage(rideOptionName: "wallaroo")
//    let ro2 = RideOption(id: "ADAB619B-9CBB-4894-8AE3-C24028ECDF2A",
//                         name: "Wallaroo",
//                         buttonRemoteImages: (selected:ri4, unselected: ri5),
//                         availableMapMarkerRemoteImage: ri6)
//
//    let ri7 = RemoteImage(rideOptionName: "kangaroo", selected: true)
//    let ri8 = RemoteImage(rideOptionName: "kangaroo", selected: false)
//    let ri9 = RemoteImage(rideOptionName: "kangaroo")
//    let ro3 = RideOption(id: "47CD8F12-8FC5-4029-A82F-40CD2884F897",
//                         name: "Kangaroo",
//                         buttonRemoteImages: (selected:ri7, unselected: ri8),
//                         availableMapMarkerRemoteImage: ri9)

    return .value([ro1])
  }

  public func post(newRideRequest: NewRideRequest) -> Promise<()> {
    return Promise<Void> { seal in
      DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 3) {
        seal.fulfill(())
      }
    }
  }

  public func getLocationSearchResults(query: String, pickupLocation: Location) -> Promise<[NamedLocation]> {
    return Promise<[NamedLocation]> { seal in
      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
        if query.isEmpty {
          seal.fulfill(fakeLocationDataSet)
          return
        }
        let results = fakeLocationDataSet.filter{ location in
          return location.name.range(of: query, options: .caseInsensitive) != nil
        }
        seal.fulfill(results)
      }
    }
  }
}

extension RemoteImage {

  init(rideOptionName: String, selected: Bool) {
    self.init(at1xURL: URL(rideOptionName: rideOptionName, selected: selected, scale: ""),
              at2xURL: URL(rideOptionName: rideOptionName, selected: selected, scale: "@2x"),
              at3xURL: URL(rideOptionName: rideOptionName, selected: selected, scale: "@3x"))
  }

  init(rideOptionName: String) {
    self.init(at1xURL: URL(rideOptionName: rideOptionName, scale: ""),
              at2xURL: URL(rideOptionName: rideOptionName, scale: "@2x"),
              at3xURL: URL(rideOptionName: rideOptionName, scale: "@3x"))
  }
}

extension URL {
  
  init(rideOptionName: String, selected: Bool, scale: String) {
    self.init(string: "http://0.0.0.0:8080/images/ride_option_\(rideOptionName)\(selected ? "_selected" : "")\(scale).png")!
  }

  init(rideOptionName: String, scale: String) {
    self.init(string: "http://0.0.0.0:8080/images/available_\(rideOptionName)_marker\(scale).png")!
  }
}


fileprivate let fakeLocationDataSet =
  [NamedLocation(name: "Sri Aurobindo Ashram",
                 location: Location(id: "1",
                                    latitude: 11.9368,
                                    longitude: 79.8343)),
   NamedLocation(name: "Bharathi Park",
                 location: Location(id: "2",
                                    latitude: 11.9330,
                                    longitude: 79.8342)),
   NamedLocation(name: "Promenade Beach",
                 location: Location(id: "3",
                                    latitude: 11.9313,
                                    longitude: 79.8358)),
   NamedLocation(name: "Immaculate Conception Cathedral",
                 location: Location(id: "4",
                                    latitude: 11.9331,
                                    longitude: 79.8301)),
   NamedLocation(name: "Basillca of the Sacred Heart of Jesus",
                 location: Location(id: "5",
                                    latitude: 26.825670,
                                    longitude: 75.798248)),
   NamedLocation(name: "Botanical Garden",
                 location: Location(id: "6",
                                    latitude: 11.95095,
                                    longitude: 79.8238)),
   NamedLocation(name: "Arikamendu",
                 location: Location(id: "6",
                                    latitude: 11.902397,
                                    longitude: 79.819954)),
   NamedLocation(name: "French War Memorial",
                 location: Location(id: "6",
                                    latitude: 11.9319,
                                    longitude: 79.8354)),
   NamedLocation(name: "Chidambaram Temple",
                 location: Location(id: "6",
                                    latitude: 11.4069,
                                    longitude: 79.6911)),
   NamedLocation(name: "Pondicherry Museum",
                 location: Location(id: "6",
                                    latitude: 11.9344,
                                    longitude: 79.8349))
   




]
