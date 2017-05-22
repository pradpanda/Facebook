package edu.iiitb.facebook.action.dao.impl;

import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import edu.iiitb.facebook.action.dao.GroupsDAO;
import edu.iiitb.facebook.action.dao.UserDAO;
import edu.iiitb.facebook.action.model.Event;
import edu.iiitb.facebook.action.model.Group;
import edu.iiitb.facebook.action.model.Invitation;
import edu.iiitb.facebook.action.model.NewsFeed;
import edu.iiitb.facebook.action.model.PostComment;
import edu.iiitb.facebook.action.model.User;
import edu.iiitb.facebook.util.ConnectionPool;

public class GroupsDAOImpl implements GroupsDAO{
	
	
	private static final String GROUPNEWS_FEEDS_FOR_USER_QUERY =/*"select "
			+"	post.postid as post_id ,"
			+"	pc.commentid as comment_id,"
			+"	u.userid as user_id,"
			+"	u.ufirstname as from_user_first_name,"
			+"	u.ulastname as from_user_last_name,"
			+"	post.postdetails as post_text,"
			+"	post.posttype as post_type,"
			+"	post.timestamp as updated_time ,"
			+"	post.likecount as post_like_count,"
			+"	pl.userlikedid as liked_post,"
			+"	post.commentcount as post_comment_count,"
			+"	post.groupid as group_id,"
			+"	post.friendid as friend_id,"
			+"	pc.comment as comment_text,"
			+"	pc.usercommentedid as commenter_user_id,"
			+"	commenter.ufirstname as commenter_first_name,"
			+"	commenter.ulastname as commenter_last_name,"
			+"	pc.commentlikecount AS comment_like_count,"
			+"	pc.timestamp as comment_updated_time from"
			+"	posts post left outer join user u on u.userid=post.postcreatedby"
			+"	left outer join  friends f on f.friendid=post.friendid"
			+"	left outer join post_comment pc on post.postid=pc.postid"
			+"	left outer join user commenter on pc.usercommentedid=commenter.userid"
			+"	left outer join post_like pl on post.postid=pl.postid"
			+"	where u.userid=? and post.posttype='Normal'"
			+"	Union all"*/
			/*"	select post.postid as post_id ,"
			+"	pc.commentid as comment_id,"
			+"	u.userid as user_id,"
			+"	u.ufirstname as from_user_first_name,"
			+"	u.ulastname as from_user_last_name,"
			+"	post.postdetails as post_text,"
			+"	post.posttype as post_type,"
			+"	post.timestamp as updated_time ,"
			+"	post.likecount as post_like_count,"
			+"	pl.userlikedid as liked_post,"
			+"	post.commentcount as post_comment_count,"
			+"	post.groupid as group_id,"
			+"	post.friendid as friend_id,"
			+"	pc.comment as comment_text,"
			+"	pc.usercommentedid as commenter_user_id,"
			+"	commenter.ufirstname as commenter_first_name,"
			+"	commenter.ulastname as commenter_last_name,"
			+"	pc.commentlikecount AS comment_like_count,"
			+"	pc.timestamp as comment_updated_time from"
			+"	posts post left outer join user u on u.userid=post.postcreatedby"
			+"	left outer join  friends f on f.friendid=post.friendid"
			+"	left outer join post_comment pc on post.postid=pc.postid"
			+"	left outer join user commenter on pc.usercommentedid=commenter.userid"
			+"	left outer join post_like pl on post.postid=pl.postid"
			+"	where u.userid=? and post.posttype='Friend'"
			+"	Union all"*/
			"	select post.postid as post_id ,"
			+"	pc.commentid as comment_id,"
			+"	u.userid as user_id,"
			+"	u.ufirstname as from_user_first_name,"
			+"	u.ulastname as from_user_last_name,"
			+"	post.postdetails as post_text,"
			+"	post.posttype as post_type,"
			+"	post.timestamp as updated_time ,"
			+"	post.likecount as post_like_count,"
			+"	pl.userlikedid as liked_post,"
			+"	post.commentcount as post_comment_count,"
			+"	post.groupid as group_id,"
			+"	post.friendid as friend_id,"
			+"	pc.comment as comment_text,"
			+"	pc.usercommentedid as commenter_user_id,"
			+"	commenter.ufirstname as commenter_first_name,"
			+"	commenter.ulastname as commenter_last_name,"
			+"	pc.commentlikecount AS comment_like_count,"
			+"	pc.timestamp as comment_updated_time from"
			+"	posts post left outer join user u on u.userid=post.postcreatedby"
			+"	left outer join  friends f on f.friendid=post.friendid"
			+"	left outer join post_comment pc on post.postid=pc.postid"
			+"	left outer join user commenter on pc.usercommentedid=commenter.userid"
			+"	left outer join post_like pl on post.postid=pl.postid"
			+"	where u.userid=? and post.posttype='Group' and groupid= ? "
			+   "ORDER BY post_id DESC , comment_updated_time , updated_time DESC"
			+ ";";


	private static final String CREATE_GROUP_QUERY=
			"insert into groups(groupname, createdby, isactive) values(?, ?, ?);";


	private static final String CREATE_GROUP_QUERY_MEMBERS=
			"insert into group_members(groupid,groupuserid,isactive) values(?, ?, ?);";

	private static final String GET_GROUP_ID_QUERY=
			"select max(groupid) from groups ";
	
	private static final String GROUP_STATUS_UPDATE_FOR_GROUPMEMBERS = "INSERT INTO posts(postdetails, postcreatedby ,timestamp , posttype,groupid) "
			+ "VALUES(?, ?, CURRENT_TIMESTAMP, ?, ?);";
	
	private static final String GET_GROUPDETAILS_QUERY=
			"select groupname,groupid from groups where groupid in(select distinct groupid from group_members where groupuserid =? and isactive='1') ";

	private static final String  GROUP= "Group";

	
	private static final String GET_MEMBERS_QRY="select ufirstname, ulastname, uemail, userid from user where userid in(select groupuserid from group_members where groupid=?)";

	
	private final String SET_COVER_PIC_BY_GROUPID = "UPDATE groups SET groupphoto=?  WHERE groupid=?";
	
	
	private final String GET_GRPCOVER_BY_ID_QRY="select groupphoto from groups where groupid=?";
	
	
	private static final String GET_MEMBERS_QUERY=
			"select userid,ufirstname,ulastname from user";

	@Override
	public void createGroup(Connection cn, ArrayList<Integer> ids1, String grpName,int userID)
			throws SQLException {
		System.out.println("IN creategrup");
		
		
		
		PreparedStatement ps=cn.prepareStatement(CREATE_GROUP_QUERY);
		ps.setString(1, grpName);
		ps.setInt(2, userID);
		ps.setInt(3,1);
		//ps.setString(4, g.getGroupPlace());
		//ps.setInt(5, userId);
		ps.executeUpdate();

		ps=cn.prepareStatement(GET_GROUP_ID_QUERY);
		//ps.setInt(1, userId);
		ResultSet rs=ps.executeQuery();
		rs.next();
		int r=rs.getInt(1);
		
		ps=cn.prepareStatement("insert into group_members (groupid,groupuserid,isactive) values ('"+r+"','"+userID+"',1)");
		ps.executeUpdate();

		/*System.out.println(r);
		System.out.println("lolage");
*/
		ps=cn.prepareStatement(CREATE_GROUP_QUERY_MEMBERS);
		ps.setInt(1, r);
		ps.setInt(3, 1);
		System.out.println(ids1.size());
		for(int i=0;i<ids1.size();i++)
		{
			System.out.println("uuu");

			ps.setInt(2,ids1.get(i));
			ps.executeUpdate();		
		}
		rs.close();
		ps.close();
		System.out.println("lolage");
	} 

	@Override
	public ArrayList<User> searchMembers(Connection cn)
			throws SQLException {
		System.out.println("b4 while");
		PreparedStatement ps=cn.prepareStatement(GET_MEMBERS_QUERY);
		ResultSet rs=ps.executeQuery();
		ArrayList<User> al=new ArrayList<User>();

		while(rs.next())
		{
			User u=new User();
			u.setUserId(rs.getInt(1));
			u.setFirstName(rs.getString(2));
			u.setLastName(rs.getString(3));
			al.add(u);
		}
		System.out.println("out of while");
		rs.close();
		ps.close();
		return al;

	} 

	
	@Override
	public ArrayList<Group> groupDetails(Connection cn,int id)
			throws SQLException {
System.out.println("grp deatils dao" + id);
		PreparedStatement ps=cn.prepareStatement(GET_GROUPDETAILS_QUERY);
		ps.setInt(1,id);
		ResultSet rs=ps.executeQuery();
		ArrayList<Group> al=new ArrayList<Group>();

		while(rs.next())
		{
			Group g= new Group();
			System.out.println(rs.getString("groupname"));
			g.setGroupName(rs.getString("groupname"));
			g.setGroupID(rs.getInt("groupid"));
			al.add(g);
		}
		rs.close();
		ps.close();
		return al;

	} 
	
	//to get grup name from id
	@Override
	public ArrayList<Group> groupName(Connection cn,int id)
			throws SQLException {

		PreparedStatement ps=cn.prepareStatement("select groupname,groupid from groups where groupid=? and isactive='1'");
		ps.setInt(1,id);
		ResultSet rs=ps.executeQuery();
		ArrayList<Group> al=new ArrayList<Group>();

		while(rs.next())
		{
			Group g= new Group();
			g.setGroupName(rs.getString("groupname"));
			g.setGroupID(rs.getInt("groupid"));
			al.add(g);
		}
		rs.close();
		ps.close();
		return al;

	} 
	
	
	//jigar get members
	
	@Override
	public int GroupPostbyGroupMember(int userId, int grpID, String status)
	{
		int statusId = -1;
		Connection connection = ConnectionPool.getConnection();
		try
		{
			PreparedStatement stmt = connection.prepareStatement(GROUP_STATUS_UPDATE_FOR_GROUPMEMBERS, Statement.RETURN_GENERATED_KEYS);
			int index = 1;
			stmt.setString(index++, status);
			stmt.setInt(index++, userId);
			stmt.setString(index++,GROUP );
			stmt.setInt(index++, grpID);
			stmt.executeUpdate();
			ResultSet rs = stmt.getGeneratedKeys();
			if (rs.next())
			{
				statusId = rs.getInt(1);
			}
		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(connection);
		}
		return statusId;
	}
	
	
	/*@Override*/
	/*public ArrayList<NewsFeed> getGroupNewsFeedsForUser(Connection cn,int userId,int grpID)
	{
		ArrayList<NewsFeed> newsFeeds = new ArrayList<NewsFeed>();
		Connection connection = ConnectionPool.getConnection();
		try
		{
			System.out.println(userId);
			System.out.println("here");
			PreparedStatement stmt = connection.prepareStatement(GROUPNEWS_FEEDS_FOR_USER_QUERY);
			int index = 1;
			stmt.setInt(index++, userId);
			stmt.setInt(index++, grpID);
			//stmt.setInt(index++, userId);
System.out.println(stmt);
			int prevPostId = -1;
			ResultSet rs = stmt.executeQuery();
			NewsFeed newsFeed = null;
			while (rs.next())
			{
				int postId = rs.getInt("post_id");
				System.out.println(postId);
				Integer commentId = rs.getInt("comment_id");
				System.out.println(commentId);
				int fromUserId = rs.getInt("user_id");
				String fromUserFirstName = rs.getString("from_user_first_name");
				System.out.println(fromUserFirstName);
				String fromUserLastName = rs.getString("from_user_last_name");
				System.out.println(fromUserLastName);
				//int toUserId = rs.getInt("to_user_id");
				//String toUserFirstName = rs.getString("to_user_first_name");
				//String toUserLastName = rs.getString("to_user_last_name");

				String postText = rs.getString("post_text");
				String postType = rs.getString("post_type");
				Date updatedTime = rs.getTimestamp("updated_time");
				System.out.println(updatedTime);
				int likeCount = rs.getInt("post_like_count");
				int  haveILiked =rs.getInt("liked_post");
				int commenterUserId = rs.getInt("commenter_user_id");
				String commenterFirstName = rs.getString("commenter_first_name");
				System.out.println(commenterFirstName);
				String commenterLastName = rs.getString("commenter_last_name");
				System.out.println(commenterLastName);
				String commentText = rs.getString("comment_text");
				int commentLikeCount = rs.getInt("comment_like_count");
				System.out.println(commentLikeCount);
				//boolean haveILikedComment = (0 == rs.getInt("me_liked_comment")) ? false : true;
				Date commentTime = rs.getTimestamp("comment_updated_time");
				if (prevPostId != postId && 0 != postId)
				{
					SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");
					String updatedTimeFormatted = sdf.format(updatedTime);
					newsFeed = new NewsFeed(postId, fromUserId, fromUserFirstName, fromUserLastName,postText, postType, updatedTimeFormatted, likeCount);
					newsFeeds.add(newsFeed);
				}

				if (null != commentId && 0 != commentId)
				{
					SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");
					String commentTimeFormatted = sdf.format(commentTime);
					PostComment postComment = new PostComment(commentId, commenterUserId, commentText,commenterFirstName,commenterLastName
							,commentTimeFormatted,commentLikeCount);
					newsFeed.getPostComments().add(postComment);
				}
				prevPostId = postId;
			}

		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(connection);
		}

		return newsFeeds;
	}*/

	
	
	
	@Override
	public List<User> getGroupMembersList(int groupID)
	{
		ArrayList<User> friends = new ArrayList<User>();
		User userDao = null;
		Connection conn = ConnectionPool.getConnection();

		try {
			System.out.println("hiiii////"+groupID);
			PreparedStatement stmt = conn.prepareStatement(GET_MEMBERS_QRY);
			stmt.setInt(1, groupID);

			ResultSet rs = stmt.executeQuery();
			
		/*	rs.next();
		System.out.println("hiiii"+rs.getString(1));*/
			
			if (rs.next()) {
				friends = new ArrayList<User>();
			} else {
				return friends;
			}
			do {
				userDao = new User();
				userDao.setUserId(rs.getInt(UserDAO.ID));
				userDao.setFirstName(rs.getString(UserDAO.FIRST_NAME));
				userDao.setLastName(rs.getString(UserDAO.LAST_NAME));
				userDao.setEmail(rs.getString(UserDAO.EMAIL));
				System.out.println(rs.getString(UserDAO.FIRST_NAME));
				friends.add(userDao);
			} while (rs.next());

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			ConnectionPool.freeConnection(conn);
		}
		return friends;
	}

	//leave grup
	
	@Override
	public void LeaveGroup(Connection cn,int userID,int grpID)
			throws SQLException {
		System.out.println("leave query");
		String qry="delete from group_members where groupuserid='"+userID+"' and groupid='"+grpID+"' ";
		PreparedStatement ps=cn.prepareStatement("delete from group_members where groupuserid='"+userID+"' and groupid='"+grpID+"' ");
		System.out.println(qry);
		ps.executeUpdate();
		ps.close();

	} 
	
	
	@Override
	public ArrayList<User> searchMembersNotAlereadyAdded(Connection cn,int grpID)
			throws SQLException {

		PreparedStatement ps=cn.prepareStatement("select userid,ufirstname,ulastname from user where userid not in (select groupuserid from group_members where groupid='"+grpID+"')");
		ResultSet rs=ps.executeQuery();
		ArrayList<User> al=new ArrayList<User>();

		while(rs.next())
		{
			User u=new User();
			u.setUserId(rs.getInt("userid"));
			u.setFirstName(rs.getString("ufirstname"));
			u.setLastName(rs.getString("ulastname"));
			al.add(u);
		}
		rs.close();
		ps.close();
		return al;

	} 

	
	@Override
	public void extraMembers(Connection cn, ArrayList<Integer> ids1,int grpID)
			throws SQLException {
		System.out.println("IN creategrup");
		
		System.out.println(" xx="+grpID);
		
		PreparedStatement ps=cn.prepareStatement("insert into group_members (groupid,groupuserid,isactive) values ('"+grpID+"',?,'1')");
		
		/*System.out.println(r);
		System.out.println("lolage");
*/
		System.out.println(ids1.size());
		for(int i=0;i<ids1.size();i++)
		{
			System.out.println("uuu");

			ps.setInt(1,ids1.get(i));
			System.out.println(ps);
			ps.executeUpdate();		
		}
		ps.close();
		System.out.println("lolage");
	} 
	@Override
	public String setCoverImageByGroupId(int GroupId, FileInputStream inputStream) {
		String ret = null;
		Connection conn = ConnectionPool.getConnection();
		// ResultSet generatedKeys = null;
		PreparedStatement preparedStmt = null;
		try {
			System.out.println("b4cover");
			preparedStmt = conn.prepareStatement(SET_COVER_PIC_BY_GROUPID);
			preparedStmt.setBlob(1, inputStream);
			preparedStmt.setInt(2, GroupId);
			System.out.println(preparedStmt);
			if (preparedStmt.executeUpdate() > 0)
				ret = "success";
			else
				ret = "error";

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			ConnectionPool.freeConnection(conn);
		}
		return ret;
	}
	
	//getting grup cover
	@Override
	public Group getGroupImageByGrpId(int grpID) {
		Group group = new Group();
		Connection connection = ConnectionPool.getConnection();
		try {
			PreparedStatement stmt = connection
					.prepareStatement(GET_GRPCOVER_BY_ID_QRY);
			stmt.setInt(1, grpID);

			ResultSet rs = stmt.executeQuery();

			if (rs.next()) {
				
				InputStream currentCoverPic = rs
						.getBinaryStream(GroupsDAO.CURRENT_COVER_PIC);
				
				group.setGroupCoverPic(currentCoverPic);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			ConnectionPool.freeConnection(connection);
		}
		return group;
	}
	
}
