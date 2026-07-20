window.addEventListener("load", function () {
    const loader = document.getElementById("loader");
    console.log("Window loaded");
    console.log(loader);

    loader.style.display = "none";
});

function showLoader() {
    document.getElementById("loader").style.display = "flex";
}