function togglePurcharse(clicked_game_id) {
    $button = $('#'+clicked_game_id);
    $span = $('#span-'+clicked_game_id);
    $peopleLikes = $('#people-purcharsed-'+clicked_game_id);
    if($button.hasClass('isActive')){

        $button.addClass('notActive');
        $button.removeClass('isActive');
        $button.prop('title', 'I have it!');

        $span.addClass('s-notActive');
        $span.removeClass('s-isActive');

        $url = '/remove_purcharse';
    } else {

        $button.addClass('isActive');
        $button.removeClass('notActive');
        $button.prop('title', 'I do not have it!');

        $span.addClass('s-isActive');
        $span.removeClass('s-notActive');

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
