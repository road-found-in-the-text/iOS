//
//  UIViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 신태원 on 2023/01/07.
//

import UIKit

extension UIViewController {
    // MARK: 빈 화면을 눌렀을 때 키보드가 내려가도록 처리
    func dismissKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
//        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    // MARK: 취소와 확인이 뜨는 UIAlertController
    func presentAlert(title: String, message: String? = nil,
                      isCancelActionIncluded: Bool = false,
                      preferredStyle style: UIAlertController.Style = .alert,
                      handler: ((UIAlertAction) -> Void)? = nil) {
        self.dismissIndicator()
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let actionDone = UIAlertAction(title: "확인", style: .default, handler: handler)
        alert.addAction(actionDone)
        if isCancelActionIncluded {
            let actionCancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(actionCancel)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: 커스텀 UIAction이 뜨는 UIAlertController
    func presentAlert(title: String, message: String? = nil,
                      isCancelActionIncluded: Bool = false,
                      preferredStyle style: UIAlertController.Style = .alert,
                      with actions: UIAlertAction ...) {
        self.dismissIndicator()
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach { alert.addAction($0) }
        if isCancelActionIncluded {
            let actionCancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(actionCancel)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: UIWindow의 rootViewController를 변경하여 화면전환
    func changeRootViewController(_ viewControllerToPresent: UIViewController) {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = viewControllerToPresent
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        } else {
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            self.present(viewControllerToPresent, animated: true, completion: nil)
        }
    }
    
    // MARK: 커스텀 하단 경고창
    func presentBottomAlert(message: String, target: NSLayoutYAxisAnchor? = nil, offset: Double? = -12) {
        view.subviews
            .filter { $0.tag == 936419836287461 }
            .forEach { $0.removeFromSuperview() }
        
        let alertSuperview = UIView()
        alertSuperview.tag = 936419836287461
        alertSuperview.backgroundColor = UIColor.white
        //UIColor(hex: 0x3C6CB7)
        alertSuperview.layer.cornerRadius = 10
        alertSuperview.isHidden = true
        alertSuperview.translatesAutoresizingMaskIntoConstraints = false
    
        let alertLabel = UILabel()
        alertLabel.font = .NotoSans(.regular, size: 15)
        alertLabel.textColor = .black
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(alertSuperview)
        alertSuperview.bottomAnchor.constraint(equalTo: target ?? view.safeAreaLayoutGuide.bottomAnchor, constant: -12).isActive = true
        alertSuperview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertSuperview.addSubview(alertLabel)
        alertLabel.topAnchor.constraint(equalTo: alertSuperview.topAnchor, constant: 3).isActive = true
        alertLabel.bottomAnchor.constraint(equalTo: alertSuperview.bottomAnchor, constant: -3).isActive = true
        alertLabel.leadingAnchor.constraint(equalTo: alertSuperview.leadingAnchor, constant: 10).isActive = true
        alertLabel.trailingAnchor.constraint(equalTo: alertSuperview.trailingAnchor, constant: -10).isActive = true
        
        alertLabel.text = message
        alertSuperview.alpha = 1.0
        alertSuperview.isHidden = false
        UIView.animate(
            withDuration: 2.0,
            delay: 1.0,
            options: .curveEaseIn,
            animations: { alertSuperview.alpha = 0 },
            completion: { _ in
                alertSuperview.removeFromSuperview()
            }
        )
    }
    
    // MARK: 커스텀 중간 경고창
    func presentCenterAlert(message: String, target: NSLayoutYAxisAnchor? = nil, offset: Double? = -12) {
        view.subviews
            .filter { $0.tag == 936419836287461 }
            .forEach { $0.removeFromSuperview() }
        
        let alertSuperview = UIView()
        alertSuperview.tag = 936419836287461
        alertSuperview.backgroundColor = UIColor.white
        //UIColor(hex: 0x3C6CB7)
        alertSuperview.layer.cornerRadius = 10
        alertSuperview.isHidden = true
        alertSuperview.translatesAutoresizingMaskIntoConstraints = false
    
        let alertLabel = UILabel()
        alertLabel.font = UIFont(name: "IBMPlexSansKR-Medium", size: 12)
        alertLabel.textColor = UIColor(hex: 0xEB5757)
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(alertSuperview)
        alertSuperview.bottomAnchor.constraint(equalTo: target ?? view.safeAreaLayoutGuide.bottomAnchor, constant: -437).isActive = true
        alertSuperview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertSuperview.addSubview(alertLabel)
        alertLabel.topAnchor.constraint(equalTo: alertSuperview.topAnchor, constant: 3).isActive = true
        alertLabel.bottomAnchor.constraint(equalTo: alertSuperview.bottomAnchor, constant: -3).isActive = true
        alertLabel.leadingAnchor.constraint(equalTo: alertSuperview.leadingAnchor, constant: 10).isActive = true
        alertLabel.trailingAnchor.constraint(equalTo: alertSuperview.trailingAnchor, constant: -10).isActive = true
        
        alertLabel.text = message
        alertSuperview.alpha = 1.0
        alertSuperview.isHidden = false
        UIView.animate(
            withDuration: 2.0,
            delay: 1.0,
            options: .curveEaseIn,
            animations: { alertSuperview.alpha = 0 },
            completion: { _ in
                alertSuperview.removeFromSuperview()
            }
        )
    }
    
    // MARK: 커스텀 중간 경고창
    func presentCenterLeftAlert(message: String, target: NSLayoutYAxisAnchor? = nil, offset: Double? = -12, height: Double) {
        view.subviews
            .filter { $0.tag == 936419836287461 }
            .forEach { $0.removeFromSuperview() }
        
        let alertSuperview = UIView()
        alertSuperview.tag = 936419836287461
        alertSuperview.backgroundColor = UIColor.white
        //UIColor(hex: 0x3C6CB7)
        alertSuperview.layer.cornerRadius = 10
        alertSuperview.isHidden = true
        alertSuperview.translatesAutoresizingMaskIntoConstraints = false
    
        let alertLabel = UILabel()
        alertLabel.font = UIFont(name: "IBMPlexSansKR-Medium", size: 12)
        alertLabel.textColor = UIColor(hex: 0xEB5757)
        alertLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(alertSuperview)
        alertSuperview.bottomAnchor.constraint(equalTo: target ?? view.safeAreaLayoutGuide.bottomAnchor, constant: height).isActive = true
        alertSuperview.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        //centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alertSuperview.addSubview(alertLabel)
        alertLabel.topAnchor.constraint(equalTo: alertSuperview.topAnchor, constant: -5).isActive = true
        alertLabel.bottomAnchor.constraint(equalTo: alertSuperview.bottomAnchor, constant: -3).isActive = true
        alertLabel.leadingAnchor.constraint(equalTo: alertSuperview.leadingAnchor, constant: 10).isActive = true
        alertLabel.trailingAnchor.constraint(equalTo: alertSuperview.trailingAnchor, constant: -10).isActive = true
        
        alertLabel.text = message
        alertSuperview.alpha = 1.0
        alertSuperview.isHidden = false
        UIView.animate(
            withDuration: 2.0,
            delay: 1.0,
            options: .curveEaseIn,
            animations: { alertSuperview.alpha = 0 },
            completion: { _ in
                alertSuperview.removeFromSuperview()
            }
        )
    }
    
    // MARK: 인디케이터 표시
    func showIndicator() {
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
    }
    
    // MARK: 인디케이터 숨김
    @objc func dismissIndicator() {
        IndicatorView.shared.dismiss()
    }
    
    // MARK: - 우측에서 좌측으로 슬라이드되며 self.dismiss
    
    func disMissLeftToRight() {
        let transition = CATransition()
        transition.duration = 0.4
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
}
