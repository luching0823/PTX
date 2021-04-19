//
//  TableViewVC.swift
//  ptxPractice
//
//  Created by 廖昱晴 on 2021/4/18.
//

import Foundation
import Alamofire

class TableViewVC: UIViewController{
    //, UITableViewDelegate, UITableViewDataSource 
    
    var start: String?
    var end: String?
    var date: String?
    let xdate = ptxApi().xdate
    let authorization = ptxApi().authorization
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "https://ptx.transportdata.tw/MOTC/v2/Rail/THSR/DailyTimetable/OD/\(start!)/to/\(end!)/\(date!)?$format=JSON"
        print(url)
        let headers = ["x-date": xdate,
                       "Authorization": authorization ]
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            if response.result.isSuccess {
                if let result = response.result.value as? [AnyObject] {
                    print(result)
                    
                    }
                    
                }
            }
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
}
