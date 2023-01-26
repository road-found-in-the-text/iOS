//
//  CreateNewScriptViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 신태원 on 2023/01/09.
//

import UIKit

class CreateNewScriptViewController: UIViewController {
    
    //테이블 뷰
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var scriptNameTxtField: UITextField!
    
    var countPage = 1 //페이지 개수 카운트해주는 변수
    
    @objc func didTapSaveBtn(_ sender: UIButton) {
        
        print("저장")
    }
    
    //추가 버튼 눌렀을 때, count 1늘리고 reload
    @objc func didTapAddBtn(_ sender: UIButton) {
        countPage = countPage + 1
        tableView.reloadData()
    }
    
    //페이지 지웠을때, count 1 감소 후 reload
    func didDeletePage(){
        countPage = countPage - 1
    }
    
    var items = ["책 구매", "철수와 약속", "스터디 준비하기"]
    var itemsImageFile = ["cart.png", "clock.png", "pencil.png"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self
        
        //네이게이션 타이틀 선언
        title = "새로운 대본 만들기"

        //네비게이션바에 아이템달고 색깔 지정해줌
        _ = [NSAttributedString.Key.foregroundColor:UIColor(hex: 0xADB5BD
)]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(didTapSaveBtn))
        
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor(hex: 0xADB5BD)
        
        
        //텍스트필드 아랫부분만 border 남기기
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: scriptNameTxtField.frame.height - 1, width: scriptNameTxtField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor(hex: 0xC9D6DE).cgColor
        scriptNameTxtField.borderStyle = UITextField.BorderStyle.none
        scriptNameTxtField.layer.addSublayer(bottomLine)
        
        
        //footer 부분 버튼 만드는 작업.
        //Radius와 Shadow를 같이 줘야되서 이런 작업이 필요함
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 50))
        
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 77, height: 34))
        
        containerView.center = footer.center
        
        footer.backgroundColor = UIColor(hex: 0xf1f5f9)
        
        let footerBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 77, height: 34))
        footerBtn.setTitle("추가", for: .normal)
        footerBtn.titleLabel?.font = UIFont.AppleSDGothicNeo(type: .medium, size: 14)
        footerBtn.setTitleColor(.black, for: .normal)
        footerBtn.setBackgroundColor(.white, for: .normal)
        footerBtn.clipsToBounds = true
        footerBtn.layer.cornerRadius = 17
        footerBtn.setImage(UIImage(named: "ic_plus.png"), for: .normal)
        
        containerView.addSubview(footerBtn)
        
        footer.addSubview(containerView)
        
        containerView.layer.shadowColor = UIColor.gray.cgColor
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 1
        containerView.layer.shadowOpacity = 0.7

        tableView.tableFooterView = footer
        
        footerBtn.addTarget(self, action: #selector(didTapAddBtn), for: .touchUpInside)
        
        
    }
    

}

extension CreateNewScriptViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDropDelegate, UITableViewDragDelegate{
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
    
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {

            if session.localDragSession != nil { // Drag originated from the same app.
                return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }

            return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return countPage
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreateNewScriptCell", for: indexPath) as? CreateNewScriptCell else{
            
            return UITableViewCell()
            
        }
        
        if indexPath.row < 9 {
            cell.pageLabel.text = "0" + String(describing: indexPath.row + 1)
        }
        else{
            cell.pageLabel.text = String(describing: indexPath.row + 1)
        }
        
        //TableViewCell 델리게이트 선언
        cell.delegate = self
        cell.delegateForHeight = self
        cell.contentTxtView.text = "내용을 작성하세요."
        cell.contentTxtView.textColor = UIColor.placeholderText
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            if editingStyle == .delete {
                
                didDeletePage()
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else if editingStyle == .insert {
                
            }
        
        tableView.reloadData()
    }
    
    // Row Editable true
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Move Row Instance Method
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        print("\(sourceIndexPath.row) -> \(destinationIndexPath.row)")
        /*let moveCell = self.items[sourceIndexPath.row]
        self.items.remove(at: sourceIndexPath.row)
        self.items.insert(moveCell, at: destinationIndexPath.row)*/
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
        return UITableView.automaticDimension
    }
    
}

//각 셀마다 생성된 버튼이 몇번째 셀의 버튼인지 알기 위해서 만든 Delegate
extension CreateNewScriptViewController: CellDelegate{
    func didTap(_ cell: UITableViewCell, name: String, content: String) {
        let indexPath = self.tableView.indexPath(for: cell)
        // do something with the index path
        
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "WriteScriptViewController") as? WriteScriptViewController else { return }
        
        vc.pageCount = (indexPath?.row ?? 0) + 1
        vc.originPageName = name
        vc.originPageContent = content
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension CreateNewScriptViewController: TableViewCellDelegate {
    
    func updateTextViewHeight(_ cell: UITableViewCell, _ textView: UITextView) {
        let size = textView.bounds.size
        let newSize = tableView.sizeThatFits(CGSize(width: size.width, height: CGFloat.greatestFiniteMagnitude))
        if size.height != newSize.height {
            UIView.setAnimationsEnabled(false)
            tableView.beginUpdates()
            tableView.endUpdates()
            UIView.setAnimationsEnabled(true)
        }
    }
}
