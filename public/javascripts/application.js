var fixHelper = function(e, ui) {
  ui.children().each(function() {
      $(this).width($(this).width());
    });
  return ui;
};

function setupTasksDragDrop() {
  $('#tasks').sortable({
    items: 'tr',
    helper: fixHelper
  }).disableSelection();
}
