package com.ecommerce.util;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

import org.json.JSONObject;

/*
 * Utility class responsible for communicating with Razorpay.
 *
 * This class only talks to Razorpay.
 *
 * It DOES NOT:
 *
 * create local orders
 * reduce stock
 * clear cart
 *
 * Those responsibilities remain inside OrderService.
 */

public class RazorpayUtil {

    /*
     * Java 21 HTTP Client.
     *
     * One instance is enough.
     */

    private static final HttpClient client =
            HttpClient.newHttpClient();

    /*
     * Creates an order on Razorpay Server.
     *
     * amount should already be in PAISE.
     */

    public static JSONObject createOrder(int amountInPaise,
                                         String receipt)
            throws IOException, InterruptedException {

        /*
         * Build JSON body.
         */

        JSONObject body = new JSONObject();

        body.put("amount", amountInPaise);

        body.put("currency", "INR");

        body.put("receipt", receipt);

        /*
         * Razorpay uses HTTP Basic Authentication.
         *
         * username = KEY_ID
         * password = KEY_SECRET
         */

        String auth =
                RazorpayConfig.KEY_ID
                        + ":"
                        + RazorpayConfig.KEY_SECRET;

        String encodedAuth =
                Base64.getEncoder()
                        .encodeToString(
                                auth.getBytes(StandardCharsets.UTF_8));

        /*
         * Build HTTP Request.
         */

        HttpRequest request =
                HttpRequest.newBuilder()

                        .uri(
                                URI.create(
                                        "https://api.razorpay.com/v1/orders"))

                        .header(
                                "Authorization",
                                "Basic " + encodedAuth)

                        .header(
                                "Content-Type",
                                "application/json")

                        .POST(
                                HttpRequest.BodyPublishers.ofString(
                                        body.toString()))

                        .build();

        /*
         * Send Request.
         */

        HttpResponse<String> response =
                client.send(
                        request,
                        HttpResponse.BodyHandlers.ofString());

        
        if (response.statusCode() != 200) {

            throw new RuntimeException(
                    "Failed to create Razorpay Order.\n"
                    + "HTTP Status : " + response.statusCode()
                    + "\nResponse : " + response.body());
        }
        /*
         * Return complete JSON.
         */

        return new JSONObject(response.body());

    }

}