// ==UserScript==
// @name         Reddit Cookie Banner Remover
// @version      1.0.0
// @description  Removes Reddit cookie banner and notification containers
// @author       Omid Mashregh-Zamini
// @match        *://*.reddit.com/*
// @grant        none
// ==/UserScript==
(function () {
  "use strict";

  var x = document.getElementsByClassName("infobar-toaster-container");
  for (var y of x) {
    y.remove();
  }
})();
