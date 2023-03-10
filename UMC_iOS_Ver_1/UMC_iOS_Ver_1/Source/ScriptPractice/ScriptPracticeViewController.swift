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
    let imageView = UIImageView()
    let label_1 = UILabel()
    let label_2 = UILabel()
    var count = 0
    
    @objc func didTapButton(_ sender: UIButton) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "CreateNewScriptViewController") as? CreateNewScriptViewController else { return }
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        count = count + 1
        
        UserDefaults.standard.set(count, forKey: "scriptCount")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 32))
        header.backgroundColor = UIColor(hex: 0xf1f5f9)
        
        let headerLabel = UILabel(frame: header.bounds)
        headerLabel.text = "    내 대본 \(UserDefaults.standard.integer(forKey: "scriptCount"))"
        headerLabel.textAlignment = .left
        headerLabel.font = UIFont.systemFont(ofSize: 14)
        headerLabel.textColor = UIColor(hex: 0x52616A)
        header.addSubview(headerLabel)
        
        tableView.tableHeaderView = header
        
        print("테이블뷰")
        
        
        let button = UIButton(frame: CGRect(x: 20, y: 700, width: 343, height: 50))
        print("왜안나옴")
        button.setTitle("새로운 대본 만들기", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.backgroundColor = .black
        button.layer.cornerRadius = 8
        
        self.view.addSubview(button)
 
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("나타남?")
        print(UserDefaults.standard.integer(forKey: "scriptCount"))
        if UserDefaults.standard.integer(forKey: "scriptCount") == 0{
            
            imageView.image = UIImage(named: "ic_script")
            imageView.frame = CGRect(x: 166, y: 286, width: 60, height: 60)
            view.addSubview(imageView)
            
            label_1.text = "새로운 대본 연습을 시작해보세요"
            label_1.textColor = UIColor(red: 0.322, green: 0.38, blue: 0.416, alpha: 1)

            label_1.font = UIFont.boldSystemFont(ofSize: 16)
            
            let padding_1: CGFloat = 10 // adjust the padding as needed
            label_1.frame = CGRect(x: 84, y: imageView.frame.maxY + padding_1, width: 230, height: 22)
            view.addSubview(label_1)
            
        
            label_2.text = "직접 대본을 만들고 실전처럼 연습해보세요."
            label_2.textColor = UIColor(red: 0.322, green: 0.38, blue: 0.416, alpha: 1)

            label_2.font = UIFont(name: "AppleSDGothicNeoM00-Regular", size: 14)
            
            let padding_2: CGFloat = 10 // adjust the padding as needed
            label_2.frame = CGRect(x: 55, y: label_1.frame.maxY + padding_2, width: 300, height: 18)
            
            view.addSubview(label_2)
            
        }
        else{
            imageView.isHidden = true
            label_1.isHidden = true
            label_2.isHidden = true
            tableView.reloadData()
        }
    }
}

extension ScriptPracticeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return UserDefaults.standard.integer(forKey: "scriptCount")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ScriptListTableViewCell", for: indexPath) as? ScriptListTableViewCell else{
            
            return UITableViewCell()
            
        }
        
        cell.title.text = UserDefaults.standard.string(forKey: "scriptName")
        
        var tempContent = ""
        for i in 0..<UserDefaults.standard.integer(forKey: "scriptCount"){
            tempContent = tempContent + (UserDefaults.standard.string(forKey: "paragraphContent" + String(i)) ?? "")
        }
        cell.content.text = tempContent
        
        cell.info.text = String(UserDefaults.standard.integer(forKey: "scriptCount")) + " 페이지 · 방금"
        
        
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
