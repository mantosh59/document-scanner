package com.mantosh.plugins.mdocumentscanner;

import static com.google.mlkit.vision.documentscanner.GmsDocumentScannerOptions.SCANNER_MODE_FULL;

import android.Manifest;
import android.app.Activity;
import android.graphics.Bitmap;

import androidx.activity.result.ActivityResult;
import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.IntentSenderRequest;
import androidx.activity.result.contract.ActivityResultContracts;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;
import com.getcapacitor.annotation.Permission;
import com.google.mlkit.vision.documentscanner.GmsDocumentScannerOptions;
import com.google.mlkit.vision.documentscanner.GmsDocumentScanning;
import com.google.mlkit.vision.documentscanner.GmsDocumentScanningResult;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import com.mantosh.plugins.MdocumentScanner.R;
import com.tom_roush.pdfbox.android.PDFBoxResourceLoader;
import com.tom_roush.pdfbox.pdmodel.PDDocument;
import com.tom_roush.pdfbox.rendering.ImageType;
import com.tom_roush.pdfbox.rendering.PDFRenderer;


@CapacitorPlugin(name = "MdocumentScanner", permissions = {
        @Permission(strings = {Manifest.permission.CAMERA}, alias = MdocumentScanner.CAMERA)
})
public class MdocumentScanner extends Plugin {

    // Permission alias constants
    static final String CAMERA = "camera";

    private ActivityResultLauncher<IntentSenderRequest> scannerLauncher;

    private PluginCall pluginCall;

    @Override
    public void load() {
        super.load();
        scannerLauncher =
                bridge.getActivity().registerForActivityResult(new ActivityResultContracts.StartIntentSenderForResult(), this::handleActivityResult);
    }

    @PluginMethod
    public void scanDocument(PluginCall call) {
        pluginCall = call;

        GmsDocumentScannerOptions.Builder options =
                new GmsDocumentScannerOptions.Builder()
                        .setResultFormats(
                                GmsDocumentScannerOptions.RESULT_FORMAT_JPEG,
                                GmsDocumentScannerOptions.RESULT_FORMAT_PDF)
                        .setScannerMode(SCANNER_MODE_FULL)
                        .setPageLimit(call.getInt("maxNumDocuments") != null ? call.getInt("maxNumDocuments") : 1)
                        .setGalleryImportAllowed(false);

        GmsDocumentScanning.getClient(options.build())
                .getStartScanIntent(bridge.getActivity())
                .addOnSuccessListener(
                        intentSender ->
                                scannerLauncher.launch(new IntentSenderRequest.Builder(intentSender).build()))
                .addOnFailureListener(e -> {

                });
    }

    private void handleActivityResult(ActivityResult activityResult) {
        int resultCode = activityResult.getResultCode();
        GmsDocumentScanningResult result =
                GmsDocumentScanningResult.fromActivityResultIntent(activityResult.getData());
        JSObject ret = new JSObject();
        if (resultCode == Activity.RESULT_OK && result != null) {
            if (result.getPdf() != null) {
                File file = new File(result.getPdf().getUri().getPath());
                // List<String> imagePathArr = new ArrayList<>();
                if (pluginCall.getString("responseType").equalsIgnoreCase("base64")) {
                    ret.put("scannedFiles", encodeFileToBase64(file));
                } else {
                    //result.getPdf().getUri().toString()
//                    imagePathArr.add(result.getPdf().getUri().getPath());
                    // imagePathArr.add(getScannedResult(file).getPath());
                    ret.put("scannedFiles",result.getPdf().getUri().getPath());
                }
                ret.put("status", "success");
                pluginCall.resolve(ret);
            }
        } else if (resultCode == Activity.RESULT_CANCELED) {
            ret.put("status", bridge.getActivity().getString(R.string.error_scanner_cancelled));
        } else {
            ret.put("status", bridge.getActivity().getString(R.string.error_default_message));
        }
        pluginCall.resolve(ret);
    }

    private File getScannedResult(File pdfFile) {
        PDFBoxResourceLoader.init(bridge.getActivity());
        try {
            // Load in an already created PDF
            PDDocument document = PDDocument.load(pdfFile);
            // Create a renderer for the document
            PDFRenderer renderer = new PDFRenderer(document);
            // Render the image to an RGB Bitmap
            Bitmap pageImage = renderer.renderImage(0, 1, ImageType.RGB);

            // Save the render result to an image
            String path = bridge.getContext().getCacheDir().getAbsolutePath() + "/scanned_document.jpg";
            File renderFile = new File(path);
            FileOutputStream fileOut = new FileOutputStream(renderFile);
            pageImage.compress(Bitmap.CompressFormat.JPEG, 100, fileOut);
            fileOut.close();
            File filePath = new File(path);
            return filePath;
        }
        catch (IOException e)
        {
            return null;
        }
    }

    private static String encodeFileToBase64(File file) {
        String b64 = "";
        try {
            byte[] bytes = new byte[0];
            if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.O) {
                bytes = Files.readAllBytes(file.toPath());
                b64 = Base64.getEncoder().encodeToString(bytes);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return b64;
    }
}
