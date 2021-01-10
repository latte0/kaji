$(function() {
  // スクロールしたら表示
  // ---------------------------------------
  var showFlag = false;
  var topBtn = $('#page-top');

  topBtn.css('bottom', '-100px');

  //スクロールを無効にする
  var scrollTop = $(window).scrollTop();
  $(window).load(function() {
    var error_text = document.getElementById('error');
    if (error_text) {
      $('.all_wrap').css({position: 'fixed', top: -scrollTop});
    }
  });

  $('#error_link').click(function() {
    $('.all_wrap').css({position: 'static', top: '0'});
    $('html,body').scrollTop(scrollTop);
    $('#error').hide();
    $('.bg').hide();
  });

  //スクロールが100に達したらボタン表示
  $(window).scroll(function() {
    if ($(this).scrollTop() > 100) {
      if (showFlag == false) {
        showFlag = true;
        topBtn.stop().animate({bottom: '20px'}, 300);
      }
    } else {
      if (showFlag) {
        showFlag = false;
        topBtn.stop().animate({bottom: '-100px'}, 300);
      }
    }
  });

  // ページ内スクロールリンク
  // ---------------------------------------
  $('a[href^=#]').click(function() {
    var speed = 500;
    var href = $(this).attr('href');
    var target = $(href == '#' || href == '' ? 'html' : href);
    var position = target.offset().top;
    // 移動先を調整する場合 var position = target.offset().top - 調整値;
    $('html, body').animate({scrollTop: position}, speed, 'swing');
    return false;
  });

  // ラジオボタンで表示切り替え
  var target = $('#target');

  $('input[type=radio]').on('click', function () {
    var value = $(this).val()
    if (value == 0) {
      target.text("所属している店舗名を記入ください。")
    } else if (value == 1) {
      target.text("施術している店舗名を記入ください。")
    }
  });
});
