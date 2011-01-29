$(function () {  
    $('.pagination a').live("click", function () {
        $('#directory').slideUp(1000, null);
        $.get(this.href, null, null, 'script');
        $('#directory').slideDown(1000, null);
        return false;  
    });  
});

$(function () {
    $('#directory').slideDown(1000, null);
});