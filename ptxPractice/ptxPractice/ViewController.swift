//
//  ViewController.swift
//  ptxPractice
//
//  Created by 廖昱晴 on 2021/4/14.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var searchDateBtn: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var startingStationBtn: UIButton!
    @IBOutlet weak var startingStationLabel: UILabel!
    @IBOutlet weak var endingStationBtn: UIButton!
    @IBOutlet weak var endingStationLabel: UILabel!
    
    var pressBtn: UIButton?
    var chooseStation: String?
    var chooseDate: String = "2021-04-18"
    var start: String = "0990"
    var end: String = "1070"
    let datePicker = UIDatePicker()
    let dateFormatter = DateFormatter()
    let pickerView = UIPickerView()
    let toolBar = UIToolbar()
    let station = [Station(stationName: "南港", stationNum: "0990"), Station(stationName: "臺北", stationNum: "1000"), Station(stationName: "板橋", stationNum: "1010"), Station(stationName: "桃園", stationNum: "1020"), Station(stationName: "新竹", stationNum: "1030"), Station(stationName: "苗栗", stationNum: "1035"), Station(stationName: "台中", stationNum: "1040"), Station(stationName: "彰化", stationNum: "1043"), Station(stationName: "雲林", stationNum: "1047"), Station(stationName: "嘉義", stationNum: "1050"), Station(stationName: "台南", stationNum: "1060"), Station(stationName: "左營", stationNum: "1070")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.backgroundColor = .white
        datePicker.setValue(UIColor(named: "PickerText"), forKey: "textColor")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResult" {
            let vc = segue.destination as! TableViewVC
            vc.start = start
            vc.end = end
            vc.date = chooseDate
        }
    }
    
    @IBAction func chooseDate(_ sender: UIButton) {
        pressBtn = searchDateBtn
        initDatePickerView()
    }
    
    @IBAction func chooseStartingStation(_ sender: UIButton) {
        pressBtn = startingStationBtn
        initPickerView()
    }
    
    @IBAction func chooseEndingStation(_ sender: UIButton) {
        pressBtn = endingStationBtn
        initPickerView()
    }
    
    @IBAction func goToSearch(_ sender: UIButton) {
        performSegue(withIdentifier: "showResult", sender: nil)
    }
    
    func initDatePickerView() {
        // 初始化datePickerView
        datePicker.backgroundColor = .white
        datePicker.autoresizingMask = .flexibleWidth
        datePicker.datePickerMode = .date
        datePicker.setValue(UIColor.black, forKey: "textColor")
        datePicker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(
            identifier: "zh_TW")
        datePicker.minimumDate = Date()
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        self.view.addSubview(datePicker)
        initToolBar()
    }

    func initPickerView() {
        // 初始化pickerView
        pickerView.backgroundColor = .white
        pickerView.autoresizingMask = .flexibleWidth
        pickerView.contentMode = .center
        pickerView.setValue(UIColor.black, forKey: "textColor")
        pickerView.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        pickerView.delegate = self
        pickerView.dataSource = self
        self.view.addSubview(pickerView)
        initToolBar()
        
    }
    
    func initToolBar() {
        // 初始化toolBar
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = .systemBlue
        toolBar.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50)
        toolBar.sizeToFit()
        // 加入左側取消按鈕
        let cancelBtn = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(cancel))
        let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(title: "確認", style: .plain, target: self, action: #selector(done))
        // 將確認按鈕tag設為pickerView的tag，決定顯示內容
        if let pressBtn = pressBtn {
            doneBtn.tag = pressBtn.tag
        }
        toolBar.setItems([cancelBtn, space, doneBtn], animated: false)
        // 設定toolBar可使用
        toolBar.isUserInteractionEnabled = true
        self.view.addSubview(toolBar)
    }
    
    @objc func cancel() {
        if pressBtn == searchDateBtn {
            datePicker.removeFromSuperview()
        } else {
            pickerView.removeFromSuperview()
        }
        
        toolBar.removeFromSuperview()
    }
    
    @objc func done() {
        if pressBtn == searchDateBtn {
            datePicker.removeFromSuperview()
            dateChanged()
        } else {
            pickerView.removeFromSuperview()
        }
        
        toolBar.removeFromSuperview()
    }
    
    @objc func dateChanged() {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateLabel.text = dateFormatter.string(from: datePicker.date)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return station.count

    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return station[row].stationName
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chooseStation = station[row].stationName
        if pressBtn?.tag == 1 {
            startingStationLabel.text = chooseStation
            start = station[row].stationNum
            print("start: \(start)")
        }
        if pressBtn?.tag == 2 {
            endingStationLabel.text = chooseStation
            end = station[row].stationNum
            print("end: \(end)")
        }
    }
}

