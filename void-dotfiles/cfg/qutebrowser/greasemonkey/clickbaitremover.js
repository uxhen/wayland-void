// ==UserScript==
// @name         Clickbait Remover
// @namespace    http://tampermonkey.net/
// @version      1.0
// @description  Remove clickbait by converting YouTube titles to lowercase
// @author       Omid Mashregh-Zamini
// @website      https://omidmash.de
// @match        https://www.youtube.com/*
// @grant        none
// ==/UserScript==

(function () {
  "use strict";

  function removeClickbait() {
    // Home page video titles
    const homeTitles = document.querySelectorAll(
      "#video-title, #video-title-link, .ytd-video-meta-block #video-title",
    );

    // Video page title
    const videoPageTitle = document.querySelector(
      "h1.ytd-video-primary-info-renderer, h1.ytd-watch-metadata",
    );

    // Sidebar/recommended video titles
    const sidebarTitles = document.querySelectorAll(
      "#video-title.ytd-compact-video-renderer, .ytd-compact-video-renderer #video-title",
    );

    // Search results titles
    const searchTitles = document.querySelectorAll(
      "#video-title.ytd-video-renderer",
    );

    // Playlist titles
    const playlistTitles = document.querySelectorAll(
      "#video-title.ytd-playlist-video-renderer",
    );

    // Combine all selectors
    const allTitles = [
      ...homeTitles,
      ...sidebarTitles,
      ...searchTitles,
      ...playlistTitles,
    ];

    if (videoPageTitle) {
      allTitles.push(videoPageTitle);
    }

    allTitles.forEach((title) => {
      if (title && title.textContent) {
        // Preserve original styling by only changing the text content
        // Store original styles to maintain formatting
        const walker = document.createTreeWalker(
          title,
          NodeFilter.SHOW_TEXT,
          null,
          false,
        );

        const textNodes = [];
        let node;
        while ((node = walker.nextNode())) {
          textNodes.push(node);
        }

        // Convert text in text nodes to lowercase while preserving DOM structure
        textNodes.forEach((textNode) => {
          textNode.textContent = textNode.textContent.toLowerCase();
        });
      }
    });
  }

  // Run on page load
  removeClickbait();

  // Run when new content loads (for infinite scroll)
  const observer = new MutationObserver(removeClickbait);
  observer.observe(document.body, {
    childList: true,
    subtree: true,
  });

  // Run periodically to catch any missed elements
  setInterval(removeClickbait, 1000);
})();
