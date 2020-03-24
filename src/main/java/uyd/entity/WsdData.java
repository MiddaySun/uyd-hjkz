package uyd.entity;

import java.sql.Date;
import java.sql.Time;

import lombok.Data;

/**
 * @author CC , Asa4CC@126.com
 * @time 2020年3月20日,上午10:36:45
 * @version 1.0
 * @description
 */
@Data
public class WsdData {

	private String wsdDataId;
	private String devId;
	private String devArea;
	private String wdValue;
	private String sdValue;
	private Date saveDate;
	private Time saveTime;

}
