//
//  MenuBarView.swift
//  VPlan
//
//  Created by Vinicius Mangueira on 17/05/20.
//  Copyright © 2020 Vinicius Mangueira. All rights reserved.
//

import RxCocoa
import RxSwift

class MenuTabBarView: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    let actionMenuSubject = PublishSubject<Bool>()
    
    var horizontalBarLeftAnchorConstraint: NSLayoutConstraint?
    
    lazy var menuCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.dataSource = self
        collection.delegate = self
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = #colorLiteral(red: 0.03137254902, green: 0.3411764706, blue: 0.6705882353, alpha: 1)
        collection.isScrollEnabled = false
        return collection
    }()
    
    let horizontalBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollection()
        setupHorizontalBar()
        menuCollectionView.register(MenuCell.self, forCellWithReuseIdentifier: "cellId")
        let index = IndexPath(item: 0, section: 0)
        menuCollectionView.selectItem(at: index, animated: true, scrollPosition: .init())
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        indexPath.row == 0 ? self.actionMenuSubject.onNext(true) : self.actionMenuSubject.onNext(false)
        horizontalBarAnimation(indexPath: indexPath)
    }
    
    func horizontalBarAnimation(indexPath: IndexPath) {
        let newIndex = indexPath.item == 0 ? 0 : 2
        let constant = CGFloat(newIndex) * frame.width/4 + 45
        horizontalBarLeftAnchorConstraint?.constant = constant
                    
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHorizontalBar() {
        addSubview(horizontalBarView)
        horizontalBarLeftAnchorConstraint = horizontalBarView.leftAnchor.constraint(equalTo: leftAnchor, constant: 45)
        horizontalBarLeftAnchorConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            horizontalBarView.bottomAnchor.constraint(equalTo: bottomAnchor),
            horizontalBarView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/4),
            horizontalBarView.heightAnchor.constraint(equalToConstant: 4)
        ])
        
    }
    
    func setupCollection() {
        addSubview(menuCollectionView)
        NSLayoutConstraint.activate([
            menuCollectionView.topAnchor.constraint(equalTo: topAnchor, constant: -10),
            menuCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            menuCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            menuCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = menuCollectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? MenuCell
        cell?.setupTitleText(indexPath.row)
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width/2, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
