//
//  SearchViewController.swift
//  UMC_iOS_Ver_1
//
//  Created by 왕정빈 on 2023/01/13.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var recentSearchKeyword: UILabel!
    @IBOutlet weak var deleteAllButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchHistoryTableView: UITableView!
    @IBOutlet weak var searchForumTableView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "검색"   //search화면 title 설정
        navigationController?.navigationBar.topItem?.title = "" //돌아가기 버튼 글자 없게
        
        registerXib()
        searchHistoryTableView.delegate = self
        searchHistoryTableView.dataSource = self
        self.searchBar.delegate = self
        addSearchHistoryToTableView()
    }
    
    //화면 터치시 키보드 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //화면 스크롤시 키보드 내림
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    func registerXib() {
        let searchHistoryCell = UINib(nibName: "SearchKeywordTableViewCell", bundle: nil)
        searchHistoryTableView.register(searchHistoryCell, forCellReuseIdentifier: "SearchKeywordTableViewCell")
    }
    
    //검색 기록 userdefaults에 저장
    func addSearchHistoryToUserDefaults() {
        var searchHistoryNum = 0
        if searchBar.text == "" { return }
        while UserDefaults.standard.object(forKey: "searchHistory\(searchHistoryNum)") != nil {
            searchHistoryNum += 1
        }
        UserDefaults.standard.setValue(searchBar.text, forKey: "searchHistory\(searchHistoryNum)")
        UserDefaults.standard.synchronize()
    }
    
    //userdefaults에 있는 검색 기록 tableView에 저장
    func addSearchHistoryToTableView() {
        var searchHistoryNum = 0
        while UserDefaults.standard.object(forKey: "searchHistory\(searchHistoryNum)") != nil {
            guard let task = UserDefaults.standard.string(forKey: "searchHistory\(searchHistoryNum)") else { return }
            if searchHistoryData.contains(task) {
                //중복 요소가 있으면 삭제하고 맨 앞으로 추가
                if let index = searchHistoryData.lastIndex(of: task) {
                    searchHistoryData.remove(at: index)
                    searchHistoryData.append(task)
                    searchHistoryNum += 1
                }
            } else {
                searchHistoryData.append(task)
                searchHistoryNum += 1
            }
        }
        searchHistoryData.reverse()     //검색 기록 배열 순서 반대로 바꾸기
        searchHistoryTableView.reloadData()
    }
    
    @IBAction func deleteAllButtonTapped(_ sender: UIButton) {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }   //UserDefaults에 값이 존재하면 전부 삭제
        searchHistoryData = []
        searchHistoryTableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchHistoryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let searchHistoryCell = tableView.dequeueReusableCell(withIdentifier: "SearchKeywordTableViewCell", for: indexPath) as? SearchKeywordTableViewCell else { return UITableViewCell() }
        searchHistoryCell.searchHistoryKeyword.text = searchHistoryData[indexPath.row]
        
        searchHistoryCell.delegate = self
        
        return searchHistoryCell
    }
}

extension SearchViewController: UISearchBarDelegate {
    //search 버튼 누르면 실행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.recentSearchKeyword.isHidden = true
        self.deleteAllButton.isHidden = true
        self.searchHistoryTableView.isHidden = true
        self.searchForumTableView.isHidden = false
        searchBar.resignFirstResponder()   //서치바 키보드 내리기
        addSearchHistoryToUserDefaults()
    }
    
    //searchBar 누르면 실행
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        self.recentSearchKeyword.isHidden = false
        self.deleteAllButton.isHidden = false
        self.searchHistoryTableView.isHidden = false
        self.searchForumTableView.isHidden = true
        addSearchHistoryToTableView()
        return true
    }
}

extension SearchViewController: CellButtonTappedDelegate {
    func deleteButtonClicked(_ sender: UIButton) {
        let point = sender.convert(CGPoint.zero, to: searchHistoryTableView)
        guard let indexpath = searchHistoryTableView.indexPathForRow(at: point) else { return }
        UserDefaults.standard.removeObject(forKey: "searchHistory\(indexpath.row)")
        searchHistoryData.remove(at: indexpath.row)
        searchHistoryTableView.beginUpdates()
        searchHistoryTableView.deleteRows(at: [IndexPath(row: indexpath.row, section: 0)], with: .none)
        searchHistoryTableView.endUpdates()
    }
}
