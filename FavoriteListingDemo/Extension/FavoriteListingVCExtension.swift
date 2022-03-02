//
//  FavoriteListingVCExtension.swift
//  FavoriteListingDemo
//
//  Created by Admin on 25/02/22.
//

import Foundation
extension FavoriteListingController
{
    //MARK: HolidaysViewModelDelegate
    func didReceiveHoldaysResponse(holidaysData: Holidays?) {
        self.arrHolidays = holidaysData?.response.holidays ?? []
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
    }
}
