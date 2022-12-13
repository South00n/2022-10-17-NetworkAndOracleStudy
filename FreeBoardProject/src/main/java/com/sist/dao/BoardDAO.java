package com.sist.dao;
// 오라클 연결
import java.util.*;
import java.sql.*;

public class BoardDAO {
	private Connection conn;
	private PreparedStatement ps;
	private final String URL = "jdbc:oracle:thin:@localhost:1521:XE";
	
	// 드라이버 등록
	public BoardDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
		} catch (Exception e) {}
	}
	
	// 연결
	public void getConnection() {
		try {
			conn = DriverManager.getConnection(URL, "hr", "happy");
		} catch (Exception e) {}
	}
	
	// 연결 해제
	public void disConnection() {
		try {
			if(ps != null) ps.close();
			if(conn != null) conn.close();
			
		} catch (Exception e) {}
	}
	
	// 기능 ==> CURD 프로그램
	// ==> 페이징 (X)
	// 1. 목록 출력 ==> SELECT (ORDER BY)
	public ArrayList<BoardVO> boardListDate() {
		ArrayList<BoardVO> list = new ArrayList<BoardVO>();
		try {
			// 1. 연결
			getConnection();
			// 2. SQL문장 제작
			String url = "SELECT no, subject, name, TO_CHAR(regdate, 'YYYY/MM/DD'), hit "
						+ "FROM freeboard "
						+ "ORDER BY no DESC";
			// 3. 오라클 서버로 전송
			ps = conn.prepareStatement(url);
			// 4. 결과값 받기
			ResultSet rs = ps.executeQuery();
			// 5. 결과값을 ArrayList에 담는다
			// 오라클에 저장된 데이터는 자동 정렬이 된 상태가 아니다
			while(rs.next()) { // 메모리에 출력된 첫번째 위치에 커서를 이동한다
				BoardVO vo = new BoardVO();
				vo.setNo(rs.getInt(1));
				vo.setSubject(rs.getString(2));
				vo.setName(rs.getString(3));
				vo.setDbday(rs.getString(4));
				vo.setHit(rs.getInt(5));
				list.add(vo);
			}
			rs.close();
		} catch (Exception e) {
			e.printStackTrace(); // 오류확인
		} finally {
			disConnection(); // 오라클 연결해제
		}
		
		return list;
	}
	// 2. 게시물 추가 ==> INSERT
	// 3. 상세보기 ==> SELECT (WHERE)
	public BoardVO boardDetailDate(int no) { // no가 게시물 번호 => 사용자로부터 받아서 데이터를 넘겨준다 (Primary Key)
		BoardVO vo = new BoardVO();
		try {
			// 1. 연결
			getConnection();
			// 2. 전송할 SQL문장 만들기
			String sql = "UPDATE freeboard SET "
						+ "hit = hit +_1 "
						+ "WHERE no =" + no;
			// 3. SQL문장 오라클 서버로 전송
			ps = conn.prepareStatement(sql);
			// 4. 실행
			ps.executeUpdate(); // 실행 => commit()까지
			
			// 5. 전송할 SQL문장을 제작
			sql = "SELECT no, name, subject, content, regdate, hit "
					+ "FROM freeborad "
					+ "WHERE no = " + no;
			// 6. 오라클로 전송
			ps = conn.prepareStatement(sql);
			// 7. 실행 후 결과값 읽기
			ResultSet rs = ps.executeQuery();
			// 8. 커서의 위치 이동 
			rs.next();
			// 9. VO에 값을 채우기
			vo.setNo(rs.getInt(1));
			vo.setName(rs.getString(2));
			vo.setSubject(rs.getString(3));
			vo.setContent(rs.getString(4));
			vo.setRegdate(rs.getDate(5));
			vo.setHit(rs.getInt(6));
			rs.close();
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			disConnection();
		}
		
		return vo;
	}
	// ----------------------------------
	// 4. 수정 ==> UPDATE
	// 5. 삭제 ==> DELETE
	// ---------------------------------- 본인 여부 확인 (비밀번호 비교)
	// 6. 검색 ==> SELECT (LIKE)
	
	
	
	
}













