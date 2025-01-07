class AppVersionModel {
  AppVersionModel({
    this.appVersion,
    this.requiredUpdate,
    this.linkUrl,
  });

  factory AppVersionModel.fromMap(Map<String, dynamic> json) => AppVersionModel(
        appVersion: json['app_version'],
        requiredUpdate: json['required_update'],
        linkUrl: json['link_url'],
      );

  final String? appVersion;
  final bool? requiredUpdate;
  final String? linkUrl;

  Map<String, dynamic> toMap() => {
        'app_version': appVersion,
        'required_update': requiredUpdate,
        'link_url': linkUrl,
      };
}
