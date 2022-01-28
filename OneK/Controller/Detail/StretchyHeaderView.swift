//
//  StretchyHeaderView.swift
//  OneK
//
//  Created by BCMM on 26/01/2022.
//

import UIKit


class StretchyHeaderView:UIView{
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let backButton: UIButton = {
       let backButton = UIButton()
        backButton.setImage(#imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), for: .normal)
        return backButton
    }()
    
    var imageHeight = NSLayoutConstraint()
    var imageBottom = NSLayoutConstraint()
    var containerViewHeight = NSLayoutConstraint()
    var containerView = UIView()
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        createView()
        setupViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createView(){
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(backButton)
        
    }
    
    func setupViewConstraints(){
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: containerView.widthAnchor),
            centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
        
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.widthAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        containerViewHeight = containerView.heightAnchor.constraint(equalTo: self.heightAnchor)
        containerViewHeight.isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageBottom = imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        imageBottom.isActive = true
        imageHeight = imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        imageHeight.isActive = true
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: nil, right: nil, paddingTop: 20, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 60, height: 60)
        
        
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView){
        containerViewHeight.constant = scrollView.contentInset.top
        let offsetY = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        containerView.clipsToBounds = offsetY <= 0
        imageBottom.constant = offsetY >= 0 ? 0 : -offsetY / 2
        imageHeight.constant = max(offsetY + scrollView.contentInset.top, scrollView.contentInset.top)
    }
    
    
}
