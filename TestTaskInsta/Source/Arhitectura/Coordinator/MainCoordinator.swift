//
//  File.swift
//  TestTaskInsta
//
//  Created by Анна Яцун on 27.06.2023.
//

import UIKit



enum MainCoordinatorEvent {
//    case openTabBarCoordinator
}

class MainCoordinator {
    var customViewController: InstaLineViewController?
    
    private(set) var navigationController: UINavigationController
    let eventHandel: (MainCoordinatorEvent) -> ()
    
    //MARK: Init
    
    init(navigationController: UINavigationController, eventHandel: @escaping (MainCoordinatorEvent) -> ()) {
        self.navigationController = navigationController
        self.eventHandel = eventHandel
    }
    
    func start() {
        let urlBuilder = URLBuilder()
        let requestService = RequestService(urlBuilder: urlBuilder)
        let customViewModel = InstaLineViewModel(requestService: requestService)
        let customViewController = InstaLineViewController(viewModel: customViewModel)
        
        customViewModel.callbackEvents = handel(event:)
        self.customViewController = customViewController
        navigationController.pushViewController(customViewController, animated: true)
    }
    
    func handel(event: FistPageViewModelEvents) {
        switch event { 
        case .openShareScreen:
            let vc = UIActivityViewController(activityItems: ["Sharing from Instagram"], applicationActivities: [])
            self.customViewController?.present(vc, animated: true, completion: nil)
        case .openMoreScreen:
            let sheet = UIAlertController(title: "Post Action", message: nil, preferredStyle: .actionSheet)
            sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            sheet.addAction(UIAlertAction(title: "Share post", style: .default))
            sheet.addAction(UIAlertAction(title: "Repost Post", style: .default))
            self.customViewController?.present(sheet, animated: true, completion: nil)
        case .openCommentScreen:
            let urlBuilder = URLBuilder()
            let requestService = RequestService(urlBuilder: urlBuilder)
            let viewModel = CommentPageViewModel(requestService: requestService)
            let controller = CommentPageViewController(viewModel: viewModel)
            controller.setTypeSizeOfPresentation(type: .medium())
            self.customViewController?.navigationController?.present(controller, animated: true)

        case .reloadData:
            break
        }
    }
}
