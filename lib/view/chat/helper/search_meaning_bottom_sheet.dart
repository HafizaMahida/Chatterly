import 'package:chat_app/data/repository/chat/model/search_meaning_response_model.dart';
import 'package:chat_app/view/utils/theme/app_colors.dart';
import 'package:chat_app/view/utils/theme/text_styles.dart';
import 'package:chat_app/view/utils/widgets/common_text.dart';
import 'package:chat_app/view_model/chat/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showWordMeaningBottomSheet(BuildContext context, String word,) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return SearchMeaningBottomSheet(word: word,);
    },
  );
}


class SearchMeaningBottomSheet extends ConsumerStatefulWidget {
  final String word;
  const SearchMeaningBottomSheet({super.key,required this.word});

  @override
  ConsumerState<SearchMeaningBottomSheet> createState() => _SearchMeaningBottomSheetState();
}

class _SearchMeaningBottomSheetState extends ConsumerState<SearchMeaningBottomSheet> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_){
      ref.read(chatController).searchWordMeaningApi(widget.word);
    });
  }
  @override
  Widget build(BuildContext context) {
    final chatWatch = ref.watch(chatController);
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.sizeOf(context).height*0.45,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child:chatWatch.isSearchLoading?
      Center(child: CircularProgressIndicator(color: AppColors.black,)):
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

         Expanded(
           child: Column(
             children: [
               /// Word + phonetic
               Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   CommonText(
                     title:chatWatch.searchMeaningResponseModel?.word??'',
                     style:  TextStyles.bold.copyWith(
                       fontSize: 22.sp,
                     ),
                   ),
                   SizedBox(width: 8.w),
                   if (chatWatch.searchMeaningResponseModel?.phonetic != null)
                     CommonText(
                       title:chatWatch.searchMeaningResponseModel?.phonetic??'',
                       style: TextStyles.regular.copyWith(
                           fontSize: 14.sp,
                           color: AppColors.grayLight1
                       ),
                     ),
                 ],
               ),

               SizedBox(height: 12.sp),

               /// Meanings
               Expanded(
                 child: chatWatch.searchMeaningResponseModel?.isFound??true?ListView.separated(
                   itemCount: chatWatch.searchMeaningResponseModel?.meanings?.length??0,
                   separatorBuilder: (_, __) =>
                       SizedBox(height: 12.sp),
                   itemBuilder: (context, index) {
                     final meaning = chatWatch.searchMeaningResponseModel?.meanings?[index];
                     return _MeaningCard(meaning: meaning??Meaning());
                   },
                 ):Center(
                   child: CommonText(
                     title:'No meaning found!',
                     style: TextStyles.medium.copyWith(
                         fontSize: 20.sp,
                         color: AppColors.black
                     ),
                   ),
                 ),
               ),
             ],
           ),
         ),
        ],
      ),
    );
  }
}

class _MeaningCard extends StatelessWidget {
  final Meaning meaning;

  const _MeaningCard({required this.meaning});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.all(12.h),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Part of speech badge
          Container(
            padding:  EdgeInsets.symmetric(
              horizontal: 8.w,
              vertical: 4.h,
            ),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: CommonText(
              title:meaning.partOfSpeech??'',
              style: TextStyles.medium.copyWith(
                fontSize: 12.sp,
                color: Colors.blue,
              ),
            ),
          ),
          SizedBox(height: 8.h),

          /// Definitions
          ...(meaning.definitions ?? []).asMap().entries.map((entry) {
            final definition = entry.value.definition ?? '';
          return Padding(
            padding: EdgeInsets.only(bottom: 6.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(
                    title:'${entry.key + 1}. ',
                    style: TextStyles.medium.copyWith()
                ),
                Expanded(
                  child: CommonText(
                    title:definition.toString()??'',
                    style: TextStyles.regular.copyWith(fontSize: 14.sp),
                  ),
                ),
              ],
            ),
          );
          }),
        ],
      ),
    );
  }
}
