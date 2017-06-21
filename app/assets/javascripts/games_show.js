function togglePurcharse(clicked_game_id) {
    $button = $('#'+clicked_game_id);
    $span = $('#span-'+clicked_game_id);
    $peopleLikes = $('#people-purcharsed-'+clicked_game_id);
    if($button.hasClass('isActive')){

        $button.addClass('btn-primary notActive');
        $button.removeClass('btn-success isActive');
        $button.html('Save as Purcharsed');

        $url = '/remove_purcharse';
    } else {

        $button.addClass('btn-success isActive');
        $button.removeClass('btn-primary notActive');
        $button.html("Remove from Purcharses");

        $url = '/add_purcharse';
    }

    $button.blur();

    $.ajax({
      type: "GET",
      dataType: "json",
      url: $url,
      data: {
          game_id: clicked_game_id// < note use of 'this' here
      },
      success: function(json) {
          $peopleLikes.html("Purcharses: " + json.peoplePurcharses);

      },
      error: function(json) {
          $peopleLikes.html("Purcharses: " + json.peoplePurcharses);
      }
  });
}
