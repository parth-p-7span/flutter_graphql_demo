import 'package:flutter_graphql/di/app_module.dart';
import 'package:flutter_graphql/graphql/client.dart';
import 'package:flutter_graphql/main_dev.dart';
import 'package:flutter_graphql/screens/polls/bloc/poll_bloc.dart';
import 'package:flutter_graphql/screens/polls/mapper/poll_graphql_response_mapper.dart';
import 'package:flutter_graphql/screens/polls/repo/poll_repo.dart';
import 'package:flutter_graphql/screens/polls/source/poll_graphql_source.dart';
import 'package:flutter_graphql/screens/polls/state/poll_ui_state_manager.dart';

class PollModule {
  static PollModule _instance = PollModule._internal();
  AppGraphqlClient appGraphqlClient = AppGraphqlClient(apiVepaarOpen);

  PollModule._internal();

  factory PollModule() {
    return _instance;
  }

  PollBloc getPolls() {
    return PollBloc(
      getPollsUiStateManager(),
    );
  }

  PollUiStateManager getPollsUiStateManager() {
    return PollUiStateManager(
      getPollsRepo(),
    );
  }

  PollRepo getPollsRepo() {
    return PollRepo(
      _getPollsGraphQlSource(),
      PollGraphQlResponseMapper(),
    );
  }

  PollGraphQlSource _getPollsGraphQlSource() {
    return PollGraphQlSource(
      appGraphqlClient,
    );
  }
}
