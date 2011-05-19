/* DO NOT MODIFY. This file was compiled Thu, 19 May 2011 18:52:35 GMT from
 * /home/rob/code/maybe_later/app/coffeescripts/application.coffee
 */

(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };
  this.TasksIndex = (function() {
    function TasksIndex(reorderPath, createPath) {
      this.reorderPath = reorderPath;
      this.createPath = createPath;
      this.setupTasksDragDrop();
      this.setupNewTaskForm();
      $.each($('#tasks tbody tr'), __bind(function(i, ele) {
        return this.setupNewRow($(ele));
      }, this));
      $('#task_title').focus();
    }
    TasksIndex.prototype.setupTasksDragDrop = function() {
      var fixHelper;
      fixHelper = function(e, ui) {
        ui.children().each(function() {
          return $(this).width($(this).width());
        });
        return ui;
      };
      return $('#tasks tbody').sortable({
        items: 'tr',
        helper: fixHelper,
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
      }).disableSelection();
    };
    TasksIndex.prototype.insertNewTask = function(title, id) {
      var newRow, taskData;
      taskData = {
        title: title,
        'id': id
      };
      newRow = $('.task_template').clone().directives({
        '.task_title': 'title',
        '@data-id': 'id'
      }).render(taskData).removeClass('task_template');
      $('#tasks tbody').prepend(newRow);
      return newRow;
    };
    TasksIndex.prototype.setupNewRow = function(newRow) {
      return newRow.find('.actions .complete_link').click(event, function() {
        event.preventDefault();
        newRow.remove();
        return $.ajax(newRow.attr('data-update_path'), {
          type: 'POST',
          data: {
            task_id: newRow.attr('data-id'),
            defer_time: 0
          },
          success: __bind(function(data) {}, this),
          error: __bind(function(data) {}, this)
        });
      });
    };
    TasksIndex.prototype.setupNewTaskForm = function() {
      return $('#task_submit').click(event, __bind(function() {
        var ajaxData, newRow, title;
        event.preventDefault();
        ajaxData = $('#new_task').serialize();
        title = $('#task_title').val();
        $('#task_title').val('');
        newRow = this.insertNewTask(title);
        return $.ajax(this.createPath, {
          type: 'POST',
          data: ajaxData,
          success: __bind(function(data) {
            newRow.attr('data-id', data.task.id);
            newRow.attr('data-update_path', data.task.update_path);
            newRow.find('td').removeClass('just_added');
            return this.setupNewRow(newRow);
          }, this),
          error: function(data) {}
        });
      }, this));
    };
    return TasksIndex;
  })();
}).call(this);
