package online.shixun.project.module.user.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import online.shixun.project.dto.UserDTO;
import online.shixun.project.module.user.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping("/allUsers")
    public String user() {
	return "/user/allUsers";
    }

    @RequestMapping("/addUser")
    public String add() {
	return "/user/addUser";
    }

    @RequestMapping("/save")
    @ResponseBody
    public String saveOrUpDate(@RequestBody UserDTO user) {
	System.out.println("save");
	userService.saveOrUpDate(user);
	return "success";
    }

    @RequestMapping("/delete")
    @ResponseBody
    public String delete(int id) {
	userService.delete(id);
	return "success";
    }

    @RequestMapping("/deletes")
    @ResponseBody
    public String deletes(String ids) {
	userService.deletes(ids);
	return "success";
    }

    @RequestMapping("/getlist")
    @ResponseBody
    public List<UserDTO> list(Model model) {
	model.addAttribute("userstatus", userService.select());
	return userService.select();
    }

    @RequestMapping("/edit")
    public String edit(long id, Model model) {
	model.addAttribute("user", userService.selectByID(id));
	return "/user/addUser";
    }

    /**
     * 修改用户状态
     * 
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/changeStatus", method = RequestMethod.POST)
    @ResponseBody
    public String change(@RequestParam("id") Long id, @RequestParam("status") Long status) {
	userService.change(id, status);
	return "success";
    }

}
