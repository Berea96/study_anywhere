package ajax;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.ActionForward;
import service.MemberDeleteService;

public class MemberDeleteAjax implements Ajax {

	@Override
	public String getJSON(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		request.setCharacterEncoding("UTF-8");
		
		String id = request.getParameter("id");
		
		System.out.println("-- MemberDeleteAction --");
		System.out.println("id : " + id);
		
		MemberDeleteService mds = new MemberDeleteService();
		
		String str = "{result : " + mds.deleteMember(id) + "}";
		
		return str;
	}

}
