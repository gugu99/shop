package listener;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import service.CounterService;

@WebListener
public class CounterListener implements HttpSessionListener {
	private CounterService counterService;
	// 세션이 생성될 때마다 DB카운터를 1씩 증가
	// 세션이 생성될 때마다 application attribute에 현재 접속 카운터를 1씩 증가
	// index.jsp에서 호출
	public void sessionCreated(HttpSessionEvent se)  { 
		this.counterService = new CounterService();
		System.out.println("--- CounterListener --- ");
		/*
		 * request.setAttribute(): 요청 객체 안에 map 형태로 저장, 응답하고 나면 삭제됨
		 * session.setAttribute(): 세션 객체 안에 map 형태로 저장, 세션이 사라지거나 invalidate()가 호출되면 삭제됨
		 * application.setAttribute(): 컨텍스트 객체 안에?, 톰캣 안에 저장. 
		 */
		
		try {
			counterService.count(); // 세션생성되면 count 메소드 통해서 방문자수+1
		} catch (Exception e) {
			System.out.println("방문자 수 오류 발생!");
			e.printStackTrace();
		}
		
		// 동시 접속자 있을 경우
		// 세션에 저장된 값 가져와서 + 1
		int cnt = (Integer) (se.getSession().getServletContext().getAttribute("currentCounter"));
		se.getSession().getServletContext().setAttribute("currentCounter", cnt + 1);
    }

	// 세션이 소멸되면 application attribute에 현재 접속 카운터를 1씩 감소
    public void sessionDestroyed(HttpSessionEvent se)  {
    	se.getSession().getServletContext().setAttribute("currentCounter"
				, (Integer)se.getSession().getServletContext().getAttribute("currentCounter") - 1);
    }
	
}