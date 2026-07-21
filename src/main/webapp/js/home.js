function updateCart(productId, action) {
    fetch("UpdateCartServlet", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "productId=" + productId + "&action=" + action
    })
    .then(response => response.text())
    .then(data => {
        if (!data) return;
        data = data.trim();
        let values = data.split(",");
        
        // Ensure the server sent back all 4 required values
        if (values.length < 4) return;

        let quantity   = values[0];
        let cartCount  = values[1];
        let subtotal   = values[2];
        let grandTotal = values[3];

        // Safely update floating cart badge if it exists
        let cartCountEl = document.getElementById("cartCount");
        if (cartCountEl) cartCountEl.innerText = cartCount;

        // Safely update grand total if it exists (only on Cart page)
        let grandTotalEl = document.getElementById("grandTotal");
        if (grandTotalEl) grandTotalEl.innerText = "Rs " + grandTotal;

        // Safely remove the element if quantity drops to 0
        if (action === "remove" || quantity === "0") {
            let cartCard = document.getElementById("cartCard" + productId);
            if (cartCard) cartCard.remove();
            return;
        }

        // Safely update quantity text
        let qtyEl = document.getElementById("qty" + productId);
        if (qtyEl) qtyEl.innerText = quantity;

        // Safely update subtotal text
        let subtotalEl = document.getElementById("subtotal" + productId);
        if (subtotalEl) subtotalEl.innerText = subtotal;
    })
    .catch(error => console.error("Error in updateCart:", error));
}	

function addToCart(productId) {
    fetch("AddToCartServlet", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "productId=" + productId
    })
    .then(response => response.text())
    .then(cartCount => {
        if (!cartCount) return;
        cartCount = cartCount.trim();

        // Safely update floating cart count
        let cartCountEl = document.getElementById("cartCount");
        if (cartCountEl) cartCountEl.innerText = cartCount;

        // Safely replace Add To Cart button with quantity selector
        let cartArea = document.getElementById("cartArea" + productId);
        if (cartArea) {
            cartArea.innerHTML =
                '<div class="quantitySelector">' +
                    '<button class="qtyBtn" type="button" onclick="updateQuantity(' + productId + ', \'decrease\')">-</button>' +
                    '<span id="qty' + productId + '">1</span>' +
                    '<button class="qtyBtn" type="button" onclick="updateQuantity(' + productId + ', \'increase\')">+</button>' +
                '</div>';        
        }
    })
    .catch(error => console.error("Error in addToCart:", error));
}

function updateQuantity(productId, action) {
    fetch("UpdateCartServlet", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "productId=" + productId + "&action=" + action
    })
    .then(response => response.text())
    .then(data => {
        if (!data) return;
        data = data.trim();
        let values = data.split(",");
        
        if (values.length < 2) return;

        let quantity = values[0];
        let cartCount = values[1];

        // Safely update floating cart count
        let cartCountEl = document.getElementById("cartCount");
        if (cartCountEl) cartCountEl.innerText = cartCount;

        let cartArea = document.getElementById("cartArea" + productId);
        if (quantity === "0") {
            if (cartArea) {
                cartArea.innerHTML =
                    '<button type="button" class="cartButton" onclick="addToCart(' + productId + ')">' +
                    'Add To Cart' +
                    '</button>';
            }
        } else {
            let qtyEl = document.getElementById("qty" + productId);
            if (qtyEl) qtyEl.innerText = quantity;
        }
    })
    .catch(error => console.error("Error in updateQuantity:", error));
}

function moveTypes(direction){

    const container = document.getElementById("typeContainer");

    const button = container.querySelector(".typeButton");

    if(button){

        const amount = button.offsetWidth + 12;

        container.scrollBy({
            left: direction * amount,
            behavior: "smooth"
        });

    }

}

function moveSubTypes(direction){

    const container = document.getElementById("subContainer");

    const button = container.querySelector(".subTypeButton");

    if(button){

        const amount = button.offsetWidth + 12;

        container.scrollBy({
            left: direction * amount,
            behavior: "smooth"
        });

    }

}
