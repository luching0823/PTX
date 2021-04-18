//
//  Train.swift
//  ptxPractice
//
//  Created by 廖昱晴 on 2021/4/16.
//

import Foundation

struct Train {
    
    var TrainDate: String // 時刻表日期 yyyy-MM-dd
    var StationID: String // 車站代號
    var TrainNo: String // 車次代號
    var Direction: Int // 0:南下 1:北上
    var StartingStationID: String // 起點車站代號
    var StartingStationName: String // 起點車站名稱
    var EndingStationID: String // 終點車站代號
    var EndingStationName: String // 終點車站代名稱
    var ArrivalTime: String // 到站時間 HH:mm:ss
    var DepartureTime: String // 離站時間 HH:mm:ss
    var UpdateTime: Date // 更新時間 yyyy-MM-ddTHH:mm:sszzz
    
}
