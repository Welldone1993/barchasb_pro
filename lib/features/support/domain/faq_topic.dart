// فایل: lib/models/faq_data.dart

class FaqTopic {
  final String title;
  final List<FaqQuestion> questions;

  FaqTopic({required this.title, required this.questions});
}

class FaqQuestion {
  final String question;
  final String answer;

  FaqQuestion({required this.question, required this.answer});
}

// داده‌های تستی (Mock Data) بر اساس اطلاعات پروژه «برچسب»
final List<FaqTopic> faqTopics = [
  FaqTopic(
    title: 'امتیازات برچسب',
    questions: [
      FaqQuestion(
        question: 'امتیازات برچسب برای چیست؟',
        answer:
            'اینجا برچسب است، جایی برای رشد و یادگیری و خلق ایده‌های جدید. در برچسب باهم تجربه میکنیم و باهم رشد میکنیم. همچنین برای چالش‌ها راه حل پیدا میکنیم و با کسب امتیاز می‌توانید از امکانات ویژه اپلیکیشن استفاده کنید.',
      ),
      FaqQuestion(
        question: 'چگونه می‌توانم امتیاز بیشتری کسب کنم؟',
        answer:
            'با تکمیل پروفایل رزومه ساز، ثبت آگهی‌های دیجیتال کامل و همچنین تعامل با پیشنهادات هوشمند در داشبورد می‌توانید امتیاز خود را ارتقا دهید.',
      ),
    ],
  ),
  FaqTopic(
    title: 'ثبت آگهی دیجیتال',
    questions: [
      FaqQuestion(
        question: 'مراحل ثبت آگهی به چه صورت است؟',
        answer:
            'ثبت آگهی در دو مرحله انجام می‌شود. در مرحله اول اطلاعات کلی مانند عکس، عنوان و بودجه را وارد می‌کنید و در مرحله دوم مهارت‌های مورد نیاز را به صورت تگ (Chip) اضافه می‌کنید.',
      ),
      FaqQuestion(
        question: 'آیا امکان ویرایش مهارت‌ها پس از افزودن وجود دارد؟',
        answer:
            'بله، در مرحله دوم ثبت آگهی، هر مهارتی که اضافه می‌کنید دارای یک دکمه ضربدر است که با کلیک روی آن می‌توانید مهارت را از لیست حذف کنید.',
      ),
    ],
  ),
  FaqTopic(
    title: 'داشبورد و امکانات',
    questions: [
      FaqQuestion(
        question: 'منوی شعاعی (Radial Menu) چیست؟',
        answer:
            'یک منوی دسترسی سریع تمام صفحه است که از گوشه تصویر باز می‌شود و امکان دسترسی سریع به بخش‌هایی مانند آگهی‌ها، خانه، پشتیبانی و خروج از حساب کاربری را فراهم می‌کند.',
      ),
      FaqQuestion(
        question: 'چگونه از حساب کاربری خارج شوم؟',
        answer:
            'با باز کردن منوی اصلی (Radial Menu) و انتخاب قطاع قرمز رنگ (خروج)، توکن کاربری شما پاک شده و از حساب خارج می‌شوید.',
      ),
    ],
  ),
];
