package uyd.entity;

import lombok.Data;

/**
 * @author CC , Asa4CC@126.com
 * @time 2020年3月24日,下午3:36:55
 * @version 1.0
 * @description
 */
@Data
public class DeviceInfo {

	private String devId;
	private String devName;
	private String devManufacture;
	private String devModelNumber;
	private String devCategory;
	private String devInterface;
	private String devState;
	private String devLastStateTime;
	private String unitId;

}
