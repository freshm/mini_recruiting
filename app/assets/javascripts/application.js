// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require jquery.ui.tabs
//= require_tree .

$( document ).ready ( function() {
	$(".eye").tooltip();
	$(".edit").tooltip();
	$(".delete").tooltip();
	$(".applicant").tooltip();
	$(".moderator").tooltip();
	$(".footer").tooltip();
	$("#tabs").tabs();
	//$(".accordion").accordion({ collapsible: true, header: "h3" });


	$("#vacancy_new_close").on("click", function() {
		$("#new_link_top").show();
		$("#new_link_bottom").show();
		$("new_vacancy").remove();
	});
});

$(document).on("click", ".close-container", function() {
	$("#new_user_container").remove();
	$("#new_user_top").show();
	$("#new_user_bottom").show();
});

$(document).on("click", ".close-container", function() {
	$("#new_link_top").show();
	$("#new_link_bottom").show();
	$("#new_vacancy_container").remove();
});


function scrollToElement(selector, time, verticalOffset) {
    time = typeof(time) != 'undefined' ? time : 1000;
    verticalOffset = typeof(verticalOffset) != 'undefined' ? verticalOffset : 0;
    element = $(selector);
    offset = element.offset();
    offsetTop = offset.top + verticalOffset;
    $('html, body').animate({
        scrollTop: offsetTop
    }, time);
}
