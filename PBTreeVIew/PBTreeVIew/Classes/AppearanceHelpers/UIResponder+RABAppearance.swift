//
//  UIResponder+RABAppearance.swift
//  PBTreeVIew
//
//  Created by Partho Biswas on 5/27/16.
//  Copyright © 2016 Partho Biswas. All rights reserved.
//

import UIKit


extension AppDelegate {
    
    func applyDefaultAppearance() {
        UIApplication.shared.statusBarStyle = .lightContent
        self.window!.tintColor = UIColor.appPrimaryColor()
        let attributes: [String : Any] = [
            NSAttributedString.Key.font.rawValue : UIFont.appNavBarTitleFont(),
            NSAttributedString.Key.foregroundColor.rawValue : UIColor.appNavigationBarForgroundColor()
        ]
        
        //setup navigationbar
//        UINavigationBar.appearance().titleTextAttributes = attributes
        UINavigationBar.appearance().barTintColor = UIColor.appPrimaryColor()
        UINavigationBar.appearance().tintColor = UIColor.white
        let insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
        // or (2,0,0,0)
        let backArrowImage = UIImage(named: "back-button")?.withAlignmentRectInsets(insets)
        //    UIImage *backArrowImage = [[UIImage imageNamed:@"back-button"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UINavigationBar.appearance().backIndicatorImage = backArrowImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backArrowImage
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -70.0), for: .default)
        UINavigationBar.appearance().isTranslucent = false
        //end of setup navigationbar
        UIApplication.shared.statusBarStyle = .lightContent
        UIApplication.shared.isStatusBarHidden = false
        //        var statusBar: UIView? = ((UIApplication.shared.value(forKey: "statusBarWindow") as? String).value(forKey: "statusBar") as? String)
        //        if statusBar?.responds(to: #selector(setBackgroundColor)) {
        //            statusBar?.backgroundColor = UIColor.appPrimaryColor()
        //        }
        
        
        
        
        UITableView.appearance().separatorInset = UIEdgeInsets.zero
        UITableViewCell.appearance().separatorInset = UIEdgeInsets.zero
        if UITableView.instancesRespond(to: #selector(setter: UIView.layoutMargins)) {
            UITableView.appearance().layoutMargins = UIEdgeInsets.zero
            UITableViewCell.appearance().layoutMargins = UIEdgeInsets.zero
            UITableViewCell.appearance().preservesSuperviewLayoutMargins = false
        }
        UIBarButtonItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont.appLightFontWithSize(18.0)
            ]
            , for: UIControl.State())
        UITableView.appearance().separatorColor = UIColor.appTableViewSeperatorColor()
        UITableView.appearance().separatorStyle = .singleLine
        UITableView.appearance().tableFooterView = UIView(frame: CGRect.zero)
        UITextField.appearance().tintColor = UIColor.appPrimaryColor()
        UITextView.appearance().tintColor = UIColor.appPrimaryColor()
        UIBarButtonItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont.appLightFontWithSize(18)
            ]
            , for: UIControl.State())
        
//        UIButton.appearance().backgroundColor = UIColor.appPrimaryColor()
        UIButton.appearance().tintColor = UIColor.white
        UIButton.appearance().layer.cornerRadius = 10.0
        UIButton.appearance().layer.borderColor = UIColor.appSecondaryColor1().cgColor
        UIButton.appearance().layer.borderWidth = 2.0
        
        // Properties when tabbar is Selected
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.appRegularFontWithSize(10.0), NSAttributedString.Key.foregroundColor: UIColor.appPrimaryColor()], for: .selected)
        // Properties when tabbar is unselected
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.appRegularFontWithSize(10.0), NSAttributedString.Key.foregroundColor: UIColor.appTabBarForgroundColor()], for: UIControl.State())
        
        UISearchBar.appearance().tintColor = UIColor.black
        UISearchBar.appearance().backgroundColor = UIColor.appSearchBarBackgroundColor()
        
        if #available(iOS 9.0, *) {
            UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = UIColor.appPrimaryColor()
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.white
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0)]
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = UIColor.black
            UILabel.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1.00)
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0)]
            UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([
                NSAttributedString.Key.foregroundColor : UIColor(red: 0.259, green: 0.259, blue: 0.259, alpha: 1.00)
                ]
                , for: UIControl.State())
            UILabel.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = UIColor.black
        } else {
            // Fallback on earlier versions
        }
    }
}


