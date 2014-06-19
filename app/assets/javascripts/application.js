// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .

var step = 0 

$(function() {

	$('.block').click(function() {
		$.get("/contracts/new", { step: step }, function(response) {
		 	$(".blockcontent").html(response);
		 	step += 1;
		});


		$('input').val(this.id);
		$('form').submit();
		// $('.blockcont').fadeOut();
		// $('.blockcont').html();
		// $('.blockcont').fadeIn();

		// $('.blockcont').html("You clicked on a checkbox.").fadeIn('slow');
	});

	$('form').on('submit', function() {
		console.log('FORM SUBMITTED');
	});
});

// $.post(url, {name: something, status: something}, function(response) {
// 	response.data //html
// 	#(somediv).fadeOut('fast', function() {
// 		#(somediv).html(response.data)
// 		somediv.fadeIn()
// 	})
// })

