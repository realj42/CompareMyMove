

$('a').click(function () {$(this).next().toggle('fast')});
$('form').submit(function (event)  {
    $('input[type="submit"]').prop('disabled', true);
    });