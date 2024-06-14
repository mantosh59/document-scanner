package com.envoyglobal.plugins.egdocscanner;

import static com.google.mlkit.vision.documentscanner.GmsDocumentScannerOptions.SCANNER_MODE_FULL;

import android.Manifest;
import android.app.Activity;
import android.net.Uri;
import android.os.Build;

import androidx.activity.result.ActivityResult;
import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.IntentSenderRequest;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.core.content.FileProvider;

import com.getcapacitor.JSArray;
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
import java.io.IOException;
import java.nio.file.Files;
import java.util.Base64;

@CapacitorPlugin(name = "EGDocScanner", permissions = {
        @Permission(strings = {Manifest.permission.CAMERA}, alias = EGDocScannerPlugin.CAMERA)
})
public class EGDocScannerPlugin extends Plugin {

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
                if (pluginCall.getString("responseType").equalsIgnoreCase("base64")) {
                    ret.put("scannedFiles", encodeFileToBase64(file));
                } else {
                    ret.put("scannedFiles", result.getPdf().getUri().toString());
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