import { registerPlugin } from '@capacitor/core';

import type { EGDocScannerPlugin } from './definitions';

const EGDocScanner = registerPlugin<EGDocScannerPlugin>('EGDocScanner', {
  web: () => import('./web').then(m => new m.EGDocScannerWeb()),
});

export * from './definitions';
export { EGDocScanner };