import 'package:chat_app/view/utils/theme/app_colors.dart';
import 'package:chat_app/view/utils/theme/text_styles.dart';
import 'package:chat_app/view/utils/widgets/common_button.dart';
import 'package:chat_app/view/utils/widgets/common_form_field.dart';
import 'package:chat_app/view/utils/widgets/common_text.dart';
import 'package:chat_app/view_model/users/users_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showAddUserBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    backgroundColor: AppColors.primary,
    builder: (context) {
      return AddUserWidget();
    },
  );
}


class AddUserWidget extends ConsumerStatefulWidget {
  const AddUserWidget({super.key});

  @override
  ConsumerState<AddUserWidget> createState() => _AddUserWidgetState();
}

class _AddUserWidgetState extends ConsumerState<AddUserWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(usersController).clearAddUserCtr();
  }
  @override
  Widget build(BuildContext context) {
    final userRead= ref.read(usersController);
    return Padding(
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 16.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(
            title: 'Add New User',
            style: TextStyles.medium.copyWith(
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 12.h),

          /// Name Input
          CommonFormField(
            controller: userRead.userNameCtr,
            hintText: 'User name',
            maxLength: 30,
          ),

          SizedBox(height: 16.h),

          /// Buttons
          Row(
            children: [
              Expanded(
                child: CommonButton(
                  label: 'Cancel',
                  backgroundColor: AppColors.errorColor.withValues(alpha: 0.3),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CommonButton(
                  label: 'Add',
                  onPressed: () {
                    if(userRead.userNameCtr.text.isEmpty){
                      return;
                    }
                    userRead.addNewUser();
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: CommonText(title:'User "${userRead.userNameCtr.text}" added!',clrFont: AppColors.primary,),
                        backgroundColor: AppColors.black.withValues(alpha: 0.9),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}




