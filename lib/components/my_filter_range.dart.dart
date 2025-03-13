import 'package:flutter/material.dart';

class FilterRange extends StatefulWidget {
  final double initialRadius;
  final Function(double) onRadiusChanged;

  const FilterRange({
    super.key,
    required this.initialRadius,
    required this.onRadiusChanged,
  });

  @override
  State<FilterRange> createState() => _FilterRangeState();

  static void show(BuildContext context, double currentRadius, Function(double) onRadiusChanged) {
    showModalBottomSheet(
      //Kullanıcının mesafe filtreleme işlemini yaptığı modal
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: 20 + MediaQuery.of(context).viewInsets.bottom,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 10,
              spreadRadius: 0,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: FilterRange(
          initialRadius: currentRadius,
          onRadiusChanged: onRadiusChanged,
        ),
      ),
    );
  }
}

class _FilterRangeState extends State<FilterRange> {
  late double radius;
  

  final Color primaryBlue = const Color(0xFF2196F3);      
  final Color lightBlue = const Color(0xFFBBDEFB);        
  final Color darkBlue = const Color(0xFF1565C0);        
  final Color veryLightBlue = const Color(0xFFE3F2FD);   

  @override
  void initState() {
    super.initState();
    radius = widget.initialRadius;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
 
        Center(
          child: Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        
        Text(
          'Mesafeyi Filtrele',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryBlue,
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 24),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Uzaklık seçin:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: veryLightBlue,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: lightBlue),
              ),
              child: Text(
                '${radius.toStringAsFixed(1)} km',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: darkBlue,
                ),
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 16),
        
        SliderTheme(
          data: SliderThemeData(
            trackHeight: 4,
            activeTrackColor: primaryBlue,
            inactiveTrackColor: lightBlue,
            thumbColor: primaryBlue,
            overlayColor: primaryBlue.withOpacity(0.2),
            thumbShape: const RoundSliderThumbShape(
              enabledThumbRadius: 12,
              elevation: 4,
              pressedElevation: 8,
            ),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
            valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
            valueIndicatorColor: darkBlue,
            valueIndicatorTextStyle: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: Slider(
            value: radius,
            min: 1,
            max: 10,
            divisions: 9,
            label: '${radius.toStringAsFixed(1)} km',
            onChanged: (value) {
              setState(() {
                radius = value;
              });
            },
          ),
        ),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '1 km',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
            Text(
              '10 km',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
        
        const SizedBox(height: 32),
        
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: BorderSide(color: primaryBlue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'İptal',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: primaryBlue,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  widget.onRadiusChanged(radius);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 2,
                  shadowColor: primaryBlue.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Uygula',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}