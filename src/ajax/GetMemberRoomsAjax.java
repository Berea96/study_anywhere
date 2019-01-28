package ajax;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;

import service.MemberModifyService;
import service.RoomService;

public class GetMemberRoomsAjax implements Ajax {

	@Override
	public String getJSON(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		String id = request.getParameter("id");
		System.out.println(id);
		
		RoomService service = new RoomService();
		
		JSONArray arr = service.getRooms(id);;
		
		return arr.toString();
	}
}
