# A&R.Local To-Do List


## HIGHEST priority


## HIGH priority

- make a more meaningful keywords index

- review video picture import-- does it still fail? Check upload too.
- Fixed, BUT:
  - Video :has_one picture as a thumbnail
  -   by comparison,
  - Event :has_many pictures as a collection
  -   therefore
  - The supplementary methods for importing will look different.
  - Should this remain, or should Video-Picture be a :has_many relationship?
  - **Probably should be a :has_many relationship for consistency.**

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
- double-check source_attachment features


## Probably fixed

- check forms for appropriate autocomplete attributes
