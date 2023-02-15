//
//  MyPageScrollViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/30.
//

import UIKit

import HPParallaxHeader
import Kingfisher

class MyPageScrollViewController: HPScrollViewController {
    
    @IBOutlet var profileView: MyPageProfileView!
    
    var member: MemberData?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        profileView.detailButton.addTarget(self, action: #selector(headerDetailButtonTapped), for: .touchUpInside)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(headerDetailButtonTapped)))
        
        configureNavigationBar()
        configureHeader()
        MyPageDataManager().fetchMemberData(id: 1, delegate: self)
    }
    
    func configureNavigationBar() {
        self.navigationItem.backButtonTitle = ""
        
        let notificationBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_bell"), style: .plain, target: self, action: #selector(notificationBarButtonItemTapped))
        let settingBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_settings"), style: .plain, target: self, action: #selector(settingBarButtonItemTapped))
        
        notificationBarButtonItem.tintColor = UIColor(named: "Main")
        settingBarButtonItem.tintColor = UIColor(named: "Main")
        
        self.navigationItem.rightBarButtonItems = [settingBarButtonItem, notificationBarButtonItem]
    }
    
    func configureHeader() {
        headerView = profileView
        headerHeight = 140 + (navigationController?.navigationBar.frame.height ?? 40)
    }
    
    func setHeaderData() {
        guard let member = member else {
            assert(false)
        }
        profileView.nicknameLabel.text = member.nickName ?? "닉네임"
        profileView.emailLabel.text = member.email
        profileView.rankImageView.image = UIImage(named: "Rank \(member.tier.capitalized)")
        profileView.bioLabel.text = member.introduction ?? ""
        profileView.bioLabel.sizeToFit()
        
        if let profileImageUrl = member.imageUrl {
            let url = URL(string: profileImageUrl)
            profileView.profileImageView.kf.setImage(with: url)
        }

        headerHeight = 140 + profileView.bioLabel.frame.height + (navigationController?.navigationBar.frame.height ?? 40)
    }
    
    // MARK: - Actions
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
        nextViewController.member = self.member
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @objc func headerDetailButtonTapped() {
        let storyboard = UIStoryboard(name: "Setting", bundle: nil)
        guard let nextViewController = storyboard.instantiateViewController(withIdentifier: "RankViewController") as? RankViewController else {
            return
        }
        
        if let member = member {
            nextViewController.userRank = member.tier
        }
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}

// MARK: - Networking
extension MyPageScrollViewController: MyPageDelegate {
    func didFetchMemberData(member: MemberData) {
        self.member = member
        setHeaderData()
    }
}
