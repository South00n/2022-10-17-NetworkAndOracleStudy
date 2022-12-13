package com.sist.board;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/BoardInsert")
public class BoardInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		 out.println("<html>");
		 out.println("<head>");
		 out.println("<link rel=\"stylesheet\" href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css\">");
		 out.println("<style>");
		 out.println(".container{margin-top:50px}");
		 out.println(".row{margin:0px auto;width:900px}");
		 out.println("h1{text-align:center}");
		 out.println("</style>");
		 out.println("</head>");
		 out.println("<body>");
		 out.println("<div class=container>");
		 out.println("<h1>자유게시판</h1>");
		 out.println("<div class=row>");
		 out.println("<table class=table>");
		 out.println("<tr>");
		 out.println("<th align=right width=15%>이름</th>");
		 out.println("<td width=85%><input type=text name=name size=15></td>");
		 out.println("</tr>");
		 out.println("<tr>");
		 out.println("<th align=right width=15%>제목</th>");
		 out.println("<td width=85%><input type=text name=subject size=45></td>");
		 out.println("</tr>");
		 out.println("<tr>");
		 out.println("<th align=right width=15%>내용</th>");
		 out.println("<td width=85%><textarea rows=10 cols=50 name=content></textarea></td>");
		 out.println("</tr>");
		 out.println("<tr>");
		 out.println("<th align=right width=15%>비밀번호</th>");
		 out.println("<td width=85%><input type=password name=pwd size=10></textarea></td>");
		 out.println("</tr>");
		 out.println("<tr>");
		 out.println("<td colspan=2 align=center>");
		 out.println("<input type=submit value=글쓰기>");
		 out.println("<input type=button value=취소 onclick=\"javascript:history.back()\">");
		 out.println("</td>");
		 out.println("</tr>");
		 out.println("</table>");
		 out.println("</form>");
		 out.println("</div>");
		 out.println("</body>");
		 out.println("</html>");
	}

}
