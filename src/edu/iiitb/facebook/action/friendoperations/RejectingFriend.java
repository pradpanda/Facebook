package edu.iiitb.facebook.action.friendoperations;

import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import edu.iiitb.facebook.action.dao.CommentsDAO;
import edu.iiitb.facebook.action.dao.FriendsDAO;
import edu.iiitb.facebook.action.dao.impl.CommentsDAOImpl;
import edu.iiitb.facebook.action.dao.impl.FriendsDAOImpl;
import edu.iiitb.facebook.action.model.User;

public class RejectingFriend extends ActionSupport implements SessionAware {

	private static final long serialVersionUID = 4017494400479579942L;
	private Map<String, Object> session;

	private int userId;
	private int friendId;
	private boolean status;
	private FriendsDAO friendsDAO = new FriendsDAOImpl();
	
	public String execute() {
		System.out.println("u are trying to reject");
	    User user = (User) session.get("user");
	    if (null != user) {
	    	userId = user.getUserId();
	    	status = friendsDAO.rejectingafriend(userId, friendId);
	    	System.out.println("u have succeded in reject");
	    	return SUCCESS;		
	    } else {
	    	return LOGIN;
	    }
	}
	 
	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getFriendId() {
		return friendId;
	}

	public void setFriendId(int friendId) {
		this.friendId = friendId;
	}

	public boolean isStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}
}
