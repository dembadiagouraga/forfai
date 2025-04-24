part of '../edit_product_page.dart';

class DescribeField extends StatelessWidget {
  final CustomColorSet colors;
  final TextEditingController desc;

  const DescribeField({super.key, required this.colors, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomTextFormField(
          label: TrKeys.description,
          controller: desc,
          textInputAction: TextInputAction.next,
          hint: '${AppHelpers.getTranslation(TrKeys.additionInformation)}...',
          minLines: 3,
          maxLength: 300,
        ),
        if (LocalStorage.getAiActive())
          Positioned(
            right: 0,
            bottom: 0,
            child: BlocBuilder<EditProductBloc, EditProductState>(
              builder: (context, state) {
                return BlocBuilder<GeminiBloc, GeminiState>(
                    builder: (context, aiState) {
                  return GenerateButton(
                    onTap: () {
                      if (state.images.isEmpty && state.listOfUrls.isEmpty) {
                        AppHelpers.openDialog(
                            context: context,
                            title: AppHelpers.getTranslation(TrKeys.pleaseSelectImage));
                      } else {
                        context
                            .read<GeminiBloc>()
                            .add(GeminiEvent.imageDescribe(
                              context: context,
                              images: state.images,
                              onSuccess: (value) {
                                desc.text = '$value\n';
                              },
                              networkImages: state.listOfUrls
                                  .map((e) => e.path ?? '')
                                  .toList(),
                            ));
                      }
                    },
                    colors: colors,
                    isLoading: aiState.isLoading,
                  );
                });
              },
            ),
          )
      ],
    );
  }
}
