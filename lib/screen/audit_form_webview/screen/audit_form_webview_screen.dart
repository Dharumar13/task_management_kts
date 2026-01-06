import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart' as webview_flutter_android;
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import '../../../app_utility/app_constant.dart';
import '../../../app_utility/app_util.dart';
import '../../../app_utility/color_resource.dart';
import '../../../app_utility/fonts.dart';
import '../../../widgets/custom_text.dart';

class AuditFormWebViewScreen extends StatefulWidget {
  final String? taskUrl;

  const AuditFormWebViewScreen({super.key, required this.taskUrl});

  @override
  State<AuditFormWebViewScreen> createState() => _AuditFormWebViewScreenState();
}

class _AuditFormWebViewScreenState extends State<AuditFormWebViewScreen> {
  bool isLoading = true;
  String url = '';

  late final WebViewController _controller;

  @override
  void initState() {
    url = widget.taskUrl!;

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: false,

        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = WebKitWebViewControllerCreationParams(

      );
    }


    final WebViewController controller = WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    if (Platform.isAndroid) {
      final myAndroidController = controller.platform as webview_flutter_android.AndroidWebViewController;
      myAndroidController.setOnShowFileSelector(_androidFilePicker);

    }
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');

          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('Navigation request to: ${request.url}');

            if (request.url.startsWith('tel:')) {
              debugPrint('Blocking navigation to ${request.url} (tel: link)');
              return NavigationDecision.prevent;
            }
            if (request.url.startsWith('mailto:')) {
              debugPrint('Blocking navigation to ${request.url} (mailto: link)');
              return NavigationDecision.prevent;
            }
            if (request.url.endsWith('.jpg') ||
                request.url.endsWith('.jpeg') ||
                request.url.endsWith('.png') ||
                request.url.endsWith('.gif')) {
              setState(() {
                url=request.url;
                _showImageDialog(url);
              });
              debugPrint('Allowing navigation to image URL: ${request.url}');

              return NavigationDecision.prevent;
            }
            if(request.url.contains('http://pact.close/')){
              backNavigation();
              return NavigationDecision.prevent;
            }

            debugPrint('Allowing navigation to hhhhhh ${request.url}');

            return NavigationDecision.navigate;
          },

          onWebResourceError: (WebResourceError error) {
            debugPrint('''
              Page resource error:
              code: ${error.errorCode}
              description: ${error.description}
              errorType: ${error.errorType}
              isForMainFrame: ${error.isForMainFrame}
          ''');
          },


          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )

      ..loadRequest(Uri.parse(url)).then((value) async {
        await controller.enableZoom(false);
      });
    _controller = controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70.0),
        child: AppBar(
          toolbarHeight: 80,
          scrolledUnderElevation: 0.0,
          leadingWidth: MediaQuery.of(context).size.width,
          backgroundColor: ColorResource.colorWhite,
          leading: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: ColorResource.color5A5C60,
                  ),
                  iconSize: 30,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    Navigator.pop(context, true);
                    //  context.pushReplacementNamed(RouterNames.jobBoardRouter);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 14.0, bottom: 4.0),
                  child: CustomText(
                    StringResource.auditForm,
                    style: GoogleFonts.readexPro(
                      color: ColorResource.color232323,
                      fontSize: AppUtils.getDeviceType() == "tablet" ? FontSize1.twentyEight : FontSize1.twentyFour,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: _controller,
          ),
        ],
      ),
    );
  }
  backNavigation(){
Navigator.pop(context,true);
  }
  void _showImageDialog(String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shadowColor: ColorResource.colorWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          backgroundColor: ColorResource.colorWhite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0,bottom: 8.0,left: 4.0,right: 4.0),
                child: Container(
                  color: ColorResource.colorWhite,
                  height: MediaQuery.of(context).size.height / 1.7,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      } else {
                        return SizedBox(
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                  : null,
                            ),
                          ),
                        );
                      }
                    },
                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                      return const Center(
                        child: Text('Failed to load image'),
                      );
                    },
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 40,
                  color:ColorResource.color003867,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Close',
                        style: GoogleFonts.readexPro(
                          color: ColorResource.colorWhite,
                          fontSize: AppUtils.getDeviceType() == "tablet" ? FontSize1.fifteen : FontSize1.fifteen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }




  Future<List<String>> _androidFilePicker(webview_flutter_android.FileSelectorParams params) async {
    // Show the bottom sheet to let the user choose between camera or file picker
    final choice = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: ColorResource.colorWhite,
      builder: (BuildContext context) {
        return Wrap(

          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.camera,color: ColorResource.color1B65B1,),
              title: Text('Camera',
                style: GoogleFonts.readexPro(
                  color: ColorResource.color232323,
                  fontSize: AppUtils.getDeviceType() == "tablet" ? FontSize1.eighteen : FontSize1.fifteen,
                  fontWeight: FontWeight.w400,
                )),
              onTap: () => Navigator.pop(context, 'camera'),
            ),
            ListTile(
              leading: const Icon(Icons.image,color: ColorResource.color1B65B1),
              title: Text('Image',
                  style: GoogleFonts.readexPro(
                    color: ColorResource.color232323,
                    fontSize: AppUtils.getDeviceType() == "tablet" ? FontSize1.eighteen : FontSize1.fifteen,
                    fontWeight: FontWeight.w400,
                  )),
              onTap: () => Navigator.pop(context, 'image'),
            ),
            ListTile(
              leading: const Icon(Icons.folder,color: ColorResource.color1B65B1),
              title: Text('File Picker',
                  style: GoogleFonts.readexPro(
                    color: ColorResource.color232323,
                    fontSize: AppUtils.getDeviceType() == "tablet" ? FontSize1.eighteen : FontSize1.fifteen,
                    fontWeight: FontWeight.w400,
                  )),
              onTap: () => Navigator.pop(context, 'filePicker'),
            ),
          ],
        );
      },
    );

    if (choice == 'camera') {
      final file = await ImagePicker().pickImage(source: ImageSource.camera);
      if (file != null) {
        String filePath = file.path;
        String name = file.name;
        List<int> fileBytes = await File(filePath).readAsBytes();
        final directory = await getTemporaryDirectory();
        final filePath1 = directory.uri.resolve(name);
        final fileData = await File.fromUri(filePath1).create(recursive: true);
        await fileData.writeAsBytes(fileBytes, flush: true);

        return [fileData.uri.toString()];
      }
    } else if (choice == 'filePicker') {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        String filePath = result.files.single.path!;
        String fileName = result.files.single.name;

        // Convert the file to base64
        List<int> fileBytes = await File(filePath).readAsBytes();

        // Convert filepath into uri
        final directory = await getTemporaryDirectory();
        final filePath1 = directory.uri.resolve(fileName);
        final file = await File.fromUri(filePath1).create(recursive: true);

        // Convert file in bytes
        await file.writeAsBytes(fileBytes, flush: true);
        return [file.uri.toString()];
      }
    } else if (choice == 'image') {
      final file = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (file != null) {
        String filePath = file.path;
        String name = file.name;
        List<int> fileBytes = await File(filePath).readAsBytes();
        final directory = await getTemporaryDirectory();
        final filePath1 = directory.uri.resolve(name);
        final fileData = await File.fromUri(filePath1).create(recursive: true);
        await fileData.writeAsBytes(fileBytes, flush: true);

        return [fileData.uri.toString()];
      }
    }

    return [];
  }
}
