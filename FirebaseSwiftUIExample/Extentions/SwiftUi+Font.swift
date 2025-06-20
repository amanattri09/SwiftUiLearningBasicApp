import SwiftUI

extension Font {
    static func poppins(fontstyle : Font.TextStyle = .body , fontWeight : Weight = .regular) -> Font {
        return Font.custom(AppFont(weight: fontWeight).rawValue, size: fontstyle.size)
    }
}

extension Font.TextStyle {
    var size : CGFloat {
        switch self {
        case .largeTitle : return 24
        case .title : return 30
        case .title2 : return 22
        case .title3 : return 20
        case .headline : return 18
        case .body : return 16
        case .callout : return 15
        case .subheadline : return 14
        case .footnote : return 13
        case .caption : return 12
        case .caption2 : return 11
        @unknown default : return 8
            
        }
    }
}


enum AppFont: String {
    
    case regular = "Poppins-Regular"
    case bold = "Poppins-Bold"
    
    init(weight : Font.Weight) {
        switch  weight {
        case .regular :
            self = .regular
        case .bold :
            self = .bold
        default :
            self = .regular
        }
    }
    
}
