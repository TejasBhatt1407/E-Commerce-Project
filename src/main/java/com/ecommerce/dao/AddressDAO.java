package com.ecommerce.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.ecommerce.model.Address;
import com.ecommerce.util.DBConnection;

public class AddressDAO {

    public boolean saveAddress(Address address){

        String sql =
        "INSERT INTO user_addresses(user_id,full_name,mobile,address,city,state,pincode)"
        + " VALUES(?,?,?,?,?,?,?)";

        try(Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)){

            ps.setInt(1,address.getUserId());
            ps.setString(2,address.getFullName());
            ps.setString(3,address.getMobile());
            ps.setString(4,address.getAddress());
            ps.setString(5,address.getCity());
            ps.setString(6,address.getState());
            ps.setString(7,address.getPincode());

            return ps.executeUpdate()>0;

        }catch(Exception e){
            throw new RuntimeException(e);
        }

//        return false;

    }
    
    public boolean saveAddress(Connection con,
            Address address)
throws Exception {

String sql =
"INSERT INTO user_addresses(user_id,full_name,mobile,address,city,state,pincode)"
+ " VALUES(?,?,?,?,?,?,?)";

PreparedStatement ps = con.prepareStatement(sql);

ps.setInt(1,address.getUserId());
ps.setString(2,address.getFullName());
ps.setString(3,address.getMobile());
ps.setString(4,address.getAddress());
ps.setString(5,address.getCity());
ps.setString(6,address.getState());
ps.setString(7,address.getPincode());

return ps.executeUpdate()>0;
}

}