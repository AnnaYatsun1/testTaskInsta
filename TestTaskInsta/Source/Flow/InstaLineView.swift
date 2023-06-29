//
//  File.swift
//  TestTaskInsta
//
//  Created by Анна Яцун on 27.06.2023.
//

import UIKit


class InstaLineView: BaseView<InstaLineViewModel>,UICollectionViewDelegate, UICollectionViewDataSource {
    private let cellIdentifier = "CustomCollectionViewCell"
    private var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout:
            UICollectionViewCompositionalLayout(
                sectionProvider: { sectionIndex, _  -> NSCollectionLayoutSection? in
                    let sectionHeight = 200 + 350
                    let postedItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1)))
                    let group = NSCollectionLayoutGroup.vertical(
                        layoutSize: NSCollectionLayoutSize(
                            widthDimension: .fractionalWidth(1),
                            heightDimension: .absolute(CGFloat(sectionHeight))),
                        subitems: [postedItem])
                    let section = NSCollectionLayoutSection(group: group)
                    section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0)
                    return section
                })
    )
    
    //MARK: LifeCurcle
    
    override func configure() {
        super.configure()
        addSubview(collectionView)
        collectionView.backgroundColor = .white
        register()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
     
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = .init(x: 0,
                                     y: 0,
                                     width: width,
                                     height: height)
    }
    
    //MARK: Public
    
    public func reloadData() {
        dispatchOnMain {
            self.collectionView.reloadData()
        }
    }
    
    //MARK: Private
    
    private func register() {
        collectionView.register(cellClass: CustomCollectionViewCell.self)
    }
    
    //MARK: Delegate CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier,
            for: indexPath) as! CustomCollectionViewCell
        
        cell.fill(model: viewModel.photos[indexPath.item])
        cell.eventHandel = { [weak self] events in
            switch events {
            case .moreButton:
                self?.viewModel.callbackEvents?(.openMoreScreen)
            case .comment:
                self?.viewModel.callbackEvents?(.openCommentScreen)
            case .share:
                self?.viewModel.callbackEvents?(.openShareScreen)
            }
        }
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

