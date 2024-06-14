import { registerPlugin } from '@capacitor/core';

import type { DocumentScannerPlugin } from './definitions';

const EGDocScanner = registerPlugin<DocumentScannerPlugin>('DocumentScanner', {
  web: () => import('./web').then(m => new m.DocumentScannerWeb()),
});

export * from './definitions';
export { EGDocScanner };