package com.example.idollbom.domain.dto.myPagedto.parentdto;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class mailDTO {
    private Long parentNoteNumber;
    private String parentNoteContent;
    private LocalDateTime parentNoteSendTime;
    private String parentNoteAlarmCheck;
    private Long parentNumber;
    private Long proNumber;
    private String proName;
}
