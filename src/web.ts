import { WebPlugin } from '@capacitor/core';

import type { MDocumentScannerPlugin, ScanDocumentOptions, ScanDocumentResponse } from './definitions';

export class MDocumentScannerWeb extends WebPlugin implements MDocumentScannerPlugin {
  async scanDocument(options?: ScanDocumentOptions): Promise<ScanDocumentResponse> {
    console.log(options)
    throw this.unimplemented('Not implemented on web.');
  }
}
