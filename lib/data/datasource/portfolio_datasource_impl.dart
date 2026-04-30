import '../models/portfolio_models.dart';
import 'portfolio_datasource.dart';

class PortfolioDataSourceImpl implements PortfolioDataSource {
  @override
  PersonalInfoModel getPersonalInfo() => const PersonalInfoModel(
    name: 'ABHISHEK KUMAR',
    title: 'Flutter Developer | 4+ Years Experience',
    summary:
        'Flutter Developer with 4+ years of experience building high-performance cross-platform mobile applications for Android and iOS using Flutter and Dart. Strong expertise in BLoC architecture, REST API integration, Firebase services, and payment gateway integrations including PhonePe and Razorpay. Currently working as a Freelance Flutter Developer.',
    email: 'dev.abhishekkumar81@gmail.com',
    phone: '+91 8127253679',
    linkedInUrl: 'https://www.linkedin.com/in/abhishek-kumar-548b84192/',
    githubUrl: 'https://github.com/devv-abhishekk',
    resumeUrl:
        'https://raw.githubusercontent.com/abhishekkumar/portfolio/main/resume.pdf',
  );

  @override
  List<SkillCategoryModel> getSkills() => const [
    SkillCategoryModel(
      category: 'Languages & Frameworks',
      skills: ['Dart', 'Flutter', 'Java', 'Android SDK'],
    ),
    SkillCategoryModel(
      category: 'State Management',
      skills: ['BLoC', 'Cubit', 'Provider', 'GetX'],
    ),
    SkillCategoryModel(
      category: 'Backend & APIs',
      skills: ['REST API Integration', 'JSON Parsing'],
    ),
    SkillCategoryModel(
      category: 'Database',
      skills: ['Firebase', 'SQLite', 'SharedPreferences'],
    ),
    SkillCategoryModel(
      category: 'Integrations',
      skills: ['PhonePe', 'UPI', 'Razorpay', 'Google Maps'],
    ),
    SkillCategoryModel(
      category: 'Architecture',
      skills: ['Clean Architecture', 'MVVM', 'Modular Structure'],
    ),
  ];

  @override
  List<ExperienceModel> getExperiences() => const [
    ExperienceModel(
      company: 'Freelance',
      role: 'Senior Flutter Developer',
      duration: 'Jan 2026 - Present',
      points: [
        'Building high-quality mobile applications for international clients.',
        'Implementing complex animations and custom UI components.',
        'Integrating multiple payment gateways and third-party services.',
      ],
    ),
    ExperienceModel(
      company: 'OneEHR Private Limited',
      role: 'Flutter Developer',
      duration: 'Sep 2025 - Nov 2025',
      points: [
        'Developed scalable Flutter modules improving performance and UI responsiveness.',
      ],
    ),
    ExperienceModel(
      company: 'Bitlyze Technologies Private Limited',
      role: 'Flutter Developer',
      duration: 'Dec 2023 - Jun 2025',
      points: [
        'Built cross-platform applications used by B2B customers.',
        'Implemented BLoC architecture improving maintainability.',
      ],
    ),
    ExperienceModel(
      company: 'SWA Softtech Private Limited',
      role: 'Flutter & Android Developer',
      duration: 'Jun 2022 - Dec 2023',
      points: [
        'Developed end-to-end Flutter applications with REST API integration.',
      ],
    ),
    ExperienceModel(
      company: 'DigiCoders Technologies Private Limited',
      role: 'Android Intern',
      duration: 'Sep 2021 - Mar 2022',
      points: [
        'Developed Android apps using Java and integrated SQLite database.',
      ],
    ),
  ];

  @override
  List<ProjectModel> getProjects() => const [
    ProjectModel(
      title: 'Tribe (B2B Shopping App)',
      description:
          'Multi-role Flutter application with store management and bulk ordering system.',
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.tribe.app',
      tags: ['Flutter', 'BLoC', 'REST API', 'Multi-role'],
    ),
    ProjectModel(
      title: 'Bharat Beej (BBSSL)',
      description:
          'Agriculture seed distribution mobile application built for the Sahakar Beej network.',
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.bbssl.app',
      tags: ['Flutter', 'Firebase', 'Agriculture'],
    ),
    ProjectModel(
      title: 'Lending App',
      description:
          'Secure digital loan platform with biometric authentication and PIN protection.',
      tags: ['Flutter', 'Biometrics', 'Security', 'FinTech'],
    ),
    ProjectModel(
      title: 'Saksham Express',
      description:
          'Logistics tracking application with GPS tracking and real-time notifications.',
      tags: ['Flutter', 'GPS', 'Real-time'],
    ),
    ProjectModel(
      title: 'Tele Consultation App',
      description:
          'Healthcare platform for appointment scheduling and doctor consultation.',
      tags: ['Flutter', 'Healthcare', 'Telemedicine'],
    ),
  ];

  @override
  List<EducationModel> getEducation() => const [
    EducationModel(
      degree: 'B.Tech – Computer Science',
      institution: 'Dr. Rizvi College of Engineering',
      year: 'Graduating 2025',
    ),
    EducationModel(
      degree: 'Diploma – Computer Science Engineering',
      institution: 'Government Polytechnic Madhogarh Jalaun',
      year: '2021',
    ),
  ];
}
