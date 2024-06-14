import { registerPlugin } from '@capacitor/core';

import type { MDocumentScannerPlugin } from './definitions';

const MDocumentScanner = registerPlugin<MDocumentScannerPlugin>('MDocumentScanner', {
  web: () => import('./web').then(m => new m.MDocumentScannerWeb()),
});

export * from './definitions';
export { MDocumentScanner };