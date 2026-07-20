package com.ecommerce.util;

import java.util.Properties;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class EmailUtility {

    private static final String EMAIL = "yourgmail@gmail.com";

    private static final String PASSWORD = "YOUR_APP_PASSWORD";

    public static boolean sendOTP(String toEmail, String otp) {

        Properties props = new Properties();

        props.put("mail.smtp.auth", "true");

        props.put("mail.smtp.starttls.enable", "true");

        props.put("mail.smtp.host", "smtp.gmail.com");

        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,

                new Authenticator() {

                    protected PasswordAuthentication getPasswordAuthentication() {

                        return new PasswordAuthentication(EMAIL, PASSWORD);

                    }

                });

        try {

            Message message = new MimeMessage(session);

            message.setFrom(new InternetAddress(EMAIL));

            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(toEmail));

            message.setSubject("OTP Verification");

            message.setText(
                    "Your OTP is : " + otp +
                    "\n\nValid for 5 minutes.");

            Transport.send(message);

            return true;

        }

        catch(Exception e) {

//            e.printStackTrace();

        	throw new RuntimeException(e);
        	
           // return false;

        }

    }

}