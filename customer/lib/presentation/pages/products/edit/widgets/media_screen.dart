part of '../edit_product_page.dart';


class MediaScreen extends StatelessWidget {
  final CustomColorSet colors;

  const MediaScreen({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    final event = context.read<EditProductBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        12.verticalSpace,
        Divider(
          thickness: 2,
          color: colors.divider,
        ),
        12.verticalSpace,
        Text(
          '${AppHelpers.getTranslation(TrKeys.photo)} *',
          style: CustomStyle.interSemi(
              color: colors.textBlack),
        ),
        4.verticalSpace,
        Text(
          AppHelpers.getTranslation(TrKeys.recommendedSize),
          style: CustomStyle.interNormal(
              color: colors.textBlack.withValues(alpha: .5),
              size: 14),
        ),
        12.verticalSpace,
        BlocBuilder<EditProductBloc, EditProductState>(
          buildWhen: (l, n) => l.images != n.images,
          builder: (context, state) {
            return MultiImagePicker(
              listOfImages: state.images,
              imageUrls: state.listOfUrls,
              onImageChange: (v) {
                event.add(
                    EditProductEvent.setImageFile(file: v));
              },
              onDelete: (v) {
                event.add(
                    EditProductEvent.deleteImage(value: v));
              },
              colors: colors,
            );
          },
        ),
        16.verticalSpace,
        Text(
          AppHelpers.getTranslation(TrKeys.video),
          style: CustomStyle.interSemi(
              color: colors.textBlack),
        ),
        4.verticalSpace,
        Text(
          AppHelpers.getTranslation(TrKeys.recommendedVideoSize),
          style: CustomStyle.interNormal(
              color: colors.textBlack.withValues(alpha: .5),
              size: 14),
        ),
        12.verticalSpace,
        BlocBuilder<EditProductBloc, EditProductState>(
          buildWhen: (l, n) => l.video != n.video,
          builder: (context, state) {
            return HorizontalVideoPicker(
              video: state.video,
              onDelete: () {
                event.add(
                    const EditProductEvent.deleteVideo());
              },
              colors: colors,
              onUpload: (v) {
                event.add(
                    EditProductEvent.setVideo(gallery: v));
              },
            );
          },
        ),
        12.verticalSpace,
      ],
    );
  }
}
