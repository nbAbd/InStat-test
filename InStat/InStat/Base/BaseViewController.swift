//
//  BaseViewController.swift
//  InStat
//
//  Created by Nurbek Abdulahatov on 19/11/21.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    var progressIndicator = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func setupTopTabBar(title: String = "",
                        tintColor: UIColor = UIColor.white,
                        indicatorImage: UIImage? = nil,
                        barTintColor: UIColor = .white,
                        titleColor: UIColor = UIColor.black,
                        preferLargerTitle: Bool = false
    ) {
        
        // Настройка под iOS 15 и выше
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.titleTextAttributes = [.foregroundColor: titleColor]
            appearance.backgroundColor = barTintColor
            if preferLargerTitle {
                appearance.shadowImage = UIImage()
                appearance.shadowColor = .clear
            }
            
            navigationController!.navigationBar.standardAppearance = appearance
            navigationController!.navigationBar.scrollEdgeAppearance = appearance
        } else {
            navigationController!.navigationBar.titleTextAttributes = [.foregroundColor : titleColor]
            navigationController!.navigationBar.isTranslucent = false
            navigationController!.navigationBar.barTintColor = barTintColor
        }
        
        navigationItem.title = title
        navigationController!.navigationBar.tintColor = tintColor
        navigationController?.navigationBar.prefersLargeTitles = preferLargerTitle
        if preferLargerTitle {
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        }
        
        let backBarButtton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtton
        if let indicatorImage = indicatorImage {
            navigationController!.navigationBar.backIndicatorImage = indicatorImage
            navigationController!.navigationBar.backIndicatorTransitionMaskImage = indicatorImage
        }
    }
    
     func showProgress() {
         progressIndicator.center = view.center
         progressIndicator.startAnimating()
         progressIndicator.hidesWhenStopped = true
         view.addSubview(progressIndicator)
    }
    
     func dismissProgress() {
         progressIndicator.stopAnimating()
         progressIndicator.removeFromSuperview()
    }
}
