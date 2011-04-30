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
      var belowRank = ui.item.next().attr('data-rank');
      if (belowRank) {
        var newRank = belowRank;
      } else {
        var newRank = -1; // special value, means lowest rank (highest number)
      }
      //      console.log(newRank);

      // AJAX here, set dragged element's rank to prev's rank minus one
      $.ajax(updatePath, {
        type: 'POST',
        data: {
         id: ui.item.attr('data-id'),
         new_rank: newRank
        },
        success: function(data) {
		  //	  console.log(data);
        },
        error: function () {
          alert("something went wrong");
        }
      });
    }
  }).disableSelection();
}
