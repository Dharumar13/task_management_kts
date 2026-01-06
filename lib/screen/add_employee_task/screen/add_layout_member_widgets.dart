import 'package:task_management_kts/app_utility/app_constant.dart';
import 'package:task_management_kts/app_utility/fonts.dart';
import 'package:task_management_kts/app_utility/singleton.dart';
import 'package:task_management_kts/screen/add_employee_task/bloc/add_layout_member_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../app_utility/app_util.dart';
import '../../../app_utility/color_resource.dart';
import '../../../router/router_names.dart';
import '../../../widgets/custom_text.dart';

void addLayoutSheet({
  required BuildContext context,
}) {
  final layoutBloc = context.read<AddLayoutMemberBloc>();
  showModalBottomSheet(
    enableDrag: true,
    isDismissible: true,
    isScrollControlled: true,
     useSafeArea: true,
    backgroundColor: ColorResource.colorWhite,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0),topRight:  Radius.circular(50.0)),
        side: BorderSide(width: 1.0,color: ColorResource.color003867)
    ),
    context: context,
    builder: (BuildContext context) {
      return  BlocProvider.value(
          value: layoutBloc, child: const AddLayoutSheet());
     // return const AddLayoutSheet();
    },
  );
}

class AddLayoutSheet extends StatelessWidget {

  const AddLayoutSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    AppUtils.getDeviceType();
    return BlocConsumer<AddLayoutMemberBloc, AddLayoutMemberState>(builder: (context,state){
      return Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: AppUtils.getDeviceType()=="tablet"?50.0:50
                ),
                SizedBox(
                  width:isPortrait==true? MediaQuery.of(context).size.width/1.5:MediaQuery.of(context).size.width/2.3,
                  child: CustomText(
                    "Are you sure to assign these employees to the layout - ${context.read<AddLayoutMemberBloc>().layoutName}?",
maxLines: 5,
                    style: GoogleFonts.inter(   color: ColorResource.color1C1F26,
                      fontWeight: FontWeight.w500,
                      fontSize: AppUtils.getDeviceType()=="tablet"?FontSize1.twenty:FontSize1.twelve,),
                  ),
                ),
                SizedBox(
                  height:AppUtils.getDeviceType()=="tablet"?50.0:30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left:30.0,right: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(onPressed: (){
                        context.pop();
                      },
                        minWidth: isPortrait==true?MediaQuery.of(context).size.width/3:MediaQuery.of(context).size.width/6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side:const BorderSide(width: 1.0,color: ColorResource.colorE0E3E7)
                        ),
                        height:AppUtils.getDeviceType()=="tablet"? 40:34,
                        color: ColorResource.colorWhite,
                        child:  CustomText(
                          "Cancel",
                          style: GoogleFonts.inter(   color: ColorResource.color5A5C60,
                            fontWeight: FontWeight.w400,
                            fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.thirteen,),
                        ),
                      ),
                      const SizedBox(width: 30.0,),
                      MaterialButton(onPressed: (){

                        context.read<AddLayoutMemberBloc>().add(AssignLayoutEvent());


                      },
                        minWidth: isPortrait==true?MediaQuery.of(context).size.width/3:MediaQuery.of(context).size.width/6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        height:AppUtils.getDeviceType()=="tablet"? 40:34,
                        color: ColorResource.color003867,
                        child:  CustomText(
                          StringResource.confirm,
                          style: GoogleFonts.inter(   color: ColorResource.colorWhite,
                            fontWeight: FontWeight.w400,
                            fontSize:AppUtils.getDeviceType()=="tablet"?FontSize1.fifteen:FontSize1.thirteen,),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height:AppUtils.getDeviceType()=="tablet"?50.0:30,
                ),

              ],
            ),
          ),
        ],
      );
    }, listener: (context,state){
      if(state is AssignLayout){
        Navigator.pop(context);
        context.pop();
        context
            .pushReplacementNamed(RouterNames.layoutScreenRouter, queryParameters: {
          "layoutDate": Singleton().layoutDate,
          "siteId":Singleton().siteID,
          "inLocation":"true"
        });

      }
    });
  }
}