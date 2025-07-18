import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/di/di.dart';
import 'package:food_app/features/auth/data/datasources/AuthLocalDataSource.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_cart/cart_bloc.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_cart/cart_event.dart';
import 'package:food_app/features/food/presentation/bloc/bloc_cart/cart_state.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

class AppMainScreen extends StatefulWidget {
  final Widget child;
  const AppMainScreen({super.key, required this.child});

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen> {
  int _currentIndex = 0;
  final tabs = ['/home', '/search', '/profile', '/cart'];

  String? userUid;
  int cartItemCount = 0;

  @override
  void initState() {
    super.initState();
    checkUserId();
  }

  void checkUserId() async {
    final uid = await sl<AuthLocalDatasource>().getCachedUserId();
    setState(() {
      userUid = uid;
    });

    if (userUid != null) {
      context.read<CartBloc>().add(FetchAllUserCartRequested(uid!));
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentLocation = GoRouterState.of(context).uri.toString();

    // List of paths where bottom nav should be hidden
    final hideBottomNavPaths = [
      '/foodDetails',
      '/viewAllProduct',
      '/signup',
      '/onboarding',
    ];

    final shouldHideBottomNav = hideBottomNavPaths.any(
      (path) => currentLocation.startsWith(path),
    );
    return Scaffold(
      body: widget.child,
      bottomNavigationBar:
          shouldHideBottomNav
              ? null
              : Container(
                height: 60,
                decoration: BoxDecoration(color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItems(Iconsax.home_15, "A", 0),
                    SizedBox(width: 10),
                    _buildNavItems(CupertinoIcons.search, "B", 1),
                    SizedBox(width: 10),
                    _buildNavItems(Icons.person_outline, "C", 2),
                    SizedBox(width: 10),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        _buildNavItems(Iconsax.shopping_cart, "D", 3),
                        BlocListener<CartBloc, CartState>(
                          listener: (context, state) {
                            if (state is CartLoaded) {
                              setState(() {
                                cartItemCount = state.carts.length;
                              });
                            }
                          },
                          child: Positioned(
                            right: -7,
                            top: 5,
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 10,
                              child: Text(
                                "${cartItemCount}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        
                        // Positioned(
                        //   right: 135,
                        //   top: -25,
                        //   child: CircleAvatar(
                        //     backgroundColor: Colors.red,
                        //     radius: 30,
                        //     child: Icon(
                        //       CupertinoIcons.search,
                        //       size: 30,
                        //       color: Colors.white,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
    );
  }

  Widget _buildNavItems(IconData icon, String label, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });

        context.go(tabs[index]);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 28,
            color: _currentIndex == index ? Colors.red : Colors.grey,
          ),
          SizedBox(height: 3),
          CircleAvatar(
            radius: 3,
            backgroundColor:
                _currentIndex == index ? Colors.red : Colors.transparent,
          ),
        ],
      ),
    );
  }
}
