/**
 * 
 */
package edu.iiitb.facebook.util;

/**
 * @author kempa
 *
 */
public interface Constants
{
	// Key to getting authentication details(password) from the session map
	public static final String USER = "user";
	/*messages*/
	public String GET_FRIEND_LIST="select userid,ufirstname,ulastname from user where (ufirstname LIKE ? or ulastname LIKE ?) and userid in (select friend_sender from friends where friend_receiver=? and friend_sender!=? and friendshipstatus='Accepted') or userid in (select friend_receiver from friends where friend_receiver!=? and friend_sender=? and friendshipstatus='Accepted')";
	public String SEND_MESSAGE="insert into messages(senderid,receiverid,messagedetails,timestamp) values(?,?,?,?)";
	public String GET_MESSAGE_ID="select messageid from messages";
	public String MESSAGE_NOTIFY="insert into message_notifications(messageid,touser,msgdesc,timestamp) values(?,?,?,?)";
	public String GET_LAST_MESSAGES="SELECT u.userid, u.ufirstname,u.ulastname, M.messagedetails, M.timestamp FROM user u INNER JOIN messages M ON (M.receiverid = u.userid and M.senderid=? and (M.timestamp,M.receiverid) in (select MAX(timestamp),receiverid from messages where receiverid in(select userid from user) group by receiverid)) or (M.senderid=u.userid and M.receiverid=? and (M.timestamp,M.senderid) in (select MAX(timestamp),senderid from messages where senderid in(select userid from user) group by senderid)) order by timestamp desc";
	public String GET_USER_IMAGE = "select uprofilepic from user where userid=? && uprofilepic is not null";
	public String GET_RECIPIENT_MESSAGES = "select timestamp,messagedetails from messages where timestamp > ? and senderid=? and receiverid=?";
	public String GET_ALL_MESSAGES = "select messagedetails,timestamp,senderid from messages where (receiverid=? and senderid=?) or (senderid=? and receiverid=?) order by timestamp";

}
