package ajax;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.RoomService;

public class updateMemberRoomsAjax implements Ajax {

	@Override
	public String getJSON(HttpServletRequest request, HttpServletResponse response) throws Exception {

		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String roomname = request.getParameter("roomname");
		String roompass = request.getParameter("roompass");
		System.out.println(roomname);
		System.out.println(roompass);
		
		RoomService service = new RoomService();
		
		boolean result = service.editRoom(roomname, roompass);
		
		String str = "{\"result\" : \"" + result + "\"";
		
		if(result) {
			str += ",\"newpass\" : \"" + roompass + "\"}";
		}
		else {
			str += "}";
		}
		
		return str;
	}
}
