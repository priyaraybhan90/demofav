//
//  FavoriteListingController.swift
//  FavoriteListingDemo
//
//  Created by Admin on 23/02/22.
//

import Foundation
import UIKit

class FavoriteListingController: UIViewController, UITableViewDelegate, UITableViewDataSource, HolidaysViewModelDelegate
{
   
    
   
    @IBOutlet var tableView: UITableView!
var viewModel = HolidaysViewModel()
    var arrHolidays = [Holiday]()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateTableView()
        registerTableView()
        customRightBarButton()
        getData()
        self.title = "My Favorite"
        viewModel.delegate = self
 
    }
    
    func customRightBarButton()
    {
        let infoImage = UIImage(named: "user.png")
        let imgWidth = infoImage?.size.width
        let imgHeight = infoImage?.size.height
        let button:UIButton = UIButton(frame: CGRect(x: 0,y: 0,width: imgWidth!, height: imgHeight!))
        button.setBackgroundImage(infoImage, for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    //MARK: -
    //MARK: TableView
    
    private func updateTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func registerTableView() {
        tableView.register(UINib.init(nibName: StringValues.FavoriteListingCellId, bundle: nil), forCellReuseIdentifier: StringValues.FavoriteListingCellId)
    }
    
    //MARK: -
    //MARK: fetch Favorite Listing
    
    func getData()
    {
        viewModel.fetchHolidaysDataFromServer()
    }
    

    //MARK: TableViewModelDelegate

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrHolidays.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favoriteCell = tableView.dequeueReusableCell(withIdentifier: StringValues.FavoriteListingCellId, for: indexPath) as? FavoriteListingCell
        let holiday = arrHolidays[indexPath.row]
        favoriteCell?.lblSegmentName.text = "Segment Name : " + holiday.name 
        favoriteCell?.lblPlatformName.text = "Platform Name : " + holiday.holidayDescription
        favoriteCell?.lblClusterName.text = "Cluster Name : " + holiday.country.name.rawValue
        favoriteCell?.lblSiteName.text = "Site Name : " + holiday.locations

        return favoriteCell!
    }
}
