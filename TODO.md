# A&R.Local To-Do List


## HIGH priority

  - stop differentiating "catalog_[resource]_xxxx" helper methods

  - PicturesHelper::picture_datetime_cascade_value_statement
    - find calls
    - rename to effective_datetime
    - make sure it works


## Medium priority

- Clean up PicturesHelper

+ Note where the selectable value source_type comes from the model, not via FormMetadata::Selectable
  - Controllers::Admin::Audio#new_[method_to_resource]
  - Controllers::Admin::Picture#new_[method_to_resource]
  - Helpers::AudioHelper#audio_admin_filter_select
  - Helpers::EventsHelper#event_public_filter_select
  - Helpers::PicturesHelper#picture_admin_filter_select


## Low Priority

  - Audio index
  - about_arlocal
    - formatting for markup types, esp. for narrow width


## Possibly fixed

  + model: strip_whitespace_edges?
