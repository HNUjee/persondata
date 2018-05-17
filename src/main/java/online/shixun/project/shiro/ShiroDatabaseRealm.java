package online.shixun.project.shiro;

import java.util.ArrayList;
import java.util.List;

import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import online.shixun.project.dto.SysuserDTO;
import online.shixun.project.module.sysuser.service.SysuserService;

public class ShiroDatabaseRealm extends AuthorizingRealm {
    private SysuserService sysuserService;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
	SysuserDTO user = (SysuserDTO) principals.getPrimaryPrincipal();
	SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
	List<String> userRoles = new ArrayList<String>();
	userRoles.add("admin");
	// 基于Role的权限信息
	// 获取当前用户所拥有的所有角色
	info.addRoles(userRoles);
	return info;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
	// 1. 把 AuthenticationToken 转换为 UsernamePasswordToken
	UsernamePasswordToken uptoken = (UsernamePasswordToken) token;
	// 通过登陆名获取用户信息
	String name = (String) uptoken.getUsername();
	// 3. 调用数据库的方法, 从数据库中查询 username 对应的用户记录
	SysuserDTO user = sysuserService.getUser(name);
	// 4. 若用户不存在, 则可以抛出 UnknownAccountException 异常
	if ("unknown".equals(user)) {
	    throw new UnknownAccountException("用户不存在!");
	}

	// SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(user,
	// user.getPassword(), getName());

	// 6. 根据用户的情况, 来构建 AuthenticationInfo 对象并返回. 通常使用的实现类为:
	// SimpleAuthenticationInfo
	// 以下信息是从数据库中获取的.
	// 1). principal: 认证的实体信息. 可以是 username, 也可以是数据表对应的用户的实体类对象.
	Object principal = user;
	// 2). credentials: 密码.
	Object credentials = user.getPassword();
	// 3). realmName: 当前 realm 对象的 name. 调用父类的 getName() 方法即可
	String realmName = getName();
	SimpleAuthenticationInfo info = null;
	info = new SimpleAuthenticationInfo(principal, credentials, realmName);
	return info;

    }

    public SysuserService getSysuserService() {
	return sysuserService;
    }

    public void setSysuserService(SysuserService sysuserService) {
	this.sysuserService = sysuserService;
    }
}
