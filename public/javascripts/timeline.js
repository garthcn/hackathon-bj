var PER_WIDTH = 320;
$(document).ready(function(){
	/* This code is executed after the DOM has been completely loaded */

	/* The number of event sections / years with events */
	var tot=$('.event').length;
	
	$('.eventList li').click(function(e){
			showWindow('<div>'+$(this).find('div.content').html()+'</div>');
	});
	
	/* Each event section is 320 px wide */
	var timelineWidth = PER_WIDTH*tot;
    var screenWidth = $(document).width();
	$('#timelineScroll').width(timelineWidth);

    /* initialize the timeline bar view in the bottom */
    updateTimelineBar();
    var highlightWidth = screenWidth / timelineWidth * screenWidth;
    $("#highlight").width(highlightWidth);
    var highlightLeft = $("#timelineBar").data("left");
    highlightLeft = 0;
    $("#highlight").css("left", highlightLeft + "px");
    $("#highlight").show();
    var barWidth = $("#timelineBar").width();

    /* attach the scroll event */
    $("#timelineLimiter").scroll(function() {
      var left = $(this).scrollLeft() / timelineWidth * barWidth + highlightLeft;
      $("#highlight").css("left", left + "px");
    });

    $("#timelineBar").click(function(e) {
      var left = (e.pageX - this.offsetLeft - highlightWidth/2) / barWidth * timelineWidth + highlightLeft;
      $("#timelineLimiter").animate({"scrollLeft": left}, 500);
    });

    $("#highlight").draggable({
      containment: "parent",
      axis: "x",
      drag: function(e, ui) {
        var left = ui.position.left/barWidth * timelineWidth;
        $("#timelineLimiter").scrollLeft(left);
      }
    });
});

function showWindow(data)
{
	/* Each event contains a set of hidden divs that hold
	   additional information about the event: */
	   
	var title = $('.title',data).text();
	var date = $('.date',data).text();
	var body = $('.body',data).html();
	
	$('<div id="overlay">').css({
								
		width:$(document).width(),
		height:$(document).height(),
		opacity:0.6
		
	}).appendTo('body').click(function(){
		
		$(this).remove();
		$('#windowBox').remove();
		
	});
	
	$('body').append('<div id="windowBox"><div id="titleDiv">'+title+'</div>'+body+'<div id="date">'+date+'</div></div>');

	$('#windowBox').css({
		width:500,
		height:350,
		left: ($(window).width() - 500)/2,
		top: ($(window).height() - 350)/2
	});
	
}

function updateTimelineBar() {
  var ratio = 1.0;
  var screenWidth = $(document).width();
  var count = $("#timelineBar .grid").length + 1;
  var perWidth = screenWidth / count;
  var paddingWidth = (screenWidth - perWidth * (count-1))/2;
  $("#timelineBar").css("padding-left", paddingWidth + perWidth/2 + "px");
  $("#timelineBar").data("left", paddingWidth + perWidth/2);
  $("#timelineBar").css("padding-right", paddingWidth + "px");
  $("#timelineBar .grid").each(function(grid){
    var width = $(this).attr("count")/ratio;
    if (width < 1) width = 1;
    if (width > perWidth - 2) width = perWidth - 2;
    $(this).css("border-left-width", width + "px");
    $(this).css("width", (perWidth - width) + "px");
  });
  $("#timelineBar").show();
}
