$(window).scroll(function () {
  if ($('#form-analisis').length > 0 ) {
      if (! isScrolledIntoView($('thead')))
      {
        // anchor div isn't visible in view so apply new style to follow div to follow on scroll
        $('#follow').css({ position: 'fixed', top: '40px', margin:0 });
        $('th').css({ width:'120px !important', 'padding-left':'10px !important', 'padding-right':'0 !important'});
      }
      else
      {
        // anchor div is visible in view so apply default style back to follow div to place in default position
        $('#follow').css({ position: 'relative', top: '0px' });
      }
    }
});

function isScrolledIntoView(elem)
{
    var docViewTop = $(window).scrollTop();
    var docViewBottom = docViewTop + $(window).height();

    var elemTop = $(elem).offset().top;
    var elemBottom = elemTop + $(elem).height();

    return ((elemBottom >= docViewTop) && (elemTop <= docViewBottom));
}
