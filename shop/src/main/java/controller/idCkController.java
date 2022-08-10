package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import service.SignService;

@WebServlet("/idckController")
public class idCkController extends HttpServlet{
	
	private SignService signService;
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		
		signService = new SignService();
		String ckId = request.getParameter("ckId");
		boolean id = signService.idCheck(ckId);
		// id -> false -> 사용불가
		// id -> true -> 사용가능
		Gson gson = new Gson();
		String jsonStr = "";
		
		PrintWriter out = response.getWriter();
		
		if (!id) { // false면 사용불가
			jsonStr = gson.toJson("n");
			out.print(jsonStr);
			return;
		} 
		
		jsonStr = gson.toJson("y");
		
		out.print(jsonStr);
		
		out.flush();
		out.close(); // 스트림은 가비지 콜렉터 대상이 아니기때문에 close해준다.
	}
}
