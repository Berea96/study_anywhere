package service;

import static db.JDBCUtil.close;
import static db.JDBCUtil.commit;
import static db.JDBCUtil.getConnection;
import static db.JDBCUtil.rollback;

import java.sql.Connection;

import org.json.simple.JSONArray;

import dao.MemberDAO;
import dao.RoomDAO;

public class RoomService {

	public JSONArray getRooms(String memberId) {
		RoomDAO roomDAO = RoomDAO.getInstance();
		Connection con = getConnection();
		roomDAO.setConnection(con);
		
		JSONArray arr = roomDAO.getRooms(memberId);
		
		close(con);
		
		return arr;
	}
	
	public boolean editRoom(String roomname, String roompass) {
		RoomDAO roomDAO = RoomDAO.getInstance();
		Connection con = getConnection();
		roomDAO.setConnection(con);
		
		int result = roomDAO.udpateRoom(roomname, roompass);
		boolean result2 = false;
		
		if(result != 0) {
			result2 = true;
			commit(con);
		} else {
			rollback(con);
		}
		
		close(con);
		
		return result2;
	}
	
	public boolean delRoom(String roomname) {
		RoomDAO roomDAO = RoomDAO.getInstance();
		Connection con = getConnection();
		roomDAO.setConnection(con);
		
		int result = roomDAO.deleteRoom(roomname);
		boolean result2 = false;
		
		if(result != 0) {
			result2 = true;
			commit(con);
		} else {
			rollback(con);
		}
		
		close(con);
		
		return result2;
	}
}
