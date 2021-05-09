# A&R.Local To-Do List


## HIGH priority

  - add whatsnew and readme files
    - **really?** whatsnew is just the git log, and readme won't help an existing installation.
    - Maybe remove the links (but keep the architecture just in case).

  - picture datetime_cascade -> datetime_effective
    - remaining textual references (sorters, etc)

  - Method arguments - compatible with Ruby 3.0.1?


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
    + icons help
    - formatting for markup types, esp. for narrow width


## Possibly fixed

  + model: strip_whitespace_edges?



# Probably done

+ when to display title vs slug vs link
+ audio
+ pictures
+ Do picture selects still require a (none) option? **yes** it looks a lot better.

+ site favicon upload/catalog?
+ has_one_attached :icon
+ views: `_form_icon.....`
+ routing (i think it's all through #edit - **no**, needs a purge attachment path)
+ controller needs a #purge_icon_attachment

+ model & db & params_permitted: source_type etc.
+ icon_source_catalog_file_path (previously: html_head_favicon_catalog_filepath)
+ icon_source_type
+ params_permitted;
+ model
+ db

+ form_metadata
+ Obsolete references in views

+ (nginx) why does admin/ caching still happen?
