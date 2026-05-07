import 'package:equatable/equatable.dart';

class ProjectEntity extends Equatable {
  final String title;
  final String description;
  final List<String> tags;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String? logoAsset;
  final String? screenshotAsset;

  const ProjectEntity({
    required this.title,
    required this.description,
    required this.tags,
    this.playStoreUrl,
    this.appStoreUrl,
    this.logoAsset,
    this.screenshotAsset,
  });

  @override
  List<Object?> get props => [title, description, tags, playStoreUrl, appStoreUrl, logoAsset, screenshotAsset];
}
