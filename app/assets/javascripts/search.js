$(function() {
  $("#search").autocomplete({
    source: $("#search").data("source"),
    minLength: 1,
    select: function(event, ui) {
      if (ui.item.value === $(event.target).val()) {
        return false; // prevent form submission
      }
      $(event.target).val(ui.item.value);
      $("#search-form").submit();
    }
  });
});