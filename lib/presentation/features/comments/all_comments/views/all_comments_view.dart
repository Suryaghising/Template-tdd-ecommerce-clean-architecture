import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template/domain/entities/comment.dart';
import 'package:template/domain/entities/product.dart';
import 'package:template/presentation/features/comments/all_comments/bloc/add_update_comment/add_update_comment_cubit.dart';
import 'package:template/presentation/features/comments/all_comments/bloc/all_comment_cubit.dart';
import 'package:template/utils/util.dart';
import 'package:intl/intl.dart';

import '../../../../widgets/CustomButton.dart';
import '../../../../widgets/custom_dialog.dart';
import '../../../../widgets/custom_pop_up_menu.dart';
import '../../../../widgets/custom_text_field.dart';
import '../../../../widgets/responsive_text.dart';

class AllCommentsView extends StatelessWidget {
  const AllCommentsView({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ResponsiveText(
          product.name,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          textColor: Colors.white,
        ),
      ),
      body: SafeArea(
        child: BlocListener<AddUpdateCommentCubit, AddUpdateCommentState>(
          listener: (context, addUpdateCommentState) {
            if (addUpdateCommentState is AddUpdateCommentSuccess) {
              context
                  .read<AllCommentCubit>()
                  .getCommentsByProductId(product.id);
            } else if (addUpdateCommentState is AddUpdateCommentFailure) {
              const snackbar = SnackBar(
                content: ResponsiveText(
                  'Something went wrong.',
                  textColor: Colors.white,
                ),
                backgroundColor: Colors.redAccent,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
          },
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4)),
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      height: height * 0.3,
                      width: width,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ResponsiveText(
                          product.name,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        ResponsiveText("Rs. ${product.price}"),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  )
                ],
              ),
              GestureDetector(
                onTap: () {
                  addCommentDialog(context,
                      onTap: (String userId, String comment) {
                    context
                        .read<AddUpdateCommentCubit>()
                        .addComment(product.id, userId, comment);
                  });
                },
                child: Container(
                  width: width,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 0.5,
                        spreadRadius: 0.5)
                  ], color: Colors.white),
                  child: const ResponsiveText('Write a comment...'),
                ),
              ),
              Expanded(
                child: BlocConsumer<AllCommentCubit, AllCommentState>(
                  builder: (context, allCommentState) {
                    if (allCommentState is AllCommentsLoaded) {
                      if(allCommentState.commentList.isEmpty) {
                        return const Center(child: ResponsiveText('No comments...'),);
                      }
                      return ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemBuilder: (context, index) {
                          final comment = allCommentState.commentList[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      height: 40,
                                      width: 40,
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 2),
                                      child: ResponsiveText(
                                        (index + 1).toString(),
                                        textColor: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ResponsiveText(
                                            'User id ${comment.userId}',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          ResponsiveText(
                                            DateFormat('yyyy-MM-dd')
                                                .format(comment.createdAt),
                                            fontSize: 10,
                                            textColor: Colors.grey,
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          ResponsiveText(comment.content),
                                        ],
                                      ),
                                    ),
                                    CustomPopupMenuButton(
                                      onSelected: (value) => onMenuItemClicked(
                                          context, value, comment),
                                      itemBuilder: (context) {
                                        return [
                                          const CustomPopupMenuItem(
                                            value: 0,
                                            child: ResponsiveText(
                                              'Update',
                                              textColor: Colors.black,
                                            ),
                                          ),
                                          const CustomPopupMenuItem(
                                            value: 1,
                                            child: ResponsiveText(
                                              'Delete',
                                              textColor: Colors.black,
                                            ),
                                          ),
                                          const CustomPopupMenuItem(
                                            value: 2,
                                            child: ResponsiveText(
                                              'Report',
                                              textColor: Colors.black,
                                            ),
                                          )
                                        ];
                                      },
                                      padding: EdgeInsets.zero,
                                      icon: const Icon(Icons.more_vert),
                                      iconSize: height * 0.025,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Divider(
                                  height: 1,
                                  color: Colors.grey.withOpacity(0.2),
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: allCommentState.commentList.length,
                      );
                    } else if (allCommentState is AllCommentsFailure) {
                      return const Center(
                        child: ResponsiveText('Something went wrong.'),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                  listener: (context, allCommentState) {
                    if(allCommentState is CommentDeleteReportSuccess) {
                      context.read<AllCommentCubit>().getCommentsByProductId(product.id);
                    } else if(allCommentState is CommentDeleteReportFailure) {
                      const snackbar = SnackBar(content: ResponsiveText('Something went wrong.', textColor: Colors.white,), backgroundColor: Colors.redAccent,);
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  addCommentDialog(
    BuildContext context, {
    required Function(String userId, String comment) onTap,
  }) {
    showDialog(
        context: context,
        builder: (ctx) {
          final TextEditingController userIdController =
              TextEditingController();
          final TextEditingController commentController =
              TextEditingController();
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: kHorizontalMargin),
                  padding: EdgeInsets.symmetric(
                      vertical: kVerticalMargin, horizontal: kHorizontalMargin),
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextField(
                          hintText: 'Add user id',
                          controller: userIdController,
                          inputType: TextInputType.number),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                          hintText: 'Add comment',
                          controller: commentController),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomButton(
                          onPressed: () {
                            Navigator.pop(ctx);
                            onTap(userIdController.text.trim(),
                                commentController.text.trim());
                          },
                          text: 'Add'),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  updateCommentDialog(
      BuildContext context, Comment comment, {
        required Function(String userId, String comment) onTap,
      }) {
    showDialog(
        context: context,
        builder: (ctx) {
          final TextEditingController userIdController =
          TextEditingController();
          final TextEditingController commentController =
          TextEditingController();
          userIdController.text = comment.userId.toString();
          commentController.text = comment.content;
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: kHorizontalMargin),
                  padding: EdgeInsets.symmetric(
                      vertical: kVerticalMargin, horizontal: kHorizontalMargin),
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextField(
                          hintText: 'Add user id',
                          controller: userIdController,
                          inputType: TextInputType.number),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomTextField(
                          hintText: 'Add comment',
                          controller: commentController),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomButton(
                          onPressed: () {
                            Navigator.pop(ctx);
                            onTap(userIdController.text.trim(),
                                commentController.text.trim());
                          },
                          text: 'Update'),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void onMenuItemClicked(BuildContext context, int value, Comment comment) {
    switch (value) {
      case 0:
        updateCommentDialog(context, comment, onTap: (String userId, String content) {
          context.read<AddUpdateCommentCubit>().updateComment(userId, content, comment);
        });
        break;

      case 1:
        CustomDialog.showCustomActionDialog(context, onTap: () {
          context.read<AllCommentCubit>().deleteComment(comment.id);
        },
            negativeText: 'No',
            positiveText: 'Delete',
            title: 'Do you want to delete the comment?');

      case 2:
        CustomDialog.showCustomActionDialog(context, onTap: () {
          context.read<AllCommentCubit>().reportComment(comment.id);
        },
            negativeText: 'No',
            positiveText: 'Report',
            title: 'Do you want to report the comment?');
    }
  }
}
