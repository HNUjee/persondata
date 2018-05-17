package online.shixun.project.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class Sinterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
	    throws Exception {

	Object session = request.getSession().getAttribute("adminsession");
	String reqURI = request.getRequestURI();
	System.out.println(reqURI);

	if (!reqURI.contains("/login")) {
	    System.out.println("null  " + session);
	    if (session == null) {
		response.sendRedirect(request.getContextPath() + "/login");
		return false;
	    }
	}
	System.out.println("true  " + session);
	return true;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
	    ModelAndView modelAndView) throws Exception {
	// TODO Auto-generated method stub

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
	    throws Exception {
	// TODO Auto-generated method stub

    }

}
