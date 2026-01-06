import 'package:task_management_kts/app_utility/app_util.dart';
import 'package:task_management_kts/router/router_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_utility/app_constant.dart';
import '../../../app_utility/color_resource.dart';
import '../../../app_utility/constant.dart';
import '../../../app_utility/fonts.dart';
import '../../../app_utility/singleton.dart';
import '../../../widgets/custom_text.dart';
import '../bloc/audit_form_bloc.dart';
import 'audit_form_widgets.dart';
import 'catch_network_image.dart';

class AuditFormScreen extends StatefulWidget {
  final String? layoutId;
  final String? date;

  const AuditFormScreen({super.key, required this.layoutId, required this.date});

  @override
  State<AuditFormScreen> createState() => _AuditFormScreenState();
}

class _AuditFormScreenState extends State<AuditFormScreen> {

  int? pageIndex = 0;

  @override
  void initState() {
    data();
    AppUtils.getDeviceType();
    super.initState();
  }

  data() async {
    context.read<AuditFormBloc>().add(GetAuditList(widget.layoutId!));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
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
                     Navigator.pop(context,true);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, bottom: 4.0),
                    child: CustomText(
                      StringResource.auditForm,
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
        body: BlocConsumer<AuditFormBloc, AuditFormState>(
          builder: (context, state) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              color: ColorResource.colorWhite,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  children: [
                    if (state is AuditFormLoaded)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0,right:8.0),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${Singleton().site} ",
                                    style: GoogleFonts.inter(
                                      color: ColorResource.color1C1F26, // Set color for the text
                                      fontSize: AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen: FontSize1.thirteen,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ": ${Singleton().agency}",
                                    style: TextStyle(
                                      color: ColorResource.color003867, // Set color for the asterisk
                                      fontSize: AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen: FontSize1.thirteen,
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),

                                ],

                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16.0, right: 16.0, top: 23.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: CustomText(
                                    "${context.read<AuditFormBloc>().auditFormModel?.data?.layoutName}",
                                    isSingleLine: true,
                                    //"DOG FOOD - WET",
                                    style: GoogleFonts.inter(
                                        color: ColorResource.color12151C,
                                        fontSize:
                                            AppUtils.getDeviceType() == "tablet"
                                                ? FontSize1.thirteen
                                                : FontSize1.thirteen,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Divider(
                              thickness: 1.0,
                              color: ColorResource.color707070,
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),

                            Expanded(
                              child: ListView.builder(
                                itemCount: context.read<AuditFormBloc>().auditFormModel?.data?.questions?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    decoration:BoxDecoration(
                                      border: Border(
                                        left: BorderSide(width: 1.0, color: ColorResource.colorF6F6F7.withValues(alpha: 0.8)),
                                        right: BorderSide(width: 1.0, color: ColorResource.colorF6F6F7.withValues(alpha: 0.8)),
                                        bottom: BorderSide(width: 1.0, color: ColorResource.colorF6F6F7.withValues(alpha: 0.8)),
                                        top: BorderSide(width: 1.0, color: ColorResource.colorF6F6F7.withValues(alpha: 0.8)),
                                      ),
                                    ),
                                    child: Padding(
                                      padding:  EdgeInsets.only(top: 16.0,bottom: 16.0,left:AppUtils.getDeviceType() == "tablet" ? 49.0:10,right:AppUtils.getDeviceType() == "tablet" ? 23.0:10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width:AppUtils.getDeviceType() == "tablet" ?MediaQuery.sizeOf(context).width/1.4:MediaQuery.sizeOf(context).width/2,
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: "${context.read<AuditFormBloc>().auditFormModel?.data?.questions![index].question} ",
                                                        style: GoogleFonts.inter(
                                                          color: ColorResource.color1C1F26, // Set color for the text
                                                          fontSize: AppUtils.getDeviceType() == "tablet" ? FontSize1.fifteen : FontSize1.twelve,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                     TextSpan(
                                                        text: "*",
                                                        style: TextStyle(
                                                          color: ColorResource.colorE65454, // Set color for the asterisk
                                                          fontSize: AppUtils.getDeviceType() == "tablet" ? FontSize1.fifteen : FontSize1.twelve,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ),
                                              const Spacer(),
                                              SizedBox(
                                                height: AppUtils.getDeviceType() == "tablet" ? 25 : 15,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: <Widget>[
                                                    Radio<int>(
                                                      visualDensity: VisualDensity.compact,
                                                      value: 1,
                                                      groupValue: int.parse("${context.read<AuditFormBloc>().auditFormModel?.data!.questions![index].answer}"),
                                                      onChanged: context.read<AuditFormBloc>().isSubmit == true ? null
                                                          : (int? val) {
                                                        context.read<AuditFormBloc>().add(SelectAuditRadioButton(index, val, context.read<AuditFormBloc>().auditFormModel?.data!.questions![index].qstnId.toString()));
                                                              context.read<AuditFormBloc>().auditFormModel?.data!.questions![index].ansReqired = "0";
                                                            },
                                                      activeColor: ColorResource.color003867,
                                                      fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState>states) {
                                                          if (states.contains(WidgetState.selected)) {
                                                            return ColorResource.color003867;
                                                          }
                                                          return ColorResource.color003867;
                                                        },
                                                      ),
                                                    ),
                                                    CustomText(
                                                      'Yes',
                                                      style: GoogleFonts.inter(color: ColorResource.color12151C, fontSize: AppUtils.getDeviceType() == "tablet" ? FontSize1.fifteen : FontSize1.twelve,
                                                        fontWeight: FontWeight.w400)),
                                                    Radio<int>(
                                                      visualDensity: VisualDensity.compact,
                                                      value: 2,
                                                      groupValue: int.parse("${context.read<AuditFormBloc>().auditFormModel?.data!.questions![index].answer}"),
                                                      onChanged: context.read<AuditFormBloc>().isSubmit == true ? null
                                                          : (int? val) {

                                                              context.read<AuditFormBloc>().add(SelectAuditRadioButton(index, val, context.read<AuditFormBloc>().auditFormModel?.data!.questions![index]
                                                                      .qstnId.toString()));
                                                              context.read<AuditFormBloc>().auditFormModel?.data!.questions![index].ansReqired = "0";
                                                            },
                                                      activeColor: ColorResource.color003867,
                                                      fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState>states) {
                                                          if (states.contains(WidgetState.selected)) {
                                                            return ColorResource.color003867;
                                                          }
                                                          return ColorResource.color003867;
                                                        },
                                                      ),
                                                    ),
                                                    CustomText(
                                                      'No',
                                                      style: GoogleFonts.inter(color: ColorResource.color12151C,
                                                        fontSize: AppUtils.getDeviceType() == "tablet" ? FontSize1.fifteen : FontSize1.twelve,
                                                        fontWeight: FontWeight.w400))],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 20,),
                                          CustomText(
                                           "Comment",
                                            style: GoogleFonts.inter(
                                                color: ColorResource.color232323,
                                                fontSize: AppUtils.getDeviceType() == "tablet" ? FontSize1.fifteen : FontSize1.thirteen,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          const SizedBox(height: 10,),
                                          SizedBox(
                                            width:MediaQuery.sizeOf(context).width/1,
                                            child: Row(
                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width:context.read<AuditFormBloc>().isSubmit==true?MediaQuery.sizeOf(context).width/1.35:MediaQuery.sizeOf(context).width/1.32,
                                                  child: TextFormField(
                                                    validator: (String? values) {
                                                      if (values!.isEmpty) {
                                                        return "Please enter comment";
                                                      }
                                                      return null;
                                                    },
                                                    readOnly: context.read<AuditFormBloc>().isSubmit!,
                                                    initialValue: "${ context.read<AuditFormBloc>().auditFormModel?.data?.questions![index].comment}",
                                                    keyboardType: TextInputType.multiline,
                                                    decoration: InputDecoration(
                                                        isDense: true,
                                                        contentPadding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 15.0),
                                                        hintStyle: GoogleFonts.inter(
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: FontSize1.thirteen,
                                                            color: ColorResource
                                                                .color232323),
                                                        enabledBorder:
                                                        const OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(10)),
                                                          borderSide: BorderSide(
                                                              width: 2.0,
                                                              color: ColorResource
                                                                  .color95ACC0), //<-- SEE HERE
                                                        ),
                                                        border: const OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(10)),
                                                          borderSide: BorderSide(
                                                              width: 2.0,
                                                              color: ColorResource
                                                                  .color95ACC0), //<-- SEE HERE
                                                        ),
                                                        focusedBorder:
                                                        const OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(10)),
                                                          borderSide: BorderSide(
                                                              width: 2.0,
                                                              color: ColorResource
                                                                  .color95ACC0), //<-- SEE HERE
                                                        ),
                                                        errorBorder:
                                                        const OutlineInputBorder(
                                                          borderRadius: BorderRadius.all(
                                                              Radius.circular(10)),
                                                          borderSide: BorderSide(
                                                              width: 2.0,
                                                              color: ColorResource
                                                                  .colorE65454), //<-- SEE HERE
                                                        ),
                                                        filled: true,
                                                        fillColor:
                                                        ColorResource.colorWhite,
                                                        errorStyle: GoogleFonts.inter(
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: FontSize1.thirteen,
                                                            color: ColorResource
                                                                .colorE65454)),
                                                    onChanged: (String value){
                                                      context.read<AuditFormBloc>().auditFormModel?.data?.questions![index].comment=value;
                                                    },
                                                  ),
                                                ),
                                                IconButton(onPressed: (){
                                                  if( context.read<AuditFormBloc>().isSubmit == false) {
                                                    showImagePicker(context: context,index: index);
                                                  }
                                                }, icon:  Icon(Icons.add_circle,size: 30,color:context.read<AuditFormBloc>().auditFormModel?.data!.questions![index].imgMandatory==1? ColorResource.colorE65454:ColorResource.color003867, )),

                                              ],
                                            ),
                                          ),
                                        const  SizedBox(height: 20,),
                                          context.read<AuditFormBloc>().auditFormModel?.data?.questions![index].images!.length!=0 || context.read<AuditFormBloc>().auditFormModel?.data?.questions![index].imageFileList?.length!=0?    SizedBox(
                                            height:100,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: (context.read<AuditFormBloc>().auditFormModel?.data?.questions![index].images?.length ?? 0) + (context.read<AuditFormBloc>().auditFormModel?.data?.questions![index].imageFileList?.length ?? 0),
                                              cacheExtent: 0,
                                              itemBuilder: (BuildContext context, int indexCombined) {
                                                if (indexCombined < (context.read<AuditFormBloc>().auditFormModel?.data?.questions![index].images?.length ?? 0)) {

                                                  final image = context.read<AuditFormBloc>().auditFormModel?.data?.questions![index].images![indexCombined];
                                                  return Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Stack(
                                                      children: [
                                                        GestureDetector(

                                                            onTap:(){

                                                            },
                                                            child: GalleryImageBox(photo: image?.url)),
                                                      Visibility(visible:context.read<AuditFormBloc>().isSubmit==false,child:Positioned(
                                                        top:5.0,
                                                        right:5.0,
                                                        child: GestureDetector(
                                                          onTap: () {

                                                            deleteImageConfirmSheet(context: context, imageId: "${image?.id}",);

                                                          },
                                                          child: Container(
                                                            padding: const EdgeInsets.all(4),
                                                            decoration: const BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: Colors.white,
                                                            ),
                                                            child:  Icon(
                                                              Icons.delete_outlined,
                                                              size:AppUtils.getDeviceType()=="tablet"?25:20,
                                                              color: ColorResource.colorE65454,
                                                            ),
                                                          ),
                                                        ),
                                                      ))
                                                      ],
                                                    ),
                                                  );
                                                } else {
                                                  // If the current index is within the range of imageFileList list
                                                  final imageFileIndex = indexCombined - (context.read<AuditFormBloc>().auditFormModel?.data?.questions![index].images?.length ?? 0);
                                                  final imageFile = context.read<AuditFormBloc>().auditFormModel?.data?.questions![index].imageFileList?[imageFileIndex];
                                                  if (imageFile != null) {
                                                    return Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Stack(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                                            child: Image.file(
                                                              width: AppUtils.getDeviceType()=="tablet"? 100:100,
                                                              height:AppUtils.getDeviceType()=="tablet"? 100:100,
                                                              fit: BoxFit.fill,
                                                              imageFile,

                                                            ),
                                                          ),
                                                          Positioned(
                                                            top:5.0,
                                                            right:5.0,
                                                            child: GestureDetector(
                                                              onTap: () {
                                                                context.read<AuditFormBloc>().add(
                                                                  RemoveImageEvent(imageFileIndex,index),
                                                                );
                                                              },
                                                              child: Container(
                                                                padding: const EdgeInsets.all(4),
                                                                decoration: const BoxDecoration(
                                                                  shape: BoxShape.circle,
                                                                  color: Colors.white,
                                                                ),
                                                                child:  Icon(
                                                                  Icons.delete_outlined,
                                                                  size:AppUtils.getDeviceType()=="tablet"?25:20,
                                                                  color: ColorResource.colorE65454,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  } else {
                                                    return Container();
                                                  }
                                                }
                                              },
                                            ),
                                          ):const SizedBox()


                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          AppUtils.getDeviceType() == "tablet"
                              ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if(context.read<AuditFormBloc>().isSubmit==false)
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                              final hasPermission =
                                                  await AppUtils()
                                                      .handleLocationPermission(
                                                          context);
                                              if (!hasPermission) return;
                                              if (context.mounted) {
                                                context
                                                    .read<AuditFormBloc>()
                                                    .add(SaveOrSubmitAnswers(
                                                        widget.layoutId!,
                                                        "save"));
                                              }
                                            },
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0),
                                        child: Container(
                                          height: 40,
                                          width:
                                          MediaQuery.of(context)
                                              .size
                                              .width /
                                              2.5,
                                          // margin: const EdgeInsets.only(top: 55),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              const BorderRadius
                                                  .all(Radius
                                                  .circular(
                                                  10)),
                                              border: Border.all(
                                                  width: 1.0,
                                                  color: ColorResource
                                                      .color003867),
                                              color: ColorResource
                                                  .color003867),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                              const EdgeInsets
                                                  .all(8.0),
                                              child: CustomText(
                                                "Save & Close",
                                                style: GoogleFonts.inter(
                                                    color: ColorResource
                                                        .colorWhite,
                                                    fontSize:
                                                    FontSize1
                                                        .fifteen,
                                                    fontWeight:
                                                    FontWeight
                                                        .w400),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {

                                        var result = context.read<AuditFormBloc>().auditFormModel?.data!.questions;
                                        String? values;
                                        String? image;

                                        for (var item in result!) {
                                          values = item.ansReqired == "0" ? "true" : "false";

                                          if(item.imgUpload==1){
                                            if(item.images!.isNotEmpty){
                                              image=item.images!.isEmpty?"false":"true";
                                            }else{
                                              image=item.imageFileList!.isEmpty?"false":"true";
                                            }


                                          }

                                          if(values == "false"){
                                            break;
                                          }
                                          if(image=="false"){
                                            break;
                                          }

                                        }
                                        if (values == "true" && image=="true") {
                                                final hasPermission =
                                                    await AppUtils()
                                                        .handleLocationPermission(
                                                            context);
                                                if (!hasPermission) return;
                                                if (context.mounted) {
                                                  confirmSheet(
                                                      context: context,
                                                      layoutId:
                                                          widget.layoutId!);
                                                }
                                              } else {
                                          alertSheetAllField(message: "All fields are required.", context: context,);

                                        }


                                      },
                                      child: Padding(
                                        padding:
                                        const EdgeInsets.only(
                                            left: 10.0,
                                            right: 10.0),
                                        child: Container(
                                          height: 40,
                                          width:
                                          MediaQuery.of(context)
                                              .size
                                              .width /
                                              2.5,
                                          // margin: const EdgeInsets.only(top: 55),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              const BorderRadius
                                                  .all(Radius
                                                  .circular(
                                                  10)),
                                              border: Border.all(
                                                  width: 2.0,
                                                  color: ColorResource
                                                      .colorE0E3E7),
                                              color: ColorResource
                                                  .colorWhite),
                                          child: Center(
                                            child: Padding(
                                              padding:
                                              const EdgeInsets
                                                  .all(8.0),
                                              child: CustomText(
                                                StringResource
                                                    .submit,
                                                style: GoogleFonts.inter(
                                                    color: ColorResource
                                                        .color5A5C60,
                                                    fontSize:
                                                    FontSize1
                                                        .fifteen,
                                                    fontWeight:
                                                    FontWeight
                                                        .w400),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              if(context.read<AuditFormBloc>().isSubmit==true)
                                Center(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(
                                        left: 10.0,
                                        right: 10.0),
                                    child: Container(
                                      height: 40,
                                      width:
                                      MediaQuery.of(context)
                                          .size
                                          .width /
                                          2.5,
                                      // margin: const EdgeInsets.only(top: 55),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          const BorderRadius
                                              .all(Radius
                                              .circular(
                                              10)),
                                          border: Border.all(
                                              width: 2.0,
                                              color: ColorResource
                                                  .colorE0E3E7),
                                          color: ColorResource
                                              .colorWhite),
                                      child: Center(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets
                                              .only(left: 6.0,right: 6.0),
                                          child: CustomText(
                                            context.read<AuditFormBloc>().message,
                                            style: GoogleFonts.inter(
                                                color: ColorResource
                                                    .color5A5C60,
                                                fontSize:
                                                FontSize1
                                                    .fifteen,
                                                fontWeight:
                                                FontWeight
                                                    .w400),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          )
                              : Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: [
                                if(context.read<AuditFormBloc>().isSubmit==false)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () async{
                                                final hasPermission =
                                                    await AppUtils()
                                                        .handleLocationPermission(
                                                            context);
                                                if (!hasPermission) return;
                                                if (context.mounted) {
                                                  context
                                                      .read<AuditFormBloc>()
                                                      .add(SaveOrSubmitAnswers(
                                                          widget.layoutId!,
                                                          "save"));
                                                }
                                              },
                                        child: Padding(
                                          padding:
                                          const EdgeInsets.only(
                                              left: 10.0,
                                              right: 10.0),
                                          child: Container(
                                            height: 34.0,
                                            width: MediaQuery.of(
                                                context)
                                                .size
                                                .width /
                                                2.5,
                                            // margin: const EdgeInsets.only(top: 55),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                const BorderRadius
                                                    .all(Radius
                                                    .circular(
                                                    10)),
                                                border: Border.all(
                                                    width: 1.0,
                                                    color: ColorResource
                                                        .color003867),
                                                color: ColorResource
                                                    .color003867),
                                            child: Center(
                                              child: Center(
                                                child: CustomText(
                                                  "Save & Close",
                                                  style: GoogleFonts.inter(
                                                      color: ColorResource
                                                          .colorWhite,
                                                      fontSize:
                                                      FontSize1
                                                          .thirteen,
                                                      fontWeight:
                                                      FontWeight
                                                          .w400),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 25.0,
                                      ),
                                      GestureDetector(
                                        onTap: () async{
                                          var result = context.read<AuditFormBloc>().auditFormModel?.data!.questions;
                                          String? values;
                                          String? image;

                                          for (var item in result!) {
                                            values = item.ansReqired == "0" ? "true" : "false";

                                            if(item.imgUpload==1){
                                              if(item.images!.isNotEmpty){
                                                image=item.images!.isEmpty?"false":"true";
                                              }else{
                                                image=item.imageFileList!.isEmpty?"false":"true";
                                              }
                                            }

                                            if(values == "false"){
                                              break;
                                            }
                                            if(image=="false"){
                                              break;
                                            }

                                          }
                                          if (values == "true" && image=="true") {
                                                  final hasPermission =
                                                      await AppUtils()
                                                          .handleLocationPermission(
                                                              context);
                                                  if (!hasPermission) return;
                                                  if (context.mounted) {
                                                    confirmSheet(
                                                        context: context,
                                                        layoutId:
                                                            widget.layoutId!);
                                                  }
                                                } else {
                                            alertSheetAllField(message: "All fields are required.", context: context,);

                                          }



                                        },
                                        child: Container(
                                          height: 34.0,
                                          width: MediaQuery.of(
                                              context)
                                              .size
                                              .width /
                                              2.5,
                                          // margin: const EdgeInsets.only(top: 55),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              const BorderRadius
                                                  .all(Radius
                                                  .circular(
                                                  10)),
                                              border: Border.all(
                                                  width: 2.0,
                                                  color: ColorResource
                                                      .colorE0E3E7),
                                              color: ColorResource
                                                  .colorWhite),
                                          child: Center(
                                            child: CustomText(
                                              StringResource
                                                  .submit,
                                              style: GoogleFonts.inter(
                                                  color: ColorResource
                                                      .color5A5C60,
                                                  fontSize:
                                                  FontSize1
                                                      .twelve,
                                                  fontWeight:
                                                  FontWeight
                                                      .w400),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                if(context.read<AuditFormBloc>().isSubmit==true)
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(
                                        left: 10.0,
                                        right: 10.0),
                                    child: Container(
                                      height: 40,

                                      // margin: const EdgeInsets.only(top: 55),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          const BorderRadius
                                              .all(Radius
                                              .circular(
                                              10)),
                                          border: Border.all(
                                              width: 2.0,
                                              color: ColorResource
                                                  .colorE0E3E7),
                                          color: ColorResource
                                              .colorWhite),
                                      child: Center(
                                        child: Padding(
                                          padding:
                                          const EdgeInsets
                                              .only(left: 6.0,right: 6.0),
                                          child: CustomText(
                                            context.read<AuditFormBloc>().message,
                                            style: GoogleFonts.inter(
                                                color: ColorResource
                                                    .color5A5C60,
                                                fontSize:
                                                FontSize1
                                                    .thirteen,
                                                fontWeight:
                                                FontWeight
                                                    .w400),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          )
                        ],
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
                ),
              ),
            );
          },
          listener: (BuildContext context, state) {
            if (state is ApisCallSuccess) {
           Navigator.pop(context,true);

            }
            if (state is AuditFormError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 4),
                  backgroundColor: Colors.red,
                  content: Center(child: Text(state.message!)),
                ),
              );
            }

            if (state is AuditFormError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 4),
                  backgroundColor: Colors.red,
                  content: Center(child: Text(state.message!)),
                ),
              );
            }
            if (state is AuditLocationDisable) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: const Duration(seconds: 4),
                  backgroundColor: Colors.red,
                  content: Center(child: Text(state.message!)),
                ),
              );
              data();
            }

            if (state is AuditFormConfirmation) {
              confirmationSheet(context: context, layoutId: widget.layoutId!, message: state.message!);
            }
            if (state is AuditFormAlert) {
              alertSheet(context: context, message: state.message!);
            }
            if(state is AuditFormException){
              AppUtils.showInternetDialog(context,onPressed: () {
                data();
                context.pop();
              });
            }
            if(state is AuditAuthorization){
              AppUtils.showAuthDialog(context,onPressed: () {
                SharedPreferences.getInstance().then((value) {
                  value.setBool(SharedPrefKeys.isLogin, false).then((value) {
                   if(context.mounted){
                     context.pushReplacementNamed(RouterNames.loginRouter);
                   }
                  });
                });
                context.pop();
              });
            }

            if(state is AuditFormImageDelete){
              data();
            }
          },
        ),
      )),
    );
  }
 /* Future<void> _getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

  }*/


}
