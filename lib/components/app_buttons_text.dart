part of 'app_buttons.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.textStyle,
  });

  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Styled.text(text,
            style: textStyle ??
                Get.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Get.theme.cardColor,
                ))
        .textAlignment(TextAlign.center)
        .alignment(Alignment.center)
        .width(width ?? Get.size.width)
        .height(height ?? 56.0)
        .ripple()
        .clipRRect(all: 8.0)
        .gestures(onTap: onPressed);
  }
}
