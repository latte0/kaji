$(function() {
  $('#sortable-table').sortable({
    update: function(e, ui) {
      params = {
        row_order_position: ui.item.index(),
        tag_id: ui.item[0].id
      };
      $.ajax({
        type: 'POST',
        url: '/admins/tags/sort',
        dataType: 'json',
        data: params
      });
    }
  });
});
