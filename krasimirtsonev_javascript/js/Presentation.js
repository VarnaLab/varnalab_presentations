var Presentation = (function(win) {
	
	var _self = this;
	var _pages = PAGES;
	var _currentPage;
	var _currentPageIndex = 0;
	var _currentPageSlidesIndex = -1;
	
	function setCurrentText(str) {
		if(!str) {
			var text = (_currentPageIndex + 1)+ " of " + _pages.length + " (" + _currentPage.url + ")";
			if(_currentPage && _currentPage.slides) {
				var numOfSlides = _currentPage.slides.length;
				var bullets = "";
				for(var i=-1; i<numOfSlides; i++) {
					if(i == _currentPageSlidesIndex) {
						bullets += "<a href='javascript:Presentation.showSlide(" + i + ");' class='bullet-current'>&#149;</a>";
					} else {
						bullets += "<a href='javascript:Presentation.showSlide(" + i + ");' class='bullet'>&#149;</a>";
					}
				}
				text = bullets + " | " + text;
			}
			$("#current").html(text);
			$("#jump-value").val(_currentPageIndex + 1);
		} else {
			$("#current").text(str);
		}
	};
	function loadPage() {
		_currentPage = _pages[_currentPageIndex];
		if(_currentPage.url && _currentPage.url != "") {
			$.ajax({
				url: "pages/" + _currentPage.url + "?r=" + Math.floor(Math.random()*10000),
				success: function(result){
					_currentPageSlidesIndex = -1;
					addPageContent(result);
					runSyntaxHighlighting();
					hideAllSlides();
					showHideSlidesNav();
					$.address.value(_currentPageIndex);
				}
			});
			setCurrentText();
		}
	};
	function addPageContent(str) {
		$("#pagesHolder").empty();
		$("#pagesHolder").append($(str));
	};
	function onJumpFieldChange() {
		var newValue = parseInt($("#jump-value").val());
		newValue -= 1;
		if(newValue != undefined) {
			if(newValue >= 0 && newValue < _pages.length) {
				_currentPageIndex = newValue;
				loadPage();
			}
		}
	};
	function next() {
		if(_currentPageIndex + 1 < _pages.length) {
			_currentPageIndex = _currentPageIndex + 1;
			loadPage();
		}		
	}
	function previous() {
		if(_currentPageIndex - 1 >= 0) {
			_currentPageIndex = _currentPageIndex - 1;
			loadPage();
		}
	}
	function nextSlide() {
		if(_currentPage.slides && _currentPage.slides.length > 0) {
			_currentPageSlidesIndex = _currentPageSlidesIndex + 1 < _currentPage.slides.length ? _currentPageSlidesIndex + 1 : _currentPageSlidesIndex;
			showSlide();
		}
	};
	function previousSlide() {
		if(_currentPage.slides && _currentPage.slides.length > 0) {
			_currentPageSlidesIndex = _currentPageSlidesIndex - 1 >= -1 ? _currentPageSlidesIndex - 1 : 0;
			showSlide();			
		}
	};
	function showSlide(index) {
		if(typeof index != "undefined") {
			_currentPageSlidesIndex = index;
		}
		hideAllSlides();
		if(_currentPage.slides[_currentPageSlidesIndex]) {
			$(_currentPage.slides[_currentPageSlidesIndex]).css("display", "block");
		}
		setCurrentText();
	}
	function hideAllSlides() {
		var numOfSlides = _currentPage.slides ? _currentPage.slides.length : 0;
		for(var i = 0; i<numOfSlides; i++) {
			$(_currentPage.slides[i]).css("display", "none");
		}
	};
	function showHideSlidesNav() {
		var numOfSlides = _currentPage.slides ? _currentPage.slides.length : 0;
		if(numOfSlides > 0) {
			$(".slides-title").fadeTo(100, 1);
			$("#next-slide").fadeTo(100, 1);
			$("#previous-slide").fadeTo(100, 1);
		} else {
			$(".slides-title").fadeTo(100, 0.2);
			$("#next-slide").fadeTo(100, 0.2);
			$("#previous-slide").fadeTo(100, 0.2);
		}
	}
	function runSyntaxHighlighting() {
		// http://www.steamdev.com/snippet/
		//$("pre").snippet("javascript", {style:"peachpuff", collapse:true});
		$("pre").snippet("javascript", {style:"darkness", collapse:true});
	};
	function onKeyDown(e) {
		if(e.which == 37) { // left
			previous();
		}
		if(e.which == 39) { // right
			next();
		}
		if(e.which == 38) { // up
			nextSlide();
		}
		if(e.which == 40) { // down
			previousSlide();
		}
	};
	function pages() {
		return _pages;
	};
	
	win.onload = function() {
		if($.address.value() != "" && $.address.value() != "/") {
			_currentPageIndex = $.address.value();
			_currentPageIndex = _currentPageIndex.replace("/", "");
			_currentPageIndex = parseInt(_currentPageIndex);
		}
		loadPage();
		$("#jump-value").keyup(onJumpFieldChange);
		$("#next").click(next);
		$("#previous").click(previous);
		$("#next-slide").click(nextSlide);
		$("#previous-slide").click(previousSlide);
		$("#reload").click(loadPage);
		$(document).keydown(onKeyDown);
	};
	
	return {
		pages: pages(),
		showSlide: showSlide
	};
	
}(window));
