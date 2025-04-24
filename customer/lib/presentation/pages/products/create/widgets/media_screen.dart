part of '../create_product_page.dart';

class MediaScreen extends StatelessWidget {
  final CustomColorSet colors;

  const MediaScreen({super.key, required this.colors});

  @override
  Widget build(BuildContext context) {
    final event = context.read<CreateProductBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        12.verticalSpace,
        Divider(thickness: 2, color: colors.divider),
        12.verticalSpace,
        Text(
          '${AppHelpers.getTranslation(TrKeys.photo)} *',
          style: CustomStyle.interSemi(color: colors.textBlack),
        ),
        4.verticalSpace,
        Text(
          AppHelpers.getTranslation(TrKeys.recommendedSize),
          style: CustomStyle.interNormal(
              color: colors.textBlack.withValues(alpha: .5), size: 14),
        ),
        12.verticalSpace,
        BlocBuilder<CreateProductBloc, CreateProductState>(
          buildWhen: (l, n) => l.images != n.images,
          builder: (context, state) {
            return MultiImagePicker(
              listOfImages: state.images,
              onImageChange: (v) {
                event.add(CreateProductEvent.setImageFile(file: v));
              },
              onDelete: (v) {
                event.add(CreateProductEvent.deleteImage(value: v));
              },
              colors: colors,
            );
          },
        ),
        16.verticalSpace,
        Text(
          AppHelpers.getTranslation(TrKeys.video),
          style: CustomStyle.interSemi(color: colors.textBlack),
        ),
        4.verticalSpace,
        Text(
          AppHelpers.getTranslation(TrKeys.recommendedVideoSize),
          style: CustomStyle.interNormal(
              color: colors.textBlack.withValues(alpha: .5), size: 14),
        ),
        12.verticalSpace,
        BlocBuilder<CreateProductBloc, CreateProductState>(
          buildWhen: (l, n) => l.video != n.video,
          builder: (context, state) {
            return HorizontalVideoPicker(
              video: state.video,
              onDelete: () {
                event.add(const CreateProductEvent.deleteVideo());
              },
              colors: colors,
              onUpload: (v) {
                event.add(CreateProductEvent.setVideo(gallery: v));
              },
            );
          },
        ),
        16.verticalSpace,
      ],
    );
  }
}
