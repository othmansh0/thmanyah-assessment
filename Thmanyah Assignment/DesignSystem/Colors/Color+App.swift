//
//  Color+App.swift
//  Thmanyah Assignment
//
//  Created by Othman Shahrouri on 06/03/2026.
//

import SwiftUI

extension Color {
    static let gold500 = Color("gold500")
    static let red600  = Color("red600")

    static let backgroundPrimary   = Color("warm950")
    static let backgroundSecondary = Color("warm100")
    static let backgroundElevated  = Color("warm50")
    static let backgroundAccented  = Color("warm200")
    static let backgroundScrim     = Color("scrim")

    static let labelPrimary   = Color("neutral900")
    static let labelSecondary = Color("neutral400")
    static let labelTertiary  = Color("labelTertiary")
    static let labelOnSolid   = Color("neutral50")

    static let ctaSolidBackground   = Color("ctaSolid")
    static let playButtonBackground = Color("gold500")
    static let fillInteractive      = Color("fillHover")

    static let separatorPrimary = Color("warm300")
    static let borderDefault    = Color("warm350")

    static let iconPrimary = Color("neutral900")
    static let iconAccent  = Color("iconAccent")

    static let colorError   = Color("red400")
    static let colorSuccess = Color("green500")
}

extension UIColor {
    static let backgroundPrimary   = UIColor(named: "warm950") ?? .systemBackground
    static let backgroundSecondary = UIColor(named: "warm100") ?? .secondarySystemBackground
    static let backgroundElevated  = UIColor(named: "warm50")  ?? .tertiarySystemBackground

    static let labelPrimary   = UIColor(named: "neutral900") ?? .label
    static let labelSecondary = UIColor(named: "neutral400")  ?? .secondaryLabel

    static let separatorPrimary = UIColor(named: "warm300") ?? .separator

    static let iconPrimary = UIColor(named: "neutral900") ?? .label
    static let iconAccent  = UIColor(named: "iconAccent") ?? .systemYellow

    static let ctaSolidBackground = UIColor(named: "ctaSolid") ?? .black
}
