import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@available(iOS 13.0, *)
@objc(DocumentScannerPlugin)
public class DocumentScannerPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "DocumentScannerPlugin"
    public let jsName = "DocumentScanner"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "scanDocument", returnType: CAPPluginReturnPromise)
    ]
//    private let implementation = EGDocScanner()

    /** @property  documentScanner the document scanner */
    let documentScanner: DocumentScanner = DocumentScanner()
    
    /**
     * start the document scanner and register callbacks
     *
     * @param  call contains JS inputs and lets you return results
     */
    @objc func scanDocument(_ call: CAPPluginCall) {
        // launch the document scanner
        documentScanner.startScan(
            bridge?.viewController,
            successHandler: { (scannedDocumentImages: [String]) in
                // document scan success
                call.resolve([
                    "status": "success",
                    "scannedImages": scannedDocumentImages
                ])
            },
            errorHandler: { (errorMessage: String) in
                // document scan error
                call.reject(errorMessage)
            },
            cancelHandler: {
                // when user cancels document scan
                call.resolve([
                    "status": "cancel"
                ])
            },
            responseType: call.getString("responseType")
        )
    }}
