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
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var tapView: UIView!
    
    var viewControllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        guard let storageViewController = self.storyboard?.instantiateViewController(withIdentifier: "MyPageStorageViewController") as? MyPageStorageViewController else {
            return
        }
        
        viewControllers.append(storageViewController)

        
        self.dataSource = self
        
        let bar = TMBar.ButtonBar()
        
        bar.backgroundView.style = .blur(style: .light)
        bar.backgroundColor = .white
        bar.layout.transitionStyle = .none
        
        // 버튼 정렬 및 간격
        bar.layout.alignment = .centerDistributed
        bar.layout.interButtonSpacing = 80
        
        // 하단 인디케이터 바 설정
        bar.indicator.weight = .custom(value: 1)
        bar.indicator.tintColor = .black
        
        addBar(bar, dataSource: self, at: .top)
    }
}

extension MyPageViewController: PageboyViewControllerDataSource, TMBarDataSource {
    
    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return 3
    }
    
    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        if index == 0 {
            return viewControllers[0]
        } else {
            return UIViewController()
        }
    }
    
    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        let item = TMBarItem(title: "")
        item.title = "Page \(index)"
        
        return item
    }
}
