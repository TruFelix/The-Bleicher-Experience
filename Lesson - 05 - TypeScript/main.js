// Here is all logic/behaviour

let navItems = [];

document.addEventListener("DOMContentLoaded", () => {
	navItems = document.querySelectorAll("nav.Bar>.Item");
	
	for (const navItem of navItems) {
		navItem.addEventListener("mouseenter", toggleNavBlur);
		navItem.addEventListener("mouseleave", toggleNavBlur);
	}
});

function toggleNavBlur(event) {
	event.target.parentElement.classList.toggle("BackgroundBlured");
}