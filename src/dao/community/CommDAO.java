package dao.community;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import vo.CommBean;
import vo.CommReBean;

import static db.JdbcUtil.*;
public class CommDAO {
	// --------------싱글톤 패턴 활용---------------
	private CommDAO() {}
	
	private static CommDAO instance = new CommDAO();

	public static CommDAO getInstance() {
		return instance;
	}
	// --------------싱글톤 패턴 활용---------------
	Connection con; // Connection 객체를 전달받아 저장할 멤버변수

	// --------------setConnection()---------------
	// 외부(Service 클래스)로부터 Connection 객체를 전달받아
	// 멤버변수에 저장하는 setConnection() 메서드 정의
	public void setConnection(Connection con) {
		this.con = con;
	}
	// --------------setConnection()---------------
	// --------------insertArticle()---------------
	// 글 등록 작업
	public int insertArticle(CommBean commBean) {
		System.out.println("CommDAO - insertArticle()~");
		int insertCount = 0;
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		int num = 1; // 글 번호를 저장할 변수
		
		try {
			String sql = "SELECT max(num) FROM community";
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			
			// 조회 값 있으면 + 1, 없으면 작성된 글이 없으므로 num = 1 그대로 사용
			if(rs.next()) {
				num = rs.getInt(1) + 1;
			}
			
			sql = "INSERT INTO community VALUES(?,?,?,?,?,now(),?)";
			ps = con.prepareStatement(sql);
			ps.setInt(1, num);
			ps.setString(2, commBean.getMember_id());
			ps.setString(3, commBean.getSubject());
			ps.setString(4, commBean.getContent());
			ps.setInt(5, commBean.getReadCount());
			ps.setString(6, commBean.getImg());
			insertCount = ps.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("insertArticle() 오류 "+e.getMessage() );
			e.printStackTrace();
		} finally {
			close(ps);
			close(rs);
		}
		return insertCount;
	}
	// --------------insertArticle()---------------
	
	// --------------selectListCount()---------------
	// 전체 게시물 수 조회
	public int selectListCount() {
		System.out.println("CommDAO - selectListCount()~");
		
		int listCount = 0;
		
		PreparedStatement ps = null;
		ResultSet rs = null;
				
		try {
			String sql = "SELECT count(num) FROM community";
			ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				listCount = rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("selectListCount() 오류 "+e.getMessage());
			e.printStackTrace();
		} finally {
			close(ps);
			close(rs);
		}
		
		return listCount;
	}
	// --------------selectListCount()---------------
	// --------------selectArticleList()---------------
	// 게시물 목록 조회
	public ArrayList<CommBean> selectArticleList(int page, int limit, String keyword, String sort){
		ArrayList<CommBean> articleList = null;
		
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		int startRow = (page - 1) * limit; // 조회를 시작할 레코드(행) 번호 계산
		
		try {
			String sql = "";
			if(sort.equals("new")) {
				sql = "SELECT c.*, m.username, count(b.community_num) as bookmark "
						+ "FROM community c LEFT JOIN member m "
						+ "ON c.member_id = m.id LEFT JOIN bookmark b "
						+ "ON c.num = b.community_num "
						+ "GROUP BY c.num "
						+ "HAVING c.subject like ? "
						+ "ORDER BY c.num desc limit ?,?";
			}else if(sort.equals("readcount")) {
				sql = "SELECT c.*, m.username, count(b.community_num) as bookmark "
						+ "FROM community c LEFT JOIN member m "
						+ "ON c.member_id = m.id LEFT JOIN bookmark b "
						+ "ON c.num = b.community_num "
						+ "GROUP BY c.num "
						+ "HAVING c.subject like ? "
						+ "ORDER BY c.readcount desc limit ?,?";
			}else if(sort.equals("bookmark")) {
				sql = "SELECT c.*, m.username, count(b.community_num) as bookmark "
						+ "FROM community c LEFT JOIN member m "
						+ "ON c.member_id = m.id LEFT JOIN bookmark b "
						+ "ON c.num = b.community_num "
						+ "GROUP BY c.num "
						+ "HAVING c.subject like ? "
						+ "ORDER BY bookmark desc limit ?,?";
			}
			ps = con.prepareStatement(sql);
			ps.setString(1, "%"+keyword+"%");
			ps.setInt(2, startRow);
			ps.setInt(3, limit);
			rs = ps.executeQuery();
			articleList = new ArrayList<CommBean>();
			
			while(rs.next()) {
				// 1개 게시물 정보를 저장할 CommBean 객체 생성 및 데이터 저장
				CommBean article = new CommBean();
				
				// 비밀번호는 제외
				article.setNum(rs.getInt(1));
				article.setUsername((rs.getString("m.username")));
				article.setSubject(rs.getString(3));
				article.setContent(rs.getString(4));
				article.setReadCount(rs.getInt(5));
				article.setDate(rs.getTimestamp(6));
				article.setImg(rs.getString(7));
				article.setBookCount(rs.getInt("bookmark"));
				article.setCommentCount(selectCommCount(rs.getInt(1)));
				// 1개 게시물을 전체 게시물 저장 객체에 추가
				articleList.add(article);
				
			}
			
		} catch (SQLException e) {
			System.out.println("selectArticleList() 오류 "+e.getMessage());
			e.printStackTrace();
		} finally {
			close(ps);
			close(rs);
		}
		return articleList;
	}
	// --------------selectArticleList()---------------
	// --------------selectCommCount()---------------
	public int selectCommCount(int community_num) {
		System.out.println("CommentDAO - selectCommCount()");
		int listCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
			
		try {
			String sql = "SELECT COUNT(*) FROM community_reply where community_num=? and re_lev=0";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, community_num);
			rs=pstmt.executeQuery();
			
			// 조회 결과가 있을 경우 (= 게시물이 하나라도 존재하는 경우)
			// => 게시물 수를 listCount 에 저장
			
			if(rs.next()) {
				listCount=rs.getInt(1);
			}
			
		} catch (SQLException e) {
			System.out.println("selectCommCount() 오류! - "+e.getMessage());
			e.printStackTrace();
		} finally {
			// 자원 반환
			// 주의! DAO 클래스 내에서 Connection 객체 반환 금지!
			close(rs);
			close(pstmt);
			
		}		
		
		return listCount;
	}
	// --------------selectCommCount(username)---------------
	// --------------selectArticleList(username)---------------
		// 회원별 게시물 목록 조회
		public ArrayList<CommBean> selectArticleList(String member_id){
			ArrayList<CommBean> articleList = null;
			
			PreparedStatement ps = null;
			ResultSet rs = null;
			
			try {
				String sql = "SELECT c.*, m.username "
						+ "FROM community c JOIN member m "
						+ "ON c.member_id = m.id "
						+ "where c.member_id=? "
						+ "order by date desc";
				ps = con.prepareStatement(sql);
				ps.setString(1, member_id);
				rs = ps.executeQuery();
				
				articleList = new ArrayList<CommBean>();
				while(rs.next()) {
					
					
						// 1개 게시물 정보를 저장할 CommBean 객체 생성 및 데이터 저장
						CommBean article = new CommBean();
						
						// 비밀번호는 제외
						article.setNum(rs.getInt(1));
						article.setMember_id(rs.getString(2));
						article.setSubject(rs.getString(3));
						article.setContent(rs.getString(4));
						article.setReadCount(rs.getInt(5));
						article.setDate(rs.getTimestamp(6));
						article.setImg(rs.getString(7));
						article.setUsername(rs.getString("m.username"));
						
						// 1개 게시물을 전체 게시물 저장 객체에 추가
						articleList.add(article);
				}
			} catch (SQLException e) {
				System.out.println("selectArticleList() 오류 "+e.getMessage());
				e.printStackTrace();
			} finally {
				close(ps);
				close(rs);
			}
			return articleList;
		}
		// --------------selectArticleList(username)---------------
	// -------------------------- selectArticle() --------------------------------
		// 게시물 상세 내용 조회
		public CommBean selectArticle(int num) {
			// 글번호(num) 에 해당하는 레코드를 SELECT 
			// 조회 결과가 있을 경우 CommBean 객체에 저장한 뒤 리턴
			CommBean article = null;
			
			PreparedStatement ps = null;
			ResultSet rs = null;
			
			try {
				
				String sql = "SELECT c.*, m.username, m.img "
						+ "FROM community c JOIN member m "
						+ "ON c.member_id = m.id "
						+ "WHERE num = ?";
				ps = con.prepareStatement(sql);
				ps.setInt(1, num);
				rs = ps.executeQuery();
				
				// 게시물이 존재할 경우 CommBean 객체를 생성하여 게시물 내용 저장
				if(rs.next()) {
					article = new CommBean();
					article.setNum(rs.getInt("num"));
					article.setMember_id(rs.getString("member_id"));
					article.setSubject(rs.getString("subject"));
					article.setContent(rs.getString("content"));
					article.setDate(rs.getTimestamp("date"));
					article.setImg(rs.getString("c.img"));
					article.setReadCount(rs.getInt("readcount"));
					article.setUsername(rs.getString("username"));
					article.setM_img(rs.getString("m.img"));
				}
				
			} catch (Exception e) {
				System.out.println("CommDAO - selectArticle(num) 오류 : "+e.getMessage());
				e.printStackTrace();
			} finally {
				close(ps);
				close(rs);
			}
			
			return article;
		}
		// -------------------------- selectArticle() --------------------------------
		// -------------------------- updateReadcount() --------------------------------
		// 게시물 조회 수 증가
		public int updateReadcount(int num) {
			// 글번호(num)에 해당하는 게시물의 조회수(readcount)를 1 증가
			int updateCount = 0;
			
			PreparedStatement ps = null;
			
			try {
			
				String sql = "UPDATE community SET readcount = readcount + 1 WHERE num = ?";
				ps = con.prepareStatement(sql);
				ps.setInt(1, num);
				updateCount = ps.executeUpdate();
				
				// 임시 확인용 상세 내용 출력
//				System.out.println("조회수 증가 결과 : " + updateCount);
			} catch (SQLException e) {
				System.out.println("CommDAO - updateReadcount() 오류 : "+e.getMessage());
				e.printStackTrace();
			} finally {
				close(ps);
			}
			
			return updateCount;
		}
		// -------------------------- updateReadcount() --------------------------------
		// -------------------------- isArticleCommWriter() --------------------------------
		public boolean isArticleCommWriter(String member_id, String pass) {
			boolean isArticleWriter = false;
			
			PreparedStatement ps = null;
			ResultSet rs = null;
			
			try {
				String sql = "SELECT * FROM member WHERE id = ?";
				ps = con.prepareStatement(sql);
				ps.setString(1, member_id);
				rs = ps.executeQuery();
				if(rs.next()) {
					if(rs.getString("pass").equals(pass)) {
						isArticleWriter = true;
					}
				}
			} catch (SQLException e) {
				System.out.println("CommDAO - isArticleCommWriter : "+e.getMessage());
				e.printStackTrace();
			} finally {
				close(ps);
				close(rs);
			}
			
			return isArticleWriter;
		}
		// -------------------------- isArticleCommWriter() --------------------------------
		// -------------------------- updateArticle() --------------------------------
		public int updateArticle(CommBean article) {
			// CommBean 객체에 저장된 수정 내용(작성자, 제목, 내용
			int updateCount = 0;
			
			PreparedStatement ps = null;
			
			try {
				String sql = "UPDATE community SET subject=?, content=?, img=? WHERE num = ?";
				ps = con.prepareStatement(sql);
				ps.setString(1, article.getSubject());
				ps.setString(2, article.getContent());
				ps.setString(3, article.getImg());
				ps.setInt(4, article.getNum());
				updateCount = ps.executeUpdate();
				
			} catch (SQLException e) {
				System.out.println("CommDAO - updateArticle : "+e.getMessage());
				e.printStackTrace();
			} finally {
				close(ps);
			}
			return updateCount;
		}
		// -------------------------- updateArticle() --------------------------------
		// -------------------------- isDeleteArticle() --------------------------------
		// 글 삭제
		public int isDeleteArticle(int num) {
			int deleteCount = 0;
			PreparedStatement ps = null;
			
			try {
				String sql = "DELETE FROM community WHERE num = ?";
				ps = con.prepareStatement(sql);
				ps.setInt(1, num);
				deleteCount = ps.executeUpdate();
				
			} catch (SQLException e) {
				System.out.println("CommDAO - isDeleteArticle : "+e.getMessage());
				e.printStackTrace();
			}
			
			return deleteCount;
		}
		// -------------------------- isDeleteArticle() --------------------------------
		// -------------------------- checkBookmark() --------------------------------
		public int checkBookmark(int num, String id) {
			int checkCount = 0;
			PreparedStatement ps = null;
			ResultSet rs = null;
			try {
				String sql = "SELECT count(*) FROM bookmark WHERE member_id =? and community_num =?";
				ps = con.prepareStatement(sql);
				ps.setString(1, id);
				ps.setInt(2, num);
				rs = ps.executeQuery();
				if(rs.next()) {
					checkCount = rs.getInt(1);
				}
			} catch (SQLException e) {
				System.out.println("CommDAO - checkBookmark : "+e.getMessage());
				e.printStackTrace();
			} finally {
				close(ps);
				close(rs);
			}
			return checkCount;
		}
		// -------------------------- checkBookmark() --------------------------------
		// -------------------------- hasBook() --------------------------------
		public ArrayList<Integer> hasBook(String member_id) {
			ArrayList<Integer> bookList = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			try {
				String sql ="SELECT community_num FROM bookmark WHERE member_id = ?";
				ps = con.prepareStatement(sql);
				ps.setString(1, member_id);
				rs = ps.executeQuery();
				
				bookList = new ArrayList<Integer>();
				while(rs.next()) {
					// 로그인 한 아이디로 북마크한 게시물 번호들 가져오기
					bookList.add(rs.getInt(1));
				}
				
			} catch (SQLException e) {
				System.out.println("CommDAO - CountBook : "+e.getMessage());
				e.printStackTrace();
			}finally {
				close(rs);
				close(ps);
			}
			
			return bookList;
		}
		// -------------------------- hasBook() --------------------------------
		// -------------------------- updateBookmark() --------------------------------
		public int updateBookmark(int num, String id) {
			int updateCount = 0;
			PreparedStatement ps = null;
			try {
				String sql = "INSERT INTO bookmark values(?,?)";
				ps = con.prepareStatement(sql);
				ps.setString(1, id);
				ps.setInt(2, num);
				updateCount = ps.executeUpdate();
			} catch (SQLException e) {
				System.out.println("CommDAO - updateBookmark : "+e.getMessage());
				e.printStackTrace();
			}finally {
				close(ps);
			}
			
			return updateCount;
		}
		// -------------------------- updateBookmark() --------------------------------
		// -------------------------- deleteBookmark() --------------------------------
		public int deleteBookmark(int num, String id) {
			int deleteCount = 0;
			PreparedStatement ps = null;
			try {
				String sql = "DELETE FROM bookmark WHERE member_id =? and community_num =?";
				ps = con.prepareStatement(sql);
				ps.setString(1, id);
				ps.setInt(2, num);
				deleteCount = ps.executeUpdate();
			} catch (SQLException e) {
				System.out.println("CommDAO - deleteBookmark : "+e.getMessage());
				e.printStackTrace();
			}finally {
				close(ps);
			}
			return deleteCount;
		}
		// -------------------------- deleteBookmark() --------------------------------
		// -------------------------- CountBook() --------------------------------
		public int CountBook(int num) {
			int count = 0;
			PreparedStatement ps = null;
			ResultSet rs = null;
			try {
				String sql ="SELECT count(*) FROM bookmark WHERE community_num=?";
				ps = con.prepareStatement(sql);
				ps.setInt(1, num);
				rs = ps.executeQuery();
				if(rs.next()) {
					count = rs.getInt(1);
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
				close(ps);
				close(rs);
			}
			return count;
		}
		// -------------------------- CountBook() --------------------------------
		
		// -------------------------- 마이페이지 > 내 북마크 > 북마크된 게시글 리스트 --------------------------------
		public ArrayList<CommBean> selectMybookArticleList(String member_id) {
			System.out.println("selectMybookArticleList");
			ArrayList<CommBean> list = new ArrayList<CommBean>();
			
			PreparedStatement ps = null;
			ResultSet rs = null;
			ResultSet rs2 = null;
			
			try {
				String sql = "select community_num from bookmark where member_id=?";
				ps = con.prepareStatement(sql);
				ps.setString(1, member_id);
				rs = ps.executeQuery();
				
				while(rs.next()) {
					sql = "SELECT c.*, m.username "
							+ "FROM community c JOIN member m "
							+ "ON c.member_id = m.id "
							+ "WHERE num = ?";
					
					ps = con.prepareStatement(sql);
					ps.setInt(1, rs.getInt(1));
					rs2 = ps.executeQuery();
					
					// 게시물이 존재할 경우 CommBean 객체를 생성하여 게시물 내용 저장
					while(rs2.next()) {
						CommBean article = new CommBean();
						
						article.setNum(rs2.getInt("num"));
						article.setMember_id(rs2.getString("member_id"));
						article.setSubject(rs2.getString("subject"));
						article.setContent(rs2.getString("content"));
						article.setDate(rs2.getTimestamp("date"));
						article.setImg(rs2.getString("img"));
						article.setReadCount(rs2.getInt("readcount"));
						article.setUsername(rs2.getString("username"));

						list.add(article);
					}
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				close(ps);
				close(rs);
				close(rs2);
			}
			
			return list;
		}
		
		
	
}