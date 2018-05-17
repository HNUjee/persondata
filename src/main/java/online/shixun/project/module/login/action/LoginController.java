package online.shixun.project.module.login.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import online.shixun.project.dto.SysuserDTO;
import online.shixun.project.module.login.service.LoginService;
import online.shixun.project.util.MD5;
import online.shixun.project.web.BaseController;

@Controller
public class LoginController extends BaseController {
    @Autowired
    private LoginService loginService;

    /**
     * 去登录页面
     * 
     * @return
     */
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login() {
	logger.info("进入登录页面");
	return "/login/login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String loginIn(@RequestParam("name") String name, @RequestParam("password") String password,
	    SysuserDTO sysuser, HttpServletRequest request, Model model) {
	Subject subject = SecurityUtils.getSubject();
	// 前端传来的验证码
	String vcode = request.getParameter("vcode");
	HttpSession session = request.getSession(false);
	// 获取session中的验证码
	String s_vcode = (String) session.getAttribute("_code");
	if (vcode.equals(s_vcode) || !subject.isAuthenticated()) {
	    UsernamePasswordToken token = new UsernamePasswordToken(name, MD5.md5(password));
	    token.setRememberMe(true);
	    try {
		subject.login(token);
	    } catch (Exception e) {
		e.getMessage();
	    }
	    logger.info("用户登录成功 " + sysuser.getName());
	    return "redirect:index";
	}
	session.setAttribute("adminsession", name);
	model.addAttribute("msg", "密码或用户名错误或验证码错误");
	return "/login/login";
    }
}
