// ==UserScript==
// @name         YouTube Shorts Blocker
// @namespace    http://tampermonkey.net/
// @version      0.1.2
// @description  Blocks the YouTube shorts from appearing.
// @author       Aiden Charles
// @license      MIT
// @match        https://www.youtube.com/*
// @grant        none
// ==/UserScript==
(function () {
  "use strict";

  const SHORTS_SELECTORS = ["ytd-reel-shelf-renderer", 'a[title="Shorts"]'];

  //these vecs make it ewasier to add new selectors to check
  const TEXT_MATCH_SELECTORS = ["ytd-rich-shelf-renderer"];

  const removeShorts = (root = document) => {
    SHORTS_SELECTORS.forEach((selector) => {
      root.querySelectorAll(selector).forEach((el) => el.remove());
    });

    TEXT_MATCH_SELECTORS.forEach((selector) => {
      root.querySelectorAll(selector).forEach((el) => {
        if (el.innerText.includes("Shorts")) el.remove();
      });
    });
  };

  const observer = new MutationObserver((mutations) => {
    for (const mutation of mutations) {
      mutation.addedNodes.forEach((node) => {
        if (node.nodeType === 1) removeShorts(node);
      });
    }
  });

  observer.observe(document.body, {
    childList: true,
    subtree: true,
  });

  removeShorts();
})();
