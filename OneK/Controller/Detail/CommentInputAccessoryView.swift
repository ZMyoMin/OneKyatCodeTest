//
//  CommentInputAccessoryView.swift
//  OneK
//
//  Created by BCMM on 26/01/2022.
//

import UIKit

protocol CommentInputAccessoryViewDelegate {
    func didSubmit(for comment: String)
}

class CommentInputAccessoryView: UIView {
    
    var delegate: CommentInputAccessoryViewDelegate?
    
    func clearCommentTextField() {
        commentTextView.text = nil
        commentTextView.showPlaceholderLabel()
    }
    
    fileprivate let commentTextView: CommentInputTextView = {
        let tv = CommentInputTextView()
        tv.isScrollEnabled = false
        tv.font = UIFont.systemFont(ofSize: 18)
        return tv
    }()
    
    fileprivate let phoneButton: UIButton = {
        let sb = UIButton(type: .system)
        sb.backgroundColor = .systemGreen
        sb.setImage(#imageLiteral(resourceName: "phone").withRenderingMode(.alwaysOriginal), for: .normal)
        sb.addTarget(self, action: #selector(handleCall), for: .touchUpInside)
        return sb
    }()
    
    fileprivate let submitButton: UIButton = {
        let sb = UIButton(type: .system)
        sb.backgroundColor = .clear
        sb.setImage(#imageLiteral(resourceName: "submitArrow").withRenderingMode(.alwaysOriginal), for: .normal)
        sb.addTarget(self, action: #selector(handleCall), for: .touchUpInside)
        return sb
    }()
    
    fileprivate let heartButton: UIButton = {
        let sb = UIButton(type: .system)
        sb.setImage(#imageLiteral(resourceName: "heartgreen").withRenderingMode(.alwaysOriginal), for: .normal)
        sb.imageEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        //sb.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        return sb
    }()
    
    fileprivate let messageButton: UIButton = {
        let sb = UIButton(type: .system)
        sb.setImage(#imageLiteral(resourceName: "message").withRenderingMode(.alwaysOriginal), for: .normal)
        sb.imageEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
//        sb.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        return sb
    }()
    
    fileprivate let countLabel: UILabel = {
       let label = UILabel()
        label.textColor = .gray
        label.text = "2"
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 1
        autoresizingMask = .flexibleHeight
        
        backgroundColor = .white
        
       
        
        addSubview(phoneButton)
        phoneButton.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 70, height: 70)
        
        
        
        addSubview(commentTextView)
        // 3
        if #available(iOS 11.0, *) {
            commentTextView.anchor(top: topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: phoneButton.leftAnchor, paddingTop: 8, paddingLeft: 100, paddingBottom: 8, paddingRight: 10, width: 0, height: 0)
        } else {
            // Fallback on earlier versions
        }
        
        commentTextView.layer.cornerRadius = 5
        commentTextView.backgroundColor = UIColor.systemGray
        
        commentTextView.addSubview(submitButton)
        commentTextView.bringSubviewToFront(submitButton)
        submitButton.anchor(top: commentTextView.topAnchor, left: nil, bottom: nil, right: phoneButton.leftAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 20, width:20, height: 20)
        
        addSubview(messageButton)
        messageButton.anchor(top: topAnchor, left: nil, bottom: nil, right: commentTextView.leftAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 40, height: 40)
        
        addSubview(countLabel)
        countLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: messageButton.leftAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 10, height: 10)
        
        addSubview(heartButton)
        heartButton.anchor(top: topAnchor, left: nil, bottom: nil, right: countLabel.leftAnchor, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        
        setupLineSeparatorView()
    }
    
    // 2
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    fileprivate func setupLineSeparatorView() {
        let lineSeparatorView = UIView()
        lineSeparatorView.backgroundColor = UIColor.gray
        addSubview(lineSeparatorView)
        lineSeparatorView.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0.5)
    }
    
    @objc func handleCall() {

        makeACall(number: "09420000002")
    }
    
    func makeACall(number:String) {
        if let url = URL(string: "tel://\(number)"),
           UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url)
        }
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

