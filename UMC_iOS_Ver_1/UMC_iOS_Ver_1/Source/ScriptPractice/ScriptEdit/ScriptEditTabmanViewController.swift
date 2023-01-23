//
//  ScriptEditTabmanViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 이서영 on 2023/01/10.
//

import UIKit

import Tabman
import Pageboy

class ScriptEditTabmanViewController: TabmanViewController {
    
    private let barButtonTitle = ["편집", "연습", "기록"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.isScrollEnabled = false

        let bar = TMBarView<TMHorizontalBarLayout, ImageLabelBarButton, TMLineBarIndicator>()

        bar.backgroundView.style = .blur(style: .light)
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

extension ScriptEditTabmanViewController: PageboyViewControllerDataSource, TMBarDataSource {

    func numberOfViewControllers(in pageboyViewController: PageboyViewController) -> Int {
        return 3
    }

    func viewController(for pageboyViewController: PageboyViewController,
                        at index: PageboyViewController.PageIndex) -> UIViewController? {
        return UIViewController()
    }

    func defaultPage(for pageboyViewController: PageboyViewController) -> PageboyViewController.Page? {
        return nil
    }

    func barItem(for bar: TMBar, at index: Int) -> TMBarItemable {
        var image: UIImage
        if index == 0 {
            image = UIImage(named: "ic_edit")!
        } else if index == 1 {
            image = UIImage(named: "ic_script")!
        } else {
            image = UIImage(named: "ic_bar chart")!
        }
        return TMBarItem(title: barButtonTitle[index], image: image)
    }
}
