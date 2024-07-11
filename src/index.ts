import { registerPlugin } from '@capacitor/core';

import type { MdocumentScannerPlugin } from './definitions';

const MdocumentScanner = registerPlugin<MdocumentScannerPlugin>('MdocumentScanner', {
  web: () => import('./web').then(m => new m.MdocumentScannerWeb()),
});

export * from './definitions';
export { MdocumentScanner };