package dao;

import static db.JDBCUtil.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class RoomDAO {
	private static RoomDAO roomDAO;
	
	private RoomDAO() {
		
	}
	
	public static RoomDAO getInstance() {
		if(roomDAO == null) {
			roomDAO = new RoomDAO();
		}
		
		return roomDAO;
	}
	
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public void setConnection(Connection con) {
		this.con = con;
	}
	
public JSONArray getRooms(String memberId) {
		
		String sql = "select * from room where userid = ?";
		JSONArray arr = new JSONArray();
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rs = pstmt.executeQuery();
			
			
			while(rs.next()) {
				JSONObject json = new JSONObject();
				json.put("roomname", rs.getString(1));
				json.put("roompass", rs.getString(2));
				json.put("userid", rs.getString(3));
				json.put("indata", rs.getString(4));
				arr.add(json);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				close(pstmt);
				close(rs);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return arr;
	}
	
	public int udpateRoom(String roomname, String roompass) {
		
		String sql = "update room set roompass = ? where roomname = ?";
		int result = 0;
		try {
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, roompass);
			pstmt.setString(2, roomname);
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}
	
	public int deleteRoom(String roomname) {
		
		String sql = "delete from room where roomname = ?";
		int result = 0;
		try {
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, roomname);
			
			result = pstmt.executeUpdate();
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
}
