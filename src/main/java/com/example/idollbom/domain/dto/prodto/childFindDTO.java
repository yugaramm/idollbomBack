package com.example.idollbom.domain.dto.prodto;

import lombok.Data;

@Data
public class childFindDTO {

    private String className;
    private String parentName;
    private String childName;
    private long childAge;
    private String childGender;
    private String childSpecialIssues;

}
