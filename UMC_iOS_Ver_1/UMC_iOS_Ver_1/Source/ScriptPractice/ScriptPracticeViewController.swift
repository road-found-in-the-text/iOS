//
//  ScriptPracticeViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 신태원 on 2023/01/07.
//

import UIKit

class ScriptPracticeViewController: UIViewController {

    //테이블 뷰
    @IBOutlet weak var tableView: UITableView!
    
    @objc func didTapButton(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateNewScriptViewController") as? CreateNewScriptViewController else { return }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 32))
        header.backgroundColor = UIColor(hex: 0xf1f5f9)
        
        let headerLabel = UILabel(frame: header.bounds)
        headerLabel.text = "    내 대본 2"
        headerLabel.textAlignment = .left
        header.addSubview(headerLabel)
        tableView.tableHeaderView = header
        
        let button = UIButton(frame: CGRect(x: 20, y: 700, width: 343, height: 50))
        print("왜안나옴")
        button.setTitle("새로운 대본 만들기", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.backgroundColor = .black
        
        self.view.addSubview(button)
 
    
    }
    
    
}

extension ScriptPracticeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScriptListTableViewCell", for: indexPath) as? ScriptListTableViewCell else{
            
            return UITableViewCell()
            
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "ScriptEdit", bundle: nil)
        guard let nextViewController = storyboard.instantiateViewController(withIdentifier: "ScriptEditTabmanViewController") as? ScriptEditTabmanViewController else {
            assert(false, "Can't load next vc")
        }
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
