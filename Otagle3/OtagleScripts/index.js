// GET ELEMENT
const btn = document.querySelector('.Options');
const About = document.querySelector(".About");
const btnOk = document.querySelector(".btnOk");
const toggleOrederButtons = document.querySelector(".Order");
// ADD Events
btn.addEventListener('click', ToggleClas);
window.addEventListener("keyup", function(event) {
    if (event.which == 121 || event.keyCode == 121) {
        ToggleClas()
        return false;
    }
    return true;
});
About.addEventListener('click', displayAlert)
btnOk.addEventListener('click', closeAlert)
    // Open/Coles MenuBar
function ToggleClas() {
    const menu = document.querySelector('.menu-bar');
    menu.classList.toggle('active');
}
// Display and Close About
function displayAlert() {
    const AboutBox = document.querySelector('.AboutBox');
    AboutBox.classList.add('active');
}

function closeAlert() {
    const AboutBox = document.querySelector('.AboutBox');
    AboutBox.classList.remove('active');
}
const configure0 = document.querySelector(".dropD1");
configure0.addEventListener("click", dropList0)
const configure = document.querySelector(".dropD2");
configure.addEventListener("click", dropList)

function dropList0() {
    const submenu = document.querySelector(".D1");
    submenu.classList.toggle("active");
}

function dropList() {
    const submenu = document.querySelector(".D2");
    submenu.classList.toggle("active");
}