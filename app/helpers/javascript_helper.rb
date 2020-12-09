module JavascriptHelper


  ###########
    
    
  def js_element_ga(tracking_id)
<<-JS_ELEMENT_GA

<script>
window.ga=window.ga||function(){(ga.q=ga.q||[]).push(arguments)};ga.l=+new Date;
ga('create', '#{tracking_id}', 'auto');
ga('send', 'pageview');
</script>

<script async src='https://www.google-analytics.com/analytics.js'>
</script>

JS_ELEMENT_GA
  end

  
  ###########


  def js_element_ga_jp_onready_development
<<-JS_ELEMENT_GA_JP_ONREADY_DEV

<script>
$(document).ready(function() { Arlocal.jPlayer_ga._env.development.onReady() });
</script>

JS_ELEMENT_GA_JP_ONREADY_DEV
  end


  ###########


  def js_element_ga_jp_onready_production
<<-JS_ELEMENT_GA_JP_ONREADY_PRODUCTION

<script>
$(document).ready(function() { Arlocal.jPlayer_ga._env.production.onReady() });
</script>

JS_ELEMENT_GA_JP_ONREADY_PRODUCTION
  end


  ###########

    
  def js_fragment_jp_audio_ordered(resource_audio)
    album_order = resource_audio.playlist_order
    title = resource_audio.full_title
    duration = resource_audio.duration_as_text
    url_type = resource_audio.audio.file_type
    url_path = audio_preferred_url(resource_audio.audio)
<<-JS_FRAGMENT_JP_AUDIO_ORDERED
{
  albumOrder: "#{album_order}",
  title: "#{title}",
  duration: "#{duration}",
  #{url_type}: "#{url_path}"
}
JS_FRAGMENT_JP_AUDIO_ORDERED
  end


  ###########


  def js_fragment_jp_audio_unordered(audio)
    title = audio.full_title
    duration = audio.duration_as_text
    url_type = audio.file_type
    url_path = audio_preferred_url(audio)
<<-JS_FRAGMENT_JP_AUDIO_UNORDERED
{
  title: "#{title}",
  duration: "#{duration}",
  #{url_type}: "#{url_path}"
}
JS_FRAGMENT_JP_AUDIO_UNORDERED
  end


  ###########  
  
  
  def js_function_album_picture_cycler(picture_filepath_string)
<<-JS_FUNCTION_ALBUM_PICTURE_CYCLER

Arlocal.current_pictureCycler = {
  _onReady: function() {
    $(document).on('click', '.arl_active_picture_viewer', function(event) { Arlocal.current_pictureCycler.cyclePictures(event, Arlocal.current_pictureCycler.pictures) });
  },
  cyclePictures: function(event, pictures) {
    var oldImageSrc = pictures.shift();
    var newImageSrc = pictures[0];
    $(event.target).attr('src', newImageSrc);
    pictures.push(oldImageSrc);
  },
  pictures: [ #{picture_filepath_string} ],
};

$(document).on('ready', Arlocal.current_pictureCycler._onReady);

JS_FUNCTION_ALBUM_PICTURE_CYCLER
  end


  ###########


  def js_function_jp_playlist_onready(playlist_json)
<<-JS_FUNCTION_JP_PLAYLIST_ONREADY

$(document).ready(function() {
  var myPlayList = new jPlayerPlaylist(
    {
      jPlayer: '#jquery_jplayer_1',
      cssSelectorAncestor: '#jp_container_1'
    },
    [
      #{playlist_json.join(',')}
    ],
    {
      playlistOptions: {},
      preload: 'none',
      solution: 'html',
      supplied: 'm4a',
      wmode: 'window'
    }
  );
});

JS_FUNCTION_JP_PLAYLIST_ONREADY
  end


  ###########


  def js_function_jp_single_onready(audio_json)
<<-JS_FUNCTION_JP_ONREADY

$(document).ready(function() {
  $('#jquery_jplayer_1').jPlayer({
    ready: function() { $(this).jPlayer('setMedia', #{audio_json} ); },
    preload: 'none',
    solution: 'html',
    supplied: 'm4a',
    wmode: 'window'
  });
});  

JS_FUNCTION_JP_ONREADY
  end


  ###########
  
    
end
