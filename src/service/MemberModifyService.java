package service;

import static db.JDBCUtil.close;
import static db.JDBCUtil.commit;
import static db.JDBCUtil.getConnection;
import static db.JDBCUtil.rollback;

import java.sql.Connection;

import org.json.simple.JSONArray;

import bean.MemberBean;
import dao.MemberDAO;

public class MemberModifyService {

	private static final String String = null;

	public boolean modifyMember(MemberBean mb, String currentPassword, String changePassword) {
		MemberDAO memberDAO = MemberDAO.getInstance();
		Connection con = getConnection();
		memberDAO.setConnection(con);

		boolean modifyResult = false;
		
		int result = memberDAO.modifyMember(mb, currentPassword, changePassword);
		
		System.out.println(":: modiyfyService ::");
		System.out.println("modifyMember result : "+result);
		System.out.println();
		
		if(result != 0) {
			modifyResult = true;
			commit(con);
		} else {
			rollback(con);
		}
		
		close(con);
		return modifyResult;
	}
	
	public boolean modifyMember(String memberID, String tempPass) {
		MemberDAO memberDAO = MemberDAO.getInstance();
		Connection con = getConnection();
		memberDAO.setConnection(con);

		boolean modifyResult = false;
		
		int result = memberDAO.modifyMember(memberID, tempPass);
		
		if(result != 0) {
			modifyResult = true;
			commit(con);
		} else {
			rollback(con);
		}
		
		close(con);
		return modifyResult;
	}
	
	/** temppass 체크 */
	public boolean tempPassCheck(String temppass, String memberID) {
		MemberDAO memberDAO = MemberDAO.getInstance();
		Connection con = getConnection();
		memberDAO.setConnection(con);
		
		boolean result = memberDAO.tempPassCheck(temppass, memberID);
		
		close(con);
		return result;
	}
}
