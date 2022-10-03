package svc.order;

import static db.JdbcUtil.*;

import java.sql.Connection;

import dao.order.OrderDAO;

public class UpdateOrderStatusService {

	public boolean updateOrderStatus(String code, String status) {
		boolean isUpdate = false;
		
		Connection con = getConnection();
		
		OrderDAO orderDAO = OrderDAO.getInstance();
		orderDAO.setConnection(con);
		int cnt = orderDAO.updateMainorder(code, status);
		
		if(cnt > 0) {
			commit(con);
			isUpdate = true;
		} else {
			rollback(con);
		}
		
		close(con);
				
		return isUpdate;
	}
	

}
