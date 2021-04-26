# A&R.Local To-Do List

## HIGH priority

  - site favicon upload/catalog?
    - has_one_attached :image
    - views: just one viewpane?
    - controllers: params_permitted; can be done via update?
    - model & db: source_type etc.
    - form_metadata
  - Note that the selectable value source_type comes from the model, not via FormMetadata::Selectable

  - (nginx) why does admin/ caching still happen?

## Medium priority

  - when to display title vs slug vs link

## Low Priority

  - AudioController#create_from_import_to_album , etc.
    AudioController#new_from_import_to_album , etc.
    - should the (Album) query be a selectable from Form[X]Metadata?

  - Audio index

## Possibly fixed

  - picture datetime_cascade -> datetime_effective
