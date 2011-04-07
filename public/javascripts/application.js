// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

jQuery.ajaxSetup({
    'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
});

$(document).ready(function() {
    $("#new_review").submit(function() {
        $.post($(this).attr("action"), $(this).serialize(), null, "script");
        return false;
    });
});

$(function() {
    var faye = new Faye.Client('http://localhost:9292/faye');
    faye.subscribe("/messages/new", function(data) {
        eval(data);
    });
});
