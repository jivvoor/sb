package kr.java.sb.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Table;
import lombok.Data;
import jakarta.persistence.Id;

@Entity
@Table(name = "memo")
@Data // 복잡한 연관관계 시 에러의 주범 (toString...)
public class Memo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // MySQL, MariaDB에서 주로...
    private Long id; // 알아서 1씩 증가하는 PK

    private String content;
}