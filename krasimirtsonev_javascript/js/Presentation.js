var Presentation = (function(win) {
	
	var _self = this;
	var _pages = PAGES;
	var _currentPage;
	var _currentPageIndex = 0;
	var _currentPageSlidesIndex = -1;
	
	// toolbar
	function toolbarInit() {
		$("#jump-value").keyup(toolbarJumpFieldChange);
		$("#toolbarNextPage").click(toolbarNextPage);
		$("#toolbarPreviousPage").click(toolbarPreviousPage);
		$("#toolbarNextPage-slide").click(toolbarNextSlide);
		$("#toolbarPreviousPage-slide").click(toolbarPreviousSlide);
	}
	function toolbarSetText() {
		var text = (_currentPageIndex + 1)+ " of " + _pages.length + " (" + _currentPage.url + ")";
		if(_currentPage && _currentPage.slides) {
			var numOfSlides = _currentPage.slides.length;
			var bullets = "";
			for(var i=-1; i<numOfSlides; i++) {
				if(i == _currentPageSlidesIndex) {
					bullets += "<a href='javascript:Presentation.slidesShow(" + i + ");' class='bullet-current'>&#149;</a>";
				} else {
					bullets += "<a href='javascript:Presentation.slidesShow(" + i + ");' class='bullet'>&#149;</a>";
				}
			}
			text = bullets + " | " + text;
		}
		$("#current").html(text);
		$("#jump-value").val(_currentPageIndex + 1);		
	};
	function toolbarJumpFieldChange() {
		var newValue = parseInt($("#jump-value").val());
		newValue -= 1;
		if(newValue != undefined) {
			if(newValue >= 0 && newValue < _pages.length) {
				_currentPageIndex = newValue;
				loadPage();
			}
		}
	};
	function toolbarNextPage() {
		if(_currentPageIndex + 1 < _pages.length) {
			_currentPageIndex = _currentPageIndex + 1;
			loadPage();
		}		
	}
	function toolbarPreviousPage() {
		if(_currentPageIndex - 1 >= 0) {
			_currentPageIndex = _currentPageIndex - 1;
			loadPage();
		}
	}
	function toolbarNextSlide() {
		if(_currentPage.slides && _currentPage.slides.length > 0) {
			_currentPageSlidesIndex = _currentPageSlidesIndex + 1 < _currentPage.slides.length ? _currentPageSlidesIndex + 1 : _currentPageSlidesIndex;
			slidesShow();
		}
	};
	function toolbarPreviousSlide() {
		if(_currentPage.slides && _currentPage.slides.length > 0) {
			_currentPageSlidesIndex = _currentPageSlidesIndex - 1 >= -1 ? _currentPageSlidesIndex - 1 : 0;
			slidesShow();			
		}
	};
	function toolbarShowSlidesNav() {
		var numOfSlides = _currentPage.slides ? _currentPage.slides.length : 0;
		if(numOfSlides > 0) {
			$(".slides-title").fadeTo(100, 1);
			$("#toolbarNextPage-slide").fadeTo(100, 1);
			$("#toolbarPreviousPage-slide").fadeTo(100, 1);
		} else {
			$(".slides-title").fadeTo(100, 0.2);
			$("#toolbarNextPage-slide").fadeTo(100, 0.2);
			$("#toolbarPreviousPage-slide").fadeTo(100, 0.2);
		}
	}
	
	// page
	function loadPage() {
		_currentPage = _pages[_currentPageIndex];
		if(_currentPage.url && _currentPage.url != "") {
			$.ajax({
				url: "pages/" + _currentPage.url + "?r=" + Math.floor(Math.random()*10000),
				success: function(result) {
					$("#pagesHolder").empty();
					$("#pagesHolder").append($(result));
					_currentPageSlidesIndex = -1;
					runSyntaxHighlighting();
					slidesHide();
					toolbarShowSlidesNav();
					addressUpdate();
				}
			});
			toolbarSetText();
		}
	};
	function slidesShow(index) {
		if(typeof index != "undefined") {
			_currentPageSlidesIndex = index;
		}
		slidesHide();
		if(_currentPage.slides[_currentPageSlidesIndex]) {
			$(_currentPage.slides[_currentPageSlidesIndex]).css("display", "block");
		}
		toolbarSetText();
	}
	function slidesHide() {
		var numOfSlides = _currentPage.slides ? _currentPage.slides.length : 0;
		for(var i = 0; i<numOfSlides; i++) {
			$(_currentPage.slides[i]).css("display", "none");
		}
	};
	
	// syntaxhighlighting
	function runSyntaxHighlighting() {
		$("pre").snippet("javascript", {style:"darkness", collapse:true});
	};
	
	// keyboard events
	function keyboardEventsInit() {
		$(document).keydown(keyboardEventsDown);
	}
	function keyboardEventsDown(e) {
		if(e.which == 37) { // left
			toolbarPreviousPage();
		}
		if(e.which == 39) { // right
			toolbarNextPage();
		}
		if(e.which == 38) { // up
			toolbarNextSlide();
		}
		if(e.which == 40) { // down
			toolbarPreviousSlide();
		}
	};
	
	// address
	function addressCheck() {
		if($.address.value() != "" && $.address.value() != "/") {
			_currentPageIndex = $.address.value();
			_currentPageIndex = _currentPageIndex.replace("/", "");
			_currentPageIndex = parseInt(_currentPageIndex);
		}
	}
	function addressUpdate() {
		$.address.value(_currentPageIndex);
	}
	
	win.onload = function() {
		toolbarInit();
		keyboardEventsInit();
		addressCheck();
		loadPage();
	};
	
}(window));
