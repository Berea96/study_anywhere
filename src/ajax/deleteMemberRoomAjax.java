package ajax;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import service.RoomService;

public class deleteMemberRoomAjax implements Ajax {

	@Override
	public String getJSON(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String roomname = request.getParameter("roomname");
		System.out.println(roomname);
		
		RoomService service = new RoomService();
		
		boolean result = service.delRoom(roomname);
		
		return "{\"result\" : \"" + result + "\"}";
	}
}
