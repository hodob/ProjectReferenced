package action.community;

import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import action.Action;
import svc.community.CommReListService;
import svc.community.CommReReCountService;
import svc.community.CommReReListService;
import vo.ActionForward;
import vo.CommReBean;
import vo.PageInfo;
import vo.ProdReviewBean;

public class CommReReCountProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("CommReReCountProAction");

		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		ActionForward forward = null;

		int community_num = Integer.parseInt(request.getParameter("num"));
		int comment_num = Integer.parseInt(request.getParameter("comment_num"));

		
		CommReReCountService commReReCountService = new CommReReCountService();



		// CommReListService 클래스의 getCommentList() 메서드를 호출하여
		// 전체 게시물 목록 리턴받아 ArrayList 객체에 저장

		int reReCount = commReReCountService.getReReCommCount(community_num, comment_num);
//
		
		System.out.println("카운트!"+reReCount);
		
		out.print(reReCount);
		out.close();
		
		
//		System.out.println("대댓글 목록"+reCommentList);

		// request 객체의 setAttribute() 메서드를 호출하여
		// 게시물 목록 정보(ArrayList)와 페이지 정보(PageInfo) 객체를 저장

//		request.setAttribute("reCommentList", reCommentList);

		// ActionForward 객체를 생성하여 comm_view.jsp 페이지로 포워딩 설정
		// => request 객체가 유지되어야 하며, 서블릿 주소가 유지되어야 하므로
		// Dispatcher 방식으로 포워딩 설정

//		forward = new ActionForward();
//		forward.setPath("CommDetail.co?num="+community_num);
//		forward.setRedirect(true);
		
		// Json
//		String json = "{\"replyList\":[";
//		for (int i = 0; i < reCommentList.size(); i++) {
//			int comm_re_num = reCommentList.get(i).getNum();
//			String name = reCommentList.get(i).getUsername();
//			String contents = reCommentList.get(i).getContents();
//			Timestamp date =reCommentList.get(i).getDate();	
//			community_num=reCommentList.get(i).getCommunity_num();
//			int re_lev = reCommentList.get(i).getRe_lev();
//			
//
//
//			
//			json += "[{\"name\":\"" + name + "\"},";
//			json += "{\"contents\":\"" + contents + "\"},";
//			json += "{\"date\":\"" + date + "\"},";
//			json += "{\"comm_re_num\":\"" + comm_re_num + "\"}]";
//			
//			
//			if (i != reCommentList.size() - 1) {
//				json += ",";
//			}
//		}
//		json += "]}";

//		out.print(json);
//		
//		System.out.println(json);

		return null;
	}

}
