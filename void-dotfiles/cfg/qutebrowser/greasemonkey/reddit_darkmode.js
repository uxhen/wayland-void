// ==UserScript==
// @name         Old Reddit Dark Mode
// @namespace    http://tampermonkey.net/
// @version      1.1
// @description  Dark mode for old Reddit
// @author       omid mashregh-zamini
// @match        https://old.reddit.com/*
// @exclude      https://new.reddit.com/*
// @grant        none
// ==/UserScript==

(function () {
  "use strict";

  const css = `
       body, .side, .content, .listing-page, .subreddit, .link, .thing, .comment {
           background-color: #1a1a1b !important;
           color: #d7dadc !important;
       }

       .res-nightmode .md h1, .res-nightmode .md h2, .res-nightmode .md h3,
       .res-nightmode .md h4, .res-nightmode .md h5, .res-nightmode .md h6,
       h1, h2, h3, h4, h5, h6 {
           color: #d7dadc !important;
       }

       .link .usertext .md, .comment .usertext .md {
           background-color: transparent !important;
           color: #d7dadc !important;
       }

       .usertext-body .md {
           color: #d7dadc !important;
       }

       .usertext-body .md p, .usertext-body .md div {
           color: #d7dadc !important;
       }

       .link, .thing {
           border-color: #343536 !important;
       }

       .link.last-clicked {
           border-color: #666 !important;
       }

       .entry .buttons li a, .flat-list li a {
           color: #818384 !important;
           background-color: transparent !important;
       }

       .entry .buttons li a:hover, .flat-list li a:hover {
           color: #d7dadc !important;
           background-color: #343536 !important;
       }

       .link .score {
           color: #d7dadc !important;
       }

       .arrow.up, .arrow.down {
           filter: brightness(0.7) !important;
       }

       .arrow.up:hover, .arrow.down:hover {
           filter: brightness(1) !important;
       }

       .arrow.upmod, .arrow.downmod {
           filter: brightness(1) !important;
       }

       .side .md {
           background-color: #272729 !important;
           color: #d7dadc !important;
           border-color: #343536 !important;
       }

       .side .spacer {
           background-color: #272729 !important;
           border-color: #343536 !important;
       }

       .titlebox {
           color: #d7dadc !important;
       }

       .search-page .content {
           background-color: #1a1a1b !important;
       }

       .linefield {
           background-color: #272729 !important;
           border-color: #343536 !important;
       }

       .linefield .title {
           color: #d7dadc !important;
       }

       .pagename a {
           color: #d7dadc !important;
       }

       .drop-choices {
           background-color: #272729 !important;
           border-color: #343536 !important;
       }

       .drop-choices a.choice {
           color: #d7dadc !important;
       }

       .drop-choices a.choice:hover {
           background-color: #343536 !important;
       }

       #header {
           background-color: #030303 !important;
           border-bottom-color: #343536 !important;
       }

       #header-bottom-left {
           background-color: #030303 !important;
       }

       .tabmenu li a {
           background-color: #272729 !important;
           color: #818384 !important;
           border-color: #343536 !important;
       }

       .tabmenu li.selected a {
           background-color: #1a1a1b !important;
           color: #d7dadc !important;
           border-bottom-color: #1a1a1b !important;
       }

       .link .title a:visited {
           color: #9494a5 !important;
       }

       .link .title a {
           color: #d7dadc !important;
       }

       .domain a {
           color: #818384 !important;
       }

       input[type="text"], input[type="password"], textarea {
           background-color: #272729 !important;
           color: #d7dadc !important;
           border-color: #343536 !important;
       }

       .usertext-edit textarea {
           background-color: #272729 !important;
           color: #d7dadc !important;
       }

       .btn, button {
           background-color: #0079d3 !important;
           color: white !important;
           border-color: #0079d3 !important;
       }

       .btn:hover, button:hover {
           background-color: #1484d6 !important;
       }

       .footer {
           background-color: #1a1a1b !important;
           color: #818384 !important;
           border-top-color: #343536 !important;
       }

       .footer a {
           color: #818384 !important;
       }

       .morelink {
           background-color: #0079d3 !important;
           border-color: #0079d3 !important;
       }

       .morelink a {
           color: white !important;
       }

       .morelink:hover {
           background-color: #1484d6 !important;
       }

       a {
           color: #4fbcff !important;
       }

       a:visited {
           color: #9494a5 !important;
       }

       .comment {
           border-left-color: #343536 !important;
           background-color: transparent !important;
       }

       .comment .child {
           border-left-color: #343536 !important;
       }

       .commentarea .comment {
           background-color: transparent !important;
       }

       .comment .md {
           color: #d7dadc !important;
       }

       .comment .usertext-body {
           color: #d7dadc !important;
       }

       .comment .usertext-body .md p {
           color: #d7dadc !important;
       }

       blockquote {
           background-color: #272729 !important;
           border-left-color: #818384 !important;
           color: #d7dadc !important;
       }

       pre, code {
           background-color: #272729 !important;
           color: #d7dadc !important;
           border-color: #343536 !important;
       }

       table {
           background-color: #272729 !important;
           color: #d7dadc !important;
       }

       th {
           background-color: #343536 !important;
           color: #d7dadc !important;
       }

       td {
           border-color: #343536 !important;
       }

       .tagline {
           color: #818384 !important;
       }

       .tagline a {
           color: #4fbcff !important;
       }

       .expand {
           color: #818384 !important;
       }

       .expand:hover {
           color: #d7dadc !important;
       }

       .author {
           color: #4fbcff !important;
       }

       .author.submitter {
           color: #0dd3bb !important;
       }

       .author.moderator {
           color: #46d160 !important;
       }

       .flair {
           background-color: #343536 !important;
           color: #d7dadc !important;
           border-color: #818384 !important;
       }

       .thing .buttons li a {
           color: #818384 !important;
       }

       .thing .buttons li a:hover {
           color: #d7dadc !important;
           text-decoration: underline !important;
       }

       .save-button, .unsave-button {
           color: #818384 !important;
       }

       .save-button:hover, .unsave-button:hover {
           color: #d7dadc !important;
       }

       .bylink {
           color: #818384 !important;
       }
   `;

  const style = document.createElement("style");
  style.textContent = css;
  document.head.appendChild(style);
})();
