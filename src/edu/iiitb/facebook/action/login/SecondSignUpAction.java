package edu.iiitb.facebook.action.login;

import java.util.Map;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;
import com.sun.org.apache.xalan.internal.xsltc.cmdline.getopt.GetOpt;

import org.apache.struts2.interceptor.SessionAware;

import edu.iiitb.facebook.action.dao.UserDAO;
import edu.iiitb.facebook.action.dao.impl.UserDAOImpl;
import edu.iiitb.facebook.action.model.User;

public class SecondSignUpAction extends ActionSupport implements SessionAware
{

	private String phone_number;
	private String secret_question;
	private String secret_answer;
	private int entered_otp;
	String ret;

	public String getPhone_number()
	{
		return phone_number;
	}

	public void setPhone_number(String phone_number)
	{
		this.phone_number = phone_number;
	}

	public String getSecret_question()
	{
		return secret_question;
	}

	public void setSecret_question(String secret_question)
	{
		this.secret_question = secret_question;
	}

	public String getSecret_answer()
	{
		return secret_answer;
	}

	public void setSecret_answer(String secret_answer)
	{
		this.secret_answer = secret_answer;
	}

	private Map<String, Object> session;

	public Map<String, Object> getSession()
	{
		return session;
	}

	public void setSession(Map<String, Object> session)
	{
		this.session = session;
	}

	UserDAO dao = new UserDAOImpl();
	User user = new User();
	SendingEmail email = new SendingEmail();

	public String execute()
	{
		user = (User) session.get("user");
		
		// when user already exist then goes to HOME page
		if(dao.getUserByUserEmail(user.getEmail()) != null)
		{
		return "exist";	
		}
		if(getEntered_otp()!=user.getOtp())
		{
		ServletActionContext.getResponse().addHeader("msg", "OTP NOT MATCHED");
		return "otpnotmatched";	
		}

		
		System.out.println(getPhone_number());
		user.setPhoneNumber(getPhone_number());
		user.setSecretQuestion(getSecret_question());
		user.setSecretAnswer(getSecret_answer());
        System.out.println(getEntered_otp());
		ret = dao.setUserwithoutphotos(user);
		System.out.println("upto this fine");
		user = dao.getUserByUserEmail(user.getEmail());
		session.put("user", user);
        System.out.println("now the otp values");
        System.out.println(getEntered_otp());
        System.out.println(user.getOtp());
		System.out.println(ret);
		/*try {
			if(email.sendmail(user.getEmail(), user.getPassword()))
			{
				System.out.println("An Email is sent to your entered Email. CheckOut");
			}
		} catch (AddressException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}*/
		return ret;
	}

	public void validate()
	{

		if (StringUtils.isEmpty(phone_number))
		{
			addFieldError(phone_number, "phone number cannot be empty");
		}

		if (StringUtils.isEmpty(secret_question))
		{
			addFieldError(secret_question, "secret question cannot be empty");
		}

		if (StringUtils.isEmpty(secret_answer))
		{
			addFieldError(secret_answer, "secret answer cannot be empty");
		}
		/*if (getEntered_otp()!=user.getOtp())
		{
			addFieldError("entered_otp", "OTP value does not matched");
		}*/

	}

	public int getEntered_otp() {
		return entered_otp;
	}

	public void setEntered_otp(int entered_otp) {
		this.entered_otp = entered_otp;
	}
}
