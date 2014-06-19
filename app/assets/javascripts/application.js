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

	window.fbAsyncInit = function() {
        FB.init({
          appId      : '1428069504133910',
          xfbml      : true,
          version    : 'v2.0'
        });

        $('.fb').click( function() {
			console.log(this.id.substring(2));	
        	var id = this.id.substring(2);
			$.get('contracts/show', {id: id}, function(response) {
				FB.ui({method: 'apprequests',
			        message: response
			    });	
			})

			
	});


      };

      (function(d, s, id){
         var js, fjs = d.getElementsByTagName(s)[0];
         if (d.getElementById(id)) {return;}
         js = d.createElement(s); js.id = id;
         js.src = "//connect.facebook.net/en_US/sdk.js";
         fjs.parentNode.insertBefore(js, fjs);
       }(document, 'script', 'facebook-jssdk'));





	handleClick();
	formHandler(); 
});


function formHandler() {
	$('.contract_form').on('submit', function() {
		if (!$('.invis').val()) {
			return false;
		}
		console.log('FORM SUBMITTED');
		value = $('.invis').val();
		console.log(value);
		step += 1;
		if (step == 6) {
			$(".main").fadeOut('fast', function() {
				$(".main").html("<div class='loading'>Please wait as the Swomee-Swans work diligently to finalize your request!</div>");
				$(".main").fadeIn('fast'); 
			});
		}

		$.get("/contracts/new", { step: step, id: value }, function(response) {
			 	// console.log(response);
			 	console.log(this.url);
			 	console.log('step: ' + step)
			 	$(".main").fadeOut('fast', function(){
			 		$(".main").html(response);
			 		handleClick();
			 		formHandler();
			 		$(".main").fadeIn('fast', function(){
			 			if (step > 2) {
			 				$('.invis').focus();
			 			}
			 		});

			 	});
		});
		return false;
	});
}	

	

function handleClick() {  
	$('.block').click(function() {
			
			console.log('clicked');
			console.log(this.id);
			step += 1;
			$.get("/contracts/new", { step: step, id: this.id }, function(response) {
			 	// console.log(response);
			 	console.log(this.url);
			 	console.log('step: ' + step)
			 	$(".main").fadeOut('fast', function(){
			 		$(".main").html(response);
			 		handleClick();
			 		formHandler();
			 		$(".main").fadeIn('fast', function(){
			 			if (step > 2) {
			 				$('.invis').focus();
			 			}
			 		});
			 	});
			});
			// $('input').val(this.id);
			// $('form').submit();
			// // $('.blockcont').fadeOut();
			// $('.blockcont').html();
			// $('.blockcont').fadeIn();

			// $('.blockcont').html("You clicked on a checkbox.").fadeIn('slow');
	});
}

// $.post(url, {name: something, status: something}, function(response) {
// 	response.data //html
// 	#(somediv).fadeOut('fast', function() {
// 		#(somediv).html(response.data)
// 		somediv.fadeIn()
// 	})
// })

