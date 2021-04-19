//
//  ptxApi.swift
//  ptxPractice
//
//  Created by 廖昱晴 on 2021/4/18.
//

import Foundation
import CryptoKit

class ptxApi {
    private let appID = "6646e635766e4fdf971180287223a56a"
    private let appKey = "PlIpLS4OzFinQAMjZ6clXwiR1_E"


    private var signDate: String {
        get {
            return "x-date: \(xdate)"
        }
    }
    
    private var key: SymmetricKey {
        get {
            return SymmetricKey(data: Data(appKey.utf8))
        }
    }
    
    private var hmac: HMAC<SHA256>.MAC {
        get {
            return hmacToData()
        }
    }
    
    private var base64HmacString: String {
        get {
            return Data(hmac).base64EncodedString()
        }
    }
    
    public var xdate : String {
        get {
            return getTimeString()
        }
    }
    
    public var authorization: String {
        get {
            return """
    hmac username="\(appID)", algorithm="hmac-sha256", headers="x-date", signature="\(base64HmacString)"
    """
        }
    }

    public let url = URL(string: "https://ptx.transportdata.tw/MOTC/v2/Rail/THSR/DailyTimetable/Today?$top=30&$format=JSON")!

    func getTimeString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ww zzz"
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        let time = dateFormatter.string(from: Date())
        
        return time
    }
    func hmacToData() -> HMAC<SHA256>.MAC {
        let hmac = HMAC<SHA256>.authenticationCode(for: Data(signDate.utf8), using: key)
        return hmac
    }
}

