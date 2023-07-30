import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomScaffold extends HookWidget {
  const CustomScaffold({
    Key? key,
    this.appBar,
    this.body,
  }) : super(key: key);

  final PreferredSizeWidget? appBar;
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    final animationController =
        useAnimationController(duration: 200.milliseconds);
    final tanim = Tween<double>(begin: 0, end: 1);
    final animation = tanim.animate(animationController);
    final hookAnimation = useAnimation(animation);

    useEffect(() {
      Future.microtask(() => animationController.forward());
      return null;
    }, []);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: SafeArea(
        top: false,
        child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return SizedBox(
                width: 1.sw,
                height: 1.sh,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: .18.sh,
                      child: Transform.translate(
                        offset: Offset(0, (hookAnimation - 1) * .18.sh),
                        child: VxArc(
                          height: hookAnimation * .06.sh,
                          child: Container(
                            height: hookAnimation * .18.sh,
                            color: context.colors.primary,
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: SizedBox(
                        height: 1.sh,
                        width: 1.sw,
                        child: body,
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
