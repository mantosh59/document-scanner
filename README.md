# mdocument-scanner

Document scanner

Plugin is in development stage.

## Install

```bash
npm install mdocument-scanner
npx cap sync
```

## API

<docgen-index>

* [`scanDocument(...)`](#scandocument)
* [Interfaces](#interfaces)
* [Enums](#enums)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### scanDocument(...)

```typescript
scanDocument(options: ScanDocumentOptions) => Promise<ScanDocumentResponse>
```

| Param         | Type                                                                |
| ------------- | ------------------------------------------------------------------- |
| **`options`** | <code><a href="#scandocumentoptions">ScanDocumentOptions</a></code> |

**Returns:** <code>Promise&lt;<a href="#scandocumentresponse">ScanDocumentResponse</a>&gt;</code>

--------------------


### Interfaces


#### ScanDocumentResponse

| Prop               | Type                                                                              | Description                                                                                                                       |
| ------------------ | --------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| **`scannedFiles`** | <code>string</code>                                                               | This is an array with either file paths or base64 images for the document scan.                                                   |
| **`status`**       | <code><a href="#scandocumentresponsestatus">ScanDocumentResponseStatus</a></code> | The status lets you know if the document scan completes successfully, or if the user cancels before completing the document scan. |


#### ScanDocumentOptions

| Prop                  | Type                                                  | Description                                                                                                       | Default                                   |
| --------------------- | ----------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------- | ----------------------------------------- |
| **`maxNumDocuments`** | <code>number</code>                                   | Android only: The maximum number of photos an user can take (not counting photo retakes)                          | <code>: 4</code>                          |
| **`responseType`**    | <code><a href="#responsetype">ResponseType</a></code> | The response comes back in this format on success. It can be the document scan image file paths or base64 images. | <code>: ResponseType.ImageFilePath</code> |


### Enums


#### ScanDocumentResponseStatus

| Members       | Value                  | Description                                                                                               |
| ------------- | ---------------------- | --------------------------------------------------------------------------------------------------------- |
| **`Success`** | <code>'success'</code> | The status comes back as success if the document scan completes successfully.                             |
| **`Cancel`**  | <code>'cancel'</code>  | The status comes back as cancel if the user closes out of the camera before completing the document scan. |


#### ResponseType

| Members             | Value                        | Description                                                                     |
| ------------------- | ---------------------------- | ------------------------------------------------------------------------------- |
| **`Base64`**        | <code>'base64'</code>        | Use this response type if you want document scan returned as base64 images.     |
| **`ImageFilePath`** | <code>'imageFilePath'</code> | Use this response type if you want document scan returned as inmage file paths. |

</docgen-api>
