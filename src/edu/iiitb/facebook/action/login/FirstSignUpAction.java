package edu.iiitb.facebook.action.login;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import edu.iiitb.facebook.action.dao.UserDAO;
import edu.iiitb.facebook.action.dao.impl.UserDAOImpl;
import edu.iiitb.facebook.action.model.User;

public class FirstSignUpAction extends ActionSupport implements SessionAware {

	private String email;
	private String reemail;
	private String password;
	private String day;
	private String month;
	private String year;
	private Date dob;
	private int otp;
	private String first_name;
	private String last_name;
	private String place;
	private String gender;
	String ret;
	private String notification;
	private Map<String, Object> session;

	public Map<String, Object> getSession() {
		return session;
	}

	UserDAO dao = new UserDAOImpl();
	User user = new User();
	SendingEmail email1 = new SendingEmail();

	@Override
	public String execute() {

		if(dao.getUserByUserEmail(getEmail()) != null)
		{
			setNotification("Email already exist, So re-enter new EmailId");
		return "exist";	
		}
		System.out.println("day value" + day);
		SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");

		String input = year + "-" + month + "-" + day;

		System.out.print(input + " Parses as ");

		Date t;

		try {
			setDob(ft.parse(input));
			System.out.println(ft.parse(input));
		} catch (ParseException e) {
			System.out.println("Unparseable using " + ft);
		}

		user.setEmail(getEmail());
		user.setPassword(getPassword());
		user.setDate(input);
		user.setDob(getDob());
		user.setPhoneNumber(null);
		user.setFirstName(getFirst_name());
		user.setLastName(getLast_name());
		user.setPlace(getPlace());
		user.setGender(getGender());
		user.setSecretQuestion("fornowitsnull");
		user.setSecretAnswer("fornowitsnull");
		
		Random rand = new Random();
		otp=rand.nextInt((9999-1000)+1) + 1000;
		System.out.println("here is the otp");
		System.out.println(otp);
		user.setOtp(otp);
		System.out.println("password is");
		System.out.println(user.getPassword());
		session.put("user", user);
		ret = SUCCESS;// dao.setUserwithoutphotos(user);
		
		try {
			if(email1.sendmail(user.getEmail(), user.getPassword(),user.getOtp()))
			{
				System.out.println("An Email is sent to your entered Email. CheckOut");
			}
		} catch (AddressException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ret;
	}

	public String getDay() {
		return day;
	}

	public void setDay(String day) {
		this.day = day;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getReemail() {
		return reemail;
	}

	public void setReemail(String reemail) {
		this.reemail = reemail;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Date getDob() {
		return dob;
	}

	public void setDob(Date dob) {
		this.dob = dob;
	}

	public String getFirst_name() {
		return first_name;
	}

	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}

	public String getLast_name() {
		return last_name;
	}

	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}

	public String getPlace() {
		return place;
	}

	public void setPlace(String place) {
		this.place = place;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getNotification() {
		return notification;
	}

	public void setNotification(String notification) {
		this.notification = notification;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public void validate() {

		if (StringUtils.isEmpty(email)) {
			addFieldError(email, "email cannot be empty");
		}

		if (StringUtils.isEmpty(reemail)) {
			addFieldError(reemail, "email cannot be empty");
		}

		if (StringUtils.isEmpty(password)) {
			addFieldError(password, "password cannot be empty");
		}

		if (StringUtils.isEmpty(first_name)) {
			addFieldError(first_name, "first name cannot be empty");
		}

		if (StringUtils.isEmpty(last_name)) {
			addFieldError(last_name, "last name cannot be empty");
		}
	}

	public int getOtp() {
		return otp;
	}

	public void setOtp(int otp) {
		this.otp = otp;
	}

}
