"use strict";
// This file will be converted to JS code
// this code will be sent to the client
let navItems;
document.addEventListener("DOMContentLoaded", () => {
    navItems = document.querySelectorAll("nav.Bar>.Item");
    navItems.forEach((navItem) => {
        navItem.addEventListener("mouseenter", toggleNavBlur);
        navItem.addEventListener("mouseleave", toggleNavBlur);
    });
});
function toggleNavBlur(event) {
    event.target.parentElement.classList.toggle("BackgroundBlured");
}
