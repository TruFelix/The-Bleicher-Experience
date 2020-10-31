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
