//
//  Theme.swift
//  Theme
//
//  Created by apple on 2024/4/5.
//

import UIKit

public enum Theme {
    case light
    case dark
    
    public static var current: Theme = .light
    
    public static let themeColor = ThemeColor()
    public static let textColor = TextColor()
    public static let font = Font()
    public static let image = Image()
    
    public class ThemeColor {
        public var normal: UIColor {
            switch Theme.current {
            case .light:
                return UIColor(red: 255.0 / 255.0, green: 250.0 / 255.0, blue: 205.0 / 255.0, alpha: 1) // #FFFACD
            case .dark:
                return UIColor(red: 48.0 / 255.0, green: 48.0 / 255.0, blue: 48.0 / 255.0, alpha: 1) // #303030
            }
        }
        
        public var plate: UIColor {
            switch Theme.current {
            case .light:
                return UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 210.0 / 255.0, alpha: 1) // #FAFAD2
            case .dark:
                return UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 1) // #000000
            }
        }
        
        public var plateShadow: UIColor {
            switch Theme.current {
            case .light:
                return .black
            case .dark:
                return .white
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
    
    public struct Font {
        public var navTitle: UIFont { .systemFont(ofSize: 20, weight: .bold) }
        public var navItem: UIFont { .systemFont(ofSize: 16) }
    }
    
    public struct Image {
        public var navBarClose: UIImage? {
            UIImage(systemName: "xmark.circle.fill")?.withTintColor(Theme.textColor.primary, renderingMode: .alwaysOriginal)
        }
    }
}
