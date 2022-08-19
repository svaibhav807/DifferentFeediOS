//
//  PaybackColors.swift
//  PaybackDemo
//
//

import UIKit

struct PaybackColors {
    struct Background {
        static var primary: UIColor {
            return UIColor(r: 27, g: 73, b: 101)
        }

        static var secondary: UIColor {
            return UIColor(r: 70, g: 143, b: 175)
        }

        static var tertiary: UIColor {
            return UIColor(r: 42, g: 111, b: 151)
        }

        static var quaternary: UIColor {
            return UIColor(r: 70, g: 143, b: 175)
        }
    }

    struct Text {
        static var primary: UIColor {
            return .label
        }

        static var link: UIColor {
            return .systemBlue
        }
    }
}
