//
//  HomeViewController.swift
//  OneK
//
//  Created by BCMM on 25/01/2022.
//

import UIKit
import FSPagerView

class HomeViewController: UIViewController,UISearchBarDelegate {
    
    @IBOutlet weak var pagerView: FSPagerView!
    
    @IBOutlet weak var pageControl: FSPageControl!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var searchBar: UISearchBar!
    
    var sliderImages = [UIImage(named: "banner-1"),UIImage(named: "banner-2"),UIImage(named: "banner-3"),UIImage(named: "banner-4"),UIImage(named: "banner-5"),UIImage(named: "banner-6"),UIImage(named: "banner-7")
    ]
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = false
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupSliderView()
        setupCollectionView()
        tabBarItem.badgeValue = "Message"
    }
    
    func setupNavigationBar(){
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "logout").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogOut))
        
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.sizeToFit()
//        searchBar.becomeFirstResponder()
        searchBar.showsCancelButton = false
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.leftView?.tintColor = .systemGreen
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: " Search at OneKyat", attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGreen])
        
        let navBaseViewe = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        navBaseViewe.addSubview(searchBar)
        navBaseViewe.clipsToBounds = true
        searchBar.clipsToBounds = true
        
        navigationItem.titleView = searchBar
    }
    
    @objc func handleLogOut(){
        
        let vc = LoginViewController()
        let navController = UINavigationController(rootViewController: vc)
        navController.modalPresentationStyle = .fullScreen
        navController.navigationBar.barTintColor = .systemGreen
        self.present(navController, animated:false, completion: nil)
        
    }
    
    func setupSliderView(){
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.automaticSlidingInterval = 5.0
        pageControl.setFillColor(.systemGreen, for: .selected)
        pageControl.numberOfPages = sliderImages.count
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let cellNib = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "homeCell")
        
        collectionView.keyboardDismissMode = .onDrag
    }




}


extension HomeViewController : FSPagerViewDelegate , FSPagerViewDataSource {
    
    // MARK:- FSPagerView DataSource
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return sliderImages.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let slideImage = sliderImages[index]
        cell.imageView?.image = slideImage
        cell.imageView?.contentMode = .scaleToFill
        return cell
    }
    
    // MARK:- FSPagerView Delegate
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        self.pageControl.currentPage = targetIndex
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
    }
    
}

extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController()
//        present(vc, animated: true, completion: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - 30) / 2
        let height = (view.frame.width * 0.65)
        return CGSize(width: width, height: height)
    }
    
}
