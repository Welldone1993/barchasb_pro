import 'package:flutter/material.dart';

import '../../domain/entities/ad_entity.dart';

class HorizontalAdCard extends StatelessWidget {
  final AdEntity ad;
  final VoidCallback? onRightArrowTap;
  final VoidCallback? onLeftArrowTap;
  final Function(String id) onDetailsTap;

  const HorizontalAdCard({
    super.key,
    required this.ad,
    this.onRightArrowTap,
    this.onLeftArrowTap,
    required this.onDetailsTap,
  });

  @override
  Widget build(BuildContext context) => Directionality(
    textDirection: TextDirection.rtl,
    child: Container(
      width: 320,
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.blue.shade100, width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(18),
                        ),
                        child: ad.imageUrl != null
                            ? Image.network(
                                ad.imageUrl!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : Container(color: Colors.grey.shade200),
                      ),
                      const Positioned(
                        top: 12,
                        right: 12,
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.lightBlue,
                          child: Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(width: 1, color: Colors.blue.shade100),
                Expanded(
                  flex: 6,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              ad.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E3A5F),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                ad.price ?? '',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF1E3A5F),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Spacer(),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (ad.category != null)
                                    _buildTag(ad.category!),
                                  const SizedBox(width: 8),
                                  if (ad.subCategories != null)
                                    _buildTag(ad.subCategories!),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),

                      // آیکون برچسب (بالا چپ)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Image.asset(
                          'assets/logo_light.png',
                          height: 20, // اگر عکس لود نشد
                        ),
                      ),

                      // دکمه جزئیات (پایین چپ)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: GestureDetector(
                          onTap: () => onDetailsTap(ad.id),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 6,
                            ),
                            decoration: const BoxDecoration(
                              color: Color(0xFF1E3A5F),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(18),
                                topRight: Radius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'جزئیات',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // فلش نارنجی سمت راست
          Positioned(
            left: -15,
            top: 0,
            bottom: 0,
            child: Center(
              child: _buildOrangeArrow(
                Icons.arrow_forward_ios,
                onRightArrowTap,
              ),
            ),
          ),

          // فلش نارنجی سمت چپ
          Positioned(
            right: -15,

            top: 0,
            bottom: 0,
            child: Center(
              child: _buildOrangeArrow(
                Icons.arrow_back_ios_new,
                onLeftArrowTap,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 11, color: Colors.grey.shade700),
      ),
    );
  }

  Widget _buildOrangeArrow(IconData icon, VoidCallback? onTap) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: 35,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xFFF68D38),
            borderRadius: icon == Icons.arrow_forward_ios
                ? const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  ),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
      );
}
