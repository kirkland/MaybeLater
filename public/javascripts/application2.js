/* DO NOT MODIFY. This file was compiled Thu, 19 May 2011 17:01:34 GMT from
 * /home/rob/code/maybe_later/app/coffeescripts/application2.coffee
 */

(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  this.TasksIndex = (function() {
    function TasksIndex(reorderPath) {
      this.reorderPath = reorderPath;
      this.setupTasksDragDrop();
    }
    TasksIndex.prototype.fixHelper = function(e, ui) {
      ui.children().each(function() {
        return $(this).width($(this).width());
      });
      return ui;
    };
    TasksIndex.prototype.setupTasksDragDrop = function() {
      return $('#tasks tbody').sortable({
        items: 'tr',
        helper: this.fixHelper,
        containment: "#tasks tbody",
        tolerance: 'pointer',
        update: __bind(function(event, ui) {
          var newTasksOrder;
          newTasksOrder = $.map($('#tasks tr').not('.task_template'), function(t) {
            return $(t).attr('data-id');
          });
          return $.ajax(this.reorderPath, {
            type: 'POST',
            data: {
              ordered_task_ids: newTasksOrder
            }
          });
        }, this)
      });
    };
    return TasksIndex;
  })();
}).call(this);
