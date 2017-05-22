package edu.iiitb.facebook.action.friendsuggestions;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import edu.iiitb.facebook.action.dao.FriendsDAO;
import edu.iiitb.facebook.action.dao.impl.FriendsDAOImpl;
import edu.iiitb.facebook.action.model.FriendSuggestions;
import edu.iiitb.facebook.action.model.User;

/**
 * 
 * @author rahul
 *
 */

public class FriendSuggestionsAction extends ActionSupport implements SessionAware {
	
	private static final long serialVersionUID = -8974523974587158560L;
	private FriendsDAO friendsDAO = new FriendsDAOImpl();
	private List<FriendSuggestions> friendSuggestionsList;
	private int userId;
	private Map<String, Object> session;
	
	public String execute() {
		System.out.println("if error occur it has to be after this");
		User user = (User) session.get("user");
	    userId = user.getUserId();
	    this.friendSuggestionsList = new ArrayList<FriendSuggestions>();
		setFriendSuggestionsList(friendsDAO.getFriendSuggestions(userId));
		System.out.println("query has been executed");
		return SUCCESS;
	}

	public List<FriendSuggestions> getFriendSuggestionsList() {
		return friendSuggestionsList;
	}

	public void setFriendSuggestionsList(List<FriendSuggestions> friendSuggestionsList) {
		this.friendSuggestionsList = friendSuggestionsList;
	}
	
	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}
	

}
