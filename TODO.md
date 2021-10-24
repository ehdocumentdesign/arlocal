# A&R.Local To-Do List


## HIGH priority

- double-check source_attachment features
+ video thumbnail upload/import
- Which parsers are obsolete?
  - HTML = Iframe
  - HTML P = simpleformat
  - HTML PRE = markdown


## Medium priority

+ Note where the selectable value source_type comes from the model, not via FormMetadata::Selectable
  - Controllers::Admin::Audio#new_[method_to_resource]
  - Controllers::Admin::Picture#new_[method_to_resource]
  - Helpers::AudioHelper#audio_admin_filter_select
  - Helpers::EventsHelper#event_public_filter_select
  - Helpers::PicturesHelper#picture_admin_filter_select


## Low Priority

  - form buttons for "destroy" action-- should they be individualized like other resource admin action buttons?
  - Audio index
  - about_arlocal
    - formatting for markup types, esp. for narrow width


## ~Possibly~ Probably fixed

- Finish import file verification (Controllers)

- Clean up PicturesHelper

- PicturesHelper::picture_datetime_cascade_value_statement
  - find calls
  - rename to effective_datetime
  - make sure it works

  + stop differentiating "catalog_[resource]_xxxx" helper methods
  + model: strip_whitespace_edges?
