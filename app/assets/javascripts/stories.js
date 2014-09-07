$(document).ready(function () {

	// SLICK - image carousel

// 	$('.mainpic').slick({
//   slidesToShow: 10,
//   slidesToScroll: 5
// });


	// $("#music").dotdotdot({
	// 		The HTML to add as ellipsis. 
	// 	ellipsis	: '... ' )};


	function hideStuff() {
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


// set up the dictionary of class to color values
var myDict = {
					  "musically" : "slategray",
					  "techcrunch" : "darkgreen",
					  "thenextweb" : "orangered",
					  "venturebeat" : "red",
					  "learnegg" : "black",
					  "cmu" : "mediumblue"
					  
					};

var allSources = {
					  "musically" : "MUSIC ALLY",
					  "techcrunch" : "TECHCRUNCH",
					  "thenextweb" : "THE NEXT WEB",
					  "venturebeat" : "VENTUREBEAT",
					  "learnegg" : "LEARNEGG",
					  "cmu" : "CMU"
}

var LogoDict = {
					  "musically" : "assets/music_ally.png",
					  "techcrunch" : "assets/tc.png",
					  "venturebeat" : "assets/VB_logo.jpg",
					  "thenextweb" : "assets/TheNextWeb.png",
					  "learnegg" : "assets/learnegg.png",
					  "cmu" : "assets/cmu.jpg"
					  
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
	} else {
				console.log($("header nav span#date").html());
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
		 .attr("width", "100")
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

		$(this).closest('div.content').siblings().children().children().css("visibility", "hidden");
		// $('.slick-track').css("visibility", "visible");
		});


	 	$('.mainpic img').mouseenter(function () {

			var myStory = $(this).attr("id");
			
			var myStoryId = "span#" + parseInt(myStory);
			
			var theStorylink = $('tbody tr').find(myStoryId).find('a');

			theStorylink.toggleClass("hovered"); // highlight the story in the table
			theStorylink.trigger( "mouseenter" ); // trigger action of mouseenter
			$(this).toggleClass("hovered"); // add hovered state to the pic
			

			var theStoryUrl = theStorylink.attr("href"); // get the story URL
			$(this).parent().attr("href", theStoryUrl); // link the pic to the story
			$(this).parent().attr("target", "_blank"); // force open in a new tab

		
		});

			$('.mainpic img').mouseleave(function () {

			var myStory = $(this).attr("id");
			
			var myStoryId = "span#" + parseInt(myStory);
			
			 $('tbody tr')
				 .find(myStoryId)
				 .find('a')
				 .toggleClass("hovered"); // unhighlight the story	

			// $(this).toggleClass("hovered"); // remove hovered state from the pic
			
		
		});


	 $('button#all_by_date').click(function() {
	 	$('tr').css("display", "inline-block");


	 	$('.all_by_date').show();
	 	$(this).addClass('active');
	 	$('.all_by_date').siblings('div').hide();
	 	$(this).siblings('button').removeClass('active');



	 	hideStuff();
	 	return false;

	 	// $('.all_by_date').parent('div').next().children('div').show();
	 });

	  //   $('button#all_by_a_to_z').click(function() {
	 	// $('.all_by_a_to_z').show(500);
	 	// $(this).addClass('active');
	 	// $('.all_by_a_to_z').siblings('div').hide();
	 	// $(this).siblings('button').removeClass('active');
	 	// // $('.all_by_date').parent('div').next().children('div').show();


			// for(var index = 0; index < $('tbody th').length; index++){

			// 	var myArea = $.trim($("th").eq(index).find("span.tag").text());

			// 	var myIcon = IconDict[myArea];

			// 	$('th').eq(index)
	 	// 			.find("img.tag")
			// 		.attr("src", myIcon)
			// 		.css("display", "inline")
			// 		.css("visibility", "visible"); // display logo
				
			// }
		 // });

	    $('button#music').click(function() {
	    	$('tr').css("display", "block");


	 		$('.by_source').show(500);
	 		$('.top_stories').hide();
	 		$('.by_source').siblings('div').hide();
	 		$('.by_source').find('div#source_education').hide();
	 		$('.by_source').find('div#source_music').show();

	 		hideStuff();

	 		$(this).addClass('active');
	 		$(this).siblings('button').removeClass('active');

	 			// $('.all_by_date').parent('div').next().children('div').show();
		 	return false;
	 	
	 });

	    $('button#education').click(function() {
	    	$('tr').css("display", "block");


	 		$('.by_source').show(500);
	 		$('.top_stories').hide();
		 	$('.by_source').siblings('div').hide();
		 	$('.by_source').find('div#source_music').hide();
		 	$('.by_source').find('div#source_education').show();

		 	hideStuff();

		 	$(this).addClass('active');
		 	$(this).siblings('button').removeClass('active');

		 	// $('.all_by_date').parent('div').next().children('div').show();
		 	return false;
		 	
	 });

	    $('button.hot').click(function() {
	    	$('.by_source').hide();
	 		$('.top_stories').show();
	 		$('.all_by_date').hide();
		 
		 	hideStuff();

		 	$('tr').css("display", "none");

		 	$(this).addClass('active');
		 	$(this).siblings('button').removeClass('active');

		 	$('div#keyword_tags').first().trigger('click');

		 	return false;
		 	
	 });

	    // show relevant stories after click on keyword
	     $('div#keyword_tags').click(function() {

	     	$(this).addClass('active');
	     	$(this).siblings('div').removeClass('active');
	 
	 		var keyword = $.trim($(this).text());
	 		var keywordClass = '.' + keyword;
	 		
	 		$(document).find(keywordClass).siblings('tr').css("display", "none");
		 	$(document).find(keywordClass).css("display", "block");


		 				
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