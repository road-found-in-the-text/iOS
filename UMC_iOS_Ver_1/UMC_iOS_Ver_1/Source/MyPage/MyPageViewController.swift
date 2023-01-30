//
//  MyPageViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 신태원 on 2023/01/07.
//

import UIKit

import Tabman
import Pageboy

class MyPageViewController: TabmanViewController {
    
    var viewControllers = [UIViewController]()
    private let tabName = ["보관함", "내가 쓴 글", "내가 쓴 댓글"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewControllers()
        
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        
        bar.backgroundView.style = .blur(style: .light)
        bar.backgroundColor = .white
        bar.layout.transitionStyle = .none
        
        // 버튼 스타일링
        bar.buttons.customize { button in
            button.font = .systemFont(ofSize: 14)
            button.selectedFont = .boldSystemFont(ofSize: 14)
            button.tintColor = UIColor(named: "Sub2")
            button.selectedTintColor = .black
        }
        
        // 버튼 정렬 및 간격
        bar.layout.alignment = .centerDistributed
        bar.layout.interButtonSpacing = 80
        
        // 하단 인디케이터 바 설정
        bar.indicator.weight = .custom(value: 1)
        bar.indicator.tintColor = .black
        
        addBar(bar, dataSource: self, at: .top)
    }
    
    func setViewControllers() {
        guard let storageViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyPageStorageViewController") as? MyPageStorageViewController else {
            return
        }
        
        guard let myPostViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyPageMyPostViewController") as? MyPageMyPostViewController else {
            return
        }
        
        viewControllers.append(storageViewController)
        viewControllers.append(myPostViewController)
    }
}

extension MyPageViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return 3
    }
    
    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        if index != 2 {
            return viewControllers[index]
        } else {
            return UIViewController()
        }
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let item = TMBarItem(title: tabName[index])
        
        return item
    }
}
