package online.shixun.project.module.index.action;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import online.shixun.project.module.sysuser.service.SysuserService;

@Controller
public class IndexController {
    @Autowired
    private SysuserService sysuserService;

    @RequestMapping("/index")
    public String index(Model model) {
	model.addAttribute("sysimg", sysuserService.getSysUserById(1).getUserFace());
	return "/index";
    }

    @RequestMapping("/main")
    public String main() {
	return "/main";
    }

}
