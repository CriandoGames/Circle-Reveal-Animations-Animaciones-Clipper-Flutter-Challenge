import 'package:circle_reveal_animations_animaciones/domain/entities/mock/list_mock_skin.dart';
import 'package:circle_reveal_animations_animaciones/domain/entities/skins/skin.dart';
import 'package:flutter/material.dart';

import 'widget/skin_home_button.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  Skin _skincurrent = mockSking.first;
  Skin _skinpass = mockSking.last;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      upperBound: 2.5,
      duration: const Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cicle Reveal Animations Challenge'),
      ),
      body: Column(
        children: [
          Expanded(
              child: Stack(
            children: [
              Positioned.fill(
                  child: Image.asset(
                _skinpass.image,
                fit: BoxFit.cover,
              )),
              Positioned.fill(
                  child: AnimatedBuilder(
                animation: _controller,
                builder: (_, __) {
                  return ClipPath(
                    clipper: SkinCliper(
                        skin: _skincurrent, value: _controller.value),
                    child: Image.asset(
                      _skincurrent.image,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              )),
            ],
          )),
          Expanded(
            child: Column(
              children: [
                Text(
                  'Hello',
                  style: Theme.of(context).textTheme.headline4,
                ),
                Expanded(
                    child: GridView.builder(
                        itemCount: mockSking.length,
                        padding: const EdgeInsets.all(20),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 20.0,
                          mainAxisSpacing: 20.0,
                        ),
                        itemBuilder: (context, index) {
                          return SkinHomeButton(
                            skin: mockSking[index],
                            selected:
                                _skincurrent.color == mockSking[index].color,
                            onPressed: () {
                              _onSkinSelected(mockSking[index]);
                            },
                          );
                        }))
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onSkinSelected(Skin mockSking) {
    setState(() {
      _skinpass = _skincurrent;
      _skincurrent = mockSking;
    });
    _controller.forward(from: 0.0).whenComplete(() {
      setState(() {
        _skinpass = _skincurrent;
      });
    });
  }
}

class SkinCliper extends CustomClipper<Path> {
  final double value;
  final Skin skin;
  SkinCliper({required this.value, required this.skin});

  late Offset alignment;

  @override
  Path getClip(Size size) {
    if (skin.alignment == Alignment.center) {
      alignment = Offset(size.width / 2, size.height / 2);
    } else if (skin.alignment == Alignment.topCenter) {
      alignment = Offset(size.width / 2, 0);
    } else if (skin.alignment == Alignment.bottomCenter) {
      alignment = Offset(size.width / 2, size.height);
    } else if (skin.alignment == Alignment.topLeft) {
      alignment = const Offset(0, 0);
    } else if (skin.alignment == Alignment.bottomLeft) {
      alignment = Offset(0, size.height);
    } else if (skin.alignment == Alignment.topRight) {
      alignment = Offset(size.width, 0);
    } else if (skin.alignment == Alignment.bottomRight) {
      alignment = Offset(size.width, size.height);
    }else if (skin.alignment == Alignment.centerLeft) {
      alignment = Offset(0, size.height / 2);
    }else if (skin.alignment == Alignment.centerRight) {
      alignment = Offset(size.width, size.height / 2);
    }else {
      alignment = Offset(size.width / 2, size.height / 2);
    }
    final path = Path();
    path.addOval(Rect.fromCenter(
        center: alignment,
        width: size.width * value,
        height: size.height * value));
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
