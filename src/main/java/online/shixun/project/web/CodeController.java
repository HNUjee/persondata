package online.shixun.project.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import online.shixun.project.util.vcode.Captcha;
import online.shixun.project.util.vcode.GifCaptcha;

@Controller
public class CodeController {
    /**
     * 获取验证码（Gif版本）
     * 
     * @param response
     */
    @RequestMapping(value = "/getGifCode", method = RequestMethod.GET)
    public void getGifCode(HttpServletResponse response, HttpServletRequest request) {
	try {
	    response.setHeader("Pragma", "No-cache");
	    response.setHeader("Cache-Control", "no-cache");
	    response.setDateHeader("Expires", 0);
	    response.setContentType("image/gif");
	    /**
	     * gif格式动画验证码 宽，高，位数。
	     */
	    Captcha captcha = new GifCaptcha(120, 33, 4);
	    // 输出
	    captcha.out(response.getOutputStream());
	    HttpSession session = request.getSession(true);
	    // 存入Session
	    System.out.println(captcha.text());
	    session.setAttribute("_code", captcha.text().toLowerCase());
	    System.out.println("s " + session.getAttribute("_code"));
	} catch (Exception e) {
	    e.getMessage();
	}
    }
}
