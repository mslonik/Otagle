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
// Arrangement Buttosn
toggleOrederButtons.addEventListener('click', changeOrder)

function changeOrder() {
    const Buttosn = document.querySelectorAll('.box_item');
    for (let index = 0; index < Buttosn.length; index++) {
        Buttosn[index].classList.toggle('stopResize')
    }
    const off = document.querySelector('.fa-toggle-off');
    const on = document.querySelector('.fa-toggle-on');
    off.classList.toggle('off');
    on.classList.toggle('active');

}
const configure = document.querySelectorAll(".dropD");
for (let index = 0; index < configure.length; index++) {
    const element = configure[index];
    element.addEventListener("click", dropList)

}


function dropList() {
    const submenu = document.querySelector(".sub-menu");
    submenu.classList.toggle("active");
}

// const editIcons = document.createElement("div");
// editIcons.classList.add("editIcons");
// editIcons.style.width = "40%";
// editIcons.style.height = "400px";
// editIcons.style.position = "absolute";
// editIcons.style.backgroundColor = "white"
// editIcons.style.top = "50%";
// editIcons.style.left = "50%";
// editIcons.style.transform = "translate(-50%,-50%)";
// editIcons.style.border = " 1px solid #000000";
// document.body.appendChild(editIcons);

// iconsInLayer = document.querySelectorAll('[id=SVGRoot]');

// const selectOption = [];

// //Iterowanie po ikonkach
// for (let index = 0; index < iconsInLayer.length; index++) {
//     const element = iconsInLayer[index].attributes;
//     let name = "";
//     let fileName = "";
//     // wyciągnięcie atrybutów name oraz class
//     for (let i = 0; i < element.length; i++) {
//         name = element[2];
//         fileName = element[1];
//     }

//     selectOption.push({ index: index, name: name.value, class: fileName.value });
// }
// //Create and append select list
// var selectList = document.createElement("select");
// selectList.id = "mySelect";
// editIcons.appendChild(selectList);

// //Create and append the options
// for (var i = 0; i < selectOption.length; i++) {
//     var option = document.createElement("option");
//     option.value = selectOption[i].class;
//     option.text = selectOption[i].name;
//     selectList.appendChild(option);
// }