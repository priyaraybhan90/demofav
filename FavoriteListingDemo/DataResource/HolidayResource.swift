//
//  HolidayResource.swift
//  FavoriteListingDemo
//
//  Created by Admin on 25/02/22.
//

import Foundation
import Combine

class HolidayResource
{
    private var cancellables = Set<AnyCancellable>()
    @Published var details : Holidays?
    
    let pub : AnyCancellable = Timer.publish(every: 0.5, tolerance: 1.0, on: .main, in: .common, options: .none)
        .autoconnect()
        .sink { completion in
            switch completion
            {
            case .finished:
                print("success")
            case .failure(let error) :
                print(error.localizedDescription)
            }
        } receiveValue: { (timestamp) in
            print("\(timestamp)")
        }
    DispatchQueue.main.async(
    pub.cancel()
    
    func holidayRequest(completion : @escaping(_ result : Holidays?)-> Void)
    {
        guard let holidayUrl = URL(string: ApiEndpoints.holidaySpotAPI) else { return }
        let httpUitility = HttpUtility()
        httpUitility.getApiData(requestUrl: holidayUrl, resultType: Holidays.self)
            .sink { _ in
                
            } receiveValue: { holidayDetails in
                self.details = holidayDetails.first
                
                _ = completion(self.details)
            }
            .store(in: &cancellables)
//
//        httpUitility.getApiData(requestUrl: holidayUrl, resultType: Holidays.self) { result in
//             _ = completion(result)
//            }
      
    }
}
