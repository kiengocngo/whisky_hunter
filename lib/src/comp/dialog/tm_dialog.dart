import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whisky_hunter/theme/tm_theme_data.dart';


class TMDialog extends StatefulWidget {
  const TMDialog({
    Key? key,
    this.title,
    this.logoTitle,
    this.msg,
    this.okText = 'Đồng ý',
    this.cancelText,
    this.okHandler,
    this.cancelHandler,
    this.closeHandler,
    this.content,
  }) : super(key: key);

  final String? title;
  final bool? logoTitle;
  final String? msg;
  final String okText;
  final String? cancelText;
  final VoidCallback? okHandler;
  final VoidCallback? cancelHandler;
  final VoidCallback? closeHandler;
  final Widget? content;

  static var isShowing = false;

  @override
  _TMDialogState createState() => _TMDialogState();

  static void show(
    BuildContext context, {
    String? title,
    String? msg,
    String okText = 'Đồng ý',
    String? cancelText,
    VoidCallback? okHandler,
    VoidCallback? cancelHandler,
    VoidCallback? closeHandler,
    Widget? content,
  }) {
    if (Get.isDialogOpen == true && isShowing) {
      Get.back();
    }
    Get.dialog(
      WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: TMDialog(
          title: title,
          msg: msg,
          okText: okText,
          cancelText: cancelText,
          okHandler: okHandler,
          cancelHandler: cancelHandler,
          closeHandler: closeHandler,
          content: content,
        ),
      ),
      barrierDismissible: false,
    );
    isShowing = true;
  }
}

class _TMDialogState extends State<TMDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
        
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 14),
              if (widget.title != null) _buildTitle(context),
              _buildBody(),
              const SizedBox(height: 14),
              _buildButtons(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTitle(context) {
    return Text(
      widget.title!,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500,),
    );
  }

  Widget _buildBody() {
    return Flexible(
      child: Container(
        padding: (widget.title == null && widget.logoTitle == null)
            ? const EdgeInsets.all(20)
            : const EdgeInsets.only(left: 30, right: 30, top: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.msg != null)
              Text(
                widget.msg!,
                style: TMThemeData.fromContext(context).text_16_500,
                textAlign: TextAlign.center,
              ),
            widget.content ?? const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: Colors.green
        ),
      child: Row(
        children: [
          if (widget.cancelText != null || widget.cancelHandler != null) ...[
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context, false);
                  TMDialog.isShowing = false;
                  if (widget.cancelHandler != null) {
                    widget.cancelHandler!();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Text(
                    widget.cancelText!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            Container(
              width: 1,
              height: 28,
              color: Colors.white,
            )
          ],
          Expanded(
            child: InkWell(
              onTap: () {
                Navigator.pop(context, true);
                TMDialog.isShowing = false;
                if (widget.okHandler != null) {
                  widget.okHandler!();
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Text(
                  widget.okText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
