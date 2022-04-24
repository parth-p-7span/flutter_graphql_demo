import 'package:flutter/material.dart';
import 'package:flutter_graphql/screens/polls/bloc/poll_bloc.dart';
import 'package:flutter_graphql/screens/polls/di/poll_module.dart';
import 'package:flutter_graphql/screens/polls/model/poll.dart';
import 'package:flutter_graphql/screens/polls/model/poll_data.dart';
import 'package:flutter_graphql/screens/polls/model/request/get_poll_request.dart';
import 'package:flutter_graphql/screens/polls/state/get_poll_state.dart';
import 'package:flutter_graphql/screens/polls/ui/poll_list_tile.dart';
import 'package:flutter_graphql/widgets/custom_appbar.dart';
import 'package:flutter_graphql/widgets/pagination_wrapper.dart';
import 'package:flutter_graphql/widgets/sortable_listview.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../theme_data.dart';

class PollPage extends StatefulWidget {
  const PollPage({Key? key}) : super(key: key);

  @override
  _PollPageState createState() => _PollPageState();
}

class _PollPageState extends State<PollPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late PollBloc _pollBloc;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  bool isSortingEnable = false;

  // int _indexOfKey(Key key) {
  //   return _pollBloc.pollDataStream.value.polls
  //       .indexWhere((Poll d) => ValueKey(d.id) == key);
  // }

  @override
  void initState() {
    super.initState();
    _pollBloc = PollModule().getPolls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: BackButton(
          color: MyTheme.appbarTitleColor,
        ),
        title: Text(
          "Polls",
          style: GoogleFonts.lato(
              textStyle: TextStyle(color: MyTheme.appbarTitleColor)),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isSortingEnable = !isSortingEnable;
                });
              },
              icon: Icon(
                Icons.sort_sharp,
                color: Colors.black54,
              ))
        ],
      ),
      body: StreamBuilder<GetPollsState>(
        stream: _pollBloc.getPollStateStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final state = snapshot.data;
            bool isInitialLoading = state?.isInitialRequest ?? true;
            if ((state?.isLoading() == true) && isInitialLoading) {
              return Center(
                  child: Container(
                child: CircularProgressIndicator(),
              ));
            }
            if ((state?.isError() == true) && isInitialLoading) {
              return Center(
                  child: Container(child: Text(state!.error.toString())));
            }
            bool isEndReached = state?.data?.isEndReached ?? false;

            return StreamBuilder<PollData>(
                stream: _pollBloc.pollDataStream,
                initialData: _pollBloc.pollDataStream.value,
                builder: (context, snapshot) {
                  final items = snapshot.data?.polls ?? [];
                  if (items.isEmpty &&
                      isInitialLoading &&
                      state?.isCompleted() == true) {
                    return Center(
                        child: Container(child: Text("items is empty")));
                  }
                  int extraItemCount = isEndReached ? 0 : 1;
                  if (state!.isLoading() || items.isEmpty) extraItemCount = 1;
                  return Column(
                    children: [
                      Expanded(
                          child: PaginationWrapper(
                        isLoading: state.isLoading(),
                        isEndReached: isEndReached,
                        onLoadMore: () {
                          _pollBloc.loadMore();
                        },
                        scrollableChild: RefreshIndicator(
                          key: refreshKey,
                          onRefresh: refreshList,
                          child: ReorderableListView.builder(
                              onReorder: (oldIndex, newIndex) {
                                var existingList =
                                    _pollBloc.pollDataStream.value;
                                final index = newIndex > oldIndex
                                    ? newIndex - 1
                                    : newIndex;
                                final data =
                                    existingList.polls!.removeAt(oldIndex);
                                existingList.polls?.insert(index, data);
                                _pollBloc.pollDataStream.add(existingList);
                              },
                              itemCount: items.length + extraItemCount,
                              itemBuilder: (context, index) {
                                if (index >= items.length) {
                                  if (state.isLoading() && isInitialLoading) {
                                    return Container(
                                        key: ValueKey("loading state"),
                                        child: Text("state is loading..."));
                                  }
                                  // show progress bar footer
                                  return SizedBox(
                                    key: ValueKey("footerLoader"),
                                    height: 40,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                                return PollListTile(
                                  key: ValueKey(items[index]),
                                  name: items[index].name,
                                  question: items[index].question,
                                  isIconVisible: isSortingEnable,
                                );
                              }),
                        ),
                      ))
                    ],
                  );
                });
          } else {
            return Center(
                child: Container(child: Text("snapshot don't have data")));
          }
        },
      ),
    );
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);

    setState(() {
      _pollBloc.getPolls(request: GetPollRequest(page: 1, perPage: 10));
    });
    return null;
  }
}
