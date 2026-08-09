// فایل: lib/views/faq_screen.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_drawer_menu.dart';
import '../../domain/faq_topic.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FB), // رنگ پس زمینه روشن مشابه تصویر
      appBar: _appBar(context),
      body: Stack(
        children: [
          // پس زمینه حباب دار (Blob) در صورت نیاز می‌توانید اینجا اضافه کنید
          ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: faqTopics.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: ExpandableTopicCard(topic: faqTopics[index]),
              );
            },
          ),
        ],
      ),
    );
  }

  AppBar _appBar(BuildContext context) => AppBar(
    backgroundColor: const Color(0xFF153354),
    // رنگ پس‌زمینه آبی تیره (مطابق تصویر)
    elevation: 0,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.circular(16), // اگر گوشه‌های پایین گرد هستند
      ),
    ),
    leading: Padding(
      padding: const EdgeInsets.only(right: 16.0, top: 12.0, bottom: 12.0),
      child: _buildIconButton(
        icon: Icons.search,
        onTap: () {
          // اکشن جستجو
        },
      ),
    ),
    leadingWidth: 70,

    // تنظیم عرض برای جا شدن دکمه
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            _buildIconButton(
              icon: Icons.notifications_none_rounded,
              hasBadge: true,
              badgeCount: '1',
              onTap: () {
                _exitActions(context);
              },
            ),
            const SizedBox(width: 8),

            _buildIconButton(
              icon: Icons.chat_bubble_outline_rounded,
              onTap: () {
                _exitActions(context);
              },
            ),
            const SizedBox(width: 8),

            // دکمه منو (سه نقطه)
            _buildIconButton(
              icon: Icons.more_vert_rounded,
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    opaque: false,
                    // برای اینکه پس‌زمینه شفاف باشد (اگر نیاز بود)
                    pageBuilder: (BuildContext context, _, __) {
                      return const PreciseRadialMenu();
                    },
                    transitionsBuilder:
                        (___, Animation<double> animation, ____, Widget child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                  ),
                );
              },
            ),
            const SizedBox(width: 16), // فاصله از حاشیه چپ صفحه
          ],
        ),
      ),
    ],
  );

  Widget _buildIconButton({
    required IconData icon,
    required VoidCallback onTap,
    bool hasBadge = false,
    String badgeCount = '',
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08), // رنگ نیمه شفاف پس‌زمینه آیکون
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            if (hasBadge)
              Positioned(
                right: -6,
                bottom: -6,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF5252), // رنگ قرمز بج
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    badgeCount,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _exitActions(BuildContext context) {
    context.go('/dashboard');
  }
}

// ---------------------------------------------------------
// ویجت سطح اول: دسته بندی سوالات (مثلا: امتیازات برچسب)
// ---------------------------------------------------------
class ExpandableTopicCard extends StatefulWidget {
  final FaqTopic topic;

  const ExpandableTopicCard({super.key, required this.topic});

  @override
  State<ExpandableTopicCard> createState() => _ExpandableTopicCardState();
}

class _ExpandableTopicCardState extends State<ExpandableTopicCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: const Color(0xFFE2E9F3), // رنگ آبی-خاکستری کادر بیرونی
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // هدر دسته بندی
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: Row(
                children: [
                  // آیکون مثبت و منفی در سمت چپ
                  Icon(
                    isExpanded ? Icons.remove : Icons.add,
                    color: const Color(0xFF132F51),
                    size: 20,
                  ),
                  const Spacer(),
                  // عنوان دسته بندی در سمت راست
                  Text(
                    widget.topic.title,
                    style: const TextStyle(
                      color: Color(0xFF132F51),
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Vazirmatn',
                    ),
                  ),
                ],
              ),
            ),
          ),

          // لیست سوالات (سطح دوم)
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: isExpanded
                ? Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                      bottom: 12,
                    ),
                    child: Column(
                      children: widget.topic.questions.asMap().entries.map((
                        entry,
                      ) {
                        int index = entry.key;
                        FaqQuestion question = entry.value;
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ExpandableQuestionCard(
                            question: question,
                            number: index + 1,
                          ),
                        );
                      }).toList(),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------
// ویجت سطح دوم: سوال و جواب دقیق
// ---------------------------------------------------------
class ExpandableQuestionCard extends StatefulWidget {
  final FaqQuestion question;
  final int number;

  const ExpandableQuestionCard({
    super.key,
    required this.question,
    required this.number,
  });

  @override
  State<ExpandableQuestionCard> createState() => _ExpandableQuestionCardState();
}

class _ExpandableQuestionCardState extends State<ExpandableQuestionCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // هدر سوال
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Icon(
                    isExpanded ? Icons.remove : Icons.add,
                    color: const Color(0xFF132F51),
                    size: 18,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.question.question,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Color(0xFF132F51),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Vazirmatn',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // باکس شماره سوال
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE2E9F3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      widget.number.toString(),
                      style: const TextStyle(
                        color: Color(0xFF132F51),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Vazirmatn',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // متن جواب
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: isExpanded
                ? Padding(
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: 16.0,
                      top: 4.0,
                    ),
                    child: Text(
                      widget.question.answer,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        color: Color(
                          0xFF6B7A90,
                        ), // رنگ خاکستری تیره برای متن جواب
                        fontSize: 13,
                        height: 1.8, // فاصله خطوط برای خوانایی بهتر
                        fontFamily: 'Vazirmatn',
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
