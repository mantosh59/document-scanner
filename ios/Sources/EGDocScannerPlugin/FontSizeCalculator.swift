public class FontSizeCalculator {
 
    static var shared: FontSizeCalculator = FontSizeCalculator()
 
    private enum FontSizeState {
        case fit, tooBig, tooSmall
    }
 
    /**
     Returns a font size of a specific string in a specific font that fits a specific size
     - parameter text:         The text to use
     - parameter maxFontSize:  The max font size available
     - parameter minFontScale: The min font scale that the font will have
     - parameter rectSize:     Rect size where the label must fit
     */
    public func fontSizeThatFits(text string: String, maxFontSize: CGFloat = 100, minFontScale: CGFloat = 0.1, rectSize: CGSize) -> CGFloat {
 
        let font = UIFont.systemFont(ofSize: 10)
 
 
        let maxFontSize = maxFontSize.isNaN ? 100 : maxFontSize
        let minFontScale = minFontScale.isNaN ? 0.1 : minFontScale
        let minimumFontSize = maxFontSize * minFontScale
        guard !string.isEmpty else {
            return font.pointSize
        }
 
        let constraintSize =  CGSize(width: CGFloat.greatestFiniteMagnitude, height: rectSize.height)
        let calculatedFontSize = binarySearch(font: font, string: string, minSize: minimumFontSize, maxSize: maxFontSize, size: rectSize, constraintSize: constraintSize)
        return (calculatedFontSize * 10.0).rounded(.down) / 10.0
    }
 
    private func binarySearch(font: UIFont, string: String, minSize: CGFloat, maxSize: CGFloat, size: CGSize, constraintSize: CGSize) -> CGFloat {
        let fontSize = (minSize + maxSize) / 2
        var attributes: [NSAttributedString.Key: Any] = [:]
        attributes[NSAttributedString.Key.font] = font.withSize(fontSize)
 
        let rect = string.boundingRect(with: constraintSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        let state = singleLineSizeState(rect: rect, size: size)
 
        // if the search range is smaller than 0.1 of a font size we stop
        // returning either side of min or max depending on the state
        let diff = maxSize - minSize
        guard diff > 0.1 else {
            switch state {
            case .tooSmall:
                return maxSize
            default:
                return minSize
            }
        }
 
        switch state {
        case .fit: return fontSize
        case .tooBig: return binarySearch(font: font, string: string, minSize: minSize, maxSize: fontSize, size: size, constraintSize: constraintSize)
        case .tooSmall: return binarySearch(font: font, string: string, minSize: fontSize, maxSize: maxSize, size: size, constraintSize: constraintSize)
        }
    }
 
    private func singleLineSizeState(rect: CGRect, size: CGSize) -> FontSizeState {
        if rect.width >= size.width + 10 && rect.width <= size.width {
            return .fit
        } else if rect.width > size.width {
            return .tooBig
        } else {
            return .tooSmall
        }
    }

    
}