import { WebPlugin } from '@capacitor/core';

import type { EGDocScannerPlugin, ScanDocumentOptions, ScanDocumentResponse } from './definitions';

export class EGDocScannerWeb extends WebPlugin implements EGDocScannerPlugin {
  async scanDocument(options?: ScanDocumentOptions): Promise<ScanDocumentResponse> {
    console.log(options)
    throw this.unimplemented('Not implemented on web.');
  }
}
