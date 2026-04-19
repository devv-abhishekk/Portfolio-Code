import 'package:equatable/equatable.dart';

class PersonalInfoEntity extends Equatable {
  final String name;
  final String title;
  final String summary;
  final String email;
  final String phone;
  final String githubUrl;
  final String linkedInUrl;
  final String resumeUrl;

  const PersonalInfoEntity({
    required this.name,
    required this.title,
    required this.summary,
    required this.email,
    required this.phone,
    required this.githubUrl,
    required this.linkedInUrl,
    required this.resumeUrl,
  });

  @override
  List<Object?> get props => [name, title, summary, email, phone, githubUrl, linkedInUrl, resumeUrl];
}
