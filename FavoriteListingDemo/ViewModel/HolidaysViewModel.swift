//
//  HolidaysViewModel.swift
//  FavoriteListingDemo
//
//  Created by Admin on 23/02/22.
//

import Foundation

protocol HolidaysViewModelDelegate
{
    func didReceiveHoldaysResponse(holidaysData: Holidays?)
}

class HolidaysViewModel
{
    static let sharedInstance = HolidaysViewModel()
    var delegate : HolidaysViewModelDelegate?
    
    func fetchHolidaysDataFromServer()
    {
        let holidayResource = HolidayResource()
        
        holidayResource.holidayRequest { result in
            
            self.delegate?.didReceiveHoldaysResponse(holidaysData: holidayResource.details)

        }
        
    }
}
