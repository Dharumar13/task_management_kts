
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../../../app_utility/app_util.dart';
import '../../../app_utility/color_resource.dart';
import '../../../app_utility/fonts.dart';
import '../../../widgets/custom_text.dart';
import '../bloc/audit_form_bloc.dart';
import '../model/audit_form_model.dart';

class ImagePreviewScreen extends StatefulWidget {
 final Question? imageList;
  final dynamic selectIndex;

  const ImagePreviewScreen(
      {super.key, this.imageList, this.selectIndex});

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  int? index;
  int? imageId;

  late int _currentIndex = widget.selectIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    _currentIndex = int.parse(widget.selectIndex);
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    super.dispose();

    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuditFormBloc, AuditFormState>(
        builder: (context, state) {
          return Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(70.0),
                child: AppBar(
                    toolbarHeight: 80,
                    scrolledUnderElevation: 0.0,
                    leadingWidth: MediaQuery.of(context).size.width,
                    backgroundColor: ColorResource.colorWhite,
                    leading: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
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
                              context.pop();
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, bottom: 4.0),
                            child: CustomText(
                             "Back",
                              style: GoogleFonts.readexPro(
                                  color: ColorResource.color232323,
                                  fontSize: AppUtils.getDeviceType() == "tablet"
                                      ? FontSize1.twentyEight
                                      : FontSize1.twentyFour,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    )
                ),
              ),
              backgroundColor: ColorResource.colorWhite,
              body: Stack(
                children: [
                  if (state is AuditFormLoading) const SizedBox(),
                  widget.imageList!.images!.isNotEmpty
                      ? photoView(context)
                      : Center(
                    child: CustomText("No image"),
                  ),
                  Positioned(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (state is AuditFormLoading)
                            SizedBox(child: AppUtils().buildLoading()),
                        ],
                      )),
                ],
              ));
        }, listener: (context, state) {
      if (state is AuditFormLoaded) {}
    });
  }

  Widget photoView(BuildContext context) {
    return PhotoViewGallery.builder(
      pageController: _pageController,
      itemCount: widget.imageList!.images?.length ?? 0,
      enableRotation: true,
      builder: (context, index) {
        return PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage(
            "${widget.imageList?.images![index].url}",
          ),
        );
      },
      loadingBuilder: (context, event) {
        return CupertinoActivityIndicator(
          color: Theme
              .of(context)
              .colorScheme
              .secondary,
        );
      },
      onPageChanged: (index) {
        _currentIndex = index;
      },
    );
  }

  Widget photoViewActions(BuildContext context) {
    return Container(
        height: 60,
        decoration: BoxDecoration(

            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Center(
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        "Photos",
                        fontWeight: FontWeight.bold,
                        color: ColorResource.colorWhite,
                        fontSize: 18,
                      ),
                      Container(
                          height: 50,
                          width: 45,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(30)),
                              color: ColorResource.colorWhite),
                          child: GestureDetector(
                              onTap: () {
                                AppUtils.showCustomDialog(context,
                                    title: "Delete",
                                    onPressed: () {}

                                );
                              }
                          )
                      )
                    ]
                )
            )));
  }

}

