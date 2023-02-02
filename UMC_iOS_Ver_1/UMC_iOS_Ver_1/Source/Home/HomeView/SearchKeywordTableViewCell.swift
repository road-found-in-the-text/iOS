//
//  SearchKeywordTableViewCell.swift
//  search
//
//  Created by 왕정빈 on 2023/01/09.
//

import UIKit

//검색 기록 cell에 있는 button 클릭 할 때의 delegate
protocol CellButtonTappedDelegate: AnyObject {
    func deleteButtonClicked(_ sender: UIButton)
}

class SearchKeywordTableViewCell: UITableViewCell {

    weak var delegate: CellButtonTappedDelegate?
    
    @IBOutlet weak var searchHistoryKeyword: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        delegate?.deleteButtonClicked(sender)
    }
    
}

