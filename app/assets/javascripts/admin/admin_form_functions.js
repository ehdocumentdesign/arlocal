Arlocal.Admin = {};

Arlocal.Admin.Frontend = {

  
  // updates the image for an associated picture-select imput
  changeSelectedImage: function(event) {
    console.log('select');
    var selected_index = $(event.target).prop('selectedIndex');
    var imageOptions = $(event.target).children('option');
    var newSelection = $(imageOptions[selected_index]);
    var imgElement = $(event.target).parent().find('.arl_form_data_select_thumbnail_image');
    var newSrc = newSelection.data('picture-src');
    var nilPictureUrl = /catalog\/pictures\/$/;
    $(imgElement).attr('src', newSrc);
  },
  
  

  toggleCoverpictureStatuses: function(event) {
    var this_checkbox = event.target;
    if ($(this_checkbox).prop('checked') === true) {
      var other_checkboxes = $('.arl_active_checkbox_coverpicture').not(this_checkbox);
      $(other_checkboxes).prop('checked',false);
      $(other_checkboxes).parent().parent().find('.arl_form_resource_picture_order').removeClass('arl_form_data_attr_not_applicable');
      $(this_checkbox).prop('checked',true)
      $(this_checkbox).parent().parent().find('.arl_form_resource_picture_order').addClass('arl_form_data_attr_not_applicable');
    }
    if ($(this_checkbox).prop('checked') === false) {
      $(this_checkbox).parent().parent().find('.arl_form_resource_picture_order').show();
    }
  },
  

  
};

Arlocal.Admin._onReady = function() {
  $(document).on('change', '.arl_active_checkbox_coverpicture', function(event) { Arlocal.Admin.Frontend.toggleCoverpictureStatuses(event) } );
  $(document).on('change', '.arl_form_data_selector_pictures', function(event) { Arlocal.Admin.Frontend.changeSelectedImage(event) } );
};
  

$(document).on('ready', Arlocal.Admin._onReady());
  

