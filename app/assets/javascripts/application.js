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
//= require jquery.turbolinks
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require_tree .
//= require cocoon

$(document).ready(function() {
  $('#bracketLink').click(function(e) { 
    e.stopPropagation();
    e.preventDefault();
    $('#waitModal').foundation('reveal', 'open');
    $.get( "/refresh_bracket", function( data ) {
      window.location = '/bracket'
      // if (data.redirect) {
      //     // data.redirect contains the string URL to redirect to
      //     window.location.href = data.redirect;
      // }
      // else {
      //     // data.form contains the HTML for the replacement form
      //     $("#bracketPage").replaceWith(data.form);
      // }

      // $( ".result" ).html( data );
      // $( "#bracketPage" ).load( '/bracket?year=2013');
    });
  });
});

$(document).ready(function() {
  $('#refreshResultsLink').click(function(e) { 
    e.stopPropagation();
    e.preventDefault();
    $('#waitModal').foundation('reveal', 'open');
    $.get( "/refresh_results", function( data ) {
      $( "#resultsPage" ).load( window.location.href + ' #resultsPage');
    });
  });
});

$(document).ajaxStop(function() {
  $('#waitModal').foundation('reveal', 'close');
});

/*! Copyright (c) 2011 by Jonas Mosbech - https://github.com/jmosbech/StickyTableHeaders
    MIT license info: https://github.com/jmosbech/StickyTableHeaders/blob/master/license.txt */
$(function(){
  $(document).foundation();
    $("table").stickyTableHeaders();
});

;(function ($, window, undefined) {
  'use strict';

  var name = 'stickyTableHeaders';
  var defaults = {
      fixedOffset: 0
    };

  function Plugin (el, options) {
    // To avoid scope issues, use 'base' instead of 'this'
    // to reference this class from internal events and functions.
    var base = this;

    // Access to jQuery and DOM versions of element
    base.$el = $(el);
    base.el = el;

    // Listen for destroyed, call teardown
    base.$el.bind('destroyed',
      $.proxy(base.teardown, base));

    // Cache DOM refs for performance reasons
    base.$window = $(window);
    base.$clonedHeader = null;
    base.$originalHeader = null;

    // Keep track of state
    base.isSticky = false;
    base.leftOffset = null;
    base.topOffset = null;

    base.init = function () {
      base.options = $.extend({}, defaults, options);

      base.$el.each(function () {
        var $this = $(this);

        // remove padding on <table> to fix issue #7
        $this.css('padding', 0);

        base.$originalHeader = $('thead:first', this);
        base.$clonedHeader = base.$originalHeader.clone();

        base.$clonedHeader.addClass('tableFloatingHeader');
        base.$clonedHeader.css('display', 'none');

        base.$originalHeader.addClass('tableFloatingHeaderOriginal');

        base.$originalHeader.after(base.$clonedHeader);

        base.$printStyle = $('<style type="text/css" media="print">' +
          '.tableFloatingHeader{display:none !important;}' +
          '.tableFloatingHeaderOriginal{position:static !important;}' +
          '</style>');
        $('head').append(base.$printStyle);
      });

      base.updateWidth();
      base.toggleHeaders();

      base.bind();
    };

    base.destroy = function (){
      base.$el.unbind('destroyed', base.teardown);
      base.teardown();
    };

    base.teardown = function(){
      if (base.isSticky) {
        base.$originalHeader.css('position', 'static');
      }
      $.removeData(base.el, 'plugin_' + name);
      base.unbind();

      base.$clonedHeader.remove();
      base.$originalHeader.removeClass('tableFloatingHeaderOriginal');
      base.$originalHeader.css('visibility', 'visible');
      base.$printStyle.remove();

      base.el = null;
      base.$el = null;
    };

    base.bind = function(){
      base.$window.on('scroll.' + name, base.toggleHeaders);
      base.$window.on('resize.' + name, base.toggleHeaders);
      base.$window.on('resize.' + name, base.updateWidth);
    };

    base.unbind = function(){
      // unbind window events by specifying handle so we don't remove too much
      base.$window.off('.' + name, base.toggleHeaders);
      base.$window.off('.' + name, base.updateWidth);
      base.$el.off('.' + name);
      base.$el.find('*').off('.' + name);
    };

    base.toggleHeaders = function () {
      base.$el.each(function () {
        var $this = $(this);

        var newTopOffset = isNaN(base.options.fixedOffset) ?
          base.options.fixedOffset.height() : base.options.fixedOffset;

        var offset = $this.offset();
        var scrollTop = base.$window.scrollTop() + newTopOffset;
        var scrollLeft = base.$window.scrollLeft();

        if ((scrollTop > offset.top) && (scrollTop < offset.top + $this.height() - base.$clonedHeader.height())) {
          var newLeft = offset.left - scrollLeft;
          if (base.isSticky && (newLeft === base.leftOffset) && (newTopOffset === base.topOffset)) {
            return;
          }

          base.$originalHeader.css({
            'position': 'fixed',
            'top': newTopOffset,
            'margin-top': 0,
            'left': newLeft,
            'z-index': 1 // #18: opacity bug
          });
          base.$clonedHeader.css('display', '');
          base.isSticky = true;
          base.leftOffset = newLeft;
          base.topOffset = newTopOffset;

          // make sure the width is correct: the user might have resized the browser while in static mode
          base.updateWidth();
        }
        else if (base.isSticky) {
          base.$originalHeader.css('position', 'static');
          base.$clonedHeader.css('display', 'none');
          base.isSticky = false;
        }
      });
    };

    base.updateWidth = function () {
      if (!base.isSticky) {
        return;
      }
      // Copy cell widths from clone
      var $origHeaders = $('th,td', base.$originalHeader);
      $('th,td', base.$clonedHeader).each(function (index) {

        var width, $this = $(this);

        if ($this.css('box-sizing') === 'border-box') {
          width = $this.outerWidth(); // #39: border-box bug
        } else {
          width = $this.width();
        }

        $origHeaders.eq(index).css({
          'min-width': width,
          'max-width': width
        });
      });

      // Copy row width from whole table
      base.$originalHeader.css('width', base.$clonedHeader.width());
    };

    base.updateOptions = function(options) {
      base.options = $.extend({}, defaults, options);
      base.updateWidth();
      base.toggleHeaders();
    };

    // Run initializer
    base.init();
  }

  // A plugin wrapper around the constructor,
  // preventing against multiple instantiations
  $.fn[name] = function ( options ) {
    return this.each(function () {
      var instance = $.data(this, 'plugin_' + name);
      if (instance) {
        if (typeof options === "string") {
          instance[options].apply(instance);
        } else {
          instance.updateOptions(options);
        }
      } else if(options !== 'destroy') {
        $.data(this, 'plugin_' + name, new Plugin( this, options ));
      }
    });
  };

})(jQuery, window);
