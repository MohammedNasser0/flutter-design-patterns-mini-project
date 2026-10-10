import 'package:flutter/material.dart';

import '../../domain/entities/learning_item.dart';

class LearningItemCard extends StatelessWidget {
  const LearningItemCard({super.key, required this.item});
  final LearningItem item;
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: const Color(0xFFE8E7F0)),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: const Color(0xFFEFECFF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '0${item.id}',
            style: const TextStyle(
              color: Color(0xFF6750CF),
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.category,
                style: const TextStyle(
                  color: Color(0xFF6750CF),
                  fontSize: 10,
                  letterSpacing: 1.6,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                item.description,
                style: const TextStyle(color: Color(0xFF77758B), height: 1.5),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
