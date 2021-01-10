$(function() {
  imageError = function(id) {
    var elm = document.getElementById('post_' + id);
    if (elm != null) {
      elm.parentNode.removeChild(elm);
    }
  };
  $('#history_back').click(function(e) {
    e.preventDefault();
    history.back();
  });
  $('img.lazyload').lazyload();
});
