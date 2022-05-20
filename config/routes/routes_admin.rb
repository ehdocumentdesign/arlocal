namespace :admin do


  get '/', to: 'about_arlocal#index', as: :root


  get 'about_arlocal',                 to: 'about_arlocal#index',           as: :about_arlocal
  get 'about_arlocal/content_storage', to: 'about_arlocal#content_storage', as: :about_arlocal_content_storage
  get 'about_arlocal/icons',           to: 'about_arlocal#icons',           as: :about_arlocal_icons
  get 'about_arlocal/markup_types',    to: 'about_arlocal#markup_types',    as: :about_arlocal_markup_types
  get 'about_arlocal/release_notes',   to: 'about_arlocal#release_notes',   as: :about_arlocal_release_notes
  get 'about_arlocal/whats_new',       to: 'about_arlocal#whats_new',       as: :about_arlocal_revision_log


  resources :administrators, only: [:index]


  resource  :arlocal_settings, only: [:edit, :update]
  patch     'arlocal_settings/update_from_resource', to: 'arlocal_settings#update_from_resource_and_return', as: :arlocal_settings_update_and_return
  patch     'arlocal_settings/purge_icon_image', to: 'arlocal_settings#purge_icon_image', as: :arlocal_settings_purge_icon_image


  resources :articles


  resources :albums
  patch     'albums/:id/audio_with_keyword',    to: 'albums#add_audio_by_keyword',       as: :album_add_audio_by_keyword
  patch     'albums/:id/pictures_with_keyword', to: 'albums#add_pictures_by_keyword',    as: :album_add_pictures_by_keyword
  patch     'albums/:id/audio_import',          to: 'albums#audio_create_from_import',   as: :album_audio_create_from_import
  patch     'albums/:id/audio_upload',          to: 'albums#audio_create_from_upload',   as: :album_audio_create_from_upload
  # get       'albums/:id/audio_keyword_join',    to: 'albums#edit_audio_keyword_join',    as: :album_edit_audio_keyword_join
  patch     'albums/:id/picture_import',        to: 'albums#picture_create_from_import', as: :album_picture_create_from_import
  patch     'albums/:id/picture_upload',        to: 'albums#picture_create_from_upload', as: :album_picture_create_from_upload
  # resources :albums do
  #   get 'pictures',                to: 'pictures#album_pictures_index',     as: :pictures_pictures_index
  #   get 'pictures/:id(.:format)',  to: 'pictures#album_pictures_show',      as: :picture
  # end


  resources :audio
  get   'audio_import_menu',          to: 'audio#new_import_menu',              as: 'audio_new_import_menu'
  get   'audio_import_single',        to: 'audio#new_import_single',            as: 'audio_new_import_single'
  post  'audio_import_single',        to: 'audio#create_from_import',           as: 'audio_create_from_import'
  get   'audio_import_to_album',      to: 'audio#new_import_to_album',          as: 'audio_new_import_to_album'
  post  'audio_import_to_album',      to: 'audio#create_from_import_to_album',  as: 'audio_create_from_import_to_album'
  get   'audio_import_to_event',      to: 'audio#new_import_to_event',          as: 'audio_new_import_to_event'
  post  'audio_import_to_event',      to: 'audio#create_from_import_to_event',  as: 'audio_create_from_import_to_event'
  patch 'audio_refresh_id3/:id',      to: 'audio#refresh_id3',                  as: 'audio_refresh_id3'
  get   'audio_upload_menu',          to: 'audio#new_upload_menu',              as: 'audio_new_upload_menu'
  get   'audio_upload_single',        to: 'audio#new_upload_single',            as: 'audio_new_upload_single'
  post  'audio_upload_single',        to: 'audio#create_from_upload',           as: 'audio_create_from_upload'
  get   'audio_upload_to_album',      to: 'audio#new_upload_to_album',          as: 'audio_new_upload_to_album'
  post  'audio_upload_to_album',      to: 'audio#create_from_upload_to_album',  as: 'audio_create_from_upload_to_album'
  get   'audio_upload_to_event',      to: 'audio#new_upload_to_event',          as: 'audio_new_upload_to_event'
  post  'audio_upload_to_event',      to: 'audio#create_from_upload_to_event',  as: 'audio_create_from_upload_to_event'
  patch 'audio/:id/purge_attachment', to: 'audio#purge_source_attachment',      as: 'audio_purge_source_attachment'



  resources :articles


  resources :events
  patch     'events/:id/audio_with_keyword',    to: 'events#add_audio_by_keyword',       as: :event_add_audio_by_keyword
  patch     'events/:id/pictures_with_keyword', to: 'events#add_pictures_by_keyword',    as: :event_add_pictures_by_keyword
  patch     'events/:id/audio_import',          to: 'events#audio_create_from_import',   as: :event_audio_create_from_import
  post      'events/:id/audio_upload',          to: 'events#audio_create_from_upload',   as: :event_audio_create_from_upload
  # get       'events/:id/audio_keyword_join',    to: 'events#edit_audio_keyword_join',    as: :event_edit_audio_keyword_join
  patch     'events/:id/picture_import',        to: 'events#picture_create_from_import', as: :event_picture_create_from_import
  patch     'events/:id/picture_upload',        to: 'events#picture_create_from_upload', as: :event_picture_create_from_upload
# resources :events do
  #   get 'pictures',                to: 'pictures#event_pictures_index',   as: :pictures_pictures_index
  #   get 'pictures/:id(.:format)',  to: 'pictures#event_pictures_show',    as: :picture
  # end


  resources :infopages, path: 'info'
  patch     'info/:id/picture_import',        to: 'infopages#picture_create_from_import', as: :infopage_picture_create_from_import
  patch     'info/:id/picture_upload',        to: 'infopages#picture_create_from_upload', as: :infopage_picture_create_from_upload
  patch     'info/:id/pictures_with_keyword', to: 'infopages#add_pictures_by_keyword',    as: :infopage_add_pictures_by_keyword


  get   'isrc/review',     to: 'isrc#review', as: :isrc_review
  patch 'isrc/update/:id', to: 'isrc#update', as: :isrc_update

  resources :keywords
  delete    'keywords/:id/untag_albums',   to: 'keywords#untag_albums',               as: :untag_albums
  delete    'keywords/:id/untag_audio',    to: 'keywords#untag_audio',                as: :untag_audio
  delete    'keywords/:id/untag_events',   to: 'keywords#untag_events',               as: :untag_events
  delete    'keywords/:id/untag_pictures', to: 'keywords#untag_pictures',             as: :untag_pictures
  patch     'keywords/:id/audio_import',   to: 'keywords#audio_create_from_import',   as: :keyword_audio_create_from_import
  patch     'keywords/:id/audio_upload',   to: 'keywords#audio_create_from_upload',   as: :keyword_audio_create_from_upload
  patch     'keywords/:id/picture_import', to: 'keywords#picture_create_from_import', as: :keyword_picture_create_from_import
  patch     'keywords/:id/picture_upload', to: 'keywords#picture_create_from_upload', as: :keyword_picture_create_from_upload


  resources :links


  resources :pictures
  patch     'picture_refresh_exif/:id',     to: 'pictures#refresh_exif',                   as: 'picture_refresh_exif'
  get       'picture_import_menu',          to: 'pictures#new_import_menu',                as: 'picture_new_import_menu'
  get       'picture_import_single',        to: 'pictures#new_import_single',              as: 'picture_new_import_single'
  post      'picture_import_single',        to: 'pictures#create_from_import',             as: 'picture_create_from_import'
  get       'picture_import_to_album',      to: 'pictures#new_import_to_album',            as: 'picture_new_import_to_album'
  post      'picture_import_to_album',      to: 'pictures#create_from_import_to_album',    as: 'picture_create_from_import_to_album'
  get       'picture_import_to_event',      to: 'pictures#new_import_to_event',            as: 'picture_new_import_to_event'
  post      'picture_import_to_event',      to: 'pictures#create_from_import_to_event',    as: 'picture_create_from_import_to_event'
  get       'picture_upload_menu',          to: 'pictures#new_upload_menu',                as: 'picture_new_upload_menu'
  get       'picture_upload_single',        to: 'pictures#new_upload_single',              as: 'picture_new_upload_single'
  post      'picture_upload_single',        to: 'pictures#create_from_upload',             as: 'picture_create_from_upload'
  get       'picture_upload_to_album',      to: 'pictures#new_upload_to_album',            as: 'picture_new_upload_to_album'
  post      'picture_upload_to_album',      to: 'pictures#create_from_upload_to_album',    as: 'picture_create_from_upload_to_album'
  get       'picture_upload_to_event',      to: 'pictures#new_upload_to_event',            as: 'picture_new_upload_to_event'
  post      'picture_upload_to_event',      to: 'pictures#create_from_upload_to_event',    as: 'picture_create_from_upload_to_event'
  patch     'picture/:id/purge_attachment', to: 'pictures#purge_source_attachment',        as: 'picture_purge_source_attachment'
  # patch     'picture/:id/attachment_add',   to: 'pictures#attachment_add',                as: 'picture_attachment_add'
  # patch     'picture/:id/attachment_purge', to: 'pictures#attachment_purge',              as: 'picture_attachment_purge'


  # toggles between admin and public view for currently-authenticated administrators
  get 'toggle', to: 'session#toggle_admin', as: :toggle_admin


  resources :streams

  resources :videos
  patch     'videos/:id/picture_import',        to: 'videos#picture_create_from_import', as: :video_picture_create_from_import
  patch     'videos/:id/picture_upload',        to: 'videos#picture_create_from_upload', as: :video_picture_create_from_upload


end
