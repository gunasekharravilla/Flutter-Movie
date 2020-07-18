import 'package:fish_redux/fish_redux.dart';
import 'package:movie/views/stream_link_page/episode_livestream_page/state.dart';

class PlayerState implements Cloneable<PlayerState> {
  String playerType;
  String streamLink;
  String background;
  int streamLinkId;
  bool useVideoSourceApi;
  bool streamInBrowser;
  @override
  PlayerState clone() {
    return PlayerState()
      ..playerType = playerType
      ..streamLink = streamLink
      ..background = background
      ..useVideoSourceApi = useVideoSourceApi
      ..streamInBrowser = streamInBrowser;
  }
}

class PlayerConnector extends ConnOp<EpisodeLiveStreamState, PlayerState> {
  @override
  PlayerState get(EpisodeLiveStreamState state) {
    PlayerState mstate = state.playerState.clone();
    mstate.useVideoSourceApi = state.bottomPanelState.useVideoSourceApi;
    mstate.streamInBrowser = state.bottomPanelState.streamInBrowser;
    mstate.background = state.selectedEpisode.stillPath;
    mstate.streamLinkId = state.selectedLink?.sid ?? 0;
    mstate.playerType =
        state.selectedLink?.streamLinkType?.name ?? 'VideoSourceApi';
    mstate.streamLink = state.selectedLink?.streamLink ??
        'https://moviessources.cf/embed/${state.tvid}/${state.season.seasonNumber}-${state.selectedEpisode.episodeNumber}';
    return mstate;
  }

  @override
  void set(EpisodeLiveStreamState state, PlayerState subState) {
    state.playerState = subState;
  }
}