package com.ecommerce.util;
import org.json.JSONObject;

public class TestJson {

    public static void main(String[] args) {

        JSONObject obj = new JSONObject();

        obj.put("name", "Tejas");

        System.out.println(obj.toString());
        
        JSONObject obj1 = new JSONObject();
        obj1.put("hello", "world");
        System.out.println(obj1);
    }

}