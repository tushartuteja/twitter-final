// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.noty.packaged.min
//= require turbolinks
//= require_tree .


function onBodyLoad() {

    var toTop = document.getElementById('toTop');
    var id = null;
    var delta;
    var height;

    function scrollToTop() {
        var y = window.scrollY;
        if (y > height / 2) {
            delta = delta + 10;
        } else {
            delta = delta - 10;
            delta = delta < 0 ? 10 : delta;
        }
        y = y - delta;
        y = y > 0 ? y : 0;
        window.scrollTo(0, y);
        if (y === 0) {
            clearInterval(id);
        }
    }

    toTop.addEventListener('click', function(event) {
        delta = 5;
        height = window.scrollY;
        event.preventDefault();
        id = setInterval(scrollToTop, 10);
    });


    var content = document.getElementById("content");
    content.addEventListener('keyup', function() {
        var length = content.value.length;
        var letters = document.getElementById("letters");
        letters.innerHTML = length;

        if (length > 140) {
            letters.style.color = "red";
        } else {
            letters.style.color = "black";
        }
    });


    var createTweet = document.getElementById("create_tweet");
    create_tweet.addEventListener('submit', function(event) {
        event.preventDefault();
        console.log("tried submitting");
        var url = "/create_tweet_json";
        var content = document.getElementById("content");
        data = {
        	content: content.value,
        	random: 12345,
        }


        $.ajax({
            url: url,
            method: "POST",
            data: data,
            success: function(result) {
            	console.log(result);
            	var list = document.getElementById("tweets");
            	next_elem = list.firstElementChild;
            	var new_elem = document.createElement('div');
            	new_elem.innerHTML = result.content;
            	list.insertBefore(new_elem, next_elem);                
            },
            error: function(error){
            	console.log(error);
            	noty({text: "Error", theme: "relax", type: 'error', layout: 'topRight'});

            }
        });

    });

}

window.addEventListener("load", function(event) {
    onBodyLoad();
});
