import { registerPlugin } from '@capacitor/core';
const EGDocScanner = registerPlugin('EGDocScanner', {
    web: () => import('./web').then(m => new m.EGDocScannerWeb()),
});
export * from './definitions';
export { EGDocScanner };
//# sourceMappingURL=index.js.map