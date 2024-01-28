package com.algaworks.ecommerce.models;

import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.MappedSuperclass;
import java.time.LocalDateTime;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

@Getter
@Setter
@EqualsAndHashCode(of = "id")
@MappedSuperclass
public class EntidadeBase {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Long id;

  @CreationTimestamp
  @Column(name = "data_criacao", updatable = false)
  private LocalDateTime dataCriacao;

  @UpdateTimestamp
  @Column(name = "data_ultima_atualizacao", insertable = false)
  private LocalDateTime dataUltimaAtualizacao;

}
