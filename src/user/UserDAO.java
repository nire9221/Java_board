 package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

	
	private Connection conn; //object for connecting database
	private PreparedStatement pstmt; // input database to sql
	private ResultSet rs; // object for holding the information
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/BBS"; // connect sql in localhost
			String dbID = "root"; // root id
			String dbPassword = "9221"; // root password
			Class.forName("com.mysql.jdbc.Driver"); //find mysql driver
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			
		} catch (Exception e) {
			e.printStackTrace();  // shows the error when error occurs
		}
	}
	
	//login 
	public int login (String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?"; // check database if ID exists and what the password is  
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery(); // result of execution 
			
			if (rs.next()) {  //if result exists  
				if (rs.getString(1).equals(userPassword)) {
					return 1; // login successful
				}
				else 
					return 0; // wrong password 
			}
			return -1; // no userID exists 
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // database error 
	}
	
	 public int join (User user) {
		 String SQL = "INSERT INTO USER VALUE (?,?,?,?,?)";
		 try {
			  pstmt = conn.prepareStatement(SQL);
			  
			  // variable for each '?' in String SQL 
			  
			  pstmt.setString(1, user.getUserID());
			  pstmt.setString(2, user.getUserPassword());
			  pstmt.setString(3, user.getUserName());
			  pstmt.setString(4, user.getUserGender());
			  pstmt.setString(5, user.getUserEmail());
			  return pstmt.executeUpdate(); 
			  
		 }
		 catch (Exception e) {
			 e.printStackTrace();
		 }
		 return -1; //database error
	 }
	
}
