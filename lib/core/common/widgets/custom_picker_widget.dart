import 'package:flutter/material.dart';
import 'package:super_fitness_app/core/theme/app_colors.dart';

class CustomHorizontalPicker extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;
  final String unit;
  final ValueChanged<int> onValueChanged;

  const CustomHorizontalPicker({
    super.key,
    required this.initialValue,
    required this.minValue,
    required this.maxValue,
    required this.unit,
    required this.onValueChanged,
  });

  @override
  State<CustomHorizontalPicker> createState() => _CustomHorizontalPickerState();
}

class _CustomHorizontalPickerState extends State<CustomHorizontalPicker> {
  late int _selectedValue;
  late ScrollController _scrollController;
  final double _itemWidth = 60.0;
  final double _itemHeight = 40.0;
  final double _triangleHeight = 12.0;
  final double _triangleWidth = 18.0;

  bool _isSnapping = false;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue.clamp(
      widget.minValue,
      widget.maxValue,
    );
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToInitialValue(animated: false);
    });

    _scrollController.addListener(_onScroll);
  }

  void _scrollToInitialValue({bool animated = true}) {
    final initialIndex = _selectedValue - widget.minValue;
    final position = initialIndex * _itemWidth;
    if (animated) {
      _scrollController.animateTo(
        position.toDouble(),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(position.toDouble());
      }
    }
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final scrollPosition = _scrollController.offset;
    final index = (scrollPosition / _itemWidth).round();
    final newValue = (index + widget.minValue).clamp(
      widget.minValue,
      widget.maxValue,
    );

    if (newValue != _selectedValue) {
      setState(() {
        _selectedValue = newValue;
      });
      widget.onValueChanged(newValue);
    }
  }

  Future<void> _snapToNearest() async {
    if (!_scrollController.hasClients) return;
    if (_isSnapping) return;

    final scrollPosition = _scrollController.offset;
    final index = (scrollPosition / _itemWidth).round();
    final maxOffset = (widget.maxValue - widget.minValue) * _itemWidth;
    final target = (index * _itemWidth).clamp(0.0, maxOffset);

    if ((target - scrollPosition).abs() < 0.5) return;

    _isSnapping = true;
    try {
      await _scrollController.animateTo(
        target,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    } finally {
      await Future<void>.delayed(const Duration(milliseconds: 10));
      _isSnapping = false;
      final snappedIndex = (target / _itemWidth).round();
      final snappedValue = (snappedIndex + widget.minValue).clamp(
        widget.minValue,
        widget.maxValue,
      );
      if (snappedValue != _selectedValue) {
        setState(() {
          _selectedValue = snappedValue;
        });
        widget.onValueChanged(snappedValue);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final totalItems = widget.maxValue - widget.minValue + 1;
    final horizontalPadding =
        MediaQuery.of(context).size.width / (2.5 - 0.04) - _itemWidth / 2;

    return SizedBox(
      height: _itemHeight + _triangleHeight + 30,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification && !_isSnapping) {
            _snapToNearest();
          }
          return false;
        },
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          itemCount: totalItems,
          itemBuilder: (context, index) {
            final value = widget.minValue + index;
            final isSelected = value == _selectedValue;
            final scrollPosition =
                _scrollController.hasClients
                    ? _scrollController.offset
                    : (_selectedValue - widget.minValue) * _itemWidth;
            final itemPosition = index * _itemWidth;
            final distanceFromCenter = (itemPosition - scrollPosition).abs();

            final maxDistance = _itemWidth * 5;
            final distanceFactor =
                (maxDistance - distanceFromCenter.clamp(0, maxDistance)) /
                maxDistance;
            final scale = 0.4 + (distanceFactor * 0.6);
            final opacity = 0.2 + (distanceFactor * 0.8);

            return SizedBox(
              width: _itemWidth,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      final target = index * _itemWidth;
                      if (!_isSnapping && _scrollController.hasClients) {
                        _isSnapping = true;
                        _scrollController
                            .animateTo(
                              target,
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeOut,
                            )
                            .whenComplete(() {
                              _isSnapping = false;
                              setState(() {
                                _selectedValue = value;
                              });
                              widget.onValueChanged(value);
                            });
                      } else {
                        setState(() {
                          _selectedValue = value;
                        });
                        widget.onValueChanged(value);
                      }
                    },
                    child: SizedBox(
                      height: _itemHeight,
                      width: _itemWidth,
                      child: Transform.scale(
                        scale: scale,
                        child: Opacity(
                          opacity: opacity,
                          child: Center(
                            child: Text(
                              '$value',
                              style: TextStyle(
                                fontSize: isSelected ? 25 : 24,
                                fontWeight: FontWeight.w800,
                                color:
                                    isSelected ? AppColors.main : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: _triangleHeight,
                    width: _triangleWidth,
                    child:
                        isSelected
                            ? CustomPaint(painter: TrianglePainter())
                            : const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = AppColors.main
          ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
