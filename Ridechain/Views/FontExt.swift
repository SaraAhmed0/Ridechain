//
//  FontExt.swift
//  TicketBooking
//
//  Created by Sara AlMezeini on 08/01/2023.
//

import SwiftUI
@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
struct ScaledFont: ViewModifier {
//    @Environment(\.sizeCategory) var sizeCategory
    var name: Roboto
    var size: CGFloat

    func body(content: Content) -> some View {
//       let scaledSize = UIFontMetrics.default.scaledValue(for: size)
        return content.font(.custom(name.rawValue, size: size))
    }
}

@available(iOS 13, macCatalyst 13, tvOS 13, watchOS 6, *)
extension View {
    func scaledFont(name: Roboto, size: CGFloat) -> some View {
        return self.modifier(ScaledFont(name: name, size: size))
    }
}
enum Roboto: String {
    case lightItalic = "Montserrat-LightItalic"
    case black = "Montserrat-Black"
    case blackItalic = "Montserrat-BlackItalic"
    case bold = "Montserrat-Bold"
    case boldItalic = "Montserrat-BoldItalic"
    case extraBold = "Montserrat-ExtraBold"
    case extraBoldItalic = "Montserrat-ExtraBoldItalic"
    case extraLight = "Montserrat-ExtraLight"
    case extraLightItalic = "Montserrat-ExtraLightItalic"
    case italic = "Montserrat-Italic"
    case light = "Montserrat-Light"
    case medium = "Montserrat-Medium"
    case mediumItalic = "Montserrat-MediumItalic"
    case regular = "Montserrat-Regular"
    case semiBold = "Montserrat-SemiBold"
    case semiBoldItalic = "Montserrat-SemiBoldItalic"
    case thin = "Montserrat-Thin"
    case thinItalic = "Montserrat-ThinItalic"
}
