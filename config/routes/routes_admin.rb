namespace :admin do


  get '/', to: 'albums#index', as: :root


  get 'about_arlocal',               to: 'about_arlocal#index',         as: :about_arlocal
  get 'about_arlocal/markup_types',  to: 'about_arlocal#markup_types',  as: :about_arlocal_markup_types
  get 'about_arlocal/release_notes', to: 'about_arlocal#release_notes', as: :about_arlocal_release_notes
  get 'about_arlocal/whats_new',     to: 'about_arlocal#whats_new',     as: :about_arlocal_revision_log


  resources :administrators, only: [:index]


  patch    'arlocal_settings/update_from_resource', to: 'arlocal_settings#update_from_resource_and_return', as: :arlocal_settings_update_and_return
  resource :arlocal_settings, only: [:edit, :update]


  resources :articles


  patch     'albums/:id/audio_with_keyword',    to: 'albums#add_audio_by_keyword',       as: :album_add_audio_by_keyword
  patch     'albums/:id/pictures_with_keyword', to: 'albums#add_pictures_by_keyword',    as: :album_add_pictures_by_keyword
  resources :albums do
    get 'pictures',                to: 'pictures#album_pictures_index',     as: :pictures_pictures_index
    get 'pictures/:id(.:format)',  to: 'pictures#album_pictures_show',      as: :picture
  end


  resources :audio

  patch 'audio_refresh_id3/:id', to: 'audio#refresh_id3', as: 'audio_refresh_id3'

  get  'audio_import_menu',      to: 'audio#new_import_menu',              as: 'audio_new_import_menu'
  get  'audio_import_single',    to: 'audio#new_import_single',            as: 'audio_new_import_single'
  post 'audio_import_single',    to: 'audio#create_from_import',           as: 'audio_create_from_import'
  get  'audio_import_to_album',  to: 'audio#new_import_to_album',          as: 'audio_new_import_to_album'
  post 'audio_import_to_album',  to: 'audio#create_from_import_to_album',  as: 'audio_create_from_import_to_album'
  get  'audio_import_to_event',  to: 'audio#new_import_to_event',          as: 'audio_new_import_to_event'
  post 'audio_import_to_event',  to: 'audio#create_from_import_to_event',  as: 'audio_create_from_import_to_event'

  get  'audio_upload_menu',      to: 'audio#new_upload_menu',              as: 'audio_new_upload_menu'
  get  'audio_upload_single',    to: 'audio#new_upload_single',            as: 'audio_new_upload_single'
  post 'audio_upload_single',    to: 'audio#create_from_upload',           as: 'audio_create_from_upload'
  get  'audio_upload_to_album',  to: 'audio#new_upload_to_album',          as: 'audio_new_upload_to_album'
  post 'audio_upload_to_album',  to: 'audio#create_from_upload_to_album',  as: 'audio_create_from_upload_to_album'
  get  'audio_upload_to_event',  to: 'audio#new_upload_to_event',          as: 'audio_new_upload_to_event'
  post 'audio_upload_to_event',  to: 'audio#create_from_upload_to_event',  as: 'audio_create_from_upload_to_event'

  patch 'audio/:id/attachment_add',   to: 'audio#attachment_add',   as: 'audio_attachment_add'
  patch 'audio/:id/attachment_purge', to: 'audio#attachment_purge', as: 'audio_attachment_purge'



  resources :articles


  patch     'events/:id/audio_with_keyword',    to: 'events#add_audio_by_keyword',       as: :event_add_audio_by_keyword
  patch     'events/:id/pictures_with_keyword', to: 'events#add_pictures_by_keyword',    as: :event_add_pictures_by_keyword
  resources :events do
    get 'pictures',                to: 'pictures#event_pictures_index',   as: :pictures_pictures_index
    get 'pictures/:id(.:format)',  to: 'pictures#event_pictures_show',    as: :picture
  end


  resource :info, path: 'info', only: [:edit, :show, :update]


  delete    'keywords/:id/untag_albums',   to: 'keywords#untag_albums',   as: :untag_albums
  delete    'keywords/:id/untag_audio',    to: 'keywords#untag_audio',    as: :untag_audio
  delete    'keywords/:id/untag_events',   to: 'keywords#untag_events',   as: :untag_events
  delete    'keywords/:id/untag_pictures', to: 'keywords#untag_pictures', as: :untag_pictures
  resources :keywords


  resources :links


  resources :pictures

  patch 'picture_refresh_exif/:id', to: 'pictures#refresh_exif', as: 'picture_refresh_exif'

  get  'picture_import_menu',      to: 'pictures#new_import_menu',              as: 'picture_new_import_menu'
  get  'picture_import_single',    to: 'pictures#new_import_single',            as: 'picture_new_import_single'
  post 'picture_import_single',    to: 'pictures#create_from_import',           as: 'picture_create_from_import'
  get  'picture_import_to_album',  to: 'pictures#new_import_to_album',          as: 'picture_new_import_to_album'
  post 'picture_import_to_album',  to: 'pictures#create_from_import_to_album',  as: 'picture_create_from_import_to_album'
  get  'picture_import_to_event',  to: 'pictures#new_import_to_event',          as: 'picture_new_import_to_event'
  post 'picture_import_to_event',  to: 'pictures#create_from_import_to_event',  as: 'picture_create_from_import_to_event'

  get  'picture_upload_menu',      to: 'pictures#new_upload_menu',              as: 'picture_new_upload_menu'
  get  'picture_upload_single',    to: 'pictures#new_upload_single',            as: 'picture_new_upload_single'
  post 'picture_upload_single',    to: 'pictures#create_from_upload',           as: 'picture_create_from_upload'
  get  'picture_upload_to_album',  to: 'pictures#new_upload_to_album',          as: 'picture_new_upload_to_album'
  post 'picture_upload_to_album',  to: 'pictures#create_from_upload_to_album',  as: 'picture_create_from_upload_to_album'
  get  'picture_upload_to_event',  to: 'pictures#new_upload_to_event',          as: 'picture_new_upload_to_event'
  post 'picture_upload_to_event',  to: 'pictures#create_from_upload_to_event',  as: 'picture_create_from_upload_to_event'

  patch 'picture/:id/attachment_add',   to: 'pictures#attachment_add',   as: 'picture_attachment_add'
  patch 'picture/:id/attachment_purge', to: 'pictures#attachment_purge', as: 'picture_attachment_purge'


  # toggles between admin and public view for currently-authenticated administrators
  get 'toggle', to: 'session#toggle_admin', as: :toggle_admin


  resources :streams

  resources :videos

end
