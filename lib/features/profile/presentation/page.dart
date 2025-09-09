import 'package:bar_stock/core/constants/state_status.dart';
import 'package:bar_stock/di/auth/auth_provider.dart';
import 'package:bar_stock/di/profile/profile_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/shadcn_flutter_extension.dart';
import 'package:bar_stock/core/shared_ui/widgets/go_back_button.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const tableSpacing = 6.0;
    final authCtrl = ref.read(authControllerProvider.notifier);
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.status == StateStatus.submitting;
    final profileState = ref.watch(profileControllerProvider);
    final profile = profileState.profile;

    logOut() async => await authCtrl.logOut();

    return Scaffold(
      child: SafeArea(
        child: Container(
          color: context.theme.colorScheme.background,
          child: Column(
            spacing: 16,
            children: [
              // Header
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GoBackButton(),
                      Button(
                        onPressed: () {},
                        style: const ButtonStyle(
                          shape: ButtonShape.circle,
                          variance: ButtonVariance.outline,
                          density: ButtonDensity.icon,
                        ),
                        child: Icon(LucideIcons.settings, size: 16),
                      ),
                    ],
                  ).withPadding(horizontal: 16, vertical: 8),
                  const Divider(),
                ],
              ),
              Flex(
                direction: Axis.vertical,
                spacing: 16,
                children: [
                  // Avatar
                  Column(
                    spacing: 16,
                    children: [
                      Avatar(
                        initials: 'Employer avatar',
                        size: 128,
                        provider: CachedNetworkImageProvider(
                          profile?.avatarUrl ?? "",
                          maxHeight: 256,
                          maxWidth: 256,
                        ),
                      ),
                      OutlineBadge(
                        child: Text(
                          profile?.name ?? "undefined",
                          style: TextStyle(fontSize: 24),
                        ).withMargin(vertical: 3, horizontal: 6),
                      ),
                    ],
                  ),
                  // Info
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          spacing: tableSpacing,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Полное имя:',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'E-mail:',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Роль:',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Приглашён:',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Column(
                          spacing: tableSpacing,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profile?.fullName ?? 'undefined',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              profile?.email ?? 'undefined',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              profile?.role ?? 'undefined',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              profile?.invitedAt.toString() ?? "undefined",
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ).withPadding(horizontal: 32, vertical: 16),
                ],
              ),
              const Spacer(),
              Button(
                onPressed: logOut,
                enabled: !isLoading,
                style: ButtonStyle(
                  variance: ButtonVariance.destructive,
                  size: ButtonSize.normal,
                  density: ButtonDensity.icon,
                ),
                trailing: isLoading
                    ? CircularProgressIndicator(size: 24)
                    : Icon(LucideIcons.logOut, size: 24),
                child: Text(
                  "Выход",
                  style: TextStyle(fontSize: 24),
                ).withMargin(horizontal: 6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
