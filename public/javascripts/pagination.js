$(function () {  
    $('.pagination a').live("click", function () {
        $('#directory').fadeOut(500, null);
        $('#directory').slideUp(1000, null);
        $.get(this.href, null, null, 'script');
        $('#directory').fadeIn(500, null);
        $('#directory').slideDown(1000, null);
        return false;
    });  
});

$(function () {
    $('#directory').slideDown(500, null);
});