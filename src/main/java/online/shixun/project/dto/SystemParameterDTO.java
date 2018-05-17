package online.shixun.project.dto;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "t_systemParameter")
public class SystemParameterDTO {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    //参数id
    private Integer id;
    //版本号
    private String currentversion;
    //作者
    private String author;
    //服务器
    private String servers;
    //数据库
    private String dataService;
    //描述
    private String description;
    //jdk版本
    private String jdks;
    //Tomcat版本
    private String tomcat;
    //关键词
    private String keywords;
    //首页
    private String homePage;

    public Integer getId() {
	return id;
    }

    public void setId(Integer id) {
	this.id = id;
    }

    public String getAuthor() {
	return author;
    }

    public void setAuthor(String author) {
	this.author = author;
    }

    public String getServer() {
	return servers;
    }

    public void setServer(String servers) {
	this.servers = servers;
    }

    public String getDescription() {
	return description;
    }

    public void setDescription(String description) {
	this.description = description;
    }

    public String getJdk() {
	return jdks;
    }

    public void setJdk(String jdks) {
	this.jdks = jdks;
    }

    public String getTomcat() {
	return tomcat;
    }

    public void setTomcat(String tomcat) {
	this.tomcat = tomcat;
    }

    public String getKeywords() {
	return keywords;
    }

    public void setKeywords(String keywords) {
	this.keywords = keywords;
    }

    public String getHomePage() {
	return homePage;
    }

    public void setHomePage(String homePage) {
	this.homePage = homePage;
    }

    public String getCurrentversion() {
	return currentversion;
    }

    public void setCurrentversion(String currentversion) {
	this.currentversion = currentversion;
    }

    public String getServers() {
	return servers;
    }

    public void setServers(String servers) {
	this.servers = servers;
    }

    public String getDataService() {
	return dataService;
    }

    public void setDataService(String dataService) {
	this.dataService = dataService;
    }

    public String getJdks() {
	return jdks;
    }

    public void setJdks(String jdks) {
	this.jdks = jdks;
    }

    @Override
    public String toString() {
	return "SystemParameterDTO [id=" + id + ", currentversion=" + currentversion + ", author=" + author
		+ ", servers=" + servers + ", dataService=" + dataService + ", description=" + description + ", jdks="
		+ jdks + ", tomcat=" + tomcat + ", keywords=" + keywords + ", homePage=" + homePage + "]";
    }

}
