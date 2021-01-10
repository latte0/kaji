$(function() {
  // スクロールしたら表示
  // ---------------------------------------
  var showFlag = false;
  var topBtn = $('.navi');

  topBtn.css('bottom', '-100px');

  //スクロールが100に達したらボタン表示
  $(window).scroll(function() {
    if ($(this).scrollTop() > 100) {
      if (showFlag == false) {
        showFlag = true;
        topBtn.stop().animate(
          {
            bottom: '0'
          },
          300
        );
      }
    } else {
      if (showFlag) {
        showFlag = false;
        topBtn.stop().animate(
          {
            bottom: '-100px'
          },
          300
        );
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
    $('html, body').animate(
      {
        scrollTop: position
      },
      speed,
      'swing'
    );
    return false;
  });
});

$(function() {
  if (navigator.userAgent.indexOf('iPhone') > 0) {
    let body = document.getElementsByTagName('body')[0];
    body.classList.add('iPhone');
  }

  var state = false;
  var scrollpos;

  $('.modal_trigger').on('click', function() {
    var num = $(this);
    var index = $('.navi .modal_trigger').index(num);
    $('.modal_panel_list .modal_panel')
      .eq(index)
      .fadeIn();
    if (state == false) {
      scrollpos = $(window).scrollTop();
      $('html')
        .addClass('window-lock')
        .css({
          top: -scrollpos
        });
      state = true;
    } else {
      $('html')
        .removeClass('window-lock')
        .css({
          top: 0
        });
      window.scrollTo(0, scrollpos);
      state = false;
    }
  });

  $('.modal_cbg').on('click', function() {
    $('.modal_panel').fadeOut();
    $('html')
      .removeClass('window-lock')
      .css({
        top: 0
      });
    window.scrollTo(0, scrollpos);
    state = false;
  });
});
