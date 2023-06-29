//
//  File.swift
//  TestTaskInsta
//
//  Created by Анна Яцун on 27.06.2023.
//

import UIKit


class FistPageView: BaseView<FistPageViewModel>,UICollectionViewDelegate, UICollectionViewDataSource {
    private let cellIdentifier = "CustomCollectionViewCell"

    var collectionView = UICollectionView(
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
//        reloadData()
    }
     
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = .init(x: 0,
                                     y: 0,
                                     width: width,
                                     height: height)
    }
    
    //MARK: Public
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func register() {
        collectionView.register(cellClass: CustomCollectionViewCell.self)
    }
    
    //MARK: Delegate CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(viewModel.photos.count)
        return viewModel.photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CustomCollectionViewCell
        
        cell.fill(model: viewModel.photos[indexPath.item])
        // Configure the cell
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

// MARK: FistPageViewExtension

extension FistPageView: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: 400, height: 500)
//    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        // Return the size for the footer view if needed
        return CGSize.zero
    }
}

