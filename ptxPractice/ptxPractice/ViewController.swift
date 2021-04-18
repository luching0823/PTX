//
//  ViewController.swift
//  ptxPractice
//
//  Created by 廖昱晴 on 2021/4/14.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var searchDateBtn: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var startingStationBtn: UIButton!
    @IBOutlet weak var startingStationLabel: UILabel!
    @IBOutlet weak var endingStationBtn: UIButton!
    @IBOutlet weak var endingStationLabel: UILabel!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var pressBtn: UIButton?
    var chooseStation: String?
    var chooseDate: Date?
    var start: Int?
    var end: Int?
    let pickerView = UIPickerView()
    let toolBar = UIToolbar()
    let station = [Station(stationName: "南港", stationNum: 1), Station(stationName: "臺北", stationNum: 2), Station(stationName: "板橋", stationNum: 3), Station(stationName: "桃園", stationNum: 4), Station(stationName: "新竹", stationNum: 5), Station(stationName: "苗栗", stationNum: 6), Station(stationName: "台中", stationNum: 7), Station(stationName: "彰化", stationNum: 8), Station(stationName: "雲林", stationNum: 9), Station(stationName: "嘉義", stationNum: 10), Station(stationName: "台南", stationNum: 11), Station(stationName: "左營", stationNum: 12)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateView.isHidden = true
        datePicker.isHidden = true
        datePicker.minimumDate = Date()
        
    }
    @IBAction func chooseDate(_ sender: UIButton) {
        pressBtn = searchDateBtn
        dateView.isHidden = false
        datePicker.isHidden = false
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        initToolBar()
//        initDatePicker()
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
            dateView.isHidden = true
            datePicker.isHidden = true
        } else {
            pickerView.removeFromSuperview()
        }
        
        toolBar.removeFromSuperview()
    }
    
    @objc func done() {
        if pressBtn == searchDateBtn {
            dateView.isHidden = true
            datePicker.isHidden = true
//            dateChanged()
        } else {
            pickerView.removeFromSuperview()
        }
        
        toolBar.removeFromSuperview()
    }
    
    @objc func dateChanged() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
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
            print("start: \(start!)")
        }
        if pressBtn?.tag == 2 {
            endingStationLabel.text = chooseStation
            end = station[row].stationNum
            print("end: \(end!)")
        }
    }
}

