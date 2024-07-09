package com.example.idollbom.domain.vo;

import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Component
@Getter
@ToString
@NoArgsConstructor
public class ParentNoteVO {

    private Long parentNoteNumber;
    private String parentNoteContent;
    private LocalDateTime parentNoteSendTime;     // 쪽지 전송 시간
    private String parentNoteAlarmCheck;          // 쪽지 알림 체크 여부
    private Long parentNumber;
    private Long proNumber;

    @Builder
    public ParentNoteVO(Long parentNoteNumber, String parentNoteContent, LocalDateTime parentNoteSendTime, String parentNoteAlarmCheck, Long parentNumber, Long proNumber) {
        this.parentNoteNumber = parentNoteNumber;
        this.parentNoteContent = parentNoteContent;
        this.parentNoteSendTime = parentNoteSendTime;
        this.parentNoteAlarmCheck = parentNoteAlarmCheck;
        this.parentNumber = parentNumber;
        this.proNumber = proNumber;
    }


}
