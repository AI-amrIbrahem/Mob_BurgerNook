import 'package:animated_background/animated_background.dart';
import 'package:animated_background/particles.dart';
import 'package:burgernook/new_code/features/splash/controllers/splash_controller.dart';
import 'package:burgernook/new_code/util/resources/ColorsUtils.dart';
import 'package:burgernook/new_code/util/resources/app_assets.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widgets/version_widget.dart';


class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);


  @override
  _AnimationBackGroundState createState() => new _AnimationBackGroundState();
}

class _AnimationBackGroundState extends State<SplashScreen> with TickerProviderStateMixin {

  var getController = Get.put(SplashController());



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:AppColors.mainColor,
      body: AnimatedBackground(
        behaviour:RandomParticleBehaviour(
          options: getController.particleOptions,
          paint: getController.particlePaint,

        ),
        vsync: this,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:CrossAxisAlignment.center,
          children: [
            
            Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment:CrossAxisAlignment.center,
                children:[
                  Center(child: Image.asset(AppAssets.logo,height: 300.h,width: 300.w,)),
                  Text('زاوية البرجر',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold),),
                  Text('توصيل الطلبات بضغطة واحدة',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),),
                ]
              ),
            ),
             // Spacer(),
            VersionWidget()

          ],
        ),
      ),
    );
  }
}


class RainParticleBehaviour extends RandomParticleBehaviour {
  static math.Random random = math.Random();

  bool enabled;

  RainParticleBehaviour({
    ParticleOptions options = const ParticleOptions(),
    Paint? paint,
    this.enabled = true,
  }) : super(options: options, paint: paint);

  @override
  void initPosition(Particle p) {
    p.cx = random.nextDouble() * size!.width;
    if (p.cy == 0.0)
      p.cy = random.nextDouble() * size!.height;
    else
      p.cy = random.nextDouble() * size!.width * 0.2;
  }

  @override
  void initDirection(Particle p, double speed) {
    double dirX = (random.nextDouble() - 0.5);
    double dirY = random.nextDouble() * 0.5 + 0.5;
    double magSq = dirX * dirX + dirY * dirY;
    double mag = magSq <= 0 ? 1 : math.sqrt(magSq);

    p.dx = dirX / mag * speed;
    p.dy = dirY / mag * speed;
  }

  @override
  Widget builder(
      BuildContext context, BoxConstraints constraints, Widget child) {
    return GestureDetector(
      onPanUpdate: enabled
          ? (details) => _updateParticles(context, details.globalPosition)
          : null,
      onTapDown: enabled
          ? (details) => _updateParticles(context, details.globalPosition)
          : null,
      child: ConstrainedBox(
        // necessary to force gesture detector to cover screen
        constraints: BoxConstraints(
            minHeight: double.infinity, minWidth: double.infinity),
        child: super.builder(context, constraints, child),
      ),
    );
  }

  void _updateParticles(BuildContext context, Offset offsetGlobal) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var offset = renderBox.globalToLocal(offsetGlobal);
    particles!.forEach((particle) {
      var delta = (Offset(particle.cx, particle.cy) - offset);
      if (delta.distanceSquared < 70 * 70) {
        var speed = particle.speed;
        var mag = delta.distance;
        speed *= (70 - mag) / 70.0 * 2.0 + 0.5;
        speed = math.max(
            options.spawnMinSpeed, math.min(options.spawnMaxSpeed, speed));
        particle.dx = delta.dx / mag * speed;
        particle.dy = delta.dy / mag * speed;
      }
    });
  }
}