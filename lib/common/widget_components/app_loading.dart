import 'package:example/common/widget_components/loading/custom_loading.dart';
import 'package:example/import.dart';

Widget get appLoading => SizedBox(
      child: Center(
        child: CustomLoading(
            color: appThemes.mainColor, type: CustomLoadingType.start),
      ),
    );
