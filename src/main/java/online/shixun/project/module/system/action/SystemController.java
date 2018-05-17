package online.shixun.project.module.system.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import online.shixun.project.dto.SystemParameterDTO;
import online.shixun.project.module.system.service.SystemParameterService;

@Controller
@RequestMapping("/system")
public class SystemController {
    @Autowired
    private SystemParameterService systemParameterService;

    @RequestMapping("/parameter")
    public String system(Model model) {
	// model.addAttribute("systems", systemParameterService.list());
	System.out.println(systemParameterService.list());
	return "/systemParameter/systemParameter";
    }

    @RequestMapping(value = "/getParameter", method = RequestMethod.GET)
    @ResponseBody
    public List<SystemParameterDTO> getsystem() {
	System.out.println("wen");
	return systemParameterService.list();
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public String save(@RequestBody SystemParameterDTO systemParameter) {
	systemParameterService.save(systemParameter);
	return "success";
    }
}
