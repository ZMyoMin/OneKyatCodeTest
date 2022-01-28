//
//  DetailViewController.swift
//  OneK
//
//  Created by BCMM on 25/01/2022.
//

import UIKit

class DetailViewController: UIViewController,CommentInputAccessoryViewDelegate {
    
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
        setupTableView()
        }
    
    lazy var containerView: CommentInputAccessoryView = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let commentInputAccessoryView = CommentInputAccessoryView(frame: frame)
        commentInputAccessoryView.delegate = self
        return commentInputAccessoryView
    }()
    
    func didSubmit(for comment: String) {
        print("The Commet..")
    }
    
    override var inputAccessoryView: UIView? {
        get {
            return containerView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    
    func setupTableView(){
        view.addSubview(tableView)
        tableView.anchor(top:view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.rowHeight = UITableView.automaticDimension
        tableView.keyboardDismissMode = .onDrag
        
        let header = StretchyHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200))
        header.imageView.image = UIImage(named: "banner-6")
        header.backButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        tableView.tableHeaderView = header
        
        let cellNib = UINib(nibName: "DetailTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "detailCell")
        
        let descNib = UINib(nibName: "DescriptionTableViewCell", bundle: nil)
        tableView.register(descNib, forCellReuseIdentifier: "descCell")
    }
    
    @objc func handleDismiss(){
        navigationController?.popViewController(animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard  let header = tableView.tableHeaderView as? StretchyHeaderView else {
            return
        }
        header.scrollViewDidScroll(scrollView: tableView)
        
    }
    
}


extension DetailViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell",for: indexPath) as! DetailTableViewCell
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "descCell",for: indexPath) as! DescriptionTableViewCell
        
        return cell
    }
    
   
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
           return UITableView.automaticDimension
       }

       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        }
           return UITableView.automaticDimension
       }

       func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
           cell.layoutIfNeeded()
       }
}
