import { WebPlugin } from '@capacitor/core';

import type { MdocumentScannerPlugin, ScanDocumentOptions, ScanDocumentResponse } from './definitions';

export class MdocumentScannerWeb extends WebPlugin implements MdocumentScannerPlugin {
  async scanDocument(options?: ScanDocumentOptions): Promise<ScanDocumentResponse> {
    console.log(options)
    throw this.unimplemented('Not implemented on web.');
  }
}
