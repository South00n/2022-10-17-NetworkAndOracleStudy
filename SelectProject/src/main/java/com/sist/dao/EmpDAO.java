package com.sist.dao;
// 오라클 연결하는 클래스
/*
 * 	 ~DAO => table당 한개 => 데이터베이스 연결
 *   ~VO, ~DTO => 데이터를 모아서 전송할 목적 (브라우저, 자바)
 *   ~Manager => 외부 데이터읽기 (크롤링, JSON..)
 *   ~Service => DAO 여러개를 묶어서 한번에 처리
 * 
 */
import java.util.*; // ArrayList
import java.lang.invoke.MethodHandles.Lookup.ClassOption;
import java.sql.*;
/*	
 * 	  C/S => network (오라클 서버) ServerSocket
 * 			 DAO (클라이언트) Scoket, BufferedReader, OutputStream ==> TCP
 * 	  1. Connection (interface) => 연결
 * 	  2. Statement (interface) => SQL문장 전송 => 결과값을 받아 온다
 * 		 Statement : SQL문장 + 데이터값을 동시에 전송
 * 		 PreparedStatement : SQL문장을 먼저 전송, 나중에 값을 채워주는 역할
 * 		 CallableStatement : PL/SQL => 오라클 함수 (프로시저)를 호출할때 사용
 *    ***3. ResultSet (interface) => 결과값을 메모리에 저장
 *       ------------------------
 *       	id		sex		name  =======> row단위로 읽기
 *       ------------------------
 *       		   BOF
 *       	1		 2		 3
 *       ------------------------       
 *         aaa		man		hong | ===> next()
 *         => 문자열   => getString(1)
 *         => 정수	 => getInt(2)
 *         => 실수  	 => getDouble(3)
 *         => 날짜	 => getDate(4)
 *       ------------------------
 *         bbb	   woman	shim
 *       ------------------------
 *         ccc	    man		park | ===> previous()
 *       ------------------------
 *       		   EOF
 *       ------------------------
 *       | 커서위치				자바 - 1~8장, 11, 12, 15(base)
 *       						Spring - 디자인 패턴 8개 사용
 *       1. 디자인패턴
 *       2. 알고리즘
 */
public class EmpDAO {
	// 연결 객체 => 한 사람당 한개만 사용
	private Connection conn;
	// 송수신 객체
	private PreparedStatement ps;
	// 오라클 주소 설정
	private final String URL = "jdbc:oracle:thin:@localhost:1521:XE";
	// *** (기술면접) 싱글턴 패턴 ==> 메모리 한개만 생성 => 재사용
	private static EmpDAO dao; // static => 이용하면 메모리를 한개만 생성이 가능
	// 메모리 누수현상(사용하지 않는 메모리가 없게) ==>
	/*
	 * 		class A
	 * 
	 * 		A a = new A();
	 * 
	 * 		a = new A();
	 * 
	 * 		a = new A();
	 */
	// 1. 드라이버 등록 Class.forName("") => 드라이버가 소프트웨어 형식 (클래스등록) = 한번만 등록
	// 생성자 => 한번 수행, 초기화
	// JDBC (원시소스) ==> 라이브러리 (MyBatis, JPA)
	public EmpDAO() {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			// => 클래스의 모든 정보를 읽어서 메모리할당, 멤버변수, 메소드를 제어할때 사용 => 리플렉션 (스프링)
			// 패키지명.클래스
			// 패키지명.클래스 => 등록 (메모리 할당 요청)
		} catch (Exception ex) {}
	}
	// 1-1 싱글턴패턴 ==> newInstance(), getInstance() => 자바에서 나오면 싱글턴이다
	// Calendar.getInstance()
	public static EmpDAO newInstance() {
		if(dao == null) {
			dao = new EmpDAO();
		}
		return dao;
	}
	// 2. 연결
	public void getConnection() {
		try {
			conn = DriverManager.getConnection(URL, "hr", "happy");
			// conn hr/happy
		} catch (Exception e) {}
	}
	// 3. 해제
	public void disConnection() {
		try {
			if(ps != null) ps.close(); // 통신 종료
			if(conn != null) conn.close(); // exit()
		} catch (Exception e) {}
	}
	// 4. 기능 => SQL
	// 사원 정보를 묶어서 클라이언트로 전송
	public ArrayList<EmpVO> empListData() {
		ArrayList<EmpVO> list = new ArrayList<EmpVO>();
		try {
			// 1. 연결
			getConnection();
			// 2. SQL문장
			String sql = "SELECT empno, ename, job, mgr, hiredate, sal, comm, emp.deptno, dname, loc, grade " 
					+ "FROM emp, dept, salgrade "
					+ "WHERE emp.deptno = dept.deptno "
					+ "AND sal BETWEEN losal AND hisal";
			// 3. 오라클 전송
			ps = conn.prepareStatement(sql);
			// 4. 실행후 결과값 받기
			ResultSet rs = ps.executeQuery(); // Record 단위 => while한번수행에 한줄을 읽어 온다
			// 5. 결과값 => ArrayList에 첨부
			while (rs.next()) {
				EmpVO vo = new EmpVO();
				vo.setEmpno(rs.getInt(1));
				vo.setEname(rs.getString(2));
				vo.setJob(rs.getString(3));
				vo.setMgr(rs.getInt(4));
				vo.setHiredate(rs.getDate(5));
				vo.setSal(rs.getInt(6));
				vo.setComm(rs.getInt(7));
				vo.setDeptno(rs.getInt(8));
				vo.getDvo().setDname(rs.getString(9));
				vo.getDvo().setLoc(rs.getString(10));
				vo.getSvo().setGrade(rs.getInt(11));
				list.add(vo);
			}
			rs.close();
			// VO => 테이블마다 따로 제작, 조인, 서브쿼리, 뷰 ==> 클래스를 포함해서 사용한다
		} catch (Exception e) {
			// 확인
			System.out.println(e.getMessage());
		} finally {
			disConnection();
		}
		return list;
	}
}


















