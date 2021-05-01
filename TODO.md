# A&R.Local To-Do List

## HIGH priority

  - Note where the selectable value source_type comes from the model, not via FormMetadata::Selectable

## Medium priority

  - when to display title vs slug vs link
  - Do picture selects still require a (none) option?

## Low Priority

  - AudioController#create_from_import_to_album , etc.
    AudioController#new_from_import_to_album , etc.
    - should the (Album) query be a selectable from Form[X]Metadata?

  - Audio index

## Possibly fixed

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

  + model: strip_whitespace_edges?
  + form_metadata
  + Obsolete references in views

  + (nginx) why does admin/ caching still happen?
  + picture datetime_cascade -> datetime_effective
