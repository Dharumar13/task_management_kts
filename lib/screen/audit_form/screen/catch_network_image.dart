import 'package:flutter/material.dart';
import '../../../app_utility/app_util.dart';

class GalleryImageBox extends StatelessWidget {
 const  GalleryImageBox({
    super.key,
    required this.photo,
  });
 final String? photo;

  @override
  Widget build(BuildContext context) {
    return
      ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      child:Image.network(photo!,
      width: AppUtils.getDeviceType()=="tablet"? 100:100,
      height:AppUtils.getDeviceType()=="tablet"? 100:100,
      fit: BoxFit.fill,
      loadingBuilder: (context,child,loadingProgress){
        if(loadingProgress==null)return child;

        final totalByetes=loadingProgress.expectedTotalBytes;
        final bytesLoaded=loadingProgress.cumulativeBytesLoaded;
        final value=totalByetes==null?null:bytesLoaded/totalByetes;

        return Center(child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: CircularProgressIndicator(value:value,),
        ));
      },
      )
    );
  }
}


class GalleryProfileCircle extends StatelessWidget {
 const GalleryProfileCircle({
    super.key,
    required this.photo,
  });
 final String? photo;

  @override
  Widget build(BuildContext context) {
    return
      ClipRRect(
        borderRadius: BorderRadius.circular(75), // Half of the width or height to make it circular
        child: Image.network(
          photo!,
          width: AppUtils.getDeviceType()=="tablet"? 122:105,
          height:AppUtils.getDeviceType()=="tablet"? 122:105,
          fit: BoxFit.fill,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;

            final totalBytes = loadingProgress.expectedTotalBytes;
            final bytesLoaded = loadingProgress.cumulativeBytesLoaded;
            final value = totalBytes == null ? null : bytesLoaded / totalBytes;

            return Center(child: SizedBox(
                height: AppUtils.getDeviceType()=="tablet"? 122:105,
                width: AppUtils.getDeviceType()=="tablet"? 122:105,
                child: CircularProgressIndicator(value: value)));
          },
        ),
      );
  }
}
