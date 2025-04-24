part of 'home_page.dart';

mixin HomePageMixin on State<HomePage> {
  late RefreshController categoryRefresh;
  late RefreshController productRefresh;
  late RefreshController bannerRefresh;
  late RefreshController storyRefresh;
  late PageController pageController;

  @override
  void initState() {
    categoryRefresh = RefreshController();
    productRefresh = RefreshController();
    bannerRefresh = RefreshController();
    storyRefresh = RefreshController();
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    categoryRefresh.dispose();
    productRefresh.dispose();
    pageController.dispose();
    bannerRefresh.dispose();
    storyRefresh.dispose();
    super.dispose();
  }

  onRefresh() {
    context.read<CategoryBloc>().add(CategoryEvent.fetchCategory(
        context: context, isRefresh: true, controller: productRefresh));
    context.read<ProductBloc>()
      ..add(ProductEvent.fetchAdsProduct(
          context: context, isRefresh: true, controller: productRefresh))
      ..add(ProductEvent.fetchAllProduct(
          context: context, isRefresh: true, controller: productRefresh));
    context.read<BlogBloc>().add(BlogEvent.fetchBlog(
        context: context, isRefresh: true, controller: productRefresh));
    context.read<BannerBloc>().add(BannerEvent.fetchBanner(
        context: context, isRefresh: true, controller: productRefresh));
    context.read<StoryBloc>().add(StoryEvent.fetchStory(
        context: context, isRefresh: true, controller: storyRefresh));
    productRefresh.resetNoData();
  }

  onLoading() {
    context.read<ProductBloc>().add(ProductEvent.fetchAllProduct(
        context: context, controller: productRefresh));
  }
}
