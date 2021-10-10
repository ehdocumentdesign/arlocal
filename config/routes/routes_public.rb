root to: 'public/albums#index'

get 'albums',     to: 'public/albums#index', as: 'public_albums'
get 'albums/:id', to: 'public/albums#show',  as: 'public_album'

get 'albums/:album_id/pictures',     to: 'public/pictures#album_pictures_index', as: 'public_album_pictures'
get 'albums/:album_id/pictures/:id', to: 'public/pictures#album_pictures_show',  as: 'public_album_picture'

get 'audio',     to: 'public/audio#index', as: 'public_audios'
get 'audio/:id', to: 'public/audio#show',  as: 'public_audio'

get 'events',          to: 'public/events#index', as: 'public_events'
get 'events/:id',      to: 'public/events#show',  as: 'public_event'

get 'events/:event_id/pictures',     to: 'public/pictures#event_pictures_index', as: 'public_event_pictures'
get 'events/:event_id/pictures/:id', to: 'public/pictures#event_pictures_show',  as: 'public_event_picture'

get 'info',     to: 'public/infopages#first', as: 'public_infopage_first'
get 'info/:id', to: 'public/infopages#show',  as: 'public_infopage'

get 'pictures',                to: 'public/pictures#index',            as: 'public_pictures'
# get 'pictures/page/:page',     to: 'public/pictures#index_by_page',    as: 'public_pictures_by_page'
get 'pictures/tagged/:tag_id', to: 'public/pictures#index_by_tag',     as: 'public_pictures_by_tag'
get 'pictures/not_tagged',     to: 'public/pictures#index_not_tagged', as: 'public_pictures_not_tagged'
get 'pictures/:id',            to: 'public/pictures#show',             as: 'public_picture'

get 'stream',      to: 'public/streams#show',  as: 'stream'
get 'streams/:id', to: 'public/streams#show',  as: 'public_stream'
get 'streams',     to: 'public/streams#index', as: 'public_streams'

get 'videos', to: 'public/videos#index', as: 'public_videos'
get 'videos/:id', to: 'public/videos#show', as: 'public_video'
