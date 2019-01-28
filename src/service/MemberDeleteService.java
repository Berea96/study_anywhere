package service;

import static db.JDBCUtil.close;
import static db.JDBCUtil.commit;
import static db.JDBCUtil.getConnection;
import static db.JDBCUtil.rollback;

import java.sql.Connection;

import dao.MemberDAO;

public class MemberDeleteService {
	public boolean deleteMember(String id) {
		
		MemberDAO memberDao = MemberDAO.getInstance();
		Connection con = getConnection();
		memberDao.setConnection(con);
		
		boolean result = memberDao.deleteMember(id);
		
		if(result) {
			commit(con);
		} else {
			rollback(con);
		}
		
		close(con);
		
		return result;
	}
}
