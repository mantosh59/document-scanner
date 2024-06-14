import Vision

class PDFCreator {
    
    func createSearchablePDF(from images: [UIImage]) -> Data {
        // Start creating the PDF data
        let data = UIGraphicsPDFRenderer().pdfData { (context) in
            
            // Grab the raw core graphics context
            let drawContext = context.cgContext
            
            // Iterate over the images
            images.forEach { image in
                
                // 1. Get the underlying Quartz image data, used to recognize the text
                guard let cgImage = image.cgImage else {
                    return
                }
                
                // 2. Recognize the text on the image
                let recognizedText: [VNRecognizedText] = self.recognizeText(from: cgImage)
                
                // 3. Calculate the size of the PDF page we are going to create
                let pageWidth = image.size.width
                let pageHeight = image.size.height
                let pageRect = CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight)
                
                // 3. Initialize a PDF page
                context.beginPage(withBounds: pageRect, pageInfo: [:])
                
                // 4. Iterate over the lines of recognized text in order to write the text layer of the PDF
                recognizedText.forEach { text in
                    self.writeTextOnTextBoxLevel(recognizedText: $0, on: drawContext, bounds: pageRect)
                }
                
                // 5. Draw the image on the PDF page
                self.draw(image: $0, on: drawContext, withSize: pageRect)
            }
            
            return data
        }
        func writeTextOnTextBoxLevel(recognizedText: VNRecognizedText, on cgContext: CGContext, bounds: CGRect) {
            
            // 0. Save some meta data information
            let text = recognizedText.string
            let pageWidth = bounds.size.width
            let pageHeight = bounds.size.height
            
            // 1. Calculate the bounding box of the recognized text
            let start = text.index(text.startIndex, offsetBy: 0)
            let end = text.index(text.endIndex, offsetBy: 0)
            let bBox = try? recognizedText.boundingBox(for: start..<end)
            
            guard let boundingBox = bBox else {
                return
            }
            
            // 2. Transform the bounding box from the processed image to the origin image
            // The coordinates are normalized to the dimensions of the processed image, with the origin at the image's lower-left corner.
            let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -pageHeight)
            let rect: CGRect = VNImageRectForNormalizedRect(boundingBox.boundingBox, Int(pageWidth), Int(pageHeight))
                .applying(transform)
            
            // 3. Calculate the best matching font size
            let fontSize = FontSizeCalculator.shared.fontSizeThatFits(text: text, rectSize: rect.size)
            let font = UIFont.systemFont(ofSize: fontSize)
            
            //4. Create and prepare an NSAttributedString
            let attributedString = NSAttributedString(
                string: text,
                attributes:  [
                    NSAttributedString.Key.font: font
                ]
            )
            
            // 5. Draw the attributed string in the transformed rect
            attributedString.draw(in: rect)
        }
        
    func draw(image: UIImage, on cgContext: CGContext, withSize: CGRect) {
            // Draws the image in the current graphics context
            image.draw(in: withSize)
        }}}
