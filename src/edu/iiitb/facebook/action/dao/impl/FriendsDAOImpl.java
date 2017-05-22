package edu.iiitb.facebook.action.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import edu.iiitb.facebook.action.dao.FriendsDAO;
import edu.iiitb.facebook.action.dao.UserDAO;
import edu.iiitb.facebook.action.model.FriendInfo;
import edu.iiitb.facebook.action.model.FriendInfo.RequestStatus;
import edu.iiitb.facebook.action.model.FriendSuggestions;
import edu.iiitb.facebook.action.model.User;
import edu.iiitb.facebook.util.CommonUtil;
import edu.iiitb.facebook.util.ConnectionPool;


public class FriendsDAOImpl implements FriendsDAO
{

	String ARE_THEY_FRIENDS_QRY = "select * from friends_with f1 where f1.request_by=? and f1.request_for=?" + " union "
			+ " select * from friends_with f1 where f1.request_by=? and f1.request_for=?";

	private static final String SUGGEST_FRIENDS_QUERY = "" 
			+ "SELECT DISTINCT userid, ufirstname, ulastname " 
			+ "FROM user "
			+ "WHERE userid in ( " 
			+ "   SELECT friend_receiver " 
			+ "    FROM friends " 
			+ "    WHERE friend_sender in ( "
			+ "        SELECT friend_receiver " 
			+ "        FROM friends " 
			+ "        WHERE friend_sender = ? "
			+ "        AND friendshipstatus = 'Accepted' " 
			+ "        UNION " 
			+ "        SELECT friend_sender " 
			+ "        FROM friends "
			+ "        WHERE friend_receiver = ? " 
			+ "        AND friendshipstatus = 'Accepted' " + "    ) " 
			+ "    AND friendshipstatus = 'Accepted' "
			+ "    AND friend_receiver != ? " 
			+ "	 AND friend_receiver NOT IN ( " 
			+ "        SELECT friend_receiver " 
			+ "        FROM friends "
			+ "        WHERE friend_sender = ? " 
			+ "        AND friendshipstatus in ('Accepted','Pending','Blocked') " 
			+ "        UNION " 
			+ "        SELECT friend_sender "
			+ "        FROM friends " 
			+ "        WHERE friend_receiver = ? " 
			+ "        AND friendshipstatus in ('Accepted','Pending','Blocked') " 
			+ "    ) "
			+ "    UNION " 
			+ "    SELECT friend_sender " 
			+ "    FROM friends " 
			+ "    WHERE friend_receiver in ( "
			+ "        SELECT friend_receiver " 
			+ "        FROM friends " 
			+ "        WHERE friend_sender = ? "
			+ "        AND friendshipstatus = 'Accepted' " 
			+ "        UNION " 
			+ "        SELECT friend_sender " 
			+ "        FROM friends "
			+ "        WHERE friend_receiver = ? " 
			+ "        AND friendshipstatus = 'Accepted' " 
			+ "    ) " 
			+ "    AND friendshipstatus = 'Accepted' "
			+ "    AND friend_sender != ? " 
			+ "	 AND friend_sender NOT IN ( " 
			+ "        SELECT friend_receiver " 
			+ "        FROM friends "
			+ "        WHERE friend_sender = ? " 
			+ "        AND friendshipstatus in ('Accepted','Pending','Blocked') " 
			+ "        UNION " 
			+ "        SELECT friend_sender "
			+ "        FROM friends " 
			+ "        WHERE friend_receiver = ? " 
			+ "        AND friendshipstatus in ('Accepted','Pending','Blocked') " 
			+ "    )" 
			+ ")";
	String MUTUAL_FRIENDS_QUERY = ""
			+ "SELECT DISTINCT userid, ufirstname, ulastname "
			+ "FROM user "
			+ "WHERE userid IN ( "
			+ "		SELECT myFriends as mutualFriends FROM "
			+ "		(SELECT friend_receiver as myFriends "
			+ "		FROM friends "
			+ "		WHERE friend_sender = ? "
			+ "		AND friendshipstatus = 'Accepted' "
			+ "		UNION "
			+ "		SELECT friend_sender as myFriends "
			+ "		FROM friends "
			+ "		WHERE friend_receiver = ? "
			+ "		AND friendshipstatus = 'Accepted') as myFriendsTable "
			+ "		WHERE myFriends IN "
			+ "			(SELECT hisFriends FROM "
			+ "			(SELECT friend_receiver as hisFriends "
			+ "			FROM friends "
			+ "			WHERE friend_sender = ? "
			+ "			AND friendshipstatus = 'Accepted' "
			+ "			UNION "
			+ "			SELECT friend_sender as hisFriends "
			+ "			FROM friends "
			+ "			WHERE friend_receiver = ? "
			+ "			AND friendshipstatus = 'Accepted') as hisFriendsTable" 
			+ "		)" 
			+ "	) ";
	

	String ADD_FRIEND_QRY = "insert into friends(friendshipstatus,friend_sender,friend_receiver) values(?,?,?)";

	String WITHDRAW_FRIEND_QRY = "delete from  friends  where friend_sender=? and friend_receiver=? and friendshipstatus='Pending' ";
	
	
	String REMOVE_FRIEND_QRY = "delete from  friends  where ((friend_sender=? and friend_receiver=?) or (friend_sender=? and friend_receiver=?)) and friendshipstatus='Accepted' ";
	
	String BLOCK_FRIEND_QRY = "update friends_with set friendshipstatus='Blocked' where ((friend_sender=? and friend_receiver=?) or (friend_sender=? and friend_receiver=?)) and friendshipstatus='Accepted' ";
	
	String CONFIRM_FRIEND_QRY = "update friends set friendshipstatus='Accepted' where friend_sender=? and friend_receiver=? ";

	String REJECT_FRIEND_QRY = "delete from  friends  where friend_sender=? and friend_receiver=? and friendshipstatus='Pending' ";
	
	
	String BLOCK_FRIEND_QUERY = "" +
		"UPDATE friends_with " +
		"SET status = 'blocked', " +
		"request_by = ?, " +
		"request_for = ? " +
		"WHERE id = ?" ;
	
	String GET_BLOCKED_FRIENDS_QUERY = "" +
		"SELECT id, first_name, last_name " +
		"FROM user " +
		"WHERE id in ( " +
		"SELECT request_for " +
		"FROM friends_with " +
		"WHERE status = 'blocked' " +
		"AND request_by = ?) ";
	
	String UNBLOCK_FRIEND_QUERY = "" +
		"DELETE FROM  friends_with " +
		"WHERE request_by = ? " +
		"AND request_for = ? " +
		"AND status = 'blocked'";
	private static final String GET_FREINDS_QRY = "select first_name, last_name, email, id from user where id in (select request_by id from friends_with where request_for=? and status = 'accepted' union select request_for id from friends_with where request_by=? and status = 'accepted')";
	
	private static final String FRIEND_REQUESTS_BY_STRANGERS = 
	    "SELECT  " + 
	    "    stranger.userid AS strangers_id, " + 
	    "    stranger.ufirstname AS strangers_first_name, " + 
	    "    stranger.ulastname AS strangers_last_name " + 
	    "FROM " + 
	    "    friends " + 
	    "        JOIN " + 
	    "    user stranger ON friends.friend_sender = stranger.userid " + 
	    "WHERE " + 
	    "    friends.friend_receiver = ? " + 
	    "        AND friends.friendshipstatus = 'Pending';";
	
	@Override
	public FriendInfo getFriendRequestStatus(int loggedInUserId, int otherUserId)
	{
		FriendInfo friendInfo = null;

		Connection conn = ConnectionPool.getConnection();

		try
		{
			PreparedStatement stmt = conn.prepareStatement(ARE_THEY_FRIENDS_QRY);

			stmt.setInt(1, loggedInUserId);
			stmt.setInt(2, otherUserId);
			stmt.setInt(3, otherUserId);
			stmt.setInt(4, loggedInUserId);
			ResultSet resultSet = stmt.executeQuery();

			if (resultSet.next())
			{
				friendInfo = new FriendInfo();

				friendInfo.setRequestedBy(resultSet.getInt(FriendsDAO.REQUEST_BY));
				friendInfo.setRequestFor(resultSet.getInt(FriendsDAO.REQUEST_FOR));
				RequestStatus reqstatus = FriendInfo.RequestStatus.fromString(resultSet.getString(FriendsDAO.REQUEST_STATUS));
				if (reqstatus != null)
				{
					friendInfo.setRequestStatus(reqstatus);
				}

			}

		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(conn);
		}

		return friendInfo;

	}

	@Override
	public List<User> getFriendsList(int userId)
	{
		ArrayList<User> friends = new ArrayList<User>();
		User userDao = null;
		Connection conn = ConnectionPool.getConnection();

		try {
			PreparedStatement stmt = conn.prepareStatement(GET_FREINDS_QRY);
			stmt.setInt(1, userId);
			stmt.setInt(2, userId);

			ResultSet rs = stmt.executeQuery();

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


	@Override
	public boolean addFriend(int loggedInUserId, int otherUserId)
	{

		Connection conn = ConnectionPool.getConnection();

		try
		{
			PreparedStatement preparedstmt = conn.prepareStatement(ADD_FRIEND_QRY);

			preparedstmt.setString(1, FriendInfo.RequestStatus.PENDING.getReqstat());
			preparedstmt.setInt(2, loggedInUserId);
			preparedstmt.setInt(3, otherUserId);
			if (preparedstmt.executeUpdate() > 0)
			{
				return true;
			}

		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(conn);
		}

		return false;
	}
	
	@Override
	public boolean withdrawrequest(int loggedInUserId, int otherUserId)
	{

		Connection conn = ConnectionPool.getConnection();

		try
		{
			PreparedStatement preparedstmt = conn.prepareStatement(WITHDRAW_FRIEND_QRY);

			preparedstmt.setInt(1, loggedInUserId);
			preparedstmt.setInt(2, otherUserId);

			if (preparedstmt.executeUpdate() > 0)
			{
				return true;
			}

		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(conn);
		}

		return false;

		
	}
	
	/////////////////////////////////
	@Override
	public boolean remove(int loggedInUserId, int otherUserId)
	{

		Connection conn = ConnectionPool.getConnection();

		try
		{
			PreparedStatement preparedstmt = conn.prepareStatement(REMOVE_FRIEND_QRY);

			preparedstmt.setInt(1, loggedInUserId);
			preparedstmt.setInt(2, otherUserId);
			preparedstmt.setInt(3, otherUserId);
			preparedstmt.setInt(4, loggedInUserId);

			if (preparedstmt.executeUpdate() > 0)
			{
				return true;
			}

		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(conn);
		}

		return false;

		
	}
	
	public boolean rejectingafriend(int loggedInUserId, int otherUserId)
	{

		Connection conn = ConnectionPool.getConnection();

		try
		{
			PreparedStatement preparedstmt = conn.prepareStatement(REJECT_FRIEND_QRY);

			
			preparedstmt.setInt(1, otherUserId);
			preparedstmt.setInt(2, loggedInUserId);

			if (preparedstmt.executeUpdate() > 0)
			{
				return true;
			}

		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(conn);
		}

		return false;

		
	}
	
	
	@Override
	public boolean block(int loggedInUserId, int otherUserId)
	{

		Connection conn = ConnectionPool.getConnection();

		try
		{
			PreparedStatement preparedstmt = conn.prepareStatement(BLOCK_FRIEND_QRY);

			preparedstmt.setInt(1, loggedInUserId);
			preparedstmt.setInt(2, otherUserId);
			preparedstmt.setInt(3, otherUserId);
			preparedstmt.setInt(4, loggedInUserId);

			if (preparedstmt.executeUpdate() > 0)
			{
				return true;
			}

		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(conn);
		}

		return false;

		
	}
	/////////////////////////////////////

	@Override
	public boolean confirmFriend(int loggedInUserId, int otherUserId)
	{
		Connection conn = ConnectionPool.getConnection();

		try
		{
			PreparedStatement preparedstmt = conn.prepareStatement(CONFIRM_FRIEND_QRY);

		
			preparedstmt.setInt(1, otherUserId);
			preparedstmt.setInt(2, loggedInUserId);

			if (preparedstmt.executeUpdate() > 0)
			{
				return true;
			}

		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(conn);
		}

		return false;

	}
	
	@Override
	public boolean acceptrequest(int loggedInUserId, int otherUserId)
	{
		Connection conn = ConnectionPool.getConnection();

		try
		{
			PreparedStatement preparedstmt = conn.prepareStatement(CONFIRM_FRIEND_QRY);

		
			preparedstmt.setInt(1, otherUserId);
			preparedstmt.setInt(2, loggedInUserId);

			if (preparedstmt.executeUpdate() > 0)
			{
				return true;
			}

		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(conn);
		}

		return false;
	}


	@Override
	public boolean rejectFriend(int loggedInUserId, int otherUserId)
	{
		Connection conn = ConnectionPool.getConnection();

		try
		{
			PreparedStatement preparedstmt = conn.prepareStatement(REJECT_FRIEND_QRY);

			preparedstmt.setInt(1, otherUserId);
			preparedstmt.setInt(2, loggedInUserId);

			if (preparedstmt.executeUpdate() > 0)
			{
				return true;
			}

		}
		catch (SQLException e)
		{
			e.printStackTrace();
		}
		finally
		{
			ConnectionPool.freeConnection(conn);
		}

		return false;
	}

	@Override
	public boolean blockFriend(int loggedInUserId, int otherUserId) {
		Connection conn = ConnectionPool.getConnection();

		
		try {
			
			PreparedStatement stmt = conn.prepareStatement(ARE_THEY_FRIENDS_QRY);
			int friendsWithId = -1;
			
			stmt.setInt(1, loggedInUserId);
			stmt.setInt(2, otherUserId);
			stmt.setInt(3, otherUserId);
			stmt.setInt(4, loggedInUserId);
			ResultSet rs = stmt.executeQuery();
			
			if (rs.next()) {
				friendsWithId = rs.getInt("id");
			}
			
			stmt = conn.prepareStatement(BLOCK_FRIEND_QUERY);

			stmt.setInt(1, loggedInUserId);
			stmt.setInt(2, otherUserId);
			stmt.setInt(3, friendsWithId);

			if (stmt.executeUpdate() > 0) {
				return true;
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			ConnectionPool.freeConnection(conn);
		}
		return false;
	}

	@Override
	public boolean unblockFriend(int myUserId, int blockedUserId) {
				
		Connection connection = ConnectionPool.getConnection();
		
		try {
			PreparedStatement stmt = connection.prepareStatement(UNBLOCK_FRIEND_QUERY);
			stmt.setInt(1, myUserId);
			stmt.setInt(2, blockedUserId);
			
			int is = stmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			ConnectionPool.freeConnection(connection);
		}
		return true;
	}

	/*
	 * Added by Rahul
	 */
	public List<FriendSuggestions> getFriendSuggestions(int userId)
	{

		List<FriendSuggestions> friendSuggestionsList = new ArrayList<FriendSuggestions>();

		Connection connection = ConnectionPool.getConnection();
		try
		{
			PreparedStatement stmt = connection.prepareStatement(SUGGEST_FRIENDS_QUERY);
			stmt.setInt(1, userId);
			stmt.setInt(2, userId);
			stmt.setInt(3, userId);
			stmt.setInt(4, userId);
			stmt.setInt(5, userId);
			stmt.setInt(6, userId);
			stmt.setInt(7, userId);
			stmt.setInt(8, userId);
			stmt.setInt(9, userId);
			stmt.setInt(10, userId);
			ResultSet rs = stmt.executeQuery();

			FriendSuggestions fs = null;

			while (rs.next())
			{
				int friendId = rs.getInt("userid");
				String firstName = rs.getString("ufirstname");
				String lastName = rs.getString("ulastname");
				fs = new FriendSuggestions(friendId, firstName, lastName);
				friendSuggestionsList.add(fs);
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

		return friendSuggestionsList;
	}
	
	/*
	 * Added by Rahul
	 */
	@Override
	public List<FriendSuggestions> getMutualFriends(int userId, int friendId) {

		List<FriendSuggestions> friendSuggestionsList = new ArrayList<FriendSuggestions>();

		Connection connection = ConnectionPool.getConnection();
		try {
			PreparedStatement stmt = connection.prepareStatement(MUTUAL_FRIENDS_QUERY);
			stmt.setInt(1, userId);
			stmt.setInt(2, userId);
			stmt.setInt(3, friendId);
			stmt.setInt(4, friendId);
			ResultSet rs = stmt.executeQuery();

			FriendSuggestions fs = null;

			while (rs.next()) {
				int mutualFriendId = rs.getInt("userid");
				String firstName = rs.getString("ufirstname");
				String lastName = rs.getString("ulastname");
				fs = new FriendSuggestions(mutualFriendId, firstName, lastName);
				friendSuggestionsList.add(fs);
			    
			}
			
			for(FriendSuggestions i:friendSuggestionsList)
			{
				System.out.println(i.getFirstName());
				System.out.println(i.getFriendId());
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			ConnectionPool.freeConnection(connection);
		}

		return friendSuggestionsList;
	}

	@Override
	public List<FriendSuggestions> getBlockedFriends(int userId) {
		List<FriendSuggestions> blockedFriendsList = new ArrayList<FriendSuggestions>();

		Connection connection = ConnectionPool.getConnection();
		try {
			PreparedStatement stmt = connection.prepareStatement(GET_BLOCKED_FRIENDS_QUERY);
			stmt.setInt(1, userId);

			ResultSet rs = stmt.executeQuery();

			FriendSuggestions fs = null;

			while (rs.next()) {
				int friendId = rs.getInt("id");
				String firstName = rs.getString("first_name");
				String lastName = rs.getString("last_name");
				fs = new FriendSuggestions(friendId, firstName, lastName);
				blockedFriendsList.add(fs);
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			ConnectionPool.freeConnection(connection);
		}

		return blockedFriendsList;
	}

  @Override
  public List<User> getFriendsRequestsByStrangers(int userId) {
    List<User> strangers = new ArrayList<User>();    
    Connection conn = ConnectionPool.getConnection();
    try {
      PreparedStatement stmt = conn
          .prepareStatement(FRIEND_REQUESTS_BY_STRANGERS);
      stmt.setInt(1, userId);
      ResultSet rs = stmt.executeQuery();

      while (rs.next()) {
    	  System.out.println("stranger found");
        int strangersId = rs.getInt("strangers_id");
        String strangersFirstName = rs.getString("strangers_first_name");
        String strangersLastName = rs.getString("strangers_last_name");
        User stranger = new User(strangersId, strangersFirstName,
            strangersLastName);
        strangers.add(stranger);
      }

    } catch (SQLException e) {
      e.printStackTrace();
    } finally {
      ConnectionPool.freeConnection(conn);
    }

    return strangers;
  }
}

