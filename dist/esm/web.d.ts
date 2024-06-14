import { WebPlugin } from '@capacitor/core';
import type { EGDocScannerPlugin, ScanDocumentOptions, ScanDocumentResponse } from './definitions';
export declare class EGDocScannerWeb extends WebPlugin implements EGDocScannerPlugin {
    scanDocument(options?: ScanDocumentOptions): Promise<ScanDocumentResponse>;
}
