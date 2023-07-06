import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../common/const/color.dart';

const Duration _kExpand = Duration(milliseconds: 200);

class BottomLayout extends StatefulWidget {
  const BottomLayout({
    super.key,
  });

  @override
  State<BottomLayout> createState() => _BottomLayoutState();
}

class _BottomLayoutState extends State<BottomLayout>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  static final Animatable<double> _halfTween =
  Tween<double>(begin: 0.0, end: 0.5);
  static final Animatable<double> _easeInTween =
  CurveTween(curve: Curves.easeIn);

  late AnimationController _animationController;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _animationController.drive(_easeInTween);
    _iconTurns = _animationController.drive(_halfTween.chain(_easeInTween));
    if (_isExpanded) {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF1F1F1),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        child: AnimatedBuilder(
          animation: _animationController.view,
          builder: (context, widget) {
            return Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'CJ CGV (주)',
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(width: 4),
                    RotationTransition(
                      turns: _iconTurns,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                            if (_isExpanded) {
                              _animationController.forward();
                            } else {
                              _animationController.reverse();
                            }
                          });
                        },
                        child: Image.asset('assets/icons/ic_arrow_down.png'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRect(
                  child: Align(
                    alignment: Alignment.center,
                    heightFactor: _heightFactor.value,
                    child: SiteInformation(
                      onTapNumber: () {},
                    ),
                  ),
                ),
                const BottomLastLine(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class BottomLastLine extends StatelessWidget {
  const BottomLastLine({super.key});

  @override
  Widget build(BuildContext context) {
    return const IntrinsicHeight(
      child: Row(
        children: [
          Text(
            '이용약관',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w200,
              color: Colors.black,
            ),
          ),
          VerticalDivider(
            thickness: 0.5,
            color: Color(0xffC8C8C8),
            indent: 5,
            endIndent: 3,
          ),
          Text(
            '개인정보처리방침',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          VerticalDivider(
            thickness: 0.5,
            color: Color(0xffC8C8C8),
            indent: 5,
            endIndent: 3,
          ),
          Text(
            '위치기반서비스 이용약관',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w200,
              color: Colors.black,
            ),
          ),
          VerticalDivider(
            thickness: 0.5,
            color: Color(0xffC8C8C8),
            indent: 5,
            endIndent: 3,
          ),
          Text(
            '법적고지',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w200,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class SiteInformation extends StatelessWidget {
  final VoidCallback onTapNumber;

  const SiteInformation({
    required this.onTapNumber,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '대표이사 : 투덜이TM',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          const Text(
            '(02842) 경기도 용인시 기흥구 동백죽전대로527번길 80',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          Text.rich(
            TextSpan(
              text: '통신판매업신고번호 : 2023-경기용인-1234 ',
              children: [
                TextSpan(
                  text: '사업자정보확인',
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      onTapNumber();
                    },
                ),
              ],
            ),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          const Text(
            '통신판매업신고번호 : 2023-경기용인-1234',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          const Text(
            '사업자 등록번호 :123-45-567890',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          const Row(
            children: [
              Text(
                '개인정보보호 책임자 : 투덜이',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
              VerticalDivider(
                thickness: 0.5,
                color: Color(0xffC8C8C8),
                indent: 5,
                endIndent: 3,
              ),
              Text(
                '호스팅사업자 : TM 네트웍스',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ],
          ),
          const Row(
            children: [
              Text(
                '대표이메일 : tuduri@paran.com',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
              VerticalDivider(
                thickness: 0.5,
                color: Color(0xffC8C8C8),
                indent: 5,
                endIndent: 3,
              ),
              Text(
                '고객센터 :1234-1234',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
