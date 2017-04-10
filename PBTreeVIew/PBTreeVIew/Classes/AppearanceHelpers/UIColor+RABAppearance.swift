//
//  UIColor+RABAppearance.swift
//  PBTreeVIew
//
//  Created by Partho Biswas on 5/27/16.
//  Copyright © 2016 Partho Biswas. All rights reserved.
//

import UIKit


extension UIColor {
    //Appearance Methods
    class func appPrimaryColor() -> UIColor {
        return RABAppearanceInfo.valueForAppearanceKey(kPrimaryAppColorKey) as! UIColor
    }

    class func appSecondaryColor1() -> UIColor {
        return RABAppearanceInfo.valueForAppearanceKey(kSecondaryColor1Key) as! UIColor
    }

    class func appBorderLineColor() -> UIColor {
        return RABAppearanceInfo.valueForAppearanceKey(kBorderLineColor) as! UIColor
    }

    class func appSearchBarBackgroundColor() -> UIColor {
        return RABAppearanceInfo.valueForAppearanceKey(kSearchBarBackgroundColor) as! UIColor
    }

    class func appNavigationBarForgroundColor() -> UIColor {
        return RABAppearanceInfo.valueForAppearanceKey(kNavigationBarForgroundColor) as! UIColor
    }

    class func appTableViewSeperatorColor() -> UIColor {
        return RABAppearanceInfo.valueForAppearanceKey(kTableViewSeperatorColor) as! UIColor
    }

    class func appTabBarForgroundColor() -> UIColor {
        return RABAppearanceInfo.valueForAppearanceKey(kTabBarForgroundColor) as! UIColor
    }

    class func aboutViewHeaderColor() -> UIColor {
        return RABAppearanceInfo.valueForAppearanceKey(kAboutViewHeaderColor) as! UIColor
    }

    class func appTableViewCellDescriptionColor() -> UIColor {
        return RABAppearanceInfo.valueForAppearanceKey(kAppTableViewCellDescriptionColor) as! UIColor
    }
}

