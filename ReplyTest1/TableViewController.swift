//
//  TableViewController.swift
//  ReplyTest1
//
//  Created by PTK on 2023/05/22.
//

import Foundation
import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var comments: [Comment] = [Comment]()
    
    var hiddenSections = Set<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        // 테이블뷰 라인 없애기
        tableView.separatorStyle = .none
        
        comments = getDummyComments(with: 3)
    }
    
    func getDummyComments(with count: Int) -> [Comment] {

        var comments = [Comment]()
        for i in 1...count {
            comments.append(Comment(commentId: i, commentText: "Comment \(i)", replies: getDummyReplies(with: i)))
        }
        return comments

    }

    func getDummyReplies(with count: Int) -> [Reply] {
        var replies = [Reply]()
        for i in 1...count {
            replies.append(Reply(replyId: i, replyText: "Reply \(i)"))
        }
        return replies
    }
    
    @objc
    private func hideSection(sender: UITapGestureRecognizer) {
        // section의 tag 정보를 가져와서 어느 섹션인지 구분한다.
        let section = sender.view!.tag
        
        // 특정 섹션에 속한 행들의 IndexPath들을 리턴하는 메서드
        func indexPathsForSection() -> [IndexPath] {
            var indexPaths = [IndexPath]()
            
            for row in 0..<comments[section].replies.count {
                indexPaths.append(IndexPath(row: row,
                                            section: section))
            }
            
            return indexPaths
        }
        
        // 가져온 section이 원래 감춰져 있었다면
        if self.hiddenSections.contains(section) {
            // section을 다시 노출시킨다.
            self.hiddenSections.remove(section)
            self.tableView.insertRows(at: indexPathsForSection(), with: .fade)
            
            self.tableView.scrollToRow(at: IndexPath(row: comments[section].replies.count - 1,
                                section: section), at: UITableView.ScrollPosition.bottom, animated: true)
        } else {
            // section이 원래 노출되어 있었다면 행들을 감춘다.
            self.hiddenSections.insert(section)
            self.tableView.deleteRows(at: indexPathsForSection(), with: .fade)
        }
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

extension TableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 섹션이 hidden이므로 행을 노출시키지 않는다.
        if self.hiddenSections.contains(section) {
            return 0
        }
        
        // 가진 데이터의 개수만큼 노출시킨다.
        return comments[section].replies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = (comments[indexPath.section].replies[indexPath.row]).replyText
        
        return cell
    }
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerText = UILabel()
        headerText.textColor = .lightGray
        headerText.adjustsFontSizeToFitWidth = true
        headerText.textAlignment = .left
        headerText.text = comments[section].commentText
        headerText.tag = section
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.hideSection(sender:)))
        headerText.isUserInteractionEnabled = true
        headerText.addGestureRecognizer(tap)
        
        return headerText
    }
}
