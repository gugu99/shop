package listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;


@WebListener
public class DriverListener implements ServletContextListener {

    public void contextInitialized(ServletContextEvent sce)  { // tomcat이 실행때 실행
    	// 1. application.setAttribute에 currentCounter 속성 1으로 초기화
    	sce.getServletContext().setAttribute("currentCounter", 1);
    	
    	// tomcat실행될때 사용하면 좋은 것
    	// 2. 톰캣 부팅시 드라이버 로딩
    	try {
			Class.forName("org.mariadb.jdbc.Driver");
			// 디버깅
			System.out.println("DriverListener.java Class.forName 드라이버로딩 성공");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
    }
}