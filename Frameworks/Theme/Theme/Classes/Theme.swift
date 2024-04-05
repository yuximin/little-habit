//
//  Theme.swift
//  Theme
//
//  Created by apple on 2024/4/5.
//

import Foundation

public enum Theme {
    case light
    case dark
    
    public static var current: Theme = .light
    
    public static var backgroundColor = BackgroundColor()
    public static var textColor = TextColor()
    
    public class BackgroundColor {
        public var normal: UIColor {
            switch Theme.current {
            case .light:
                return UIColor(red: 255.0 / 255.0, green: 250.0 / 255.0, blue: 205.0 / 255.0, alpha: 1) // #FFFACD
            case .dark:
                return UIColor(red: 48.0 / 255.0, green: 48.0 / 255.0, blue: 48.0 / 255.0, alpha: 1) // #303030
            }
        }
    }
    
    public struct TextColor {
        public var primary: UIColor {
            switch Theme.current {
            case .light:
                return UIColor(red: 51.0 / 255.0, green: 51.0 / 255.0, blue: 51.0 / 255.0, alpha: 1) // #333333
            case .dark:
                return UIColor(red: 238.0 / 255.0, green: 238.0 / 255.0, blue: 238.0 / 255.0, alpha: 1) // #EEEEEE
            }
        }
        
        public var secondary: UIColor {
            switch Theme.current {
            case .light:
                return UIColor(red: 102.0 / 255.0, green: 102.0 / 255.0, blue: 51.0 / 102.0, alpha: 1) // #666666
            case .dark:
                return UIColor(red: 204.0 / 255.0, green: 204.0 / 255.0, blue: 204.0 / 255.0, alpha: 1) // #CCCCCC
            }
        }
        
        public var tertiary: UIColor {
            switch Theme.current {
            case .light:
                return UIColor(red: 153.0 / 255.0, green: 153.0 / 255.0, blue: 153.0 / 255.0, alpha: 1) // #999999
            case .dark:
                return UIColor(red: 170.0 / 255.0, green: 170.0 / 255.0, blue: 170.0 / 255.0, alpha: 1) // #AAAAAA
            }
        }
    }
}
