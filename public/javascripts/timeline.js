var PER_WIDTH = 320;
$(document).ready(function(){
	/* This code is executed after the DOM has been completely loaded */

	/* The number of event sections / years with events */
	var tot=$('.event').length;
	
	/* Each event section is 320 px wide */
	var timelineWidth = PER_WIDTH*tot;
    var screenWidth = $(document).width();
    var screenHeight = window.innerHeight;
	$('#timelineScroll').width(timelineWidth);
    $('#timelineLimiter').height(screenHeight - 130);

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

    //$("div.grid").popover({placement: "top"});
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
  var ratio = 0.3;
  var screenWidth = $(document).width();
  var count = $("#timelineBar .grid").length;
  var perWidth = parseInt(screenWidth / count);
  var less = screenWidth - perWidth * count;
  var idx = 0;
  $("#timelineBar .grid").each(function(grid){
    var width = parseInt($(this).attr("count")/ratio);
    if (width < 1) width = 1;
    if (width > perWidth - 2) width = perWidth - 2;
    $(this).width(width);
    var x = 0;
    if (idx < less) x = 1;
    idx += 1;
    $(this).css("margin-left", Math.floor((perWidth - width + x)/2) + "px");
    $(this).css("margin-right", Math.ceil((perWidth - width + x)/2) + "px");
  });
  $("#timelineBar").show();
}
