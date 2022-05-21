# A&R.Local To-Do List


## HIGHEST priority

- review video picture import-- does it still fail? Check upload too.


## HIGH priority

- check forms for appropriate autocomplete attributes

- datetime to text inputs instead of selects
  - why does `size: ` attribute result in larger-than-size fields? inherited from CSS maybe?

- check various `form_pictures`
  - coverpicture=true would slightly obscure the Order field
  - is a javascript thing.
  - also maybe `form_elements/join_picture_order` needs a class declaration

- views/admin/shared/_index_joined
  - is this used beyond Picture
  - previous plan was for shared partials showing joined resources
  - is this still the plan, or should this be refactored into individual resource view partials?
    - contrast with `_admin_[resource]_stats.haml`

- Video: include attribute for duration? read mediainfo?

- Why does PictureKeyword have an `id_public` method? It's not even directly accessible.
  - related: are the redundant join methods such as `PictureKeyword#picture_title #picture_id #picture_slug` still needed?

- give a title to nested_picture uploads/imports

- form_elements/picture_select: should it receive selectable or selectable.pictures?
  - _Check this throughout. Might be best to start with seeing what variables each form_elements requires._

- eventshelper:158 why assign js empty?

- pictures_helper picture_preferred_url
  - check if picture exists (add file_exists? method to model)
  - if not, return a dummy html_class to guarantee minimal dimensions
- form_pictures exerwhere
- picture_selector in join_single

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

- change the Calendar model from a module to a class
  - **Compare with video_group.** Maybe it's best as a query method?

- 1_borders.scss
  - refactor mixins that are image

- admin:audio#edit?id3 needs some refinement.
  - columns
  - is audio_helper the best place for the method?

+ Note where the selectable value source_type comes from the model, not via FormMetadata::Selectable
  - ***Refactoring these has low priority because there is only one @selectable item.***
    - Controllers::Admin::Audio#new_[method_to_resource]
    - Controllers::Admin::Picture#new_[method_to_resource]
  - ***Refactoring these requires deciding whether to assign SorterIndexAdmin[].options_for_select to @selectable into the controller and passing it all the way through.***
    - Helpers::AudioHelper#audio_admin_filter_select
    - Helpers::EventsHelper#event_public_filter_select
    - Helpers::PicturesHelper#picture_admin_filter_select

+ Albums#Show: section/div nesting doesn't make sense. **CSS Grid will fix this**


## Low Priority

- administrators/sign_in
  - Is it worth getting `devise::rememberable` to work correctly?

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

- Video index sort by keyword
+ CSS Grid for admin forms checkbox **In Progress**
- TODO: Button spacing in admin forms **In Progress**

- Admin::Videos#Edit
  - add title across panes
  - check for pane stickiness with neighbors

- Finish import file verification (Controllers)

- Delete obsolete commented-out parser methods.

- Pictures without titles
  - (untitled) appears in joined_pictures. YAY!
  - how to make it appear in <select> options?
    - start w/ `QueryPictures.options_for_select_admin_with_nil`
      - `all_pictures.sort_by{ |p| p.title_without_markup.downcase }`
    - `views/form_elements/picture_select`
      - `picture_options_for_select(selectable.pictures, form)`
    - helpers/picture_helper:127
      -           picture.title_without_markup,
      - **should be picture.title**
      - Picture model had previously been retrofitted to allow this. Looks OK to change.
      - but should the method be called `title_for_select`?

- ISRC on videos

- ISRC: report and validation across models
  * admin menu header/link
    - **routing**
      - **What's with the extended URL syntax on this? see update.[format??]**
      - **And what's with the format param equal to the title?**
      * index = edit?
    * layout
      * table
      * type, name, isrc, [submit]
  - **controller**
    * reports_controller
    * query resources from audio and video
    * update
    - **reject ID from params?**
  * views
    * sort by isrc
    * form for each item
  - admin_isrc_review_sort_order
    - sort by title?
    - sort by resource?
    - model
    - helpers
    - controller etc.

  - Admin::ArlocalSettings?admin
    - ***This might have been fixed in or negated by the FormMetadata refactor.***
    - options for select & selectable & form_elements/select form_elements_arls/select_sorter
    - The map method for the form builder is located within the lib/InactiveRecord module and FormMetadata::Selectable
    - For clarity, should it be refactored into the form builder or partial?
    - As things stand, it's not clear how the collection and value/text methods get delivered to the form


    - Should auto_keyword be in the top part of a form? **I think so.**
