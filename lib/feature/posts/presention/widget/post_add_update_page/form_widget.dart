import '../../../domain/entity/post_entity.dart';
import 'elevated_form_submit_widget.dart';
import 'text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';

class FormWidget extends StatefulWidget {
  final PostEntity? post;
  final bool isUpdatePost;
  const FormWidget({super.key, this.post, required this.isUpdatePost});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

final _formKey = GlobalKey<FormState>();
TextEditingController _titleController = TextEditingController();
TextEditingController _bodyController = TextEditingController();

class _FormWidgetState extends State<FormWidget> {
  @override
  void initState() {
    _titleController.text = widget.post?.title ?? '';
    _bodyController.text = widget.post?.body ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldWidget(
                controller: _titleController, multiLine: false, name: "Title"),
            TextFormFieldWidget(
                controller: _bodyController, multiLine: true, name: "Body"),
            ElevatedFormSubmitWidget(
                isUpdatePost: widget.isUpdatePost,
                onPressed: validateFormThenAddOrUpdatePost),
          ],
        ));
  }

  void validateFormThenAddOrUpdatePost() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final PostEntity post = PostEntity(
          id: widget.isUpdatePost ? widget.post?.id : null,
          title: _titleController.text,
          body: _bodyController.text);

      if (widget.isUpdatePost) {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(AddPostEvent(post));
      }
    }
  }
}
