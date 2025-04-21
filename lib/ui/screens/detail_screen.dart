import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/restaurant_api_service.dart';
import 'package:restaurant_app/data/api/restaurant_image_url.dart';
import 'package:restaurant_app/data/models/restaurant_detail.dart';
import 'package:restaurant_app/providers/restaurant_detail_provider.dart';
import 'package:restaurant_app/ui/widgets/loading_view.dart';
import 'package:restaurant_app/ui/widgets/menu_tab.dart';
import 'package:restaurant_app/ui/widgets/overview_tab.dart';
import 'package:restaurant_app/ui/widgets/reviews_tab.dart';
import 'package:restaurant_app/utils/restaurant_detail_state.dart';
import 'package:restaurant_app/ui/widgets/error_view.dart';

class DetailScreen extends StatelessWidget {
  final String restaurantId;

  const DetailScreen({super.key, required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final provider = RestaurantDetailProvider(
          context.read<RestaurantApiService>(),
        );
        provider.setRestaurantId(restaurantId);
        return provider;
      },
      child: Consumer<RestaurantDetailProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            body: switch (provider.state) {
              RestaurantDetailLoadingState() => LoadingView(
                title: 'Loading Restaurant Details...',
              ),
              RestaurantDetailLoadedState(data: var restaurant) =>
                _DetailViewWithTabs(
                  restaurant: restaurant,
                  onRefresh: () => provider.fetchRestaurantDetail(),
                ),
              RestaurantDetailNoneState(message: String? message) => ErrorView(
                message: message ?? 'No restaurants available.',
                onRetry: () => provider.fetchRestaurantDetail(),
              ),
              RestaurantDetailErrorState(error: String error) => ErrorView(
                message: error,
                onRetry: () => provider.fetchRestaurantDetail(),
              ),
            },
          );
        },
      ),
    );
  }
}

class _DetailViewWithTabs extends StatefulWidget {
  final RestaurantDetail restaurant;
  final VoidCallback onRefresh;

  const _DetailViewWithTabs({
    required this.restaurant,
    required this.onRefresh,
  });

  @override
  State<_DetailViewWithTabs> createState() => _DetailViewWithTabsState();
}

class _DetailViewWithTabsState extends State<_DetailViewWithTabs>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => widget.onRefresh(),
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 300,
              pinned: true,
              stretch: true,
              backgroundColor: Theme.of(context).colorScheme.primary,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  var top = constraints.biggest.height;
                  bool isCollapsed = top < kToolbarHeight + 30;

                  return FlexibleSpaceBar(
                    centerTitle: false,
                    titlePadding: EdgeInsets.only(
                      bottom: isCollapsed ? 16 : 20,
                      left: isCollapsed ? 54 : 24,
                      right: 16,
                    ),
                    title: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: isCollapsed ? 1.0 : 0.0,
                      child: Text(
                        widget.restaurant.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Hero(
                          tag: 'restaurant-${widget.restaurant.id}',
                          child: Image.network(
                            RestaurantImageUrl.large(
                              widget.restaurant.pictureId,
                            ),
                            fit: BoxFit.cover,
                            errorBuilder:
                                (_, __, ___) => Container(
                                  color: Colors.grey[700],
                                  child: const Icon(
                                    Icons.broken_image,
                                    color: Colors.white,
                                    size: 60,
                                  ),
                                ),
                          ),
                        ),
                        Positioned.fill(
                          child: BackdropFilter(
                            filter: ui.ImageFilter.blur(
                              sigmaX: isCollapsed ? 10 : 0,
                              sigmaY: isCollapsed ? 10 : 0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.7),
                                    Colors.transparent,
                                    Colors.black.withOpacity(0.8),
                                  ],
                                  stops: const [0.0, 0.4, 1.0],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          bottom: 20,
                          right: 20,
                          child: AnimatedOpacity(
                            duration: const Duration(milliseconds: 300),
                            opacity: isCollapsed ? 0.0 : 1.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Hero(
                                        tag:
                                            'restaurant-name-${widget.restaurant.id}',
                                        child: Material(
                                          color: Colors.transparent,
                                          child: Text(
                                            widget.restaurant.name,
                                            style: const TextStyle(
                                              fontSize: 26,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              shadows: [
                                                Shadow(
                                                  blurRadius: 8,
                                                  color: Colors.black,
                                                  offset: Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Hero(
                                      tag:
                                          'restaurant-rating-${widget.restaurant.id}',
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 12,
                                            vertical: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(
                                                  context,
                                                ).colorScheme.secondary,
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
                                                  0.3,
                                                ),
                                                blurRadius: 8,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                widget.restaurant.rating
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Hero(
                                      tag:
                                          'restaurant-city-${widget.restaurant.id}',
                                      child: Material(
                                        color: Colors.transparent,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(
                                              0.2,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              20,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.location_on,
                                                color: Colors.white,
                                                size: 16,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                widget.restaurant.city,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  labelColor: Theme.of(context).colorScheme.primary,
                  unselectedLabelColor: Colors.grey,
                  tabs: const [
                    Tab(icon: Icon(Icons.info_outline), text: "Overview"),
                    Tab(icon: Icon(Icons.restaurant_menu), text: "Menu"),
                    Tab(icon: Icon(Icons.reviews), text: "Reviews"),
                  ],
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            OverviewTab(restaurant: widget.restaurant),
            MenuTab(menus: widget.restaurant.menus),
            ReviewsTab(
              reviews: widget.restaurant.customerReviews,
              restaurantId: widget.restaurant.id,
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
