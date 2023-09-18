import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../Views/common/error_page/page_not_found.dart';
import '../Views/common/forgot_password/forgot_password.dart';
import '../Views/common/login_page/login_page.dart';
import '../Views/common/main_page/common_home_page.dart';
import '../Views/common/reload_page/reload_page.dart';
import '../Views/evaluation/evaluation_main_page.dart';
import '../Views/evaluation/overview/screen_overview_evaluation.dart';
import '../Views/pilotage/entity/admin/screen_admin_pilotage.dart';
import '../Views/pilotage/entity/entity_piloatage_main.dart';
import '../Views/pilotage/entity/overview/screen_overview_pilotage.dart';
import '../Views/pilotage/entity/performs/screen_pilotage_perform.dart';
import '../Views/pilotage/entity/profil/screen_pilotage_profil.dart';
import '../Views/pilotage/entity/suivi/screen_suivi_pilotage.dart';
import '../Views/pilotage/entity/support_client/screen_support_client.dart';
import '../Views/pilotage/entity/tableau_bord/indicateur_screen.dart';
import '../Views/pilotage/entity/tableau_bord/screen_tableau_bord_pilotage.dart';
import '../Views/pilotage/home/pilotage_home.dart';
import '../helpers/helper_methods.dart';
import '../widgets/loading_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

class RouteClass {
  static final supabase = Supabase.instance.client;

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: supabase.auth.currentSession != null ? "/" : "/account/login",
    errorBuilder: (context, state) {
      return PageNotFound();
    },
    routes: [
      GoRoute(
          path: '/',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            restorationId: state.pageKey.value,
            child: const MainPage(),
          ),
      ),
      GoRoute(
        path: '/reload-page',
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          restorationId: state.pageKey.value,
          child: ReloadScreen(redirection: state.extra.toString(),),
        ),
      ),
      GoRoute(
          path: '/pilotage',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            restorationId: state.pageKey.value,
            child: const PilotageHome(),
          ),
          routes: [
            GoRoute(
                path: 'espace/sucrivoire-siege',
                name: "Sucrivoire Siège",
                pageBuilder: (context, state) => NoTransitionPage<void>(
                    key: state.pageKey,
                    restorationId: state.pageKey.value,
                    child: Scaffold(
                      backgroundColor: Colors.white,
                      body: Center(
                        child: loadingPageWidget(),
                      ),
                    )//const PilotageEntiteOverview(urlPath: "profil"),
                ),
                routes:[
                  ShellRoute(
                    navigatorKey: _shellNavigatorKey,
                    builder: (BuildContext context, GoRouterState state, Widget child) {
                      return EntityPilotageMain(child: child);
                    },
                    routes: <RouteBase>[
                      GoRoute(
                        path: 'accueil',
                        pageBuilder: (context, state) => NoTransitionPage<void>(
                            key: state.pageKey,
                            child: const ScreenOverviewPilotage()
                        ),
                      ),
                      GoRoute(
                        path: 'tableau-de-bord',
                        pageBuilder: (context, state) => NoTransitionPage<void>(
                            key: state.pageKey,
                            child: const ScreenTableauBordPilotage()
                        ),
                        routes: [
                          GoRoute(
                              path: 'indicateurs',
                              pageBuilder: (context, state) => NoTransitionPage<void>(
                                  key: state.pageKey,
                                  child: IndicateurScreen()
                              ),
                          )
                        ]
                      ),
                      GoRoute(
                        path: 'profil',
                        pageBuilder: (context, state) => NoTransitionPage<void>(
                            key: state.pageKey,
                            child: ScreenPilotageProfil()
                        ),
                      ),
                      //
                      GoRoute(
                        path: 'performances',
                        pageBuilder: (context, state) => NoTransitionPage<void>(
                            key: state.pageKey,
                            child: const ScreenPilotagePerform()
                        ),
                      ),
                      GoRoute(
                        path: 'suivi-des-donnees',
                        pageBuilder: (context, state) => NoTransitionPage<void>(
                            key: state.pageKey,
                            child: const ScreenPilotageSuivi()
                        ),
                      ),
                      GoRoute(
                        path: 'admin',
                        pageBuilder: (context, state) => NoTransitionPage<void>(
                            key: state.pageKey,
                            child: const ScreenPilotageAdmin()
                        ),
                      ),
                      GoRoute(
                        path: 'support-client',
                        pageBuilder: (context, state) => NoTransitionPage<void>(
                            key: state.pageKey,
                            child: const ScreenSupportClient()
                        ),
                      )
                    ],
                  ),
                ]
            ),
          ]),
            ShellRoute(
              navigatorKey: _shellNavigatorKey,
              builder: (BuildContext context, GoRouterState state, Widget child) {
                return EvaluationPage(child: child);
              },
              routes: <RouteBase>[
                GoRoute(
                  path: '/audit/accueil',
                  pageBuilder: (context, state) => NoTransitionPage<void>(
                      key: state.pageKey,
                      child: const ScreenOverviewEvaluation()
                  ),
                ),
              ],
            ),

      GoRoute(
          path: '/account/login',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            restorationId: state.pageKey.value,
            child: const LoginPage(),
          )
      ),
      GoRoute(
          path: '/account/reset-password',
          pageBuilder: (context, state) => NoTransitionPage<void>(
            key: state.pageKey,
            restorationId: state.pageKey.value,
            child: const ResetPassword(),
          )
      ),
    ],
    redirect: (context ,state) async {

      if (state.fullPath!=null && state.fullPath =="/account/reset-password"){
        return null;
      }
      final storage = FlutterSecureStorage();
      String? loggedPref = await storage.read(key: 'logged');
      String? email = await storage.read(key: 'email');
      final appVersion = await getAppVersion();
      String? appVersionFlutter = await storage.read(key: 'app_version');
      bool sessionVerification = false;
      final session = supabase.auth.currentSession;
      if (session != null) {
        sessionVerification = true;
      } else {
        sessionVerification = false;
      }
      if (loggedPref == "true" && email!=null && GetUtils.isEmail(email) && sessionVerification ==true && appVersion == appVersion)//appVersionFlutter )
      {
        return null;
      }
      return "/account/login";
    },
  );

  static getAppVersion() async {
    final result = await supabase.from("System").select("app_version").eq("id", 0);
    return result[0]["app_version"];
  }
}
