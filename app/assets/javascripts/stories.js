$(document).ready(function () {

	// $("#music").dotdotdot({
	// 		The HTML to add as ellipsis. 
	// 	ellipsis	: '... ' )};

// set up the dictionary of class to color values
var myDict = {
					  "musically" : "slategray",
					  "techcrunch" : "darkgreen",
					  "thenextweb" : "orangered",
					  "venturebeat" : "red",
					  "learnegg" : "black"
					  
					};

var LogoDict = {
					  "musically" : "assets/music_ally.png",
					  "techcrunch" : "assets/tc.png",
					  "venturebeat" : "assets/VB_logo.jpg",
					  "thenextweb" : "assets/TheNextWeb.png",
					  "learnegg" : "assets/learnegg.png"
					  
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

		// $('button#all_by_date').siblings('button').removeClass('active');

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

		
 		
		// get image value
		var myPic = $(this).find("img").attr("src");
		var myPicId = $(this).find("span#id").text();
		var myPicUrl = $(this).find("a").attr("href");
		var mySource = $.trim($(this).find("td").text());
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
	
		});



	 $('button#all_by_date').click(function() {
	 	$('.all_by_date').fadeToggle(500);
	 	$(this).toggleClass('active');
	 	$('.all_by_date').siblings('div').toggle();
	 	$(this).siblings('button').toggleClass('active');
	 	// $('.all_by_date').parent('div').next().children('div').show();
	 });

	    $('button#all_by_a_to_z').click(function() {
	 	$('.all_by_a_to_z').fadeToggle(500);
	 	$(this).toggleClass('active');
	 	$('.all_by_a_to_z').siblings('div').hide();
	 	$(this).siblings('button').removeClass('active');
	 	// $('.all_by_date').parent('div').next().children('div').show();


			for(var index = 0; index < $('tbody th').length; index++){

				var myArea = $.trim($("th").eq(index).find("span.tag").text());
				console.log(myArea);

				var myIcon = IconDict[myArea];
				console.log(myIcon);

				$('th').eq(index)
	 				.find("img.tag")
					.attr("src", myIcon)
					.css("display", "inline")
					.css("visibility", "visible"); // display logo
				
			}
		 });







	  $('button.types').click(function() {
	 	$('button_options').toggle();
    	$(this).toggleClass('active');
    
		var type = $(this).attr("id");
		var name = TypeDict[type];

		for (var i=0;i<name.length;i++) { 
			var item = name[i];
			$(document).find('th.' + item).fadeToggle(500);
			}
		
		return false;

	 });


	$('button.sources').click(function() {
    	$('button_options').toggle();
    	$(this).toggleClass('active');
    
		var name = $(this).attr("id");
		var n = name.split(" ")[0];
		
		$(document).find('th.' + name).fadeToggle(500);

		return false;

	});

});