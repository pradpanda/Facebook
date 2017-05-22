package edu.iiitb.facebook.action.dao;

import java.io.FileInputStream;

import edu.iiitb.facebook.action.model.User;

public interface UserDAO
{

	String ID = "userid";
	String EMAIL = "uemail";
	String PASSWORD = "upwd";
	String DOB = "udob";
	String PHONE_NUMBER = "uphone";
	String FIRST_NAME = "ufirstname";
	String LAST_NAME = "ulastname";
	String PLACE = "place";
	String CURRENT_PROFILE_PIC = "uprofilepic";
	String CURRENT_COVER_PIC = "ucoverpic";
	String SECRET_QUESTION = "usecques";
	String SECRET_ANSWER = "usecans";
	String CREATED = "ucreationtime";
	String RELATIONSHIP = "relationship";
	String NATIVEPLACE = "nativeplace";
	String GENDER = "ugender";
	String LOCALE = "locale";
	
	
	

	User getUserImageByUserId(int userId);

	User getUserByUserId(int userId);
	User getUserByUserEmail(String email);
	String setUser(User user);
	
	
	String setCoverImageByUserId(int userId, FileInputStream inputStream);
	String setProfileImageByUserId(int userId, FileInputStream inputStream);
	String setUserwithoutphotos(User user);
	String resetpassword(String email, String password);
	
	String setLocale(int userId, String localeCode);
	
}