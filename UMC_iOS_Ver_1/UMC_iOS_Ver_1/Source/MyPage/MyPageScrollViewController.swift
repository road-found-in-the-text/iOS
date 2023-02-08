//
//  MyPageScrollViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/30.
//

import UIKit

import HPParallaxHeader

class MyPageScrollViewController: HPScrollViewController {
    
    @IBOutlet var profileView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        headerView = profileView
        headerHeight = 180 + (navigationController?.navigationBar.frame.height ?? 40)
        
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        self.navigationItem.backButtonTitle = ""
        
        let notificationBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_bell"), style: .plain, target: self, action: #selector(notificationBarButtonItemTapped))
        let settingBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_settings"), style: .plain, target: self, action: #selector(settingBarButtonItemTapped))
        
        notificationBarButtonItem.tintColor = UIColor(named: "Main")
        settingBarButtonItem.tintColor = UIColor(named: "Main")
        
        self.navigationItem.rightBarButtonItems = [settingBarButtonItem, notificationBarButtonItem]
    }
    
    @objc func notificationBarButtonItemTapped() {
        guard let nextViewController = storyboard?.instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController else {
            return
        }
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc func settingBarButtonItemTapped() {
        let storyboard = UIStoryboard(name: "Setting", bundle: nil)
        guard let nextViewController = storyboard.instantiateViewController(withIdentifier: "SettingViewController") as? SettingViewController else {
            assert(false)
        }
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }

}
