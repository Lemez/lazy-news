$(document).ready(function () {

		loadtheduck();
		var top = $('.content').css('margin-top');

	// $("#music").dotdotdot({
	// 		The HTML to add as ellipsis. 
	// 	ellipsis	: '... ' )};


	function hideSidebar() {
		 $(document)
		 .find("div#mydate")
		 .css("visibility", "hidden"); // hide date

		 $(document)
		 .find("div#mysource")
		 .css("visibility", "hidden"); // hide date

		 $(document)
		 .find("img#logo")
		 .css("visibility", "hidden"); // hide logo
	}

	function toggleMyandOthersActiveState(e, type){
		$(e).addClass('active');
		$(e).siblings(type).removeClass('active');
	}

	function toggleDivStates(e){
		$(e).addClass('active');
		$(e).siblings('div').removeClass('active');
	}
	function showMeandHideOthers(me) {
		$('tr').css("display", "block");
	 	$(me).siblings('div').hide();
	 	$(me).show();
	}


// set up the dictionary of class to color values
var myDict = {
					  "musically" : "slategray",
					  "techcrunch" : "darkgreen",
					  "thenextweb" : "orangered",
					  "venturebeat" : "red",
					  "learnegg" : "black",
					  "cmu" : "mediumblue",
					  "edsurge" : "maroon"
					  
					};

var allSources = {
					  "musically" : "MUSIC ALLY",
					  "techcrunch" : "TECHCRUNCH",
					  "thenextweb" : "THE NEXT WEB",
					  "venturebeat" : "VENTUREBEAT",
					  "learnegg" : "LEARNEGG",
					  "cmu" : "CMU",
					  "edsurge" : "EDSURGE"
}

var LogoDict = {
					  "musically" : "assets/music_ally.png",
					  "techcrunch" : "assets/tc.png",
					  "venturebeat" : "assets/VB_logo.jpg",
					  "thenextweb" : "assets/TheNextWeb.png",
					  "learnegg" : "assets/learnegg.png",
					  "cmu" : "assets/cmu.jpg",
					  "edsurge" : "assets/edsurge.jpg"
					  
					};

var TypeDict = {
	"press" : ["guardian", "mailandguardian"],
	"radio"	: ["npr"],
	"blogs"	: ["afropop", "afrobeat", "mondomix", "womex"]
}

var IconDict = {
					  "EDUCATION" : "assets/book.png",
					  "MUSIC" : "assets/cd.png"
					};

	if ($('.all_by_date').css("display", "inline")) {

		$('button#all_by_date').siblings('button').removeClass('active');
		$('button#all_by_date').addClass('active');

		for(var index = 0; index < $('tbody th').length; index++){

			// trim whitespace from "source" text value
    		var myClass = $.trim($('td').eq(index).text());
			var myColor = myDict[myClass];
			
			// add source as a class 
			$('th').eq(index)
					.addClass(myClass)
 					.css("border-bottom", "2px dotted " + myColor);

   		 	$('td').eq(index)
 						.addClass(myClass);
		 
 			$('.all_by_date').siblings('div').hide();
			} 
	}


	$('tbody tr').mouseenter(function () {

		// get date value
		var myDate = $.trim($(this).find("th").find('span.intext').text());
		if (myDate == '') {
			myDate = "N/A";
		} 

		// $('.slick-track').css("visibility", "visible");
		
 		
		// get image value
		var myPic = $(this).find("img").attr("src");
		var myPicId = $(this).find("span#id").text();
		var myPicUrl = $(this).find("a").attr("href");
		var mySource = allSources[$.trim($(this).find("td").text())];
		var myClass = $.trim($(this).children('th').attr("class"));
		var myColor = myDict[myClass];
		var myLogo = LogoDict[myClass];

	
		 $(document)
		 .find("div#mydate")
		 .html("<h2>" + myDate + "</h2>")
		 .css("visibility", "visible"); // display date

		 $(document)
		 .find("div#mysource")
		 .html("<h2>" + mySource + "</h2>")
		 .css("visibility", "visible"); // display date

		 $(document)
		 .find("img#logo")
		 .attr("src", myLogo)
		 .css("width", "120")
		 .css("height", "60")
		 .show()
		 .css("visibility", "visible"); // display logo

		 // $(document)
		 // .find("img#mainpic")
		 // .attr("src", myPic)
		 // .css("visibility", "visible"); // display pic



	});


	 $('tbody tr').mouseleave(function () {

		$('header')
				.find("#date")
				.html(" ") 
				.removeClass("on");
		$('header')
				.find("img")
				.removeClass("on");

		$(this).find("td").css("visibility", "hidden");

		// $(this).closest('div.content').siblings().children().children().css("visibility", "hidden");
		// $('.slick-track').css("visibility", "visible");
		});


	 	$('.mainpic img').mouseenter(function () {

			var myStory = $(this).attr("id");
			var myStoryId = "span#story" + parseInt(myStory);
			var theStorylink = $('tbody tr').find(myStoryId).find('a');

			theStorylink.toggleClass("hovered"); // highlight the story in the table
			theStorylink.trigger( "mouseenter" ); // trigger action of mouseenter
			$(this).toggleClass("hovered"); // add hovered state to the pic

			var theStoryUrl = theStorylink.attr("href"); // get the story URL
			$(this).parent().attr("href", theStoryUrl); // link the pic to the story
			$(this).parent().attr("target", "_blank"); // force open in a new tab

			var storyPosition = $(myStoryId).position().top;
			console.log(storyPosition);
			// $('.content').animate({
			// 	scrollTop : storyPosition
			// }, 500);
		
		});

		$(document).scroll(function () {
			console.log($('tr').scrollTop());
		})

			$('.mainpic img').mouseleave(function () {

			var myStory = $(this).attr("id");
			var myStoryId = "span#story" + parseInt(myStory);
			
			 $('tbody tr')
				 .find(myStoryId)
				 .find('a')
				 .toggleClass("hovered"); // unhighlight the story	

			$(this).toggleClass("hovered"); // remove hovered state from the pic
		
		});


		$('button#all_by_date').click(function() {
		 	
		 	toggleMyandOthersActiveState(this, 'button');
		 	hideSidebar();

		 	showMeandHideOthers('.all_by_date');
		 	
		 	return false;
		 });


	    $('button#music, button#education').click(function(e) {
	    	
	    	toggleMyandOthersActiveState(this, 'button');
	 		hideSidebar();

	 		var myDiv = '.source_'+ $(this).attr('id');

	 		showMeandHideOthers('.by_source');
	 		showMeandHideOthers(myDiv);
	    	
		 	return false;
	 });


	    $('button.hot').click(function() {

	    	toggleMyandOthersActiveState(this, 'button');
	    	hideSidebar();

	    	showMeandHideOthers('.top_stories');
		 
		 	$('tr').css("display", "none");
		 	$('div#keyword_tags').first().trigger('click');

		 	return false;
	 });

	    // show relevant stories after click on keyword
	     $('div#keyword_tags').click(function() {

	     	toggleMyandOthersActiveState(this, 'div');
	 
	 		var keyword = $.trim($(this).text());
	 		var keywordClass = '.' + keyword;
	 		
	 		$(document).find(keywordClass).siblings('tr').css("display", "none");
		 	$(document).find(keywordClass).css("display", "block");

		 	// set the page divs up to scroll properly
 			prepareHeights('#keyword_div','#keywordstoriesdiv');
		
	 });

	     $('button').click(function(){
	    
	    	loadtheduck();
	     });

	     function loadtheduck(){
	     	 $("div.story_info img#logo")
				 .hide(); // display logo
	     }

	     function prepareHeights(top,bottom ){
	     		var divHeight = $(top).css('height');
			 	$(bottom).css('margin-top',divHeight);
	     }

	     function resizeHeights(top,bottom ){
	     		var divHeightTop = parseInt($(top).height());
			 	var divHeightBottom = parseInt($(bottom).css('height'));
			 	var calc = $(window).height() - divHeightTop;
			 	console.log(calc);
			 	if (calc < 300) {
			 		// $(top).css('height', $(window).height()/2);
			 	}
	     }

	     $(window).load(function(){prepareHeights('#imagewalldiv','#allstoriesdiv');});
	     $(window).resize(function() {
	     	prepareHeights('#imagewalldiv','#allstoriesdiv');
	     	// resizeHeights('#imagewalldiv','#allstoriesdiv');
	     });

//wip
// $('button#keywords').click(function() {
// 	 	$('.keywords').toggle(500);
// 	 	 });






	//   $('button.types').click(function() {
	//  	$('button_options').toggle();
 //    	$(this).toggleClass('active');
    
	// 	var type = $(this).attr("id");
	// 	var name = TypeDict[type];

	// 	for (var i=0;i<name.length;i++) { 
	// 		var item = name[i];
	// 		$(document).find('th.' + item).fadeToggle(500);
	// 		}
		
	// 	return false;

	//  });


	// $('button.sources').click(function() {
 //    	$('button_options').toggle();
 //    	$(this).toggleClass('active');
    
	// 	var name = $(this).attr("id");
	// 	var n = name.split(" ")[0];
		
	// 	$(document).find('th.' + name).fadeToggle(500);

	// 	return false;

	// });

});