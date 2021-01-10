$(function() {
  $('#p2').addClass('hidden_favorite');
});

function clickBtn2() {
  const p2 = document.getElementById('p2');

  if (p2.style.visibility == 'visible') {
    // hiddenで非表示
    p1.style.visibility = 'visible';
    p2.style.visibility = 'hidden';
  } else {
    // visibleで表示
    p1.style.visibility = 'hidden';
    p2.style.visibility = 'visible';
  }
}
