package uyd.entity;

import lombok.Data;

/**
 * @author CC , Asa4CC@126.com
 * @time 2020年3月12日
 * @version 1.0
 * @description 用户实体类
 */
@Data
public class User {

	private String userId;// 用户编码
	private String username; // 用户名
	private String password; // 密码
	private String trueName; // 真实姓名
	private String gender; // 性别
	private String jobNumber; // 工号
	private String departmentId; // 部门编号
	private String departmentName; // 部门名称
	private String postId; // 岗位编号
	private String postName; // 岗位编号
	private String idCardNo; // 身份证号
	private String phone; // 联系电话
	private String unitId; // 机构名称
	private String address; // 联系地址

}
