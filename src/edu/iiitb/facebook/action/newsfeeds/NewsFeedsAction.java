/**
 * 
 */
package edu.iiitb.facebook.action.newsfeeds;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.LocaleUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

import edu.iiitb.facebook.action.dao.GroupsDAO;
import edu.iiitb.facebook.action.dao.PostsDAO;
import edu.iiitb.facebook.action.dao.impl.GroupsDAOImpl;
import edu.iiitb.facebook.action.dao.impl.PostsDAOImpl;
import edu.iiitb.facebook.action.model.FriendInfo;
import edu.iiitb.facebook.action.model.Group;
import edu.iiitb.facebook.action.model.NewsFeed;
import edu.iiitb.facebook.action.model.User;
import edu.iiitb.facebook.util.ConnectionPool;

/**
 * @author arjun
 * 
 */

public class NewsFeedsAction extends ActionSupport implements SessionAware
{

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = -7724100238927300603L;

	private Map<String, Object> session;

	private PostsDAO postsDAO = new PostsDAOImpl();

	private List<NewsFeed> newsFeeds;

	private int userId;
	
	private ArrayList<Group> grpDetails;

	public String execute() throws SQLException
	{
		User user = (User) session.get("user");
		userId = user.getUserId();
		session.put("requestStatus", FriendInfo.RequestStatus.MYPROFILE.getReqstat());
		session.put("profileReference", user.getUserId() + "");

		this.session.put("WW_TRANS_I18N_LOCALE", LocaleUtils.toLocale(user.getLocale()));
		newsFeeds = postsDAO.getNewsFeedsForUser(userId);
		
		//nisarga

		ArrayList<Group> al=new ArrayList<Group>();

			Connection cn=ConnectionPool.getConnection();

			GroupsDAO groupDAO =new GroupsDAOImpl();
			
			al=groupDAO.groupDetails(cn, userId);
			
			HttpServletRequest request = ServletActionContext.getRequest();
			
			request.setAttribute("grpDetails", al);
			//setGrpDetails(al);	
			/////////////////

		
		
		return SUCCESS;
	}

	public List<NewsFeed> getNewsFeeds()
	{
		return newsFeeds;
	}

	public void setNewsFeeds(List<NewsFeed> newsFeeds)
	{
		this.newsFeeds = newsFeeds;
	}

	@Override
	public void setSession(Map<String, Object> session)
	{
		this.session = session;
	}

	public int getUserId()
	{
		return userId;
	}

	public void setUserId(int userId)
	{
		this.userId = userId;
	}

}

