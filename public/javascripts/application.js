var fixHelper = function(e, ui) {
  ui.children().each(function() {
      $(this).width($(this).width());
    });
  return ui;
};

function setupTasksDragDrop(updatePath) {
  $('#tasks').sortable({
    items: 'tr',
    helper: fixHelper,
    update: function(event, ui) { 
      var aboveRank = ui.item.prev().attr('data-rank');
      if (aboveRank) {
        var newRank = aboveRank;
      } else {
        var newRank = -1; // special value, means higest rank
      }
      console.log(aboveRank);

      // AJAX here, set dragged element's rank to prev's rank minus one
      $.ajax(updatePath, {
        type: 'POST',
        data: {
         id: ui.item.attr('data-id'),
         new_rank: newRank
        },
        success: function(data) {
          console.log(data);
        },
        error: function () {
          alert("something went wrong");
        }
      });
    }
  }).disableSelection();
}
