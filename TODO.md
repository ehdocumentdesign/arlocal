# A&R.Local To-Do List


## HIGH priority

- CSS: Review `forms_test.scss` and remove obsolete classes from `forms.scss`
  - Done, BUT:
    - adminstrator forms including sign-on need updating
    - admin_header picture lost its class **fixed?**
    - resource `form_pictures` lost some data heading/value classes.
      - album and keyword, probably event too (hopefully uses a partial in `form_elements`)
      - font-face
      - layout/grid/table for uniform alignment.
  - check these classes in `resource.scss`
    - line 86: `.arl_admin_resource_joined*`

- Video: include attribute for duration & read mediainfo?

- give a title to nested_picture uploads/imports


>        - Which parsers are obsolete? **Seems right.**
>          - HTML = Iframe
>          - HTML P = simpleformat
>          - HTML PRE = markdown
>        - Only allow iframe in video embedding. **No, leave it as HTML embed for power admins.**
>        - This is OK to finalize.


- form_elements/picture_select: should it receive selectable or selectable.pictures?
  - _Check this throughout. Might be best to start with seeing what variables each form_elements requires._

- Why are some delete/purge buttons made with a proper form helper, but others are through button_helper?

- eventshelper:158 why assign js empty?

- pictures_helper picture_preferred_url
  - check if picture exists (add file_exists? method to model)
  - if not, return a dummy html_class to guarantee minimal dimensions
- form_pictures exerwhere
- picture_selector in join_single

- Admin::ArlocalSettings?icon
  - purge_attachment has not been refactored into new grid css

- Should auto_keyword be in the top part of a form? **I think so.**

- review routes for semantic/logical cohesion
  - obsolete routes are commented. I think all of them.
  - some are not currently in use.


## Medium priority

- what is this: in `app/assets/stylesheets/evo/2_public/jplayer/1_jp_audio.scss :: 2`
> // TODO: figure out why this doesn't render border-bottom or border-top
> // see .jp-type-playlist for border-bottom.
> // see .arl_albums_show_player for border-top.
>

- FormMetadataSelectableUtils:65
  - will relying on an Integer for @picture.id create a false negative?

- EventVideo object

- import/upload video via `keywords/_form_video_import`

- Anti-pattern forming in `form_metadata`
  - Make a object or hash that centralizes forms/panes and their properties instead of using `case` statements

- 1_borders.scss
  - refactor mixins that are image

- admin:audio#edit?id3 needs some refinement.
  - columns
  - is audio_helper the best place for the method?

- Admin::ArlocalSettings?admin
  - options for select & selectable & form_elements/select form_elements_arls/select_sorter
  - The map method for the form builder is located within the lib/InactiveRecord module and FormMetadata::Selectable
  - For clarity, should it be refactored into the form builder or partial?
  - As things stand, it's not clear how the collection and value/text methods get delivered to the form

- which partials can be refactored?
  - especially `_admin_[resource]_stats.haml`

+ Note where the selectable value source_type comes from the model, not via FormMetadata::Selectable
  - Controllers::Admin::Audio#new_[method_to_resource]
  - Controllers::Admin::Picture#new_[method_to_resource]
  - Helpers::AudioHelper#audio_admin_filter_select
  - Helpers::EventsHelper#event_public_filter_select
  - Helpers::PicturesHelper#picture_admin_filter_select

+ Albums#Show: section/div nesting doesn't make sense. **CSS Grid will fix this**


## Low Priority

  - form buttons for "destroy" action-- should they be individualized like other resource admin action buttons?  **YES, probably.***
  - Audio index
  - about_arlocal
    - formatting for markup types, esp. for narrow width


## Possibly fixed

- Does audio view still use _form_attachment* ? **Probably not.**
  **YES. it's a decision tree for upload/purge.**
  **Resubmit as a UI/UX review.**

- review routes for actions/controllers made obsolete by `#edit?pane=[]`
- Video: Why doesn't picture import work? check all them for bugs. maybe the Video model.
+ video thumbnail upload/import
- double-check source_attachment features


## Probably fixed

+ CSS Grid for admin forms checkbox **In Progress**
- TODO: Button spacing in admin forms **In Progress**

- Admin::Videos#Edit
  - add title across panes
  - check for pane stickiness with neighbors

- Finish import file verification (Controllers)

- Clean up PicturesHelper

- PicturesHelper::picture_datetime_cascade_value_statement
  - find calls
  - rename to effective_datetime
  - make sure it works

  + stop differentiating "catalog_[resource]_xxxx" helper methods
  + model: strip_whitespace_edges?

  - event/form_audio does not have partial for _form_audio_join_by_keyword
