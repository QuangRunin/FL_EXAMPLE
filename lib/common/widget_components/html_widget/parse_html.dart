import 'package:example/common/utils/utils.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:photo_view/photo_view.dart';
import 'package:example/import.dart';

class ParseHtml extends StatelessWidget with BaseMixin {
  const ParseHtml({
    super.key,
    required this.value,
    this.styleText,
  });
  final String? value;
  final TextStyle? styleText;
  @override
  Widget build(BuildContext context) {
    return HtmlWidget(
      value ?? '-',
      onErrorBuilder: (context, element, error) => const Text('-'),
      onLoadingBuilder: (context, element, loadingProgress) => Center(
        child: SizedBox(
          width: 25,
          height: 25,
          child: CircularProgressIndicator(
            color: color.mainColor,
            strokeWidth: 2,
          ),
        ),
      ),
      onTapImage: (ImageMetadata data) {
        showDialog(
          context: context,
          builder: (context) {
            return Stack(
              alignment: Alignment.topRight,
              children: [
                PhotoView(
                    imageProvider: NetworkImage(data.sources.first.url),
                    initialScale: PhotoViewComputedScale.contained,
                    minScale: PhotoViewComputedScale.contained * 0.5,
                    maxScale: PhotoViewComputedScale.contained * 4),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Navigator.of(context).pop(),
                    child:
                        const Icon(Icons.close, color: Colors.white, size: 24),
                  ),
                ),
              ],
            );
          },
        );
      },
      onTapUrl: (p0) {
        openBrowser(p0);
        return false;
      },
      textStyle: styleText ??
          textStyle.regular(
            size: 14,
          ),
    );
  }

  // ignore: deprecated_member_use
  Widget buildImage(BuildMetadata meta, Object provider, ImageMetadata data) {
    final built = buildImage(meta, provider, data);

    if (provider is ImageProvider) {
      final heroTag = data.sources.first.url;

      return Builder(
        builder: (context) => GestureDetector(
          child: Hero(
            tag: heroTag,
            child: buildImage(meta, provider, data),
          ),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => Scaffold(
                    appBar: AppBar(),
                    body: SizedBox(
                      child: PhotoView(
                        heroAttributes: PhotoViewHeroAttributes(tag: heroTag),
                        imageProvider: provider,
                      ),
                    ),
                  ))),
        ),
      );
    }

    return built;
  }
}
