package com.medical.system.domain;

import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.medical.common.annotation.Excel;
import com.medical.common.core.domain.BaseEntity;

/**
 * 患者信息对象 his_patient
 *
 * @author lijie
 * @date 2026-03-19
 */
public class HisPatient extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** 患者 ID */
    private Long patiId;

    /** 患者姓名 */
    @Excel(name = "患者姓名")
    private String patiName;

    /** 病历号 */
    @Excel(name = "病历号")
    private String patiCode;

    /** 性别 (0 男 1 女) */
    @Excel(name = "性别")
    private String gender;

    /** 年龄 */
    @Excel(name = "年龄")
    private Integer age;

    /** 出生日期 */
    @JsonFormat(pattern = "yyyy-MM-dd")
    @Excel(name = "出生日期", width = 30, dateFormat = "yyyy-MM-dd")
    private Date birthday;

    /** 联系电话 */
    @Excel(name = "联系电话")
    private String phone;

    /** 身份证号 */
    @Excel(name = "身份证号")
    private String idCard;

    /** 联系地址 */
    @Excel(name = "联系地址")
    private String address;

    /** 过敏史 */
    @Excel(name = "过敏史")
    private String allergy;

    /** 既往病史 */
    @Excel(name = "既往病史")
    private String medicalHistory;

    public void setPatiId(Long patiId)
    {
        this.patiId = patiId;
    }

    public Long getPatiId()
    {
        return patiId;
    }
    public void setPatiName(String patiName)
    {
        this.patiName = patiName;
    }

    public String getPatiName()
    {
        return patiName;
    }
    public void setPatiCode(String patiCode)
    {
        this.patiCode = patiCode;
    }

    public String getPatiCode()
    {
        return patiCode;
    }
    public void setGender(String gender)
    {
        this.gender = gender;
    }

    public String getGender()
    {
        return gender;
    }
    public void setAge(Integer age)
    {
        this.age = age;
    }

    public Integer getAge()
    {
        return age;
    }
    public void setBirthday(Date birthday)
    {
        this.birthday = birthday;
    }

    public Date getBirthday()
    {
        return birthday;
    }
    public void setPhone(String phone)
    {
        this.phone = phone;
    }

    public String getPhone()
    {
        return phone;
    }
    public void setIdCard(String idCard)
    {
        this.idCard = idCard;
    }

    public String getIdCard()
    {
        return idCard;
    }
    public void setAddress(String address)
    {
        this.address = address;
    }

    public String getAddress()
    {
        return address;
    }
    public void setAllergy(String allergy)
    {
        this.allergy = allergy;
    }

    public String getAllergy()
    {
        return allergy;
    }
    public void setMedicalHistory(String medicalHistory)
    {
        this.medicalHistory = medicalHistory;
    }

    public String getMedicalHistory()
    {
        return medicalHistory;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("patiId", getPatiId())
            .append("patiName", getPatiName())
            .append("patiCode", getPatiCode())
            .append("gender", getGender())
            .append("age", getAge())
            .append("birthday", getBirthday())
            .append("phone", getPhone())
            .append("idCard", getIdCard())
            .append("address", getAddress())
            .append("allergy", getAllergy())
            .append("medicalHistory", getMedicalHistory())
            .append("createBy", getCreateBy())
            .append("createTime", getCreateTime())
            .append("updateBy", getUpdateBy())
            .append("updateTime", getUpdateTime())
            .append("remark", getRemark())
            .toString();
    }
}