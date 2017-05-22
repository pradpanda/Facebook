package edu.iiitb.facebook.action.groups;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import edu.iiitb.facebook.action.dao.GroupsDAO;
import edu.iiitb.facebook.action.dao.impl.GroupsDAOImpl;
import edu.iiitb.facebook.action.model.Group;
import edu.iiitb.facebook.action.model.NewsFeed;
import edu.iiitb.facebook.action.model.User;
import edu.iiitb.facebook.util.ConnectionPool;

public class LoadGrups extends ActionSupport implements SessionAware{

	/**
	 * created by nisarga
	 */
	private static final long serialVersionUID = 1L;

	private int grpID ;
	
	private ArrayList<NewsFeed> groupnewsfeeds=new ArrayList<NewsFeed>();

	
	public ArrayList<NewsFeed> getGroupnewsfeeds() {
		return groupnewsfeeds;
	}

	public void setGroupnewsfeeds(ArrayList<NewsFeed> groupnewsfeeds) {
		this.groupnewsfeeds = groupnewsfeeds;
	}

	private ArrayList<Group> grpDetails;
	
	public void setGrpDetails(ArrayList<Group> grpDetails) {
		for(Group g:grpDetails)
			System.out.println(g.getGroupName());
		this.grpDetails = grpDetails;
	}

	private int userId;
	
	private Map<String, Object> session;


	public int getGrpID() {
		return grpID;
	}

	public void setGrpID(int grpID) {
		this.grpID = grpID;
	}

	public String execute() throws SQLException
	{
		System.out.println("IN LoadGrups Class");
		
		Connection cn=ConnectionPool.getConnection();
		 User user = (User) session.get("user");
		    if (null != user) {
		    	userId=user.getUserId();
		    }
		    
		ArrayList<Group> al=new ArrayList<Group>();
		
		
		System.out.println("grpID"+getGrpID());
		
		GroupsDAO groupDAO =new GroupsDAOImpl();
			
		al=groupDAO.groupName(cn, grpID);

		//groupnewsfeeds =groupDAO.getGroupNewsFeedsForUser(cn,userId,grpID);
		
		setGroupnewsfeeds(groupnewsfeeds);
		
		for(NewsFeed n: groupnewsfeeds)
		{
			System.out.println(n.getFromUserFirstName());
		}
		
		HttpServletRequest request = ServletActionContext.getRequest();
		
		request.setAttribute("grpName", al);
		
		request.setAttribute("userID", userId);
		
//load		
		ArrayList<Group> al1=new ArrayList<Group>();
		System.out.println("uid"+userId);

		GroupsDAO groupDAO1 =new GroupsDAOImpl();
		
		al1=groupDAO1.groupDetails(cn, userId);
		
		HttpServletRequest request1 = ServletActionContext.getRequest();
		
		request1.setAttribute("grpDetails", al1);
		
		System.out.println("here");
		for(Group g:al1)
		System.out.println("jigr"+g.getGroupName());
		
		ConnectionPool.freeConnection(cn);

		return SUCCESS;
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
}
