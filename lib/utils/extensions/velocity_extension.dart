part of 'extensions.dart';

extension BoxColor on VxTextBuilder {
  VxTextBuilder colorPrimary(BuildContext context) =>
      color(context.colors.primary);
  VxTextBuilder colorSecondary(BuildContext context) =>
      color(context.colors.secondary);
}
