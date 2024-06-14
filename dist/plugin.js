var capacitorEGDocScanner = (function (exports, core) {
    'use strict';

    exports.ResponseType = void 0;
    (function (ResponseType) {
        /**
         * Use this response type if you want document scan returned as base64 images.
         */
        ResponseType["Base64"] = "base64";
        /**
         * Use this response type if you want document scan returned as inmage file paths.
         */
        ResponseType["ImageFilePath"] = "imageFilePath";
    })(exports.ResponseType || (exports.ResponseType = {}));
    exports.ScanDocumentResponseStatus = void 0;
    (function (ScanDocumentResponseStatus) {
        /**
         * The status comes back as success if the document scan completes
         * successfully.
         */
        ScanDocumentResponseStatus["Success"] = "success";
        /**
         * The status comes back as cancel if the user closes out of the camera
         * before completing the document scan.
         */
        ScanDocumentResponseStatus["Cancel"] = "cancel";
    })(exports.ScanDocumentResponseStatus || (exports.ScanDocumentResponseStatus = {}));

    const EGDocScanner = core.registerPlugin('EGDocScanner', {
        web: () => Promise.resolve().then(function () { return web; }).then(m => new m.EGDocScannerWeb()),
    });

    class EGDocScannerWeb extends core.WebPlugin {
        async scanDocument(options) {
            console.log(options);
            throw this.unimplemented('Not implemented on web.');
        }
    }

    var web = /*#__PURE__*/Object.freeze({
        __proto__: null,
        EGDocScannerWeb: EGDocScannerWeb
    });

    exports.EGDocScanner = EGDocScanner;

    Object.defineProperty(exports, '__esModule', { value: true });

    return exports;

})({}, capacitorExports);
//# sourceMappingURL=plugin.js.map
