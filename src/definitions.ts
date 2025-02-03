export interface MdocumentScannerPlugin {
  scanDocument(options: ScanDocumentOptions): Promise<ScanDocumentResponse>
}

export interface ScanDocumentOptions {
  /**
   * Android only: The maximum number of photos an user can take (not counting photo retakes)
   * @default: 1
   */
  maxNumDocuments?: number

  /**
   * The response comes back in this format on success. It can be the document
   * scan image file paths or base64 images.
   * @default: ResponseType.ImageFilePath
   */
  responseType?: ResponseType,

  /**
   * If true it will output scanned files as array of image URI
   * @default: false
   */
  outputAsMultiplePath?: boolean,
}

export enum ResponseType {
  /**
   * Use this response type if you want document scan returned as base64 images.
   */
  Base64 = 'base64',

  /**
   * Use this response type if you want document scan returned as inmage file paths.
   */
  ImageFilePath = 'imageFilePath'
}

export interface ScanDocumentResponse {
  /**
   * This is an array with either file path or base64 for the
   * document scan.
   */
  scannedFiles: string[]

  /**
   * The status lets you know if the document scan completes successfully,
   * or if the user cancels before completing the document scan.
   */
  status: ScanDocumentResponseStatus
}

export enum ScanDocumentResponseStatus {
  /**
   * The status comes back as success if the document scan completes
   * successfully.
   */
  Success = 'success',

  /**
   * The status comes back as cancel if the user closes out of the camera
   * before completing the document scan.
   */
  Cancel = 'cancel'
}
