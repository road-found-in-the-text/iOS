//
//  ScriptBottomSheetViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/18.
//

import UIKit

protocol ScriptBottomSheetDelegate: AnyObject {
    func practiceStartButtonTapped(practiceTime: Int)
}

class ScriptBottomSheetViewController: UIViewController {
    
    var delegate: ScriptBottomSheetDelegate?
    
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var practiceStartButton: UIButton!
    
    let minute = [Int](0...59).map{ String($0) }
    let second = [Int](0...59).map{ String($0) }
    
    var selectedTime = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "목표시간 설정"
        practiceStartButton.layer.cornerRadius = 8
        
        addPickerViewLabel()
    }
    
    func addPickerViewLabel() {
        let font = UIFont.systemFont(ofSize: 16)
        let fontSize: CGFloat = font.pointSize
        let componentWidth: CGFloat = self.view.frame.width / CGFloat(pickerView.numberOfComponents)
        let y = (pickerView.frame.height / 2) - (fontSize / 2)

        let minuteLabel = UILabel(frame: CGRect(x: componentWidth * 0.53, y: y, width: componentWidth * 0.4, height: fontSize))
        minuteLabel.font = font
        minuteLabel.textAlignment = .left
        minuteLabel.text = "분"
        minuteLabel.textColor = .black
        pickerView.addSubview(minuteLabel)
        
        let secondLabel = UILabel(frame: CGRect(x: componentWidth * 1.34, y: y, width: componentWidth * 0.4, height: fontSize))
        secondLabel.font = font
        secondLabel.textAlignment = .left
        secondLabel.text = "초"
        secondLabel.textColor = .black
        pickerView.addSubview(secondLabel)
    }
    
    @IBAction func practiceStartButtonTapped(_ sender: UIButton) {
        let minute = pickerView.selectedRow(inComponent: 0)
        let second = pickerView.selectedRow(inComponent: 1)
        let practiceTime = minute * 60 + second
        
        delegate?.practiceStartButtonTapped(practiceTime: practiceTime)
    }

}

// MARK: - UIPickerView
extension ScriptBottomSheetViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return minute.count
        } else {
            return second.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if component == 0 {
            return minute[row]
        } else {
            return second[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return pickerView.frame.height / 3
    }
    
    
}
