//
//  Color+App.swift
//  Take Home Project
//
//  Created by Othman Shahrouri on 06/03/2026.
//

import SwiftUI
import UIKit

extension Color {
    static let gold500 = Color("gold500")
    static let red600  = Color("red600")

    static let backgroundPrimary   = Color("warm950")
    static let backgroundSecondary = Color("warm100")
    static let backgroundAccented  = Color("warm200")
    static let backgroundScrim     = Color("scrim")

    static let labelPrimary   = Color("neutral900")
    static let labelSecondary = Color("neutral400")
    static let labelSecondaryMuted = Color("labelSecondaryMuted")
    static let labelOnSolid   = Color("neutral50")

    static let ctaSolidBackground   = Color("ctaSolid")
    static let playButtonBackground = Color("gold500")

    static let separatorPrimary = Color("warm300")

    static let iconPrimary = Color("neutral900")

    static let colorError   = Color("red400")
    static let accentGreen  = Color("accentGreen")

    static let chipActiveBackground = Color("chipActiveBackground")
    static let playPillBackground = Color("playPillBackground")
    static let mediaContainerBackground = Color("mediaContainerBackground")
    static let profileCardBackground = Color("profileCardBackground")
}

extension UIColor {

    static let backgroundPrimary = UIColor(named: "warm950") ?? .systemBackground

    static let labelPrimary   = UIColor(named: "neutral900") ?? .label
    static let labelSecondary = UIColor(named: "neutral400") ?? .secondaryLabel

    static let neutral500 = UIColor(named: "neutral500") ?? .separator

    static let iconPrimary = UIColor(named: "neutral900") ?? .label
    static let gold500 = UIColor(named: "gold500") ?? UIColor(red: 212/255, green: 175/255, blue: 55/255, alpha: 1)
}
